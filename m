Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5DDE202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 17:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965330AbdIYRkh (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 13:40:37 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:51640 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934132AbdIYRkg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 13:40:36 -0400
Received: by mail-pf0-f169.google.com with SMTP id b70so4146058pfl.8
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 10:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UbmNkyBfIm7KAlCpe2qZBL7vFVDXLr9WkRTRvX8W/Ig=;
        b=C1GwUO2ytMTAKYwLrcRuqxCyh1NbQ4/Lhs65XVBxilH+AKZfXEh3usKE9DL3VkDeDv
         H+CSX5I2NSP0UhFZ4W0JG6In+pipBWTQnMqjEPU4kDUXDILMCCVWedENWECRB3t4or8+
         CQfk3VJruDr9vm1yuBfkd/VyCCiIOOw4ugNkIb73CnUri0p9ngiAgSYPeJU39d0AvFUZ
         Rt84rm/Lsm6buTjqjxcniqXgms447MbV9cOcxXGmYW8Xt9TrVWE1tPjNB8KVvfnIFmhp
         A6B9fWmBQmsZztV1Obd58+7M2SKh0Jun9VozUOO6NPdw2jL/3SpF3266E0grSOaihZRZ
         DCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UbmNkyBfIm7KAlCpe2qZBL7vFVDXLr9WkRTRvX8W/Ig=;
        b=ZV+oiB3fxwl5UE8OmG8BCLoZ4VWg13l5N+sCRgS/71xOWsnE1srMRoAQTy34AoG1X9
         J5CtnayKRBZtWZl3aAHglPkeCoNJiiNPUfnfVsFcoWWQyjr2gc9jn4lgVBdAy8FaMG3M
         El1EBS90cv9ZxeIbLqoKa2JqQC+Vtcm4wPJxjoyFrkbp0R/hYYziWQvgJGfh4RtyXsoV
         I2zB56oTOALoWJxfTMY3pqiTGVB8b6l9YhDhMkJpdgJ/+rBskbi3tJqoHm1buxCzc2Yh
         pBaBk+pfGJeNRF97adR+JpoYVlFAAm+Tq70XWuDf/hGkDryPPYAneCAlvMXeotx5Ez7v
         Ha+Q==
X-Gm-Message-State: AHPjjUjXF8FplTAcjW5QVoy1oVT58Q8m0s1unFjiiN0kiU+OAqmNDQZB
        JNQlCOF8sBNnyz9VeVsrWwfidA==
X-Google-Smtp-Source: AOwi7QCZc8vx9OW7q0h1Nph1/ntuXyxoNvDIVnfKosYgXLo/pUOm7ArfT+cEbGdrffKK7D5L1DgYLw==
X-Received: by 10.84.129.193 with SMTP id b59mr8342908plb.24.1506361235603;
        Mon, 25 Sep 2017 10:40:35 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:2d6e:b6b:1517:59cb])
        by smtp.gmail.com with ESMTPSA id k126sm3729503pfc.45.2017.09.25.10.40.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 10:40:34 -0700 (PDT)
Date:   Mon, 25 Sep 2017 10:40:33 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 4/4] Move documentation of string_list into string-list.h
Message-ID: <20170925174033.GD35385@google.com>
References: <20170925155927.32328-1-hanwen@google.com>
 <20170925155927.32328-5-hanwen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170925155927.32328-5-hanwen@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/25, Han-Wen Nienhuys wrote:
> This mirrors commit bdfdaa4978dd92992737e662f25adc01d32d0774 which did

Not really important but most times we reference another commit from a
commit msg we include the one line summary like:
    'bdfdaa497 (strbuf.h: integrate api-strbuf.txt documentation,
    2015-01-16)'

> the same for strbuf.h:
> 
> * API documentation uses /** */ to set it apart from other comments.
> 
> * Function names were stripped from the comments.
> 
> * Ordering of the header was adjusted to follow the one from the text
>   file.
> 
> * Edited some existing comments to follow the new standard.
> 
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  Documentation/technical/api-string-list.txt | 209 ----------------------------
>  string-list.h                               | 187 +++++++++++++++++++++----
>  2 files changed, 159 insertions(+), 237 deletions(-)
>  delete mode 100644 Documentation/technical/api-string-list.txt
> 
> diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
> deleted file mode 100644
> index c08402b12..000000000
> --- a/Documentation/technical/api-string-list.txt
> +++ /dev/null
> @@ -1,209 +0,0 @@
> -string-list API
> -===============
> -
> -The string_list API offers a data structure and functions to handle
> -sorted and unsorted string lists.  A "sorted" list is one whose
> -entries are sorted by string value in `strcmp()` order.
> -
> -The 'string_list' struct used to be called 'path_list', but was renamed
> -because it is not specific to paths.
> -
> -The caller:
> -
> -. Allocates and clears a `struct string_list` variable.
> -
> -. Initializes the members. You might want to set the flag `strdup_strings`
> -  if the strings should be strdup()ed. For example, this is necessary
> -  when you add something like git_path("..."), since that function returns
> -  a static buffer that will change with the next call to git_path().
> -+
> -If you need something advanced, you can manually malloc() the `items`
> -member (you need this if you add things later) and you should set the
> -`nr` and `alloc` members in that case, too.
> -
> -. Adds new items to the list, using `string_list_append`,
> -  `string_list_append_nodup`, `string_list_insert`,
> -  `string_list_split`, and/or `string_list_split_in_place`.
> -
> -. Can check if a string is in the list using `string_list_has_string` or
> -  `unsorted_string_list_has_string` and get it from the list using
> -  `string_list_lookup` for sorted lists.
> -
> -. Can sort an unsorted list using `string_list_sort`.
> -
> -. Can remove duplicate items from a sorted list using
> -  `string_list_remove_duplicates`.
> -
> -. Can remove individual items of an unsorted list using
> -  `unsorted_string_list_delete_item`.
> -
> -. Can remove items not matching a criterion from a sorted or unsorted
> -  list using `filter_string_list`, or remove empty strings using
> -  `string_list_remove_empty_items`.
> -
> -. Finally it should free the list using `string_list_clear`.
> -
> -Example:
> -
> -----
> -struct string_list list = STRING_LIST_INIT_NODUP;
> -int i;
> -
> -string_list_append(&list, "foo");
> -string_list_append(&list, "bar");
> -for (i = 0; i < list.nr; i++)
> -	printf("%s\n", list.items[i].string)
> -----
> -
> -NOTE: It is more efficient to build an unsorted list and sort it
> -afterwards, instead of building a sorted list (`O(n log n)` instead of
> -`O(n^2)`).
> -+
> -However, if you use the list to check if a certain string was added
> -already, you should not do that (using unsorted_string_list_has_string()),
> -because the complexity would be quadratic again (but with a worse factor).
> -
> -Functions
> ----------
> -
> -* General ones (works with sorted and unsorted lists as well)
> -
> -`string_list_init`::
> -
> -	Initialize the members of the string_list, set `strdup_strings`
> -	member according to the value of the second parameter.
> -
> -`filter_string_list`::
> -
> -	Apply a function to each item in a list, retaining only the
> -	items for which the function returns true.  If free_util is
> -	true, call free() on the util members of any items that have
> -	to be deleted.  Preserve the order of the items that are
> -	retained.
> -
> -`string_list_remove_empty_items`::
> -
> -	Remove any empty strings from the list.  If free_util is true,
> -	call free() on the util members of any items that have to be
> -	deleted.  Preserve the order of the items that are retained.
> -
> -`print_string_list`::
> -
> -	Dump a string_list to stdout, useful mainly for debugging purposes. It
> -	can take an optional header argument and it writes out the
> -	string-pointer pairs of the string_list, each one in its own line.
> -
> -`string_list_clear`::
> -
> -	Free a string_list. The `string` pointer of the items will be freed in
> -	case the `strdup_strings` member of the string_list is set. The second
> -	parameter controls if the `util` pointer of the items should be freed
> -	or not.
> -
> -* Functions for sorted lists only
> -
> -`string_list_has_string`::
> -
> -	Determine if the string_list has a given string or not.
> -
> -`string_list_insert`::
> -
> -	Insert a new element to the string_list. The returned pointer can be
> -	handy if you want to write something to the `util` pointer of the
> -	string_list_item containing the just added string. If the given
> -	string already exists the insertion will be skipped and the
> -	pointer to the existing item returned.
> -+
> -Since this function uses xrealloc() (which die()s if it fails) if the
> -list needs to grow, it is safe not to check the pointer. I.e. you may
> -write `string_list_insert(...)->util = ...;`.
> -
> -`string_list_lookup`::
> -
> -	Look up a given string in the string_list, returning the containing
> -	string_list_item. If the string is not found, NULL is returned.
> -
> -`string_list_remove_duplicates`::
> -
> -	Remove all but the first of consecutive entries that have the
> -	same string value.  If free_util is true, call free() on the
> -	util members of any items that have to be deleted.
> -
> -* Functions for unsorted lists only
> -
> -`string_list_append`::
> -
> -	Append a new string to the end of the string_list.  If
> -	`strdup_string` is set, then the string argument is copied;
> -	otherwise the new `string_list_entry` refers to the input
> -	string.
> -
> -`string_list_append_nodup`::
> -
> -	Append a new string to the end of the string_list.  The new
> -	`string_list_entry` always refers to the input string, even if
> -	`strdup_string` is set.  This function can be used to hand
> -	ownership of a malloc()ed string to a `string_list` that has
> -	`strdup_string` set.
> -
> -`string_list_sort`::
> -
> -	Sort the list's entries by string value in `strcmp()` order.
> -
> -`unsorted_string_list_has_string`::
> -
> -	It's like `string_list_has_string()` but for unsorted lists.
> -
> -`unsorted_string_list_lookup`::
> -
> -	It's like `string_list_lookup()` but for unsorted lists.
> -+
> -The above two functions need to look through all items, as opposed to their
> -counterpart for sorted lists, which performs a binary search.
> -
> -`unsorted_string_list_delete_item`::
> -
> -	Remove an item from a string_list. The `string` pointer of the items
> -	will be freed in case the `strdup_strings` member of the string_list
> -	is set. The third parameter controls if the `util` pointer of the
> -	items should be freed or not.
> -
> -`string_list_split`::
> -`string_list_split_in_place`::
> -
> -	Split a string into substrings on a delimiter character and
> -	append the substrings to a `string_list`.  If `maxsplit` is
> -	non-negative, then split at most `maxsplit` times.  Return the
> -	number of substrings appended to the list.
> -+
> -`string_list_split` requires a `string_list` that has `strdup_strings`
> -set to true; it leaves the input string untouched and makes copies of
> -the substrings in newly-allocated memory.
> -`string_list_split_in_place` requires a `string_list` that has
> -`strdup_strings` set to false; it splits the input string in place,
> -overwriting the delimiter characters with NULs and creating new
> -string_list_items that point into the original string (the original
> -string must therefore not be modified or freed while the `string_list`
> -is in use).
> -
> -
> -Data structures
> ----------------
> -
> -* `struct string_list_item`
> -
> -Represents an item of the list. The `string` member is a pointer to the
> -string, and you may use the `util` member for any purpose, if you want.
> -
> -* `struct string_list`
> -
> -Represents the list itself.
> -
> -. The array of items are available via the `items` member.
> -. The `nr` member contains the number of items stored in the list.
> -. The `alloc` member is used to avoid reallocating at every insertion.
> -  You should not tamper with it.
> -. Setting the `strdup_strings` member to 1 will strdup() the strings
> -  before adding them, see above.
> -. The `compare_strings_fn` member is used to specify a custom compare
> -  function, otherwise `strcmp()` is used as the default function.
> diff --git a/string-list.h b/string-list.h
> index 79ae567cb..e63ee4854 100644
> --- a/string-list.h
> +++ b/string-list.h
> @@ -1,6 +1,72 @@
>  #ifndef STRING_LIST_H
>  #define STRING_LIST_H
>  
> +/**
> + * The string_list API offers a data structure and functions to handle
> + * sorted and unsorted arrays of strings.  A "sorted" list is one whose
> + * entries are sorted by string value in `strcmp()` order.
> + *
> + * The 'string_list' struct used to be called 'path_list', but was renamed
> + * because it is not specific to paths.

This line probably doesn't need to be included in the docs anymore.  I
know this was pretty much a code move so this could be removed in a
follow up patch later.

> + *
> + * The caller:
> + *
> + * . Allocates and clears a `struct string_list` variable.
> + *
> + * . Initializes the members. You might want to set the flag `strdup_strings`
> + *   if the strings should be strdup()ed. For example, this is necessary
> + *   when you add something like git_path("..."), since that function returns
> + *   a static buffer that will change with the next call to git_path().
> + *
> + * If you need something advanced, you can manually malloc() the `items`
> + * member (you need this if you add things later) and you should set the
> + * `nr` and `alloc` members in that case, too.
> + *
> + * . Adds new items to the list, using `string_list_append`,
> + *   `string_list_append_nodup`, `string_list_insert`,
> + *   `string_list_split`, and/or `string_list_split_in_place`.
> + *
> + * . Can check if a string is in the list using `string_list_has_string` or
> + *   `unsorted_string_list_has_string` and get it from the list using
> + *   `string_list_lookup` for sorted lists.
> + *
> + * . Can sort an unsorted list using `string_list_sort`.
> + *
> + * . Can remove duplicate items from a sorted list using
> + *   `string_list_remove_duplicates`.
> + *
> + * . Can remove individual items of an unsorted list using
> + *   `unsorted_string_list_delete_item`.
> + *
> + * . Can remove items not matching a criterion from a sorted or unsorted
> + *   list using `filter_string_list`, or remove empty strings using
> + *   `string_list_remove_empty_items`.
> + *
> + * . Finally it should free the list using `string_list_clear`.
> + *
> + * Example:
> + *
> + *     struct string_list list = STRING_LIST_INIT_NODUP;
> + *     int i;
> + *
> + *     string_list_append(&list, "foo");
> + *     string_list_append(&list, "bar");
> + *     for (i = 0; i < list.nr; i++)
> + *             printf("%s\n", list.items[i].string)
> + *
> + * NOTE: It is more efficient to build an unsorted list and sort it
> + * afterwards, instead of building a sorted list (`O(n log n)` instead of
> + * `O(n^2)`).
> + *
> + * However, if you use the list to check if a certain string was added
> + * already, you should not do that (using unsorted_string_list_has_string()),
> + * because the complexity would be quadratic again (but with a worse factor).
> + */
> +
> +/**
> + * Represents an item of the list. The `string` member is a pointer to the
> + * string, and you may use the `util` member for any purpose, if you want.
> + */
>  struct string_list_item {
>  	char *string;
>  	void *util;
> @@ -8,6 +74,18 @@ struct string_list_item {
>  
>  typedef int (*compare_strings_fn)(const char *, const char *);
>  
> +/**
> + * Represents the list itself.
> + *
> + * . The array of items are available via the `items` member.
> + * . The `nr` member contains the number of items stored in the list.
> + * . The `alloc` member is used to avoid reallocating at every insertion.
> + *   You should not tamper with it.
> + * . Setting the `strdup_strings` member to 1 will strdup() the strings
> + *   before adding them, see above.
> + * . The `compare_strings_fn` member is used to specify a custom compare
> + *   function, otherwise `strcmp()` is used as the default function.
> + */
>  struct string_list {
>  	struct string_list_item *items;
>  	unsigned int nr, alloc;
> @@ -18,35 +96,61 @@ struct string_list {
>  #define STRING_LIST_INIT_NODUP { NULL, 0, 0, 0, NULL }
>  #define STRING_LIST_INIT_DUP   { NULL, 0, 0, 1, NULL }
>  
> +/* General functions which work with both sorted and unsorted lists. */
> +
> +/**
> + * Initialize the members of the string_list, set `strdup_strings`
> + * member according to the value of the second parameter.
> + */
>  void string_list_init(struct string_list *list, int strdup_strings);
>  
> +/**
> + * Apply want to each item in list, retaining only the ones for which

Maybe enclose 'want' in some form of quotes to distinguish that it is a
variable.

> + * the function returns true.  If free_util is true, call free() on
> + * the util members of any items that have to be deleted.  Preserve
> + * the order of the items that are retained.
> + */
> +void filter_string_list(struct string_list *list, int free_util,
> +			string_list_each_func_t want, void *cb_data);
> +
> +/**
> + * Dump a string_list to stdout, useful mainly for debugging
> + * purposes. It can take an optional header argument and it writes out
> + * the string-pointer pairs of the string_list, each one in its own
> + * line.
> + */
>  void print_string_list(const struct string_list *p, const char *text);
> +
> +/**
> + * Free a string_list. The `string` pointer of the items will be freed
> + * in case the `strdup_strings` member of the string_list is set. The
> + * second parameter controls if the `util` pointer of the items should
> + * be freed or not.
> + */
>  void string_list_clear(struct string_list *list, int free_util);
>  
> -/* Use this function to call a custom clear function on each util pointer */
> -/* The string associated with the util pointer is passed as the second argument */
> +/**
> + * Callback type for `string_list_clear_func`.  The string associated
> + * with the util pointer is passed as the second argument
> + */
>  typedef void (*string_list_clear_func_t)(void *p, const char *str);
> +
> +/** Call a custom clear function on each util pointer */
>  void string_list_clear_func(struct string_list *list, string_list_clear_func_t clearfunc);
>  
> -/* Use this function or the macro below to iterate over each item */

Maybe include a comment stating this is the callback type for
'for_each_string_list'

>  typedef int (*string_list_each_func_t)(struct string_list_item *, void *);
> +
> +/** Iterate over each item. */
>  int for_each_string_list(struct string_list *list,
>  			 string_list_each_func_t, void *cb_data);
> +
> +/** Iterate over each item, as a macro. */
>  #define for_each_string_list_item(item,list)            \
>  	for (item = (list)->items;                      \
>  	     item && item < (list)->items + (list)->nr; \
>  	     ++item)
>  
> -/*
> - * Apply want to each item in list, retaining only the ones for which
> - * the function returns true.  If free_util is true, call free() on
> - * the util members of any items that have to be deleted.  Preserve
> - * the order of the items that are retained.
> - */
> -void filter_string_list(struct string_list *list, int free_util,
> -			string_list_each_func_t want, void *cb_data);
> -
> -/*
> +/**
>   * Remove any empty strings from the list.  If free_util is true, call
>   * free() on the util members of any items that have to be deleted.
>   * Preserve the order of the items that are retained.
> @@ -54,25 +158,34 @@ void filter_string_list(struct string_list *list, int free_util,
>  void string_list_remove_empty_items(struct string_list *list, int free_util);
>  
>  /* Use these functions only on sorted lists: */
> +
> +/** Determine if the string_list has a given string or not. */
>  int string_list_has_string(const struct string_list *list, const char *string);
>  int string_list_find_insert_index(const struct string_list *list, const char *string,
>  				  int negative_existing_index);
> -/*
> - * Inserts the given string into the sorted list.
> - * If the string already exists, the list is not altered.
> - * Returns the string_list_item, the string is part of.
> +
> +/**
> + * Insert a new element to the string_list. The returned pointer can
> + * be handy if you want to write something to the `util` pointer of
> + * the string_list_item containing the just added string. If the given
> + * string already exists the insertion will be skipped and the pointer
> + * to the existing item returned.
> + *
> + * Since this function uses xrealloc() (which die()s if it fails) if the
> + * list needs to grow, it is safe not to check the pointer. I.e. you may
> + * write `string_list_insert(...)->util = ...;`.
>   */
>  struct string_list_item *string_list_insert(struct string_list *list, const char *string);
>  
> -/*
> - * Removes the given string from the sorted list.
> - * If the string doesn't exist, the list is not altered.
> +/**
> + * Remove the given string from the sorted list.  If the string
> + * doesn't exist, the list is not altered.
>   */
>  extern void string_list_remove(struct string_list *list, const char *string,
>  			       int free_util);
>  
> -/*
> - * Checks if the given string is part of a sorted list. If it is part of the list,
> +/**
> + * Check if the given string is part of a sorted list. If it is part of the list,
>   * return the coresponding string_list_item, NULL otherwise.
>   */
>  struct string_list_item *string_list_lookup(struct string_list *list, const char *string);
> @@ -87,14 +200,14 @@ void string_list_remove_duplicates(struct string_list *sorted_list, int free_uti
>  
>  /* Use these functions only on unsorted lists: */
>  
> -/*
> +/**
>   * Add string to the end of list.  If list->strdup_string is set, then
>   * string is copied; otherwise the new string_list_entry refers to the
>   * input string.
>   */
>  struct string_list_item *string_list_append(struct string_list *list, const char *string);
>  
> -/*
> +/**
>   * Like string_list_append(), except string is never copied.  When
>   * list->strdup_strings is set, this function can be used to hand
>   * ownership of a malloc()ed string to list without making an extra
> @@ -102,16 +215,34 @@ struct string_list_item *string_list_append(struct string_list *list, const char
>   */
>  struct string_list_item *string_list_append_nodup(struct string_list *list, char *string);
>  
> +/**
> + * Sort the list's entries by string value in `strcmp()` order.
> + */
>  void string_list_sort(struct string_list *list);
> +
> +/**
> + * Like `string_list_has_string()` but for unsorted lists. Linear in
> + * size of the list.
> + */
>  int unsorted_string_list_has_string(struct string_list *list, const char *string);
> +
> +/**
> + * Like `string_list_lookup()` but for unsorted lists. Linear in size
> + * of the list.
> + */
>  struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
>  						     const char *string);
> -
> +/**
> + * Remove an item from a string_list. The `string` pointer of the
> + * items will be freed in case the `strdup_strings` member of the
> + * string_list is set. The third parameter controls if the `util`
> + * pointer of the items should be freed or not.
> + */
>  void unsorted_string_list_delete_item(struct string_list *list, int i, int free_util);
>  
> -/*
> - * Split string into substrings on character delim and append the
> - * substrings to list.  The input string is not modified.
> +/**
> + * Split string into substrings on character `delim` and append the
> + * substrings to `list`.  The input string is not modified.
>   * list->strdup_strings must be set, as new memory needs to be
>   * allocated to hold the substrings.  If maxsplit is non-negative,
>   * then split at most maxsplit times.  Return the number of substrings
> -- 
> 2.14.1.821.g8fa685d3b7-goog
> 

-- 
Brandon Williams
