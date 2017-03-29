Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70C5020966
	for <e@80x24.org>; Wed, 29 Mar 2017 07:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753900AbdC2HhK (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 03:37:10 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36724 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753640AbdC2HhK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 03:37:10 -0400
Received: by mail-pf0-f196.google.com with SMTP id r137so904744pfr.3
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 00:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ABTBofbcdOSNQK9nTV9ddfyclHkADea5J+qew9ToMug=;
        b=iI/LnZqlv5xYW2j58YmSy8D0Na+oBWt6/j/KhKMXgbYIH5dPtIAmwZSNUpqmB9sq1V
         U3RLX9qwdYHrFuJhdIveJ/tBhiiYA7mNpiTwWDgeHEwpldo7GJ+nbB36lUWzYo4AZiY5
         1FqUwgHQqRHuKebKPTQ3X/PJbSCCTp2OnURKl6NuymDWXxOx9opJIWXXM2BY7koaRCPp
         x1wtxnaxnQlNKsi4GfZFPw5SCPnFlq7Y94dlpnepQsUBg+QPof6GNGcUxD/7ypNK9oJt
         wVsHVDHXr0s7ILyjR2OSg1yBBRJTvls2pcY/2WCZTVvWpsM2gbE2FeTWdff9Hu+BczR9
         YAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ABTBofbcdOSNQK9nTV9ddfyclHkADea5J+qew9ToMug=;
        b=AjxkhIdvA8SwSwgYrZGZt6RD/QDDC+QroQCehvsm5wHxAq1SeHpWyBANaol+eis1IB
         5P5b1+YMaDS/8XTRtJ38qVkhcSSbu/9J2zLVyjs01ChgTT/HXYa2uEBT3YLnfDtpFCBd
         48nM8bPHy9H987Jo5PZrKkRda2V7fqTj0ph9SZKPCgUuZrRT2ggmDxDyD+Q72VQgJhb9
         V8TfJXZXVeqAH8RS/Avpur65Zeruap1kxhWD5iehDJ/qvKThHO87O1DERe+VuqrOogLW
         Hy7w5VqtLsjrqumAhfrl1rauxbW40pGggcOJITqzbTcn4J/I3F1ApC2SmVy7mTZXnyyD
         lWJA==
X-Gm-Message-State: AFeK/H2JQ+ffUZt7H8hQsmI/5quQ2FREGtqm+HSiNIT+KeOkRzS7pmea+c/7gLda9gqb/w==
X-Received: by 10.99.102.134 with SMTP id a128mr34148205pgc.215.1490773028687;
        Wed, 29 Mar 2017 00:37:08 -0700 (PDT)
Received: from gmail.com (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id 80sm11513087pfy.67.2017.03.29.00.37.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Mar 2017 00:37:07 -0700 (PDT)
Date:   Wed, 29 Mar 2017 00:37:04 -0700
From:   David Aguilar <davvid@gmail.com>
To:     Mike Lewis <mike@mplew.is>
Cc:     git@vger.kernel.org, "David A . Greene" <greened@obbligato.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        James Denholm <nod.helm@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>
Subject: Re: [PATCH] contrib/subtree: add "--no-commit" flag for merge and
 pull
Message-ID: <20170329073704.vhya5gkwg7j5kchb@gmail.com>
References: <20170326070238.64522-1-mike@mplew.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170326070238.64522-1-mike@mplew.is>
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 26, 2017 at 03:02:38AM -0400, Mike Lewis wrote:
> Allows the user to verify and/or change the contents of the merge
> before committing as necessary
> 
> Signed-off-by: Mike Lewis <mike@mplew.is>
> ---
>  contrib/subtree/git-subtree.sh | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index dec085a23..c30087485 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -29,6 +29,8 @@ onto=         try connecting new tree to an existing one
>  rejoin        merge the new branch back into HEAD
>   options for 'add', 'merge', and 'pull'
>  squash        merge subtree changes as a single commit
> + options for 'merge' and 'pull'
> +no-commit     perform the merge, but don't commit
>  "
>  eval "$(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?)"
>  
> @@ -48,6 +50,7 @@ annotate=
>  squash=
>  message=
>  prefix=
> +commit_option="--commit"

It might be simpler to default commit_option= empty like the others, and
remove the "" double quotes around "$commit_option" indicated below so
that the shell ignores it when it's empty.

>  
>  debug () {
>  	if test -n "$debug"
> @@ -137,6 +140,12 @@ do
>  	--no-squash)
>  		squash=
>  		;;
> +	--no-commit)
> +		commit_option="--no-commit"
> +		;;
> +	--no-no-commit)
> +		commit_option="--commit"
> +		;;

"--no-no-commit" should just be "--commit" instead.
The real flag is called "--commit" (git help merge), so subtree
should follow suite by supporting "--commit" and "--no-commit" only.


> @@ -815,17 +824,17 @@ cmd_merge () {
>  	then
>  		if test -n "$message"
>  		then
> -			git merge -s subtree --message="$message" "$rev"
> +			git merge -s subtree --message="$message" "$commit_option" "$rev"
                                                                  ^              ^
>  		else
> -			git merge -s subtree "$rev"
> +			git merge -s subtree "$commit_option" "$rev"
                                             ^              ^
>  		fi
>  [...]

-- 
David
