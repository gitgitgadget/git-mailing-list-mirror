Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3499B1F404
	for <e@80x24.org>; Fri,  6 Apr 2018 16:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751754AbeDFQM0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 12:12:26 -0400
Received: from mout.gmx.net ([212.227.17.21]:48247 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751435AbeDFQM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 12:12:26 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M6fXs-1eGtaz0d52-00wVRD; Fri, 06
 Apr 2018 18:12:21 +0200
Date:   Fri, 6 Apr 2018 18:12:04 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Joel Teichroeb <joel@teichroeb.net>
cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, gitster@pobox.com
Subject: Re: [PATCH v5 5/5] stash: convert pop to builtin
In-Reply-To: <20180405022810.15796-6-joel@teichroeb.net>
Message-ID: <nycvar.QRO.7.76.6.1804061755000.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180405022810.15796-1-joel@teichroeb.net> <20180405022810.15796-6-joel@teichroeb.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:e+XMedKkbHIMpxbuEPJk2iVtQneCQY47asORsVffKHS/rv9+jCi
 s1VSPllxGYC5aJtly5oNulrzyx0aRQEjr6NUgSfe1+GxDq0UxBWRr0RIDP5ieeo2OfIUjvF
 z7om0Qjs7T0x3Jy/98KhUCkKoY2hEAT3rVER6YQ/p6YKPICw7dCWJ0uLGWsv4C+zP8P1dNp
 38Ig+JXnLewVr/L0VZE3w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:O2rWtlgvOHQ=:s/slDVUrMpPd8kldsT973M
 tyq+GGvpCVJrPBO095c/YMosjIbrgNN0P+P/Lgdi2nCh8R37Z6X+4YkfUK/+3qLhaslzbfhmM
 xTQAUcG0gTYZIDtSSAFHSgCfgpcmwkfAlQWejuoj+s8oQHK2Qp8O4QC5ssgkiYKJa9dFqY0Dm
 NbyY/yuq2mUXX8yw1ighyi5CkOeayH9+4jxfC3lYYw1drIRII4dBZGaFPzmet8xX3YgMI2lwG
 iT68wTVYg1F4smKmoUOLYXXpkuudwwnZAQZnfSGW52cjzbha1Z6sETc9vB2+6rpXf95w27SwB
 qAuwqVol9cWPk/dy06b0nzu2xK4Fn5D5/AGsc+nv4N7NQ+guxl1IMRd9lYcYnjysA9NPJAd5U
 /xH2rHi44xEhKT4DztdJqk6KweMrD8fdWC3yobHo7ai7njzPeSMYOhFJon14k3sxlV6ieJaNV
 Y4vTarpSclqeQhGe6BYa8mSFxbBqtPO909fk2II+woXb8qO8p0d5Sp7G7XkulUpQOQFj1VFpb
 Iibz49Uc1b3AsFSOx4za7TygdhtqobW/kkb/qYVwxYqG2/ZCymLWRZjLuCNn777EtyMw1RhWd
 G07tKA/J7dcZ5FTXifbkZalDYMpftVcfKHwCsm+ODHT3F+QpTQNeZQZu0iwSo7RcEdJuUNjMS
 EcUYRsdsU8r6H7AEoP5DoJvkhLdsLaVMLu7VoRoNd3svU7xY4xLCE6ye7wXHGGs9nBy83Q7wY
 wUaz5CgiSemA4H3GUFuOKbKvvFslZV1U9axs94ZPZYj//S9vkVytt4CcNXXYthCWDF0q6Rpy7
 Y+EJezWWj8prpO0+XrB1jB0OOkRI27oYbYL2DOMssnRwNf+1Ua3oQV9jxms70wjGs5Ji9r4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joel,

On Wed, 4 Apr 2018, Joel Teichroeb wrote:

> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> index 486796bb6a..7c8950bc90 100644
> --- a/builtin/stash--helper.c
> +++ b/builtin/stash--helper.c
> @@ -13,6 +13,7 @@
>  
>  static const char * const git_stash_helper_usage[] = {
>  	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
> +	N_("git stash--helper pop [--index] [-q|--quiet] [<stash>]"),
>  	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),

In the shell version, it says `( pop | apply )`. I think we should do that
here, too.

> @@ -508,6 +514,39 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
>  	return ret;
>  }
>  
> +static int pop_stash(int argc, const char **argv, const char *prefix)
> +{
> +	int index = 0, ret;
> +	struct stash_info info;
> +	struct option options[] = {
> +		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
> +		OPT_BOOL(0, "index", &index,
> +			N_("attempt to recreate the index")),
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options,
> +			git_stash_helper_pop_usage, 0);

I think we should test argc after this, too.

> +
> +	if (get_stash_info(&info, argc, argv))
> +		return -1;
> +
> +	if (assert_stash_ref(&info)) {
> +		free_stash_info(&info);
> +		return -1;
> +	}
> +
> +	if (do_apply_stash(prefix, &info, index)) {
> +		printf_ln(_("The stash entry is kept in case you need it again."));
> +		free_stash_info(&info);
> +		return -1;
> +	}

The same `if (!ret)` trick to convert &&-chains as I mentioned earlier
could be used here, too.

> +
> +	ret = do_drop_stash(prefix, &info);
> +	free_stash_info(&info);
> +	return ret;
> +}
> +
>  static int branch_stash(int argc, const char **argv, const char *prefix)
>  {
>  	const char *branch = NULL;
> @@ -577,6 +616,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  		result = clear_stash(argc, argv, prefix);
>  	else if (!strcmp(argv[0], "drop"))
>  		result = drop_stash(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "pop"))
> +		result = pop_stash(argc, argv, prefix);
>  	else if (!strcmp(argv[0], "branch"))
>  		result = branch_stash(argc, argv, prefix);
>  	else {
> diff --git a/git-stash.sh b/git-stash.sh
> index c5fd4c6c44..8f2640fe90 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -554,50 +554,6 @@ assert_stash_like() {
>  	}
>  }
>  
> -is_stash_ref() {
> -	is_stash_like "$@" && test -n "$IS_STASH_REF"
> -}
> -
> -assert_stash_ref() {
> -	is_stash_ref "$@" || {
> -		args="$*"
> -		die "$(eval_gettext "'\$args' is not a stash reference")"
> -	}
> -}
> -
> -apply_stash () {
> -	cd "$START_DIR"
> -	git stash--helper apply "$@"
> -	res=$?
> -	cd_to_toplevel
> -	return $res
> -}
> -
> -pop_stash() {
> -	assert_stash_ref "$@"
> -
> -	if apply_stash "$@"
> -	then
> -		drop_stash "$@"
> -	else
> -		status=$?
> -		say "$(gettext "The stash entry is kept in case you need it again.")"
> -		exit $status
> -	fi
> -}
> -
> -drop_stash () {
> -	assert_stash_ref "$@"
> -
> -	git reflog delete --updateref --rewrite "${REV}" &&
> -		say "$(eval_gettext "Dropped \${REV} (\$s)")" ||
> -		die "$(eval_gettext "\${REV}: Could not drop stash entry")"
> -
> -	# clear_stash if we just dropped the last stash entry
> -	git rev-parse --verify --quiet "$ref_stash@{0}" >/dev/null ||
> -	clear_stash
> -}
> -
>  test "$1" = "-p" && set "push" "$@"
>  
>  PARSE_CACHE='--not-parsed'
> @@ -634,7 +590,8 @@ push)
>  	;;
>  apply)
>  	shift
> -	apply_stash "$@"
> +	cd "$START_DIR"
> +	git stash--helper apply "$@"
>  	;;
>  clear)
>  	shift
> @@ -654,7 +611,8 @@ drop)
>  	;;
>  pop)
>  	shift
> -	pop_stash "$@"
> +	cd "$START_DIR"
> +	git stash--helper pop "$@"
>  	;;
>  branch)
>  	shift

Nice!

Ciao,
Dscho
