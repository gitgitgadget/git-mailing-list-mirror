Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57DAA2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 21:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751826AbdHGVkv (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 17:40:51 -0400
Received: from mout.web.de ([212.227.15.3]:62612 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751589AbdHGVku (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 17:40:50 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MQL8O-1e45KJ0Gk8-00TlWB; Mon, 07
 Aug 2017 23:40:35 +0200
Subject: Re: [PATCH v4 4/4] add: modify already added files when --chmod is
 given
To:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Jan Keromnes <janx@linux.com>,
        =?UTF-8?Q?Ingo_Br=c3=bcckl?= <ib@wupperonline.de>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20160912210818.26282-1-t.gummerer@gmail.com>
 <20160914210747.15485-1-t.gummerer@gmail.com>
 <20160914210747.15485-5-t.gummerer@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <3c61d9f6-e0fd-22a4-68e0-89fd9ce9b944@web.de>
Date:   Mon, 7 Aug 2017 23:40:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20160914210747.15485-5-t.gummerer@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:iFgtjSTLZnultms4g/RdfYcLy49Y8L8wFBvquPU5BVwh5D56PjL
 /kRu99gEKFwzQm/1R1NN/ASOL9nza6SFbHZawEI6gzJBv34lsJru1K243Jda6ISUyGZTXT4
 CJ/60BeIqRvr20gl+2G/gibS5VQJFKbz2ydB5DkajT6EbG3XIRGrY7gsSD5LmqIf0ncCFTI
 7bPlkXAR06n01KNnGQszA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NmgO/gzTxYo=:jb1hUBmlF52h5PHs0JB9XH
 LPJQOgh0/Iw9FdY83urTCfK9LZ9Uvm0qigLFZ5Zz0Reutvvexd/hCw9MNoY4NT4KSmwGfB+gz
 BfHBvAwQNg2xb0TtIfTIFUkP/o90YDlyU5v8insuEOU9WdxQiR9rfWqpfIhaPtE3PnLtXFl0q
 zDQpXSAPZpy2UTtqo/kzNsbVTkY00oiOuTDNfBlSRdLsY+TZwB7cxRVjroXecDGAmYr4e6kCS
 N/++98x3OFuSHmbj6kfWd9hcZIYJi+PET7bIIa5kl9V1KtEGpPb4xA7W80Ka82tAH2xZL4bIo
 zIRdcRm6/2OfxoCZZG+IL91KlJFTBz06r9Z1dZMrhiikwLxIcVPHVRHJjDXkazRaP2cLPT9wH
 LPr1eawjvfHFK0LskvxMHF+S78MHIKwllCTAlgD8s1+NzsT3nKTVct92TvkAjGraxj3jDgo5e
 6+29hm9OTzLEZZ/B8PZyLSZ6pisNB8HnZT+kBxC60Qpk3o4gTPH0RpAdoaKo56crGDp2l+E7V
 DD85xtDGmVDjm3JeSBG5YShKgpmmm6Oz4BFNMdL2TklN6om/uxRP2CbwfO5zV1gemhbKUDrpe
 74gJqqNlNeMEqqzEBqLAaC6I+F9gdhoFfeVZKNeTE9xlfnyZDtEVKbnrrZ9FQPgupIXtj5oyX
 Bc5O9iey2yW8exmLhOs9yNqZ4+Sq+Ypo1FoOVZ+DiV0L+xwt41wJecPuTYHNjVKFQL+VzmdyC
 CKilVieRG6uA9YdX1njmbSCRuI+vnXTHWhEfNVywQXVnBaZTPjKHCzfCbYmenZOfLLg62Dcz+
 mKftvOlEzIpOrT9Pkpfvlf4TfQ0DMnEGva6TlHqGrbL+N5rpjk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.09.2016 um 23:07 schrieb Thomas Gummerer:
> When the chmod option was added to git add, it was hooked up to the diff
> machinery, meaning that it only works when the version in the index
> differs from the version on disk.
> 
> As the option was supposed to mirror the chmod option in update-index,
> which always changes the mode in the index, regardless of the status of
> the file, make sure the option behaves the same way in git add.
> 
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>

Sorry for replying almost a year late, hopefully you're still interested.

> ---
>   builtin/add.c      | 47 ++++++++++++++++++++++++++++-------------------
>   builtin/checkout.c |  2 +-
>   builtin/commit.c   |  2 +-
>   cache.h            | 10 +++++-----
>   read-cache.c       | 14 ++++++--------
>   t/t3700-add.sh     | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   6 files changed, 91 insertions(+), 34 deletions(-)
> 
> diff --git a/builtin/add.c b/builtin/add.c
> index b1dddb4..595a0b2 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -26,10 +26,25 @@ static int patch_interactive, add_interactive, edit_interactive;
>   static int take_worktree_changes;
>   
>   struct update_callback_data {
> -	int flags, force_mode;
> +	int flags;
>   	int add_errors;
>   };
>   
> +static void chmod_pathspec(struct pathspec *pathspec, int force_mode)

"int force_mode" looks like a binary (or perhaps ternary) flag, but
actually it is a character and can only have the values '-' or '+'.
In builtin/update-index.c it's called "char flip" and we probably should
define it like this here as well.

> +{
> +	int i;
> +	
> +	for (i = 0; i < active_nr; i++) {
> +		struct cache_entry *ce = active_cache[i];
> +
> +		if (pathspec && !ce_path_match(ce, pathspec, NULL))
> +			continue;
> +
> +		if (chmod_cache_entry(ce, force_mode) < 0)
> +			fprintf(stderr, "cannot chmod '%s'", ce->name);

This error message is missing a newline.  In builtin/update-index.c we
also show the attempted change (-x or +x); perhaps we want to do that
here as well.

Currently chmod_cache_entry() can only fail if ce is not a regular
file or it's other parameter is neither '-' nor '+'.  We rule out the
latter already in the argument parsing code.  The former can happen if
we add a symlink, either explicitly or because it's in a directory
we're specified.

I wonder if we even need to report anything, or under which conditions.
If you have a file named dir/file and a symlink named dir/symlink then
the interesting cases are:

	git add --chmod=.. dir/symlink
	git add --chmod=.. dir/file dir/symlink
	git add --chmod=.. dir

Warning about each case may be the most cautious thing to do, but
documenting that --chmod has no effect on symlinks and keeping silent
might be less annoying, especially in the last case.  What do you
think?

> @@ -342,13 +354,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>   	if (!show_only && ignore_missing)
>   		die(_("Option --ignore-missing can only be used together with --dry-run"));
>   
> -	if (!chmod_arg)
> -		force_mode = 0;
> -	else if (!strcmp(chmod_arg, "-x"))
> -		force_mode = 0666;
> -	else if (!strcmp(chmod_arg, "+x"))
> -		force_mode = 0777;
> -	else
> +	if (chmod_arg && ((chmod_arg[0] != '-' && chmod_arg[0] != '+') ||
> +			  chmod_arg[1] != 'x' || chmod_arg[2]))
>   		die(_("--chmod param '%s' must be either -x or +x"), chmod_arg);

That's the argument parsing code mentioned above.  The strcmp-based
checks look nicer to me btw.  How about this?

	if (chmod_arg && strcmp(chmod_arg, "-x") && strcmp(chmod_arg, "+x"))

But that's just nitpicking.

René
