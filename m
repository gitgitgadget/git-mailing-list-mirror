Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0851E1FAFB
	for <e@80x24.org>; Thu, 30 Mar 2017 11:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933019AbdC3LDQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 07:03:16 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:59119 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932749AbdC3LDP (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Mar 2017 07:03:15 -0400
X-AuditID: 12074411-4bfff700000005a9-5a-58dce5f07d28
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id F5.51.01449.1F5ECD85; Thu, 30 Mar 2017 07:03:13 -0400 (EDT)
Received: from [192.168.69.190] (p579060CC.dip0.t-ipconnect.de [87.144.96.204])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2UB3AWc026116
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 30 Mar 2017 07:03:11 -0400
Subject: Re: [PATCH v5 3/6] dir_iterator: iterate over dir after its contents
To:     Daniel Ferreira <bnmvco@gmail.com>, git@vger.kernel.org
References: <1490844730-47634-1-git-send-email-bnmvco@gmail.com>
 <1490844730-47634-4-git-send-email-bnmvco@gmail.com>
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <53fa1238-d649-0cb9-d40a-ad9c38677aa1@alum.mit.edu>
Date:   Thu, 30 Mar 2017 13:03:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <1490844730-47634-4-git-send-email-bnmvco@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsUixO6iqPvx6Z0Ig6vzJC0ef3rLZtF1pZvJ
        oqH3CrNF95S3jBabN7ezOLB67Jx1l91jwaZSj4uXlD0+b5ILYInisklJzcksSy3St0vgyuhc
        +oyxoN+7onH5FKYGxu1WXYycHBICJhLHp+5l6mLk4hAS2MEkMb17ATuEc55JomHKb3aQKmEB
        X4kD/3qYuxg5OEQErCWur/ECCQsJlEsc+zKbFcRmFrCRON7UywhiswnoSizqaWYCsXkF7CV+
        fv0PNoZFQFWiZ/5RNhBbVCBEYs7CB4wQNYISJ2c+YQGxOQUcJU7smAw1U09ix/VfULa8xPa3
        c5gnMPLPQtIyC0nZLCRlCxiZVzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmurlZpbopaaUbmKE
        BK/gDsYZJ+UOMQpwMCrx8FasvR0hxJpYVlyZe4hRkoNJSZR389w7EUJ8SfkplRmJxRnxRaU5
        qcWHGCU4mJVEeLmfAOV4UxIrq1KL8mFS0hwsSuK8fEvU/YQE0hNLUrNTUwtSi2CyMhwcShK8
        V0EaBYtS01Mr0jJzShDSTBycIMN5gIbPAxteXJCYW5yZDpE/xagoJc5rBpIQAElklObB9cKS
        yytGcaBXhHnPglTxABMTXPcroMFMQIPFbW6BDC5JREhJNTCyt56PVY1ve1w++/PVl4Fvjf/M
        imk1PL/TctrC92cszj9oFHJvT+/y6NybrxiR39/cVZSvOFv2vu69Ob/vmS681hCmpZ976n93
        eEOwgtuUaqGAMumEE+0L30w5aLJu7vuE6MeKnxIie2KY7i8pYz3JWvyn5MovhoWS9vG2+y2U
        vD3Vld2OOCuxFGckGmoxFxUnAgAzsDDjCQMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/30/2017 05:32 AM, Daniel Ferreira wrote:
> Create an option for the dir_iterator API to iterate over subdirectories
> only after having iterated through their contents. This feature was
> predicted, although not implemented by 0fe5043 ("dir_iterator: new API
> for iterating over a directory tree", 2016-06-18).
> 
> Add the "flags" parameter to dir_iterator_create, allowing for the
> aforementioned "depth-first" iteration mode to be enabled. Currently,
> the only acceptable flag is DIR_ITERATOR_DEPTH_FIRST.

The flag name has been changed.

> This is useful for recursively removing a directory and calling rmdir()
> on a directory only after all of its contents have been wiped.
> 
> Amend a call to dir_iterator_begin() to pass the flags parameter
> introduced.
> 
> Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
> ---
>  dir-iterator.c       | 53 ++++++++++++++++++++++++++++++++++++++++++++++++----
>  dir-iterator.h       | 17 ++++++++++++-----
>  refs/files-backend.c |  2 +-
>  3 files changed, 62 insertions(+), 10 deletions(-)
> 
> diff --git a/dir-iterator.c b/dir-iterator.c
> index 3ac984b..05d53d2 100644
> --- a/dir-iterator.c
> +++ b/dir-iterator.c
> @@ -47,6 +47,9 @@ struct dir_iterator_int {
>  	 * that will be included in this iteration.
>  	 */
>  	struct dir_iterator_level *levels;
> +
> +	/* Holds the flags passed to dir_iterator_begin(). */
> +	unsigned flags;
>  };
>  
>  static inline void push_dir_level(struct dir_iterator_int *iter, struct dir_iterator_level *level)
> @@ -113,12 +116,14 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
>  					iter->base.path.buf, strerror(errno));
>  				/* Popping the level is handled below */
>  			}
> -		} else if (S_ISDIR(iter->base.st.st_mode)) {
> +		} else if (S_ISDIR(iter->base.st.st_mode) &&
> +			!(iter->flags & DIR_ITERATOR_POST_ORDER_TRAVERSAL)) {
>  			if (level->dir_state == DIR_STATE_ITER) {
>  				/*
>  				 * The directory was just iterated
>  				 * over; now prepare to iterate into
> -				 * it.
> +				 * it (unless an option is set for us
> +				 * to do otherwise).
>  				 */
>  				push_dir_level(iter, level);
>  				continue;
> @@ -152,7 +157,7 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
>  			de = readdir(level->dir);
>  
>  			if (!de) {
> -				/* This level is exhausted; pop up a level. */
> +				/* This level is exhausted  */
>  				if (errno) {
>  					warning("error reading directory %s: %s",
>  						iter->base.path.buf, strerror(errno));
> @@ -160,6 +165,32 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
>  					warning("error closing directory %s: %s",
>  						iter->base.path.buf, strerror(errno));
>  
> +				if (iter->flags & DIR_ITERATOR_POST_ORDER_TRAVERSAL) {
> +					/* If we are handling dirpaths after their contents,

The comment opening and closing delimiters should be on their own lines.

> +					 * we have to iterate over the directory now that we'll
> +					 * have finished iterating into it. */
> +					level->dir = NULL;

`level->dir = NULL` can be done before the `if` statement rather than
both here and after the `if` statement.

> +
> +					if (pop_dir_level(iter) == 0)
> +						return dir_iterator_abort(dir_iterator);
> +
> +					level = &iter->levels[iter->levels_nr - 1];
> +					/* Since we are iterating through the dirpath

Comment opening should be on its own line.

> +					 * after we have gone through it, we still need
> +					 * to get rid of the trailing slash we appended.
> +					 *
> +					 * This may generate issues if we ever want to
> +					 * iterate through the root directory AND have
> +					 * post-order traversal enabled.
> +					 */
> +					strbuf_strip_suffix(&iter->base.path, "/");

Hmmm, I was wrong again. Remember that this code path is stripping the
"/" from the directory that has just been iterated over, and has already
been closed and popped off the stack. But if we are iterating over "/",
then when it is popped off the stack, `pop_dir_level(iter)` returns
zero, and we never get to this line. So I think you can remove this warning.

> +
> +					if (set_iterator_data(iter, level))
> +						continue;
> +
> +					return ITER_OK;
> +				}
> +
>  				level->dir = NULL;
>  				if (pop_dir_level(iter) == 0)
>  					return dir_iterator_abort(dir_iterator);
> @@ -174,6 +205,18 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
>  			if (set_iterator_data(iter, level))
>  				continue;
>  
> +			/*
> +			 * If we want to iterate dirs after files, we shall
> +			 * begin looking into them *before* we return the dir
> +			 * itself.
> +			 */
> +			if (S_ISDIR(iter->base.st.st_mode) &&
> +				(iter->flags & DIR_ITERATOR_POST_ORDER_TRAVERSAL)) {
> +				push_dir_level(iter, level);
> +
> +				break;
> +			}
> +
>  			return ITER_OK;
>  		}
>  	}
> @@ -200,7 +243,7 @@ int dir_iterator_abort(struct dir_iterator *dir_iterator)
>  	return ITER_DONE;
>  }
>  
> -struct dir_iterator *dir_iterator_begin(const char *path)
> +struct dir_iterator *dir_iterator_begin(const char *path, unsigned flags)
>  {
>  	struct dir_iterator_int *iter = xcalloc(1, sizeof(*iter));
>  	struct dir_iterator *dir_iterator = &iter->base;
> @@ -208,6 +251,8 @@ struct dir_iterator *dir_iterator_begin(const char *path)
>  	if (!path || !*path)
>  		die("BUG: empty path passed to dir_iterator_begin()");
>  
> +	iter->flags = flags;
> +
>  	strbuf_init(&iter->base.path, PATH_MAX);
>  	strbuf_addstr(&iter->base.path, path);
>  
> diff --git a/dir-iterator.h b/dir-iterator.h
> index 27739e6..649ccf6 100644
> --- a/dir-iterator.h
> +++ b/dir-iterator.h
> @@ -11,8 +11,7 @@
>   * Every time dir_iterator_advance() is called, update the members of
>   * the dir_iterator structure to reflect the next path in the
>   * iteration. The order that paths are iterated over within a
> - * directory is undefined, but directory paths are always iterated
> - * over before the subdirectory contents.
> + * directory is undefined.
>   *
>   * A typical iteration looks like this:
>   *
> @@ -38,6 +37,13 @@
>   * dir_iterator_advance() again.
>   */
>  
> +/* Possible flags for dir_iterator_begin().

Comment opening should be on its own line.

> [...]

So, using your handy-dandy `test-dir-iterator` program, I did a bunch of
manual testing.

It's a little bit unfortunate (though certainly not a showstopper) that
`lstat()` is called twice on directories in `POST_ORDER` mode.

More significant is that pre-order traversal includes unreadable
directory entries (e.g., those whose permissions don't allow reading),
whereas post-order traversal omits them. The reason is that when
`opendir()` fails, the `if (!level->dir)` code block pops it off the
stack before the `if (iter->flags & DIR_ITERATOR_POST_ORDER_TRAVERSAL)`
block gets a chance to return it to the caller.

This is not great. It seems like callers would want to know about
unreadable directories within the tree.

I haven't checked whether that problem can be fixed up easily in the
current code. But I'm getting convinced that the code (i.e., even my
code, before your changes) is more convoluted than it needs to be, and
that makes it too hard to work with. Quite likely you have the same
feeling by now... :-/

Imagine something like this:

Change the `dir_state` enumeration to the following:

* DIR_STATE_PUSHED -- the top-of-stack directory has just been pushed
  onto the stack but not iterated over or opened.
* DIR_STATE_PRE_ITERATED -- the top-of-stack directory has just been
  returned to the caller (pre-order), but not opened.
* DIR_STATE_ITERATING -- the top-of-stack directory has been opened and
  we are currently iterating over its entries.
* DIR_STATE_ITERATED -- the top-of-stack directory's entries have all
  been iterated over, and the directory has been closed.
* DIR_STATE_POST_ITERATED -- the top-of-stack directory has been
  returned to the caller (post-order) and is ready to be popped.

Then the function could have a single loop with a more conventional
state machine structure *doing exactly one thing per iteration*,
something like:

while (1) {
	if (level->dir_state == DIR_STATE_PUSHED) {
		if (iter->flags & DIR_ITERATOR_DIRS_BEFORE) {
			...set iterator data...
			level->dir_state = DIR_STATE_PRE_ITERATED;
			return ITER_OK;
		} else {
			level->dir_state = DIR_STATE_PRE_ITERATED;
		}
	} else if (level->dir_state == DIR_STATE_PRE_ITERATED) {
		if (iter->flags & DIR_ITERATOR_RECURSE) {
			...open directory...
			level->dir_state = DIR_STATE_ITERATING;
		} else {
			level->dir_state = DIR_STATE_ITERATED;
		}
	} else if (level->dir_state == DIR_STATE_PRE_ITERATING) {
		if (readdir(...)) {
			if (S_ISDIR) {
				...push dir...
				level->dir_state = DIR_STATE_PUSHED;
			} else {
				...set iterator data...
				return ITER_OK;
			}
		} else {
			level->dir_state = DIR_STATE_ITERATED;
		}
	} else if (level->dir_state == DIR_STATE_ITERATED) {
		if (iter->flags & DIR_ITERATOR_DIRS_AFTER) {
			...set iterator data...
			level->dir_state = DIR_STATE_POST_ITERATED;
			return ITER_OK;
		} else {
			level->dir_state = DIR_STATE_POST_ITERATED;
		}
	} else if (level->dir_state == DIR_STATE_POST_ITERATED) {
		...pop dir...
		if (...done...) {
			break;
		}
	}
}

It's a biggish rewrite (and I'm not implying that you have to do it),
but I think the results would be more readable than the current code.

Michael

