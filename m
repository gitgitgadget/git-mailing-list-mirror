Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E3C81F404
	for <e@80x24.org>; Wed, 15 Aug 2018 19:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbeHOWey (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 18:34:54 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37459 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727661AbeHOWey (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 18:34:54 -0400
Received: by mail-wm0-f54.google.com with SMTP id n11-v6so2274653wmc.2
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 12:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mo0dtzkQVraTdmOiRsKbWlVPOAbpvL/Dg3GwKdgOAoQ=;
        b=jexQHNsnGGKKzNX2rVdHoBY9T1YnedApHsJqSSPSIBwsMi8On1HPNQDSf/vnfuP6eq
         +A4m0Lns+mX3sUHvO/q12EkYHo4dSJXbckNdw78bKe18S25L8PufDbqrH9Vqtqv9OLrr
         vIsVizJ2mr2MzGt+MnLPH2CSu9CvjlYUKg/LR387mR/N38s4moDtIG+UJoaJNUqRGgR1
         ZuxkDMDIVcSRaoM6U6ojwAHirmHU6K+VLPkNAvnUZGw8oCSC4MOlHzLbvtucqUWqrv3l
         vxLwrXNQRll2Ofh0U3v1sA5wA9mQfTR58jYwdgVv8uCjz08jsKVYK7BSZzWJFW7IFFfg
         Hy7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mo0dtzkQVraTdmOiRsKbWlVPOAbpvL/Dg3GwKdgOAoQ=;
        b=RABXS7YYo3sL2En/Bdbty9kouOv/S8iX71ctsluvHxhl/4/CfI1epRn9iYer7zSmzI
         LSugrKrjsobl4Pkj0eo7FQBzV3TS14OqDmx+y2su1SLXXVnFe+IVH+eidJvE3WJDfP75
         HZuutub3RRzRE5j+Sx0M73MZ4Z5IGmUtiJ8dg5Iorhhs+qe1sWGsoTlsJkwvceKOFJ86
         kzqKZio/cM/bFQkFr771qbIbJlMIPBP/rF1XwdUjKfPzk3TUob0YyEe8dhTIr4ZsgiIU
         Tq7nk/Rb3S+PCm8UGTW9y1iG1dK0mjYy9UM7UH2sdIvLS+TmVFb5VM+I7E+yKEFtL0e6
         oefg==
X-Gm-Message-State: AOUpUlHU4aUMUQYYJVPF27g2znTnR2w7L+y6DUVzu4MjmqcJXNvkfJFz
        96xIyAdyYmk1KwQmAl35dUs=
X-Google-Smtp-Source: AA+uWPxX0Xn1hD3k2Q8dvlIxGfpKFOTW6VoIqD/ukox5tJbMt+lM1BVX82Y8P0aXDpiubOrX8UiK5A==
X-Received: by 2002:a1c:cecf:: with SMTP id e198-v6mr13759306wmg.83.1534362081812;
        Wed, 15 Aug 2018 12:41:21 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id 200-v6sm5015053wmv.6.2018.08.15.12.41.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 12:41:20 -0700 (PDT)
Date:   Wed, 15 Aug 2018 20:41:20 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v7 09/26] stash: implement the "list" command in
 the builtin
Message-ID: <20180815194120.GK2734@hank.intra.tgummerer.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
 <47556d40a9944e8cc45ba3df8e12c80a1898b160.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47556d40a9944e8cc45ba3df8e12c80a1898b160.1533753605.git.ungureanupaulsebastian@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Subject: stash: implement the "list" command in the builtin

Nit: The previous commit messages all have the format "stash: convert
<command> to builtin", maybe follow the same pattern here?

The rest of the patch looks good to me.

On 08/08, Paul-Sebastian Ungureanu wrote:
> Add stash list to the helper and delete the list_stash function
> from the shell script.
> 
> Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> ---
>  builtin/stash--helper.c | 31 +++++++++++++++++++++++++++++++
>  git-stash.sh            |  7 +------
>  2 files changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> index d6bd468e0..daa4d0034 100644
> --- a/builtin/stash--helper.c
> +++ b/builtin/stash--helper.c
> @@ -12,6 +12,7 @@
>  #include "rerere.h"
>  
>  static const char * const git_stash_helper_usage[] = {
> +	N_("git stash--helper list [<options>]"),
>  	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
>  	N_("git stash--helper ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
>  	N_("git stash--helper branch <branchname> [<stash>]"),
> @@ -19,6 +20,11 @@ static const char * const git_stash_helper_usage[] = {
>  	NULL
>  };
>  
> +static const char * const git_stash_helper_list_usage[] = {
> +	N_("git stash--helper list [<options>]"),
> +	NULL
> +};
> +
>  static const char * const git_stash_helper_drop_usage[] = {
>  	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
>  	NULL
> @@ -609,6 +615,29 @@ static int branch_stash(int argc, const char **argv, const char *prefix)
>  	return ret;
>  }
>  
> +static int list_stash(int argc, const char **argv, const char *prefix)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	struct option options[] = {
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options,
> +			     git_stash_helper_list_usage,
> +			     PARSE_OPT_KEEP_UNKNOWN);
> +
> +	if (!ref_exists(ref_stash))
> +		return 0;
> +
> +	cp.git_cmd = 1;
> +	argv_array_pushl(&cp.args, "log", "--format=%gd: %gs", "-g",
> +			 "--first-parent", "-m", NULL);
> +	argv_array_pushv(&cp.args, argv);
> +	argv_array_push(&cp.args, ref_stash);
> +	argv_array_push(&cp.args, "--");
> +	return run_command(&cp);
> +}
> +
>  int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  {
>  	pid_t pid = getpid();
> @@ -639,6 +668,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  		return !!pop_stash(argc, argv, prefix);
>  	else if (!strcmp(argv[0], "branch"))
>  		return !!branch_stash(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "list"))
> +		return !!list_stash(argc, argv, prefix);
>  
>  	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
>  		      git_stash_helper_usage, options);
> diff --git a/git-stash.sh b/git-stash.sh
> index 8f2640fe9..6052441aa 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -382,11 +382,6 @@ have_stash () {
>  	git rev-parse --verify --quiet $ref_stash >/dev/null
>  }
>  
> -list_stash () {
> -	have_stash || return 0
> -	git log --format="%gd: %gs" -g --first-parent -m "$@" $ref_stash --
> -}
> -
>  show_stash () {
>  	ALLOW_UNKNOWN_FLAGS=t
>  	assert_stash_like "$@"
> @@ -574,7 +569,7 @@ test -n "$seen_non_option" || set "push" "$@"
>  case "$1" in
>  list)
>  	shift
> -	list_stash "$@"
> +	git stash--helper list "$@"
>  	;;
>  show)
>  	shift
> -- 
> 2.18.0.573.g56500d98f
> 
