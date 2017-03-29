Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3EE120966
	for <e@80x24.org>; Wed, 29 Mar 2017 09:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755495AbdC2J4J (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 05:56:09 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:53036 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755087AbdC2J4H (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Mar 2017 05:56:07 -0400
X-AuditID: 1207440e-ccbff7000000340b-fe-58db84b34a9f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 80.C0.13323.3B48BD85; Wed, 29 Mar 2017 05:56:04 -0400 (EDT)
Received: from [192.168.69.190] (p4FEDF5D2.dip0.t-ipconnect.de [79.237.245.210])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2T9u0GW015492
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 29 Mar 2017 05:56:02 -0400
Subject: Re: [PATCH v4 2/5] dir_iterator: iterate over dir after its contents
To:     Daniel Ferreira <bnmvco@gmail.com>, git@vger.kernel.org
References: <1490747533-89143-1-git-send-email-bnmvco@gmail.com>
 <1490747533-89143-3-git-send-email-bnmvco@gmail.com>
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <7a665631-da6a-4b9f-b9e7-750f2504eccd@alum.mit.edu>
Date:   Wed, 29 Mar 2017 11:56:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <1490747533-89143-3-git-send-email-bnmvco@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsUixO6iqLul5XaEwcUF3BaPP71ls+i60s1k
        0dB7hdmie8pbRovNm9tZHFg9ds66y+6xYFOpx8VLyh6fN8kFsERx2aSk5mSWpRbp2yVwZbQ/
        PslUcDWi4vDqlewNjLPduhg5OSQETCTOdDazdTFycQgJ7GCS2Pz9KztIQkjgApPEk0MWILaw
        gK9Ew5m1LF2MHBwiAtYS19d4QZSUS0z6dIoVxGYWsJE43tTLCGKzCehKLOppZgIp5xWwl5jb
        UQQSZhFQlXi+cRPYdFGBEIk5Cx+AlfMKCEqcnPmEBcTmFHCUWD2zgxlipJ7Ejuu/oMbLS2x/
        O4d5AiP/LCQts5CUzUJStoCReRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrrFebmaJXmpK6SZG
        SODy7WBsXy9ziFGAg1GJh3dH3q0IIdbEsuLK3EOMkhxMSqK8JwxvRwjxJeWnVGYkFmfEF5Xm
        pBYfYpTgYFYS4dVXBMrxpiRWVqUW5cOkpDlYlMR51Zao+wkJpCeWpGanphakFsFkZTg4lCR4
        G5qBGgWLUtNTK9Iyc0oQ0kwcnCDDeYCGbwep4S0uSMwtzkyHyJ9iVJQS570OkhAASWSU5sH1
        whLLK0ZxoFeEeWtBqniASQmu+xXQYCagweI2t0AGlyQipKQaGBm27DFnL0g6pVfaml/SEfh7
        t8Wml20HFvcLb/oybbZHhMDmF4lLTt4rXiz28NDFaekH9NqX2e+qblT/wLR+3e3NFYd59Pvm
        zd9/b3Px0sfaLfzLD56ZO+WXXcaEw5yXOSezpFVI/pRRkAv/tWiioEtJG1/PWqv3yW031527
        e3Bt1oUT086qZu9XYinOSDTUYi4qTgQAMX/tbQcDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/29/2017 02:32 AM, Daniel Ferreira wrote:
> Create an option for the dir_iterator API to iterate over subdirectories
> only after having iterated through their contents. This feature was
> predicted, although not implemented by 0fe5043 ("dir_iterator: new API
> for iterating over a directory tree", 2016-06-18).

I admire your ambition at taking on this project. Even though the
`dir_iterator` code is fairly short, it is quite intricate and it took
me quite a bit of thought to get it right. Don't be discouraged by how
many iterations it takes to get a change like this accepted.

When reviewing your changes, I realized that
`dir_iterator_level::initialized` and `dir_iterator_level::dir_state`
are somewhat redundant with each other in the pre-existing code. It
would be possible to add a third state, say `DIR_STATE_PUSH`, to the
enum, and use that to replace the state that we now call `!initialized`.

I'm not demanding that change, but it might make the bookkeeping in the
new code a little bit easier to understand, because the logic that
decides what to do based on setting of the new option would either
transition the level from `DIR_STATE_PUSH -> DIR_STATE_ITER ->
DIR_STATE_RECURSE` (for pre-order traversal) or `DIR_STATE_PUSH ->
DIR_STATE_RECURSE -> DIR_STATE_ITER` (for post-order traversal). I think
this could make the state machine clearer and thereby make it easier to
reason about the code.

> Add the "flags" parameter to dir_iterator_create, allowing for the
> aforementioned "depth-first" iteration mode to be enabled. Currently,
> the only acceptable flag is DIR_ITERATOR_DEPTH_FIRST.
> 
> This is useful for recursively removing a directory and calling rmdir()
> on a directory only after all of its contents have been wiped.

This patch changes the signature of `ref_iterator_begin()` without
adjusting the caller in `refs/files-backend.c`. This means that the code
doesn't even compile after this patch is applied.

The Git project insists that the code compile and all tests pass after
each and every commit. Among other things, this keeps the code
"bisectable" using `git bisect`, which is a very useful property.

I see that you adjust the caller later in the patch series, in
"files_reflog_iterator: amend use of dir_iterator". Please squash that
patch into this one.

I also realize that I made a goof in my comments about v3 of this patch
series. Your new option is not choosing between "depth-first" and
"breadth-first". Both types of iteration are depth-first. Really it is
choosing between pre-order and post-order traversal. So I think it would
be better to name the option `DIR_ITERATOR_POST_ORDER`. Sorry about that.

> ---
>  dir-iterator.c | 46 ++++++++++++++++++++++++++++++++++++++++++----
>  dir-iterator.h | 14 +++++++++++---
>  2 files changed, 53 insertions(+), 7 deletions(-)
> 
> diff --git a/dir-iterator.c b/dir-iterator.c
> index 853c040..545d333 100644
> --- a/dir-iterator.c
> +++ b/dir-iterator.c
> @@ -48,6 +48,9 @@ struct dir_iterator_int {
>  	 * that will be included in this iteration.
>  	 */
>  	struct dir_iterator_level *levels;
> +
> +	/* Holds the flags passed to dir_iterator_begin(). */
> +	unsigned flags;
>  };
> 
>  static inline void push_dir_level(struct dir_iterator_int *iter, struct dir_iterator_level *level)
> @@ -114,12 +117,14 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
>  			}
> 
>  			level->initialized = 1;
> -		} else if (S_ISDIR(iter->base.st.st_mode)) {
> +		} else if (S_ISDIR(iter->base.st.st_mode) &&
> +		!iter->flags & DIR_ITERATOR_DEPTH_FIRST) {

You need parentheses on the previous line:

		!(iter->flags & DIR_ITERATOR_DEPTH_FIRST)) {

because otherwise it is interpreted as

		(!iter->flags) & DIR_ITERATOR_DEPTH_FIRST) {

BTW, you should compile with stricter compiler options so that your
compiler warns you about problems like this. This is documented in
`Documentation/CodingGuidelines` (along with lots more useful information):

 - As a Git developer we assume you have a reasonably modern compiler
   and we recommend you to enable the DEVELOPER makefile knob to
   ensure your patch is clear of all compiler warnings we care about,
   by e.g. "echo DEVELOPER=1 >>config.mak".

Also, this line is not indented far enough. It should probably line up
with the inside of the opening parenthesis of the preceding line, like

> +		} else if (S_ISDIR(iter->base.st.st_mode) &&
> +			   !(iter->flags & DIR_ITERATOR_DEPTH_FIRST)) {

But let's dig a little bit deeper. Why don't the tests catch this coding
error? Currently there is only one option, `DIR_ITERATOR_DEPTH_FIRST`,
so if that constant were defined to be 1 as expected, the code would
accidentally work anyway (though it would break if another flag is ever
added). But in fact, you define `DIR_ITERATOR_DEPTH_FIRST` to be 2
(probably unintentionally; see below), so this condition always
evaluates to false!

So what's going on here? Why don't the tests fail?

The only pre-existing user of `dir_iterator` is
`files_reflog_iterator_begin()`, and I think that none of the callers of
that function care whether the iteration is pre-order or post-order. So
maybe they're getting post-order iteration and just don't notice?

But no, that's not it either. For example, the following command, which
iterates over reflogs, gives different answers on your branch vs.
standard git:

    $ git rev-list --all --reflog | sort >expected
    $ ./git rev-list --all --reflog | sort >actual
    $ git diff --no-index --numstat expected actual
    0       1065    expected => actual

(Adding the parentheses as suggested above makes the two outputs agree.)

The disagreement is not a surprise, because there isn't a corresponding
coding error in the code below that returns the directory itself in a
post-order iteration. The net result appears to be that there is no
recursion at all into subdirectories when `DIR_ITERATOR_DEPTH_FIRST` is
set. So due to this bug, we get neither a correct post-order iteration
nor a correct pre-order iteration with the new option.

In summary, this is a trivial bug that is easy to fix, but it points to
an alarming problem: our tests don't detect a pretty serious breakage in
the iteration over reflogs. And nothing is testing directory iteration
itself, and in particular whether the new option is doing what it should.

Probably the easiest way to remedy the latter problem would be to write
a little test helper program that iterates over an arbitrary directory
and prints the names of the files that it finds, with a `--post-order`
option that twiddles the new functionality. Then directory iteration
could be tested pretty easily by creating a few test directories and
files, running the test helper, and checking its output (remembering
that the order of iteration at a *single directory level* is undefined).
I think such a test is needed if we are to be confident that your
changes are correct.

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
> @@ -153,10 +158,27 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
>  			de = readdir(level->dir);
> 
>  			if (!de) {
> -				/* This level is exhausted; pop up a level. */
> +				/* This level is exhausted  */
>  				if (errno) {
>  					warning("error reading directory %s: %s",
>  						iter->base.path.buf, strerror(errno));
> +				} else if (iter->flags & DIR_ITERATOR_DEPTH_FIRST) {
> +					/* If we are handling dirpaths after their contents,
> +					 * we have to iterate over the directory now that we'll
> +					 * have finished iterating into it. */

The Git project style is to open and terminate multiline comments on
separate lines:

        /*
	 * If we are handling dirpaths after their contents,
	 * we have to iterate over the directory now that we'll
	 * have finished iterating into it.
         */

The same problem appears elsewhere in your patch, too.

> +					level->dir = NULL;

You never call `closedir()` in this branch of the code, so you are
leaking file descriptors. Meanwhile, I don't think there's a reason to
set `dir->level` to `NULL` here, since it's just about to be popped off
the stack.

> +
> +					if (pop_dir_level(iter, level) == 0)
> +						return dir_iterator_abort(dir_iterator);
> +
> +					level = &iter->levels[iter->levels_nr - 1];
> +					/* Remove a trailing slash */
> +					strbuf_strip_suffix(&iter->base.path, "/");

I think that unconditionally stripping trailing slashes prevents this
code from being used to iterate over the root directory, "/". It's
probably not a use case that will be needed, but it would be an
unexpected surprise if anybody decided to do so.

Please either fix this or document the limitation.

> +
> +					if (set_iterator_data(iter, level))
> +						continue;
> +
> +					return ITER_OK;
>  				} else if (closedir(level->dir))
>  					warning("error closing directory %s: %s",
>  						iter->base.path.buf, strerror(errno));
> @@ -175,8 +197,22 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
>  			if (set_iterator_data(iter, level))
>  				continue;
> 
> +			/*
> +			 * If we want to iterate dirs after files, we shall
> +			 * begin looking into them *before* we return the dir
> +			 * itself.
> +			 */
> +			if (S_ISDIR(iter->base.st.st_mode) &&
> +			iter->flags & DIR_ITERATOR_DEPTH_FIRST) {

The line above is also indented incorrectly.

> +				push_dir_level(iter, level);
> +				goto continue_outer_loop;

Instead of `goto`, couldn't you use `break` here?

> +			}
> +
>  			return ITER_OK;
>  		}
> +
> +continue_outer_loop:
> +		;
>  	}
>  }
> 
> @@ -201,7 +237,7 @@ int dir_iterator_abort(struct dir_iterator *dir_iterator)
>  	return ITER_DONE;
>  }
> 
> -struct dir_iterator *dir_iterator_begin(const char *path)
> +struct dir_iterator *dir_iterator_begin(const char *path, unsigned flags)
>  {
>  	struct dir_iterator_int *iter = xcalloc(1, sizeof(*iter));
>  	struct dir_iterator *dir_iterator = &iter->base;
> @@ -209,6 +245,8 @@ struct dir_iterator *dir_iterator_begin(const char *path)
>  	if (!path || !*path)
>  		die("BUG: empty path passed to dir_iterator_begin()");
> 
> +	iter->flags = flags;
> +
>  	strbuf_init(&iter->base.path, PATH_MAX);
>  	strbuf_addstr(&iter->base.path, path);
> 
> diff --git a/dir-iterator.h b/dir-iterator.h
> index 27739e6..28ff3df 100644
> --- a/dir-iterator.h
> +++ b/dir-iterator.h
> @@ -38,6 +38,13 @@
>   * dir_iterator_advance() again.
>   */

The module docstring just above this hunk needs updating, too.

> +/* Possible flags for dir_iterator_begin().
> + *
> + * DIR_ITERATOR_DEPTH_FIRST: ensures subdirectories and their contents
> + * are iterated through before the containing directory.
> + */
> +#define DIR_ITERATOR_DEPTH_FIRST (1 << 1)
> +

Normally the first constant in a bitset gets the value `(1 << 0)`; i.e.,
1. Is there a reason you use 2 here?

> [...]

Michael

