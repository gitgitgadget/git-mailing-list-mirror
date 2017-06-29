Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5575B1F719
	for <e@80x24.org>; Thu, 29 Jun 2017 21:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752002AbdF2VSk (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 17:18:40 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33177 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751896AbdF2VSh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 17:18:37 -0400
Received: by mail-pg0-f67.google.com with SMTP id u62so13190311pgb.0
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 14:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wf7YWfNGWLf8JUUbf8NtB1Aq93QtkR4KY4/1ImYYsXY=;
        b=G2qkWCUhinjnIJpCPfPYmmmO1Tdt0BvwAxWiKCOXggZvXtCCo0sphCx/Rw2xB6GsR5
         NMcxYSsxHTU/IRPPU0R//NlFCzEAc6sbts8A4Oj2GXCV93VudbPKf5eUBFzSQsliW5OG
         Fhy7Pl6JVBKpiW5Vgv4LCwERlRKV/u+7TFoftMADiO1UUFjGEUA1N6Oaqij30n5sLbbX
         ZQI17u0RO0Z9Dfs6MbJIHdLglr5ezi3EsPLK+KaWAxouTGh7dVm/XPNaG23KB614gUIS
         jYPOO009L25aOzhDB1YQ3ypfMAPxtGq9rSd6/4hqicBqJ+c1s7Cm7eISpcrfKJzgept7
         xMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wf7YWfNGWLf8JUUbf8NtB1Aq93QtkR4KY4/1ImYYsXY=;
        b=J2eXaBKlwj4TYPzHKov4QLkrM5Pwi+NiJNyapYmS325Na6soXTi49Mmsm4e3f+TDMt
         1as+m3rEaXLmKrFT8Z1S355B5+bsv5flnA2ZN0Go4Ha9Uereuj3ZQzcUjUL/AeRNyizR
         g5m24eOwpkNQa1Zzud0ynIpm5yT35RwGH35v1QEk1KJXgyKUKI4ywT/UpmWOUG8wgRaK
         wFuUnEYeIS9HzFC1ERF9e1LJgaVBsRgZUsvMogsdgFHfGeQsCyTQYQQ72KRt3bZloE5I
         y6QjYwgOmB3fGVL1WQiRBpxiotE21JMY7X3QpJ/NeutqwQs9gjGZTnlKq/RjLkPeP8Z0
         Jzsg==
X-Gm-Message-State: AKS2vOw64+QY4CASWrgFNOUQCr+4FVqyxr4dfIiOjfMsP6lAeRIv49af
        IA4idA7Zqmo36Q==
X-Received: by 10.84.142.129 with SMTP id 1mr19859370plx.84.1498771116488;
        Thu, 29 Jun 2017 14:18:36 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:38f0:2d30:90af:519d])
        by smtp.gmail.com with ESMTPSA id q14sm7751650pfj.26.2017.06.29.14.18.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 14:18:35 -0700 (PDT)
Date:   Thu, 29 Jun 2017 14:18:32 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 2/2] hashmap: migrate documentation from
 Documentation/technical into header
Message-ID: <20170629211832.GB68015@aiede.mtv.corp.google.com>
References: <20170629011334.11173-1-sbeller@google.com>
 <20170629011334.11173-3-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170629011334.11173-3-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> Subject: hashmap: migrate documentation from Documentation/technical into header
>
> While at it, clarify the use of `key`, `keydata`, `entry_or_key` as well
> as documenting the new data pointer for the compare function.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  Documentation/technical/api-hashmap.txt | 309 --------------------------------
>  hashmap.h                               | 249 +++++++++++++++++++++++--
>  2 files changed, 231 insertions(+), 327 deletions(-)
>  delete mode 100644 Documentation/technical/api-hashmap.txt

Yay, I love this.

[...]
> --- a/Documentation/technical/api-hashmap.txt
> +++ /dev/null
> @@ -1,309 +0,0 @@

Verified that these docs have all been migrated to the header, except
where noted below.

[...]
> -`int (*hashmap_cmp_fn)(const void *entry, const void *entry_or_key, const void *keydata)`::
> -
> -	User-supplied function to test two hashmap entries for equality. Shall
> -	return 0 if the entries are equal.
> -+
> -This function is always called with non-NULL `entry` / `entry_or_key`
> -parameters that have the same hash code. When looking up an entry, the `key`
> -and `keydata` parameters to hashmap_get and hashmap_remove are always passed
> -as second and third argument, respectively. Otherwise, `keydata` is NULL.

This was really heard to read in the preimage.  Thanks for cleaning it up.

[...]
> -Usage example
> --------------
> -
> -Here's a simple usage example that maps long keys to double values.

What happened to this?  I think it would be useful to include in a
long comment at the top of the header.  A worked example like this
makes it easier to get one's bearings and know which functions to look
at.

[...]
> -Using variable-sized keys
> --------------------------

Same question: should this discussion go in the hashmap_get()
docstring, with a pointer from hashmap_remove()?  Or should it go in
test-hashmap.c, with a pointer in the docstrings of both?

[...]
> +++ b/hashmap.h
> @@ -3,11 +3,18 @@
>  
>  /*
>   * Generic implementation of hash-based key-value mappings.
> - * See Documentation/technical/api-hashmap.txt.
> + *
>   */

nit: why the blank line?

>  
> -/* FNV-1 functions */
> -
> +/*
> + * Ready-to-use hash functions for strings, using the FNV-1 algorithm (see
> + * http://www.isthe.com/chongo/tech/comp/fnv).
> + * `strhash` and `strihash` take 0-terminated strings, while `memhash` and
> + * `memihash` operate on arbitrary-length memory.
> + * `strihash` and `memihash` are case insensitive versions.
> + * `memihash_cont` is a variant of `memihash` that allows a computation to be
> + * continued with another chunk of data.
> + */
>  extern unsigned int strhash(const char *buf);
>  extern unsigned int strihash(const char *buf);
>  extern unsigned int memhash(const void *buf, size_t len);
> @@ -16,6 +23,15 @@ extern unsigned int memihash_cont(unsigned int hash_seed, const void *buf, size_
>  
>  static inline unsigned int sha1hash(const unsigned char *sha1)
>  {
> +	/*
> +	 * Converts a cryptographic hash (e.g. SHA-1) into an int-sized hash code
> +	 * for use in hash tables. Cryptographic hashes are supposed to have
> +	 * uniform distribution, so in contrast to `memhash()`, this just copies
> +	 * the first `sizeof(int)` bytes without shuffling any bits. Note that
> +	 * the results will be different on big-endian and little-endian
> +	 * platforms, so they should not be stored or transferred over the net.
> +	 */

This comment should go in front of the function instead of in its body, like this:

	/*
	 * Converts a crypto [...]
	 */
	static inline unsigned int sha1hash(...

because it is describing the purpose and usage of the function and not
its implementation.

[...]
> +/*
> + * User-supplied function to test two hashmap entries for equality. Shall
> + * return 0 if the entries are equal.
> + *
> + * This function is always called with non-NULL `entry` and `entry_or_key`
> + * parameters that have the same hash code.
> + *
> + * When looking up an entry, the `key` and `keydata` parameters to hashmap_get
> + * and hashmap_remove are always passed
> + * as second `entry_or_key` and third argument `keydata`, respectively.
> + * Otherwise, `keydata` is NULL.

strange wrapping

> + *
> + * There are two modes for this function to be used:
> + * (a) When looking for an exact match of a given `entry`, then `keydata`
> + *     ought to be NULL, and this function should cast `entry` and
> + *     `entry_or_key` to the user entries and check for equality.

What does it mean that `keydata` ought to be NULL?  Are you saying it
will be NULL, or that someone has to ensure it's NULL, or something
else?

> + * (b) When it is too expensive to allocate such a user entry (either because
> + *     it is large or varialbe sized, such that it is not on the stack),
> + *     Then the relevant data to check for equality should be passed via
> + *     ` keydata`.

stray space in "` keydata`".

> + *
> + * Resulting from these modes, this function should compare `keydata` to `entry`
> + * when `keydata` is not NULL. `entry_or_key` may be a bogus hashmap_entry (see
> + * hashmap_get_from_hash).

What is meant by a bogus hashmap_entry here?  (See also below.)

[...]
> +/*
> + * struct hashmap is the hash table structure. Members can be used as follows,
> + * but should not be modified directly.
> + */
>  struct hashmap {
[...]
> +	/* Prevent automatic rehashes during inserts and deletes when set. */
> +	unsigned disallow_rehash : 1;
>  };

Please add a reference to hashmap_disallow_rehash so people know how
to set this.

>  
>  /* hashmap functions */
>  
> +/*
> + * Initializes a hashmap structure.
> + *
> + * `map` is the hashmap to initialize.
> + *
> + * The `equals_function` can be specified to compare two entries for equality.
> + * If NULL, entries are considered equal if their hash codes are equal.
> + *
> + * When the compare function needs specific user supplied `data`, it should

nit: it's not user supplied so much as caller supplied.  Maybe this
can say something like

	The `data` parameter can be used to provide additional data (a callback
	cookie) that will be passed to `equals_function` each time it is called.
	This allows a single `equals_function` to implement multiple comparison
	functions.

[...]
> +/*
> + * Frees a hashmap structure and allocated memory.
> + *
> + * If `free_entries` is true, each hashmap_entry in the map is freed as well.
> + */

nit: Documentation/technical said the hashmap_entrys get freed using
free().  Can't hurt to carry that note over, to save the reader from
hunting down whether the struct hashmap allows setting a custom free
function.

[...]
> +/*
> + * Returns the hashmap entry for the specified key, or NULL if not found.
> + *
> + * `map` is the hashmap structure.
> + * `key` is a user data structure that starts with hashmap_entry that has at
> + *  least been initialized with the proper hash code (via `hashmap_entry_init`).

nit: strange alignment (extra space before "least").

Should these argument lists be formatted as a list somehow (e.g. leading
"- " bullets, or with a blank line between them?  (I don't have a
strong opinion, just noticed they can be hard to read with everything
run together.)

> + * `keydata` is a data structure that holds just enough information to check
> + * for equality to a given entry.
> + *
> + * One of `key` or `keydata` shall be NULL.
> + *
> + * If an entry with matching hash code is found, `key` and `keydata` are passed
> + * to `hashmap_cmp_fn` to decide whether the entry matches the key.
> + */
>  extern void *hashmap_get(const struct hashmap *map, const void *key,
[...]
> + * Removes a hashmap entry matching the specified key. If the hashmap
> + * contains duplicate entries equal to the specified key, only one of
> + * them will be removed.
> + *
> + * `map` is the hashmap structure.
> + * `key` is a user data structure that starts with hashmap_entry that has at
> + *  least been initialized with the proper hash code (via `hashmap_entry_init`).

nit: strange alignment again

[...]
>  extern void *hashmap_remove(struct hashmap *map, const void *key,
[...]
> +/*
> + * Returns the hashmap entry for the specified hash code and key data,
> + * or NULL if not found.
> + *
> + * `map` is the hashmap structure.
> + * `hash` is the hash code of the entry to look up.
> + *
> + * If an entry with matching hash code is found, `keydata` is passed to
> + * `hashmap_cmp_fn` to decide whether the entry matches the key. The
> + * `entry_or_key` parameter points to a bogus hashmap_entry structure that
> + * should not be used in the comparison.

What is going on with this note about bogus entry_or_key?  I have no
idea what it is trying to say, neither in the preimage nor the
postimage.

> + */
>  static inline void *hashmap_get_from_hash(const struct hashmap *map,
> -		unsigned int hash, const void *keydata)
> +					  unsigned int hash,
> +					  const void *keydata)

In Documentation/technical, hashmap_get_from_hash was immediately
after hashmap_get, making it more discoverable.

Should the descriptions of these two functions mention each other to
bring about a similar effect?

[...]
> @@ -91,7 +273,7 @@ int hashmap_bucket(const struct hashmap *map, unsigned int hash);
>   * manner appropriate to their usage.  This simply
>   * prevents the table from being unexpectedly re-mapped.
>   *
> - * If is up to the caller to ensure that the hashmap is
> + * It is up to the caller to ensure that the hashmap is
>   * initialized to a reasonable size to prevent poor
>   * performance.
>   *

The Documentation/technical/ text says:

	A call to allow rehashing does not force a rehash; that might happen
	with the next insert or delete.

which I find easier on the eyes than

	 * When value=0, allow future rehahses.  This DOES NOT force
	 * a rehash now.

Why not make this comment use the full description from
Documentation/technical/ verbatim?

> @@ -104,10 +286,28 @@ static inline void hashmap_disallow_rehash(struct hashmap *map, unsigned value)
[...]
> -/* hashmap_iter functions */
>  
> +/*
> + * hashmap_iter functions
> + *
> + * Used to iterate over all entries of a hashmap. Note that it is
> + * not safe to add or remove entries to the hashmap while
> + * iterating.
> + */
> +
> +struct hashmap_iter {

nit: might be simpler to associate this comment with the struct:

	/*
	 * Used to iterate over ...
	 */
	struct hashmap_iter {
		...
	}

That way, the scope of what the comment is describing is clearer.
When looking up the functions, I'm likely to look up the hashmap_iter
type they use, so I'd end up reading this comment anyway.

> +	struct hashmap *map;
> +	struct hashmap_entry *next;
> +	unsigned int tablepos;
> +};
> +
> +/* Initializes a `hashmap_iter` structure. */
>  extern void hashmap_iter_init(struct hashmap *map, struct hashmap_iter *iter);
> +
> +/* Returns the next hashmap_entry, or NULL if there are no more entries. */
>  extern void *hashmap_iter_next(struct hashmap_iter *iter);
> +
> +/* Initializes the iterator and returns the first entry, if any). */

Stray paren?

Probably worth mentioning this is a convenience wrapper for iter_init
+ iter_next, like the Documentation/technical/ text did.

>  static inline void *hashmap_iter_first(struct hashmap *map,

The rest looks good.

Thanks and hope that helps,
Jonathan
