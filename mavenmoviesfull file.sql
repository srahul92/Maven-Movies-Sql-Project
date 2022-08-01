/* use to enter into that database*/
use mavenmovies;     

/* is for all columns */
select * from inventory;
select * from rental;
select 
	customer_id,
    rental_date
from rental;

/*select will only select the n no columns*/
select 
	first_name,
	last_name,
    email
from customer;

select
	rating
from film;

/* this will give you the distinct values of the value sin a columns.*/
select distinct    
	rating
    from film;

select distinct
	rental_duration
from film;

/*where clause to give a condition */
select
	customer_id,
    rental_id,
	amount,
    payment_date
from payment
where amount = 0.99;

select
	customer_id,
    rental_id,
	amount,
    payment_date
from payment
where payment_date>'2006-01-01';

/* error 1064 is for syntax error*/
select
	customer_id,
    rental_id,
    amount,
    payment_date
from payment
where customer_id between 1 and 100;

/* where cutomer_id <101 0r <=100 and the above method */

select *
from payment
where amount = '0.99'
and payment_date>'2006-01-01';

select *
from payment
where amount > '5'
and customer_id between 1 and 100
and payment_date > '2006-01-01';

/* or with where */

select *
from payment
where amount > '5'
or customer_id between 1 and 100
or payment_date > '2006-01-01';

select *
from payment
where  payment_date > '2006-01-01'
and customer_id between 1 and 100
or amount > '5';


select *
from payment
where amount > 5
or customer_id =42
or customer_id =53
or customer_id =60
or customer_id =73;

/* In for where  helps to reduce the using same colm for different situation */
select *
from payment
where amount > 5
and customer_id IN (42,53,60,75);

/* like use for pattern matching in your where clause  use with logical operators  used
 with % %  or --, -- before or after letters*/
select 
	title,
    description
from film
where description like '%epic%';

select 
	title,
    description
from film
where description like '_china';

select 
	title,
    description
from film
where title like '_LLADIN CALENDA';

select 
	title,
    special_features
from film
where special_features like '%Behind the Scenes%';

/* group by contains columns in them and it comes afteer the where clause */

/*  group by also add aggregate functions and you have to give the columns without agreegate into the group by */
-- this will also add comments but only in single line /* use to multiline comments
select
	rating,
    count(film_id)  
from film
group by rating;

-- as for alias
-- Step 1 pulling all rating
select
	rating,
    count(film_id) as count_of_films_with_this_rating
from film
group by rating;

select
	rental_duration,
    count(title) as films_with_this_rental_duration
from film
group by rental_duration;


select
	rating,
    rental_duration,
    replacement_cost as replacement,
    count(film_id) as count_of_films
from film
group by rating,
replacement,
rental_duration;

select
	rating,
    count(film_id) as count_of_films,
    min(length) as shortest_film,
    max(length) as longest_film,
    avg(length) as average_length_of_films,
    avg(rental_duration)
from film
group by rating;
 
 
 /* if charge more for the rental rate if the replacement cost is higher */
select
	replacement_cost,
    avg(rental_rate) as average_rental_rate,
    min(rental_rate) as min_rental_rate,
    max(rental_rate) as max_rental_rate,
    count(film_id) AS COUNT_OF_FILM_ID
from film
group by replacement_cost;

/*  group by is also a clause */

-- having clause & the 5th of the big six
/* having clause is always used after the groupby command and it' filter's out the values from the group by by using aggregate function */

select
	customer_id,
    count(rental_id) as total_rentals
from rental
group by customer_id
having count(rental_id) = 25;

select
	customer_id,
    count(rental_id) as total_rentals
from rental
group by customer_id
having total_rentals < 15;


-- ---------- order by -----------
-- the 6 of big 6
-- order by makes your query in a order
-- we use ascending or descending with columns to set the order
-- this always will be the last of the big six
-- u can use order by as subsequent criteria

select 
	rental_id,
    customer_id,
    staff_id,
    amount   
from payment
order by amount desc, customer_id; -- As we know asc is the default and the second value comes in ascending inside the desc of first value
-- means first value will come as desc and in that the customer is comes like ascending

select 
	rental_id,
    customer_id,
    staff_id,
    sum(amount) as total_payment_amount
from payment
order by amount desc, customer_id;

	
select
	customer_id,
    sum(amount) as total_payment_amount
from payment
group by customer_id
order by total_payment_amount desc;


select * from film;

select
	title,
    length,
    rental_rate
from film
order by length desc;


-- Allows you to perform the series if then logical operator in a specific order
-- anytime your data feels noisy and grannular think it of solving by case statements
select *
from film;

select
	distinct title,
    case
		when rental_duration <= 4 then 'rental_too_short'
        when rental_rate >=3.99 then 'too_expensive'
        when rating in ('Nc-17','R') then 'too_adult'
		when length not between 60 and 90 then 'too_short_or_to_long'
		when description like '%sharks%' then 'nope_has_sharks'
        else 'great_reco_for_my_niece'
        end as fit_for_recommendation
	from film;

select distinct active
from customer;

select
	first_name,
    last_name,
    case
		when store_id = 1 and active = 1 then 'store 1 active'
        when store_id = 1 and active = 0 then 'store 1 inactive'
        when store_id = 2 and active = 1 then 'store 1 active'
        when store_id = 2 and active = 0 then 'store inactive'
		else 'uh oh...check logic1'
        end as store_and_status
	from customer;
    
select * from inventory;

select
	inventory_id,
    film_id,
    case when store_id = 1 then inventory_id else null end as store_1_inventory,
    case when store_id = 1 then inventory_id else null end as store_2_inventory
from inventory
order by inventory_id;

-- joins uses
-- inner join gives records from both table only when there is a match

select distinct
	inventory.inventory_id  -- you have to give the table name to the col name otherwise it'll get error
from inventory              -- otherwise the server got confused in retrieve the data from which table
	inner join rental       -- and that col should be in both of the tables
     on inventory.inventory_id = rental.inventory_id
limit 5000;

select
    inventory.inventory_id,
    inventory.store_id,
    film.description,
    film.title    
from inventory
    inner join film
		on inventory.film_id = film.film_id;

-- left join to return everything and overlap from left table

select distinct
	inventory_id
from rental
limit 5000;

select distinct
	inventory.inventory_id
    
from inventory
INNER JOIN rental
		on inventory.inventory_id = rental.inventory_id
        limit 5000;
        
select distinct
	inventory.inventory_id,   -- if there is no match so anby table you will try to pull out from the left table will come as match
    rental.inventory_id
from inventory
left join rental
	on inventory.inventory_id =rental.inventory_id
    limit 5000;
    
select
	film.title,
    
    count(film_actor.actor_id) as no_of_actors
from film
	left join film_actor
		on film.film_id = film_actor.film_id
        group by film.title
        LIMIT 5000;
    
-- bridging  teo tables that are un related 
-- by finding out a common table that is related to both of the table
-- if two tables aren't connected , make a list of all tables working and see any is related two both of the table

select
	film.film_id,
    film.title,
    category.name as category_name
from film
	INNER JOIN film_category
			on film.film_id = film_category.film_id
	inner join category
			on film_category.category_id = category.category_id;

select
	concat(actor.first_name,"  ",actor.last_name) as actor_names,
    film.title as film_names
from film
	inner join film_actor
		on film.film_id = film_actor.film_id
	inner join actor
		on film_actor.actor_id = actor.actor_id;
 
-- multi conditions joins
-- where condition is given in the join itself

select distinct
	film.title,
    film.description
from film
	inner join inventory
		on film.film_id = inventory.film_id
	inner join store
		on inventory.store_id = store.store_id
            and inventory.store_id = 2;
            
            
-- union stacking two results on top of each other
-- can't coombine a variable with a integer

select title from film
union
select film_id from inventory;

select
	'advisor' as type,
    first_name,
	last_name
from advisor
		union
select
	'investor' as type,
    first_name,
    last_name
from investor;

select
	'staff' as team_type,
    concat(first_name,"  ",last_name) as names
from staff
		union
select
	'advisor' as team_type,
    concat(first_name," ",last_name) as names
from advisor;

-- 



/* 
1. My partner and I want to come by each of the stores in person and meet the managers. 
Please send over the managers’ names at each store, with the full address 
of each property (street address, district, city, and country please).  
*/ 

SELECT 
	staff.first_name AS manager_first_name, 
    staff.last_name AS manager_last_name,
    address.address, 
    address.district, 
    city.city, 
    country.country

FROM store
	LEFT JOIN staff ON store.manager_staff_id = staff.staff_id
    LEFT JOIN address ON store.address_id = address.address_id
    LEFT JOIN city ON address.city_id = city.city_id
    LEFT JOIN country ON city.country_id = country.country_id
;
	
/*
2.	I would like to get a better understanding of all of the inventory that would come along with the business. 
Please pull together a list of each inventory item you have stocked, including the store_id number, 
the inventory_id, the name of the film, the film’s rating, its rental rate and replacement cost. 
*/

SELECT 
	inventory.store_id, 
    inventory.inventory_id, 
    film.title, 
    film.rating, 
    film.rental_rate, 
    film.replacement_cost
FROM inventory
	LEFT JOIN film
		ON inventory.film_id = film.film_id
;

/* 
3.	From the same list of films you just pulled, please roll that data up and provide a summary level overview 
of your inventory. We would like to know how many inventory items you have with each rating at each store. 
*/

SELECT 
	inventory.store_id, 
    film.rating, 
    COUNT(inventory_id) AS inventory_items
FROM inventory
	LEFT JOIN film
		ON inventory.film_id = film.film_id
GROUP BY 
	inventory.store_id,
    film.rating
;

/* 
4. Similarly, we want to understand how diversified the inventory is in terms of replacement cost. We want to 
see how big of a hit it would be if a certain category of film became unpopular at a certain store.
We would like to see the number of films, as well as the average replacement cost, and total replacement cost, 
sliced by store and film category. 
*/ 

SELECT 
	store_id, 
    category.name AS category, 
	COUNT(inventory.inventory_id) AS films, 
    AVG(film.replacement_cost) AS avg_replacement_cost, 
    SUM(film.replacement_cost) AS total_replacement_cost
    
FROM inventory
	LEFT JOIN film
		ON inventory.film_id = film.film_id
	LEFT JOIN film_category
		ON film.film_id = film_category.film_id
	LEFT JOIN category
		ON category.category_id = film_category.category_id

GROUP BY 
	store_id, 
    category.name
    
ORDER BY 
	SUM(film.replacement_cost) DESC
;

/*
5.	We want to make sure you folks have a good handle on who your customers are. Please provide a list 
of all customer names, which store they go to, whether or not they are currently active, 
and their full addresses – street address, city, and country. 
*/

SELECT 
	customer.first_name, 
    customer.last_name, 
    customer.store_id,
    customer.active, 
    address.address, 
    city.city, 
    country.country

FROM customer
	LEFT JOIN address ON customer.address_id = address.address_id
    LEFT JOIN city ON address.city_id = city.city_id
    LEFT JOIN country ON city.country_id = country.country_id
;

/*
6.	We would like to understand how much your customers are spending with you, and also to know 
who your most valuable customers are. Please pull together a list of customer names, their total 
lifetime rentals, and the sum of all payments you have collected from them. It would be great to 
see this ordered on total lifetime value, with the most valuable customers at the top of the list. 
*/

SELECT 
	customer.first_name, 
    customer.last_name, 
    COUNT(rental.rental_id) AS total_rentals, 
    SUM(payment.amount) AS total_payment_amount

FROM customer
	LEFT JOIN rental ON customer.customer_id = rental.customer_id
    LEFT JOIN payment ON rental.rental_id = payment.rental_id

GROUP BY 
	customer.first_name,
    customer.last_name

ORDER BY 
	SUM(payment.amount) DESC
    ;
    
/*
7. My partner and I would like to get to know your board of advisors and any current investors.
Could you please provide a list of advisor and investor names in one table? 
Could you please note whether they are an investor or an advisor, and for the investors, 
it would be good to include which company they work with. 
*/

SELECT
	'investor' AS type, 
    first_name, 
    last_name, 
    company_name
FROM investor

UNION 

SELECT 
	'advisor' AS type, 
    first_name, 
    last_name, 
    NULL
FROM advisor;

/*
8. We're interested in how well you have covered the most-awarded actors. 
Of all the actors with three types of awards, for what % of them do we carry a film?
And how about for actors with two types of awards? Same questions. 
Finally, how about actors with just one award? 
*/

SELECT
	CASE 
		WHEN actor_award.awards = 'Emmy, Oscar, Tony ' THEN '3 awards'
        WHEN actor_award.awards IN ('Emmy, Oscar','Emmy, Tony', 'Oscar, Tony') THEN '2 awards'
		ELSE '1 award'
	END AS number_of_awards, 
    AVG(CASE WHEN actor_award.actor_id IS NULL THEN 0 ELSE 1 END) AS pct_w_one_film
	
FROM actor_award
	

GROUP BY 
	CASE 
		WHEN actor_award.awards = 'Emmy, Oscar, Tony ' THEN '3 awards'
        WHEN actor_award.awards IN ('Emmy, Oscar','Emmy, Tony', 'Oscar, Tony') THEN '2 awards'
		ELSE '1 award'
	END







        