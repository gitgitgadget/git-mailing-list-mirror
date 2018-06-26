Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E777D1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 22:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933675AbeFZWbl (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 18:31:41 -0400
Received: from mout.gmx.net ([212.227.17.21]:57903 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933266AbeFZWbj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 18:31:39 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MbrR4-1fq9ZX2AoI-00JMWp; Wed, 27
 Jun 2018 00:31:37 +0200
Date:   Wed, 27 Jun 2018 00:31:37 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v6 4/4] stash: convert pop to builtin
In-Reply-To: <5d5b05caecc01d8f252ef5f8495549663815ed63.1529943789.git.ungureanupaulsebastian@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1806270029450.21419@tvgsbejvaqbjf.bet>
References: <cover.1529943789.git.ungureanupaulsebastian@gmail.com> <5d5b05caecc01d8f252ef5f8495549663815ed63.1529943789.git.ungureanupaulsebastian@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Aq3C2OmvtmBW4KWrG3ky3LqwF/NcDHj8GxviEJWCRjNaWwNEd9S
 3hih+Rb2e95OQSPQU81iT8ZZjlJnbkyPitOigbskZanZPZN1+ZdrLhKE4ClRAzpQS4Oc9OH
 WUBpLoTiKNqKqz2fb27ZYMGeYCXYGgJx8g5lwvly6xeaqkyPRSjUJ3PGBMmRyDma6vv5ubj
 KIj34f9b2JEmItsiJUQjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CpDaPrUCOOM=:tMgqoaCS5h8b6XKqz1TiBz
 F6AZLgxPcniQN6kvfykieT/SV/kGSf/1Aim2SO8NCmq5nNk9ytw5GtO67yHmVeC+beiKY6jS/
 j5ZGWl7q50HMKryYLoz9dkpTldGj2nGqFCCnxsg7Dj+ICwDgE/wSq0KowMkdG8LwEPjnpczir
 YZ0LSsoOHgn2qlO+/nLIRhsfxDgr/RtnhvwpdMs5wbuhwVpp+52nzo1NWTCGGKKEeqaijDytH
 e8cOfmtPdbqufuqcCIgqEfQTy8nhqSvFrs51VpwCgG8+hQLwrsVUUG+6msmMEO2I6ZQ5+DeWd
 ZSApqQrmfhICK9CXSn2u+y0fM7THCzTXPWg+kj2PfPhr3ClaHfbJXmXvx+cLfxL1zzWFm4286
 MHnVVHmRODxMP7AUhj3myjUqDAMiZsdprYNBGkVmmws8gZmTCNfQxMmz2Yf0qFFnbN3uQ747q
 beOKDZ4d2kSyoZJnyS3+eY2fy5jsghIOqX0dKKxJKwmkZKKhyMa3s1Ujqyzmuo4fcqibFWotz
 0WECVSfWALsJ2ghTG8/mV6lMKP0DhC0BKCSFkicCh5x4usflvCtxeCjqwlbozhHaTdrWRQlgY
 +GJ70sX/3bm3IM8sTCzeolBK3LhJpwpuhIXGu2rgkPWMW3QDf6W3p/3qLvoXNTjTx4XjW9Gpc
 Wl7xgqsgFNvSeSsw7vRy9mkz7OVvyLw+SHiw83pMI5mCfWjDyHdOfBUmpTTPokbVazwl6DORM
 1VdlCr0TAh8EEXfXTp4/WIhUZcYwO4tVz7+4yDfxYx0T5exU89Mp7x02wvv11Pso032xIM/Q/
 Ac1np4/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul,

I think I had revewied these 4 patches before, and I'd wager a bet that
you addressed all of my suggestions, if any.

I had a look over patches 2-4, and want to take a little bit more time
tomorrow to pour over patch 1 (which is a little larger, as it lays a lot
of ground work), to make sure that I cannot find anything else to improve.

Well done so far!
Dscho


On Mon, 25 Jun 2018, Paul-Sebastian Ungureanu wrote:

> From: Joel Teichroeb <joel@teichroeb.net>
> 
> Add stash pop to the helper and delete the pop_stash, drop_stash,
> assert_stash_ref functions from the shell script now that they
> are no longer needed.
> 
> Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
> Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> ---
>  builtin/stash--helper.c | 36 ++++++++++++++++++++++++++++++-
>  git-stash.sh            | 47 ++---------------------------------------
>  2 files changed, 37 insertions(+), 46 deletions(-)
> 
> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> index fbf78249c..a38d6ae8a 100644
> --- a/builtin/stash--helper.c
> +++ b/builtin/stash--helper.c
> @@ -13,7 +13,7 @@
>  
>  static const char * const git_stash_helper_usage[] = {
>  	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
> -	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
> +	N_("git stash--helper ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
>  	N_("git stash--helper branch <branchname> [<stash>]"),
>  	N_("git stash--helper clear"),
>  	NULL
> @@ -24,6 +24,11 @@ static const char * const git_stash_helper_drop_usage[] = {
>  	NULL
>  };
>  
> +static const char * const git_stash_helper_pop_usage[] = {
> +	N_("git stash--helper pop [--index] [-q|--quiet] [<stash>]"),
> +	NULL
> +};
> +
>  static const char * const git_stash_helper_apply_usage[] = {
>  	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
>  	NULL
> @@ -528,6 +533,33 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
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
> +			     git_stash_helper_pop_usage, 0);
> +
> +	if (get_stash_info(&info, argc, argv))
> +		return -1;
> +
> +	assert_stash_ref(&info);
> +	if ((ret = do_apply_stash(prefix, &info, index)))
> +		printf_ln(_("The stash entry is kept in case you need it again."));
> +	else
> +		ret = do_drop_stash(prefix, &info);
> +
> +	free_stash_info(&info);
> +	return ret;
> +}
> +
>  static int branch_stash(int argc, const char **argv, const char *prefix)
>  {
>  	const char *branch = NULL;
> @@ -589,6 +621,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  		return !!clear_stash(argc, argv, prefix);
>  	else if (!strcmp(argv[0], "drop"))
>  		return !!drop_stash(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "pop"))
> +		return !!pop_stash(argc, argv, prefix);
>  	else if (!strcmp(argv[0], "branch"))
>  		return !!branch_stash(argc, argv, prefix);
>  
> diff --git a/git-stash.sh b/git-stash.sh
> index 29d9f4425..8f2640fe9 100755
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
> @@ -655,7 +611,8 @@ drop)
>  	;;
>  pop)
>  	shift
> -	pop_stash "$@"
> +	cd "$START_DIR"
> +	git stash--helper pop "$@"
>  	;;
>  branch)
>  	shift
> -- 
> 2.18.0.rc2.13.g506fc12fb
> 
> 
