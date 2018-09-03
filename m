Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E1B01F404
	for <e@80x24.org>; Mon,  3 Sep 2018 14:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbeICTBO (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 15:01:14 -0400
Received: from mout.gmx.net ([212.227.15.19]:39825 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbeICTBO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 15:01:14 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MXqaN-1gQmoH0aet-00WpbG; Mon, 03
 Sep 2018 16:40:42 +0200
Date:   Mon, 3 Sep 2018 16:40:41 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v8 15/20] stash: convert push to builtin
In-Reply-To: <18debd5c9b1dc11a763caac39e10d4e8d5894bcb.1535665109.git.ungureanupaulsebastian@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1809031613390.71@tvgsbejvaqbjf.bet>
References: <cover.1535665109.git.ungureanupaulsebastian@gmail.com> <18debd5c9b1dc11a763caac39e10d4e8d5894bcb.1535665109.git.ungureanupaulsebastian@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2eYNHzPiIeJ3ue0qdnKdRXjhrIfaYQs30i7F5rPeT02GcMwQcta
 qgNC3VretuIqn+WnhHD4miRmUQ4a/H5JjEzDSQMIBOumsrYZCZH6rh+ivarYVS/HVB8t5Ot
 WNGZqX4tiEsPu1PHxHyQm6YGpyYei9eqN5W2DZ6dcFpkFSUaLW17tyw8KlxDxZa9aA+pcM4
 g+WPYTPUCSprgR7Ldh8Pw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qq2aKBqdcjo=:KXTiTW1gLSN3nLpDIrTTYe
 fOr6tUd9+IT0KpXAcsj/2zrnUBNt9YSncPJ87UNTnZqA6DBI5xTsikZCwnU1A5puX/gWNTSnW
 YQbjiDbS6ffBTnk0W6hymM+A6dvzX4Lhps5/Oo7NzVeunwm64oUglZkRnqfhInBvq3nkkkTLN
 GS14BTzOwjgfQDp12B3bXVCfHuQnFNmzVh1Udvg1EJKvIPdiMRZ/h4pCu5qFpPKeXcnQE87Kk
 czzfSE5BF2KagFLZ/9owEfyUwJeOqr7vf3YPnjKoWepX7jBlJYIwwz1p1hOTTVLbKWpwAS7zT
 E3lZfPdS9aLkJxNauk1QnEBOIHUkTkqhA/rw8NM4Rnw+TBnUXmljjg7aE1Dz4Jp4ol2mvqbtM
 D68qY4uqXJYdt3bfsuJIh0gZqKEYOA6YiWJdoT2M2OGElRcLtgDeRUvMBVSw4qIhHMrkgZ/Ze
 DcOG1X/ebXS6BNssULHclgcMV1cVrV/r95WepRUaWbl/TwEauDN8dooq25XtuTs+bMhxP0ddT
 yAi37ZdvnqWOuVCzYx05zXyR1Ps9eJypy5RQC4zQBjQw16VclKwlp7BVo3oVS36Zm7JXmUSo5
 KAwH072nuSrJSpU+CUVoAXQjrLKx0uJ3grjLdIZm1yCWbsJn9q8CRzMpLeBQYjpuSCAjNGoQA
 Ps2dMmPkH/XEl8Qa3m29P6cgf7LkQ1QRdCrSL1cicZ8H14N2AHnHmDhUw2WLgFqPNR1vJYejg
 CeFN2EQ2YMAHp/n14reZ/n3MGmN+FYoGMmcaUBGuFquj0XUhQDK4oS0s0y6gOXMlRVe6YVSXU
 ynQl1sa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul,

On Fri, 31 Aug 2018, Paul-Sebastian Ungureanu wrote:

> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> index ce360a569d..23670321d8 100644
> --- a/builtin/stash--helper.c
> +++ b/builtin/stash--helper.c
> @@ -1204,6 +1214,223 @@ static int create_stash(int argc, const char **argv, const char *prefix)
>  	return ret < 0;
>  }
>  
> +static void add_ps_items_to_argv_array(struct argv_array *args,
> +				       struct pathspec ps) {

As this is a purely file-local function (and will probably stay that way),
`add_pathspecs()` might be sweeter to the eyes.

> +	int i;
> +	for (i = 0; i < ps.nr; ++i)

I vaguely recall that Junio preferred an empty line between the
declarations and the first statement. Let's give him his wish?

Also, he recently remarked in a different thread that he prefers `i++`
when the value is not used immediately.

> +		argv_array_push(args, ps.items[i].match);
> +}
> +
> +static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
> +			 int keep_index, int patch_mode, int include_untracked)
> +{
> +	int ret = 0;
> +	struct stash_info info;
> +	if (patch_mode && keep_index == -1)
> +		keep_index = 1;
> +
> +	if (patch_mode && include_untracked) {
> +		fprintf_ln(stderr, _("Can't use --patch and --include-untracked or --all at the same time"));

We usually wrap these long lines by using the C feature where you can
"interrupt" a string literal by putting end quotes on the first line, and
start with a quote in the next line, and the compiler will handle that as
if it was one string. In this instance:

		fprintf_ln(stderr, _("Can't use --patch and --include-untracked"
				     " or --all at the same time"));

> +		return -1;
> +	}
> +
> +	read_cache_preload(NULL);
> +	if (!include_untracked && ps.nr) {
> +		int i;
> +		char *ps_matched = xcalloc(ps.nr, 1);
> +
> +		for (i = 0; i < active_nr; ++i) {
> +			const struct cache_entry *ce = active_cache[i];
> +			ce_path_match(&the_index, ce, &ps, ps_matched);
> +		}
> +
> +		if (report_path_error(ps_matched, &ps, NULL)) {
> +			fprintf_ln(stderr, _("Did you forget to 'git add'?"));
> +			return -1;
> +		}
> +		free(ps_matched);
> +	}
> +
> +	if (refresh_cache(REFRESH_QUIET))
> +		return -1;
> +
> +	if (!check_changes(ps, include_untracked)) {
> +		printf_ln(_("No local changes to save"));
> +		return 0;
> +	}
> +
> +	if (!reflog_exists(ref_stash) && do_clear_stash()) {
> +		fprintf_ln(stderr, _("Cannot initialize stash"));
> +		return -1;

While technically not necessary, I would prefer to write `goto done` here,
too. It is too easy to forget when introducing/changing code paths.

> +	}
> +
> +	if (do_create_stash(ps, &stash_msg, include_untracked, patch_mode,
> +			    &info)) {
> +		ret = -1;
> +		goto done;
> +	}
> +
> +	if (do_store_stash(oid_to_hex(&info.w_commit), stash_msg, 1)) {
> +		fprintf(stderr, _("Cannot save the current status"));

We probably want to use fprintf_ln() here.

> +		ret = -1;
> +		goto done;
> +	}
> +
> +	printf_ln(_("Saved working directory and index state %s"), stash_msg);
> +
> +	if (!patch_mode) {

It might be easier to read if the `if (patch_mode)` block was handled
first, which would call `goto done` also in case of success, not only in
case of failure.

> +		if (include_untracked && !ps.nr) {
> +			struct child_process cp = CHILD_PROCESS_INIT;
> +
> +			cp.git_cmd = 1;
> +			argv_array_pushl(&cp.args, "clean", "--force",
> +					 "--quiet", "-d", NULL);
> +			if (include_untracked == 2)
> +				argv_array_push(&cp.args, "-x");
> +			if (run_command(&cp)) {
> +				ret = -1;
> +				goto done;
> +			}
> +		}
> +		if (ps.nr) {
> +			struct child_process cp1 = CHILD_PROCESS_INIT;
> +			struct child_process cp2 = CHILD_PROCESS_INIT;
> +			struct child_process cp3 = CHILD_PROCESS_INIT;
> +			struct strbuf out = STRBUF_INIT;
> +
> +			cp1.git_cmd = 1;
> +			argv_array_push(&cp1.args, "add");
> +			if (!include_untracked)
> +				argv_array_push(&cp1.args, "-u");
> +			if (include_untracked == 2)

I think it would make sense to turn this into an `enum`, or at least to
`#define` the magic constant `2` into something like `INCLUDE_ALL`.

> +				argv_array_push(&cp1.args, "--force");
> +			argv_array_push(&cp1.args, "--");
> +			add_ps_items_to_argv_array(&cp1.args, ps);
> +			if (run_command(&cp1)) {
> +				ret = -1;
> +				goto done;
> +			}
> +
> +			cp2.git_cmd = 1;
> +			argv_array_pushl(&cp2.args, "diff-index", "-p",
> +					 "--cached", "--binary", "HEAD", "--",
> +					 NULL);
> +			add_ps_items_to_argv_array(&cp2.args, ps);
> +			if (pipe_command(&cp2, NULL, 0, &out, 0, NULL, 0)) {
> +				ret = -1;
> +				goto done;
> +			}
> +
> +			cp3.git_cmd = 1;
> +			argv_array_pushl(&cp3.args, "apply", "--index", "-R",
> +					 NULL);
> +			if (pipe_command(&cp3, out.buf, out.len, NULL, 0, NULL,
> +					 0)) {
> +				ret = -1;
> +				goto done;
> +			}
> +		} else {
> +			struct child_process cp = CHILD_PROCESS_INIT;
> +			cp.git_cmd = 1;
> +			argv_array_pushl(&cp.args, "reset", "--hard", "-q",
> +					 NULL);
> +			if (run_command(&cp)) {
> +				ret = -1;
> +				goto done;
> +			}
> +		}
> +
> +		if (keep_index == 1 && !is_null_oid(&info.i_tree)) {
> +			struct child_process cp1 = CHILD_PROCESS_INIT;
> +			struct child_process cp2 = CHILD_PROCESS_INIT;
> +			struct strbuf out = STRBUF_INIT;
> +
> +			if (reset_tree(&info.i_tree, 0, 1)) {
> +				ret = -1;
> +				goto done;
> +			}
> +
> +			cp1.git_cmd = 1;
> +			argv_array_pushl(&cp1.args, "ls-files", "-z",
> +					 "--modified", "--", NULL);
> +			add_ps_items_to_argv_array(&cp1.args, ps);
> +			if (pipe_command(&cp1, NULL, 0, &out, 0, NULL, 0)) {
> +				ret = -1;
> +				goto done;
> +			}
> +
> +			cp2.git_cmd = 1;
> +			argv_array_pushl(&cp2.args, "checkout-index", "-z",
> +					 "--force", "--stdin", NULL);
> +			if (pipe_command(&cp2, out.buf, out.len, NULL, 0, NULL,
> +					 0)) {
> +				ret = -1;
> +				goto done;
> +			}
> +		}
> +	} else {
> +		struct child_process cp = CHILD_PROCESS_INIT;
> +
> +		cp.git_cmd = 1;
> +		argv_array_pushl(&cp.args, "apply", "-R", NULL);
> +
> +		if (pipe_command(&cp, patch.buf, patch.len, NULL, 0, NULL, 0)) {
> +			fprintf_ln(stderr, _("Cannot remove worktree changes"));
> +			ret = -1;
> +			goto done;
> +		}
> +
> +		if (keep_index < 1) {
> +			int i;
> +			struct child_process cp = CHILD_PROCESS_INIT;
> +
> +			cp.git_cmd = 1;
> +			argv_array_pushl(&cp.args, "reset", "-q", "--", NULL);
> +			for (i = 0; i < ps.nr; ++i)
> +				argv_array_push(&cp.args, ps.items[i].match);
> +			if (run_command(&cp)) {
> +				ret = -1;
> +				goto done;
> +			}
> +		}
> +	}
> +done:
> +	free((char *) stash_msg);
> +	return ret;
> +}
> +
> +static int push_stash(int argc, const char **argv, const char *prefix)
> +{
> +	int keep_index = -1;
> +	int patch_mode = 0;
> +	int include_untracked = 0;
> +	int quiet = 0;
> +	const char *stash_msg = NULL;
> +	struct pathspec ps;
> +	struct option options[] = {
> +		OPT_SET_INT('k', "keep-index", &keep_index,
> +			N_("keep index"), 1),

Shouldn't this be an `OPT_BOOL`? I do not know whether `OPT_SET_INT`
handles the `--no-keep-index` as intended, but I do know that of
`OPT_BOOL`...

Thanks,
Dscho

> +		OPT_BOOL('p', "patch", &patch_mode,
> +			N_("stash in patch mode")),
> +		OPT__QUIET(&quiet, N_("quiet mode")),
> +		OPT_BOOL('u', "include-untracked", &include_untracked,
> +			 N_("include untracked files in stash")),
> +		OPT_SET_INT('a', "all", &include_untracked,
> +			    N_("include ignore files"), 2),
> +		OPT_STRING('m', "message", &stash_msg, N_("message"),
> +			 N_("stash message")),
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options,
> +			     git_stash_helper_push_usage,
> +			     0);
> +
> +	parse_pathspec(&ps, 0, PATHSPEC_PREFER_FULL, prefix, argv);
> +	return do_push_stash(ps, stash_msg, quiet, keep_index, patch_mode,
> +			     include_untracked);
> +}
> +
>  int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  {
>  	pid_t pid = getpid();
> @@ -1242,6 +1469,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  		return !!store_stash(argc, argv, prefix);
>  	else if (!strcmp(argv[0], "create"))
>  		return !!create_stash(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "push"))
> +		return !!push_stash(argc, argv, prefix);
>  
>  	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
>  		      git_stash_helper_usage, options);
> diff --git a/git-stash.sh b/git-stash.sh
> index ab06e4ffb8..c3146f62ab 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -412,7 +412,8 @@ save)
>  	;;
>  push)
>  	shift
> -	push_stash "$@"
> +	cd "$START_DIR"
> +	git stash--helper push "$@"
>  	;;
>  apply)
>  	shift
> @@ -448,7 +449,8 @@ branch)
>  *)
>  	case $# in
>  	0)
> -		push_stash &&
> +		cd "$START_DIR"
> +		git stash--helper push &&
>  		say "$(gettext "(To restore them type \"git stash apply\")")"
>  		;;
>  	*)
> -- 
> 2.19.0.rc0.22.gc26283d74e
> 
> 
