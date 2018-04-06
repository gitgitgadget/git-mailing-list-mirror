Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A35E1F404
	for <e@80x24.org>; Fri,  6 Apr 2018 15:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751696AbeDFPui (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 11:50:38 -0400
Received: from mout.gmx.net ([212.227.17.20]:44461 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751027AbeDFPuh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 11:50:37 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LzKQf-1eQYJ21uwD-014Tx6; Fri, 06
 Apr 2018 17:50:29 +0200
Date:   Fri, 6 Apr 2018 17:50:12 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Joel Teichroeb <joel@teichroeb.net>
cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, gitster@pobox.com
Subject: Re: [PATCH v5 4/5] stash: convert branch to builtin
In-Reply-To: <20180405022810.15796-5-joel@teichroeb.net>
Message-ID: <nycvar.QRO.7.76.6.1804061743210.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180405022810.15796-1-joel@teichroeb.net> <20180405022810.15796-5-joel@teichroeb.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VoLYHEi3nCTwaEZoPDUTxfow6gUlHgcUBi++YiP1k3+RHpHaoOW
 HsmqhxT2oxFsxxEmLAQ84NmKZt/EfoQ9Aw2vWooDqZW3rsl+6a2vLeRf+5XEVp/Q+k7ImW0
 R2xY0cG2Y1Nt8GgJ7v/M0TT2QlS1yROYgqTz37koVT+So+rJ/dwobdjm/T/ljk83b3cNWuT
 Vqne9tf4Aq5158w0rrVvA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jdkGNksuKjI=:L4ANJ7vRz602p+inGZmzZw
 RmaawmFn6WemkDZNwvPV48w56rtqg6+RX+N0qpKrFbMuX0GLNzwFdWgfvysLQ4sSlqonBaKus
 mJ4WjBlIKLUC5Qxrm12rkYP37bUO4QbHp7rbFysa3u4uTTW3vvaB/yDG7KNcsCfrukpHwZZsi
 TvkQZ5nVa4fb1v3Ae9qZLzhQCyW6RAZ0ebckbgpQlWFleqtZrVTDG9xP+UUs2+Qa4DjMcShNw
 qoSdcrsCH/d5Ed0PSW1CR0xqACyl8YFi0D9njq0njw9LZjz6/lbVrSTsnBKm6sXsdRSd27Upz
 l6tSoimddPU3XQW75idM9ip4/JrNCvwzBeUJ360Z537x3n3xX+WfdUG9PZOxUNeJGhScwoLuN
 w74Cv+wlyvAPTiHBYUIm+4/+uoj0cup0NmZGEuDPZ+PuDG4a27hpR1dckltQTroavV1inIaJU
 lLxnOqlYGYtgwvP/6+ErgpBOPlS/UDbSWn2IchS6SxOFiIqlhLioc769qvIQoYOq6ct7TcAS4
 lOK6IVefPtlVUY8yZPgfGjShc6HPWjkDgEmD5wHNsyadSA77m/Fy6fbk4lMUu4XMk68NuV26B
 R10NvHzk97mtULf/eeM64IfutwVtYqu6FXWzhce9Z/fON5AMnAIw1wfvnlNC3w2tlcCIvKxCG
 lWKQ5C4jP7CJmL3RoFEYAHBZGxqcip0o84udwabz0SBMG5TDZhKN0kkl2ELbe/NlYa3j363cS
 w3g8paex0d3wt8APO5PrXRJOr9SUjyN/nDXmPUZyUFfK977PyfaQMSbTd7m41gyBtOPGgrHoN
 HAEkX6rJUYAsSAv/V1HjAUzuPfHjayYWlA6BMQU6Lm+vdeLCZGIdB9KENgSjDmQpluceq7E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joel,

On Wed, 4 Apr 2018, Joel Teichroeb wrote:

> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> index 520cd746c4..486796bb6a 100644
> --- a/builtin/stash--helper.c
> +++ b/builtin/stash--helper.c
> @@ -502,6 +508,49 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
>  	return ret;
>  }
>  
> +static int branch_stash(int argc, const char **argv, const char *prefix)
> +{
> +	const char *branch = NULL;
> +	int ret;
> +	struct argv_array args = ARGV_ARRAY_INIT;
> +	struct stash_info info;
> +	struct option options[] = {
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options,
> +			git_stash_helper_branch_usage, 0);
> +
> +	if (argc == 0)
> +		return error(_("No branch name specified"));

We should probably also test for argc > 2 and error out in that case...

> +
> +	branch = argv[0];
> +
> +	if (get_stash_info(&info, argc - 1, argv + 1))
> +		return -1;
> +
> +	/* Checkout does not currently provide a function for checking out a branch
> +	 * as cmd_checkout does a large amount of sanity checks first that we
> +	 * require here.
> +	 */

While this is true, this code comment is *prone* to become stale. Maybe
move this remark into the commit message?

> +	argv_array_pushl(&args, "checkout", "-b", NULL);
> +	argv_array_push(&args, branch);
> +	argv_array_push(&args, oid_to_hex(&info.b_commit));
> +	ret = cmd_checkout(args.argc, args.argv, prefix);
> +	if (ret) {
> +		free_stash_info(&info);
> +		return -1;
> +	}
> +
> +	ret = do_apply_stash(prefix, &info, 1);
> +	if (!ret && info.is_stash_ref)
> +		ret = do_drop_stash(prefix, &info);

An alternative way to translate that &&-chain would be to do this:

	ret = cmd_checkout(args.argc, args.argv, prefix);
	if (!ret)
		ret = do_apply_stash(prefix, &info, 1);
	if (!ret && info.is_stash_ref)
		ret = do_drop_stash(prefix, &info);

... which might be a bit easier to read and to maintain?

> +
> +	free_stash_info(&info);
> +
> +	return ret;
> +}
> +
>  int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  {
>  	int result = 0;
> @@ -528,6 +577,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  		result = clear_stash(argc, argv, prefix);
>  	else if (!strcmp(argv[0], "drop"))
>  		result = drop_stash(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "branch"))
> +		result = branch_stash(argc, argv, prefix);
>  	else {
>  		error(_("unknown subcommand: %s"), argv[0]);
>  		usage_with_options(git_stash_helper_usage, options);
> diff --git a/git-stash.sh b/git-stash.sh
> index 0b8f07b38a..c5fd4c6c44 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -598,20 +598,6 @@ drop_stash () {
>  	clear_stash
>  }
>  
> -apply_to_branch () {
> -	test -n "$1" || die "$(gettext "No branch name specified")"
> -	branch=$1
> -	shift 1
> -
> -	set -- --index "$@"
> -	assert_stash_like "$@"
> -
> -	git checkout -b $branch $REV^ &&
> -	apply_stash "$@" && {
> -		test -z "$IS_STASH_REF" || drop_stash "$@"
> -	}
> -}
> -
>  test "$1" = "-p" && set "push" "$@"
>  
>  PARSE_CACHE='--not-parsed'
> @@ -672,7 +658,8 @@ pop)
>  	;;
>  branch)
>  	shift
> -	apply_to_branch "$@"
> +	cd "$START_DIR"
> +	git stash--helper branch "$@"
>  	;;
>  *)
>  	case $# in

The rest looks obviously good to me (I am not all that sure about the `cd
"$START_DIR"` but it definitely does not hurt).

Ciao,
Dscho
