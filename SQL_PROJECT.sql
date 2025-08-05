--SQL RETAIL SALES ANALYSIS
DROP TABLE retail_sales;
CREATE TABLE retail_sales(
		transactions_id INT primary key,
		sale_date date,
		sale_time time,
        customer_id FLOAT,
		gender VARCHAR(50),
		age INT,
		category VARCHAR(50),
		quantiy FLOAT,
		price_per_unit FLOAT,
		cogs FLOAT,
		total_sale FLOAT
);

SELECT*FROM retail_sales;

-- first we count the no. of rows 
SELECT count(*)
FROM retail_sales;

-- we check a null value
SELECT*FROM retail_sales
where
		transactions_id is null
		or
		sale_date is null
		or
		sale_time is null
		or
		gender is null
		or
		category is null
		or
		quantiy is null
		or
		price_per_unit is null
		or
		cogs is null
		or
		total_sale is null;

--Data cleaning
delete from retail_sales
where
		transactions_id is null
		or
		sale_date is null
		or
		sale_time is null
		or
		gender is null
		or
		category is null
		or
		quantiy is null
		or
		price_per_unit is null
		or
		cogs is null
		or
		total_sale is null;
		
--DATA EXPLORATON

--COUNT NO. OF CUSTOMER
SELECT COUNT(*) AS total_sales FROM retail_sales;

--TOTAL NO. OF UNIQUE CUSOTMERS 
SELECT COUNT(distinct customer_id) AS total_customers FROM retail_sales;

--TOTAL NO. OF UNIQUE Category 
SELECT COUNT(distinct category) AS total_category FROM retail_sales;
SELECT distinct category FROM retail_sales;


-- HOW MANY SALES WE HAVE
SELECT SUM(total_sale) AS overall_sales
FROM retail_sales;

--Business Analysis key problems 
--1.Write a SQL query to retrieve all columns for sales made on '2022-11-05:
select * from retail_sales
where sale_date ='2022-11-05';

--2.Write a SQL query to retrieve all transactions where the category is
--'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
select * from retail_sales
where category = 'Clothing' and quantiy >=4 and to_char(sale_date,'YYYY-MM') ='2022-11' ;

--3.Write a SQL query to calculate the total sales and total count  for each category.
SELECT category , SUM(total_sale) AS net_sale,
COUNT(*) as total_orders
FROM retail_sales
GROUP BY category ;

--4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select avg(age) as avg_age
from retail_sales
where category = 'Beauty';

--5.Write a SQL query to find all transactions where the total_sale is greater than 1000.
select transactions_id , total_sale 
from retail_sales 
where total_sale>=1000;

--6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
select gender,category, count(*)
from retail_sales
group by gender,category;


SELECT*FROM retail_sales;

--7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT year,month, avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1

--8.Write a SQL query to find the top 5 customers based on the highest total sales:
select customer_id , sum(total_sale) as net_sale
from retail_sales
group by customer_id
order by net_sale desc
limit 5 ; 

--9.Write a SQL query to find the number of unique customers who purchased items from each 
SELECT  category,    
COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category;

--10.Write a SQL query to create each shift and number of orders 
--(Example Morning <12, Afternoon Between 12 & 17, Evening >17):
select case 
when extract(hour from sale_time ) < 12  then 'Morning'
when extract (hour from sale_time) between 12 and  17 then 'evening'
else 'Evening' 
End as shift,
count(*) as  total_order
from retail_sales
group by shift;






