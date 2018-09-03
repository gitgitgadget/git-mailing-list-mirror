Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D0481F404
	for <e@80x24.org>; Mon,  3 Sep 2018 13:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbeICRtc (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 13:49:32 -0400
Received: from mout.gmx.net ([212.227.17.21]:39413 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbeICRtc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 13:49:32 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LsxuQ-1fmY9q3fp4-012XQ8; Mon, 03
 Sep 2018 15:29:20 +0200
Date:   Mon, 3 Sep 2018 15:29:20 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v8 08/20] stash: convert branch to builtin
In-Reply-To: <ed6aea4eb1e60dfe5c77ce8c9bc9d8409b658aed.1535665109.git.ungureanupaulsebastian@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1809031527000.71@tvgsbejvaqbjf.bet>
References: <cover.1535665109.git.ungureanupaulsebastian@gmail.com> <ed6aea4eb1e60dfe5c77ce8c9bc9d8409b658aed.1535665109.git.ungureanupaulsebastian@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MEuRDbSq7aDSIZKBd4lF/v/AzXLiF5xnLqwmpi7BdLKdozvdSpR
 squ33LnSXpUs/7Kt4YBl1zXsaRrvV+YOyBHaf4mDfXUt+LpVt8IIVOIJ6TQ9oqx6781jqS4
 2hvU6AcwObCKseRtE3VSGZU+RES0ocxj3C905XeykgJ2FDjKUEazOO7XHGYqXS+txoDiSBG
 XCBEuuk9SbC4OInruZb7A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:S3MB+T1i9Z0=:NcGhuNbYOfZUUKhNZ1T+gX
 5nCNgFSjt+RhMS/APOnIn/zTnXIdx+HTpVajpUBITQyT8BnmEFlLeDXTo+3Ee0A1wc9HobHo/
 of4fLl9IO9nJNIfNGuVe8NAP3fzeiAShiBZF+dboLKzn5/NSMW7s+WWzePYNZuMsdWIvgNakl
 KnGF3mSVlCB7jLLUZk8Gok9vBOLXrvtdk3U9LZw0j4O23nxPpqFWYQSuOYO4YbreoNs36JIvg
 Fz484l9PbEjB9AYuprab8GtBJwZXasmbbNaEr2946sKicrvH9z5JD6qxGIlqqSrhQHjfvSxAQ
 NHm/VBB3XsKASCGMZqLMNznu151XXRVdEa1NiG6b0kE8j8OCaWJSkUc7P85SLPJ99ZFi9+lyq
 54jw2dDsE7PdLZmtBEijPhxc85SdmOvK5rAANODi6STs/E4S+URbXhdbnkBRFU0BY+osQv555
 uT6rGh6Uv08f5rf+rmZIN6XUL2TeST9+KBP16bv/iWyDLQZgtlJRq56kfA3knFWOrVa8uHU8y
 EFyCRfv6Y9GTiYXCzzMpwKb83OwH1RTq5EKvFYg14leVli/5rnCbe9KKGiKjQSwGk64izIZ+b
 +s83whAqMvqoZN9H2SOzMub4rAiFBz/z0yjAtLMRswIHBmE/TmnzJfQNtTWthZOhzMMZ34GP6
 ptRbnCjFV0Exm992HumxQVQjMZcuBNHWP7E3dro8B/AJyUquMu3GzMdlUkZ70J6nOCj9X07gh
 95FPAqc9vGm3D1f7F39FDYlczmJCpagBVbRr0mcx5N0EEbQVWWsWrAj8JC9SLYXopszR519jF
 HMIPMfK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul,

On Fri, 31 Aug 2018, Paul-Sebastian Ungureanu wrote:

> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> index cbe23fef11..dadc028649 100644
> --- a/builtin/stash--helper.c
> +++ b/builtin/stash--helper.c
> @@ -535,6 +541,42 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
>  	return ret;
>  }
>  
> +static int branch_stash(int argc, const char **argv, const char *prefix)
> +{
> +	const char *branch = NULL;
> +	int ret;
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	struct stash_info info;
> +	struct option options[] = {
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options,
> +			     git_stash_helper_branch_usage, 0);
> +
> +	if (!argc)
> +		return error(_("No branch name specified"));

Very minor: when calling `error()`, the message is prefixed with a
lower-case "error:" and our convention is to continue in lower-case.

Ciao,
Dscho

> +
> +	branch = argv[0];
> +
> +	if (get_stash_info(&info, argc - 1, argv + 1))
> +		return -1;
> +
> +	cp.git_cmd = 1;
> +	argv_array_pushl(&cp.args, "checkout", "-b", NULL);
> +	argv_array_push(&cp.args, branch);
> +	argv_array_push(&cp.args, oid_to_hex(&info.b_commit));
> +	ret = run_command(&cp);
> +	if (!ret)
> +		ret = do_apply_stash(prefix, &info, 1);
> +	if (!ret && info.is_stash_ref)
> +		ret = do_drop_stash(prefix, &info);
> +
> +	free_stash_info(&info);
> +
> +	return ret;
> +}
> +
>  int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  {
>  	pid_t pid = getpid();
> @@ -561,6 +603,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  		return !!clear_stash(argc, argv, prefix);
>  	else if (!strcmp(argv[0], "drop"))
>  		return !!drop_stash(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "branch"))
> +		return !!branch_stash(argc, argv, prefix);
>  
>  	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
>  		      git_stash_helper_usage, options);
> diff --git a/git-stash.sh b/git-stash.sh
> index a99d5dc9e5..29d9f44255 100755
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
> @@ -673,7 +659,8 @@ pop)
>  	;;
>  branch)
>  	shift
> -	apply_to_branch "$@"
> +	cd "$START_DIR"
> +	git stash--helper branch "$@"
>  	;;
>  *)
>  	case $# in
> -- 
> 2.19.0.rc0.22.gc26283d74e
> 
> 
