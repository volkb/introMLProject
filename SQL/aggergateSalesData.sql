with category2item as (SELECT t1.*,t2.item_category_name from items t1 INNER JOIN item_categories t2 on t1.item_category_id = t2.item_category_id),
sale2category AS (SELECT t2.*, t1.item_category_id FROM category2item t1 INNER JOIN sales_train t2 on t1.item_id = t2.item_id),
itemSaleCount AS (
select
  date,
  item_id,
  item_price,
  item_category_id,
  count(item_id) as numitems
from sale2category
group by
  date,item_id,item_price,item_category_id
)
SELECT 
  MONTH(CONVERT(datetime,date,105)) as saleMonth,
  YEAR(CONVERT(datetime,date,105)) as SaleYear,
  item_id,
  item_category_id,
  count(item_id) as qty,
  sum(item_price) as profit
INTO
  sales_aggergates
FROM
  itemSaleCount
GROUP BY
   MONTH(CONVERT(datetime,date,105)),YEAR(CONVERT(datetime,date,105)),item_id, item_category_id
Order BY
  saleMonth,SaleYear