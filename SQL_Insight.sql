select *from superstore limit 5;
-- 1. What is the total sales of the company?
select sum(sales) as total_sales
from superstore;
-- 2. Which region generates the highest sales?
select region ,round(sum(sales),2) as total_sales
from superstore
group by region 
order by total_sales desc;

-- 3. Which category contributes the most to sales?
select category, round(sum(sales),2) as total_sales
from superstore
group by category
order by total_sales desc;
-- 4. Top 5 products by sales
select product_name , sum(sales) as total_sales
from superstore
group by product_name 
order by total_sales desc 
limit 5;
-- 5. Monthly sales trend
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month,
       SUM(sales) AS total_sales
FROM superstore
GROUP BY month
ORDER by total_sales;


-- 6. What is the total profit?
select  round(sum(profit),2) as total_profit

from superstore;

-- 7. Which region is most profitable? 
select region , sum(profit) as total_profit
from superstore
group by region
order  by total_profit desc
limit 1;
-- 8. Which category has highest profit?
select category , round(sum(profit),2) as total_profit 
from superstore
group by category 
order by total_profit desc;

-- 9. Find loss-making products
select product_name , sum(profit) as total_profit 
from superstore
group by product_name 
order by total_profit asc
limit 5;

-- 10. Top 5 most profitable products
select product_name , sum(profit) as total_profit 
from superstore
group by product_name 
order by total_profit desc
limit 5;

-- 11. Does discount affect profit?
select discount , avg(profit) as average_profit
from superstore
group by discount 
order by average_profit desc;

-- 12. High discount but low profit products
 select profit , discount, product_name 
 from superstore
 where  discount >0.3
 order by profit ;
 
 -- 13. Top 5 customers by sales
select customer_name , sum(sales) as total_sales
from superstore
group by customer_name 
order by total_sales desc
limit 5;

-- 14. Which segment buys the most?
select segment ,round(sum(sales ),2) as total_sales 
from superstore
group by segment
order by total_sales desc;

-- 15. Number of unique customers
select  count(distinct customer_name )
as customer from superstore ;

-- ALTER TABLE superstore 
-- RENAME COLUMN `sub-category` TO sub_category;



-- 16. Sales and profit by sub-category
select sub_category , sum( profit ) as total_profit ,
sum(sales) as total_sales
from superstore
group by sub_category 
order by total_sales,total_profit desc;

-- 17. Most sold products by quantity
select product_name , sum(quantity) as total_quantity

from superstore
group by product_name 
order by total_quantity desc;  

-- 18. Which shipping mode is most used?
select count(distinct(row_id)) as total_orders, ship_mode 
from superstore
group by ship_mode
order by total_orders desc;

-- 19. Average shipping delay /
select avg(datediff(order_date , ship_date)) as avg_date_delay 
from superstore;

-- 20. Top 5 cities by sales
SELECT city, SUM(sales) AS total_sales
FROM superstore
GROUP BY city
ORDER BY total_sales DESC
LIMIT 5;
 
 -- top performing product in each category
 SELECT category, product_name, total_sales,
       RANK() OVER (PARTITION BY category ORDER BY total_sales DESC) AS rank_in_category
FROM (
    SELECT category, product_name, SUM(sales) AS total_sales
    FROM superstore
    GROUP BY category, product_name
) t;

-- revenue per order
SELECT 
    SUM(sales)/COUNT(DISTINCT order_id) AS avg_order_value
FROM superstore;

-- regional prefrences
SELECT region, product_name, total_quantity
FROM (
    SELECT region, product_name,
           SUM(quantity) AS total_quantity,
           RANK() OVER (PARTITION BY region ORDER BY SUM(quantity) DESC) AS rnk
    FROM superstore
    GROUP BY region, product_name
) t
WHERE rnk = 1;
select count(row_id) from superstore