Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 016E11F404
	for <e@80x24.org>; Mon,  3 Sep 2018 14:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbeICTRl (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 15:17:41 -0400
Received: from mout.gmx.net ([212.227.17.21]:49429 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbeICTRk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 15:17:40 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M5csW-1fhWIc1PpY-00xYTR; Mon, 03
 Sep 2018 16:57:06 +0200
Date:   Mon, 3 Sep 2018 16:57:05 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v8 18/20] stash: convert `stash--helper.c` into
 `stash.c`
In-Reply-To: <82f5af08c6475765fac27e30f716a48039d56404.1535665109.git.ungureanupaulsebastian@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1809031640490.71@tvgsbejvaqbjf.bet>
References: <cover.1535665109.git.ungureanupaulsebastian@gmail.com> <82f5af08c6475765fac27e30f716a48039d56404.1535665109.git.ungureanupaulsebastian@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Kh2hblm1S/qQ7B108hmrvd1JyVtZsij31ql/hmsm+AAuNR0RHHE
 1yih1Giryp2bbuQfmKsqL562sG0hfMrpCxXQ78iX829hNxBTFCucZdR7CM8F/+wtsexb1r4
 82oVr6U1qng+hK2M71tvAbGfob54oWUAL3BX8GuZwZRFayAv8Jo7KGy0/4D5C909bRw1OSo
 Gn40Bqxa8QKUDwM+leEvA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iHuHUVwhhw8=:L4BmJchFcJ1/QRvPT6+KSt
 D/GSreDED10vlF+5XCGZLhEbRjDsDD02+Gn0qcvF8AOZwohHY3U86lmp57Xqhkej/av1xwQyq
 qrqZ6nMm2GgeXT9Y9W0O74cM/RHxgeXpjCFrvXIQY1FNF50Pb7LzsFNLrmS5wiAW77fpid8Vg
 nVnAt9k0vM+fIyv2IglmYiF9I5uLI48zNp6l/ZiSai9tSQwjewJyWTsfmdnFIGmEUxP7ncOvQ
 9fuWZJCYamCwvAz3tiZTgf/Hmk9sbrgBsqUtsXB9VaAXyXsvtDOq0yojSU9Hri5JYq0YSDob0
 WEZYeFFLptxXQCh35ce5yiSkj6MUd7W/NssdBrKpyonDT9fNRxGxbVE4QFcPvNTjrnqONHJep
 Qmku+S+KqHF0zygtXY9xSrmQFPIn9cWw75UVdvGw3B0xyVTqBG3GV5GNyydRqBsqStiZayre5
 scDt0bKUQU6On9ujcDhpygGz4kohmiZK5LEYew876+EpBAourIDNtpiyY2IGvkF1IaiYOSI3Z
 J4SgRob1ebIBFe8aZwNFJ8LZKIkzZGb6nTO1UEzTuduZwGOhE+SwV2Te1ZkUHwIvUOGlhvdT9
 xqbQeGN27/hJwEzxGevVaoSdEx/5uxnCiVrtbxNKAs5SivblMGzBlGBNNGoqZQGnB6H/dh7XN
 IKSqvIqsI30K7PKdav6NAQczWOYDl6mCFNSh7Q48YdCOwSG6H42M8t9aKZv3uRvFhpQTfEEgd
 SU9fxqahx/8/dh/3ZQhWsvKUEfNYjn3VR97Mgun4HiDKGRsrc11C7YHWIo0jTzwQbIgK4O7du
 0Q45k8R
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul,

On Fri, 31 Aug 2018, Paul-Sebastian Ungureanu wrote:

> diff --git a/builtin/stash--helper.c b/builtin/stash.c
> similarity index 90%
> rename from builtin/stash--helper.c
> rename to builtin/stash.c
> index 1269f2548c..3d2316e3f7 100644
> --- a/builtin/stash--helper.c
> +++ b/builtin/stash.c
> @@ -1198,34 +1198,39 @@ static int do_create_stash(struct pathspec ps, const char **stash_msg,
>  
>  static int create_stash(int argc, const char **argv, const char *prefix)
>  {
> -	int include_untracked = 0;
> +	int i;
>  	int ret = 0;
> +	char *to_free = NULL;
>  	const char *stash_msg = NULL;
>  	struct stash_info info;
>  	struct pathspec ps;
> +	struct strbuf stash_msg_buf = STRBUF_INIT;
>  	struct option options[] = {
> -		OPT_BOOL('u', "include-untracked", &include_untracked,
> -			 N_("include untracked files in stash")),
> -		OPT_STRING('m', "message", &stash_msg, N_("message"),
> -			 N_("stash message")),

This was indeed a bit surprising, but after re-reading the commit message,
it became clear what this is all about.

But I wonder...

>  		OPT_END()
>  	};
>  
>  	argc = parse_options(argc, argv, prefix, options,
> -			     git_stash_helper_create_usage,
> +			     git_stash_create_usage,
>  			     0);

As we no longer accept any command-line arguments, (and as the `create`
command *explicitly* allows messages starting with a dash), it would
probably make more sense to test `argc` directly:

	if (!argc)
		usage_with_options(git_stash_create_usage, options);

>  
> +	for (i = 0; i < argc; ++i)
> +		strbuf_addf(&stash_msg_buf, "%s ", argv[i]);

... this adds an extra space at the end, right? I guess this should read
instead:

	for (i = 0; i < argc; i++) {
		if (i > 0)
			strbuf_addch(&stash_msg_buf, ' ');
		strbuf_addstr(&stash_msg_buf, argv[i]);
	}

> +	stash_msg = strbuf_detach(&stash_msg_buf, NULL);

As we no longer have any way to set `stash_msg` via an option, this
variable should go away.

And rather than detaching the strbuf here, it would be better to release
it after the call to `do_create_stash()`. (And the `to_free` variable is
no longer necessary, either.)

> +	to_free = (char *) stash_msg;
> +
>  	memset(&ps, 0, sizeof(ps));
> -	ret = do_create_stash(ps, &stash_msg, include_untracked, 0, &info, 0);
> +	ret = do_create_stash(ps, &stash_msg, 0, 0, &info, 0);
>  
>  	if (!ret)
>  		printf_ln("%s", oid_to_hex(&info.w_commit));
>  
> +	free(to_free);
> +	free((char *) stash_msg);
> +
>  	/*
>  	 * ret can be 1 if there were no changes. In this case, we should
>  	 * not error out.
>  	 */
> -	free((char *) stash_msg);
>  	return ret < 0;
>  }
>  
> @@ -1443,9 +1448,10 @@ static int push_stash(int argc, const char **argv, const char *prefix)
>  		OPT_END()
>  	};
>  
> -	argc = parse_options(argc, argv, prefix, options,
> -			     git_stash_helper_push_usage,
> -			     0);
> +	if (argc)
> +		argc = parse_options(argc, argv, prefix, options,
> +				     git_stash_push_usage,
> +				     0);

Is this `if (argc)` guard necessary?

>  
>  	parse_pathspec(&ps, 0, PATHSPEC_PREFER_FULL, prefix, argv);
>  	return do_push_stash(ps, stash_msg, quiet, keep_index, patch_mode,
> @@ -1478,7 +1484,7 @@ static int save_stash(int argc, const char **argv, const char *prefix)
>  	};
>  
>  	argc = parse_options(argc, argv, prefix, options,
> -			     git_stash_helper_save_usage,
> +			     git_stash_save_usage,
>  			     0);
>  
>  	for (i = 0; i < argc; ++i)
> @@ -1494,10 +1500,12 @@ static int save_stash(int argc, const char **argv, const char *prefix)
>  	return ret;
>  }
>  
> -int cmd_stash__helper(int argc, const char **argv, const char *prefix)
> +int cmd_stash(int argc, const char **argv, const char *prefix)
>  {
> +	int i = -1;
>  	pid_t pid = getpid();
>  	const char *index_file;
> +	struct argv_array args = ARGV_ARRAY_INIT;
>  
>  	struct option options[] = {
>  		OPT_END()
> @@ -1505,16 +1513,16 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  
>  	git_config(git_default_config, NULL);
>  
> -	argc = parse_options(argc, argv, prefix, options, git_stash_helper_usage,
> +	argc = parse_options(argc, argv, prefix, options, git_stash_usage,
>  			     PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDASH);
>  
>  	index_file = get_index_file();
>  	strbuf_addf(&stash_index_path, "%s.stash.%" PRIuMAX, index_file,
>  		    (uintmax_t)pid);
>  
> -	if (argc < 1)
> -		usage_with_options(git_stash_helper_usage, options);
> -	if (!strcmp(argv[0], "apply"))
> +	if (argc == 0)
> +		return !!push_stash(0, NULL, prefix);
> +	else if (!strcmp(argv[0], "apply"))
>  		return !!apply_stash(argc, argv, prefix);
>  	else if (!strcmp(argv[0], "clear"))
>  		return !!clear_stash(argc, argv, prefix);
> @@ -1536,7 +1544,44 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  		return !!push_stash(argc, argv, prefix);
>  	else if (!strcmp(argv[0], "save"))
>  		return !!save_stash(argc, argv, prefix);
> +	else if (*argv[0] != '-')
> +		usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
> +			      git_stash_usage, options);
> +
> +	if (strcmp(argv[0], "-p")) {
> +		while (++i < argc && strcmp(argv[i], "--")) {
> +			/*
> +			 * `akpqu` is a string which contains all short options,
> +			 * except `-m` which is verified separately.
> +			 */
> +			if ((strlen(argv[i]) == 2) && *argv[i] == '-' &&
> +			    strchr("akpqu", argv[i][1]))

I *think* this is missing the `n`.

Thanks,
Dscho

> +				continue;
> +
> +			if (!strcmp(argv[i], "--all") ||
> +			    !strcmp(argv[i], "--keep-index") ||
> +			    !strcmp(argv[i], "--no-keep-index") ||
> +			    !strcmp(argv[i], "--patch") ||
> +			    !strcmp(argv[i], "--quiet") ||
> +			    !strcmp(argv[i], "--include-untracked"))
> +				continue;
> +
> +			/*
> +			 * `-m` and `--message=` are verified separately because
> +			 * they need to be immediately followed by a string
> +			 * (i.e.`-m"foobar"` or `--message="foobar"`).
> +			 */
> +			if ((strlen(argv[i]) > 2 &&
> +			     !strncmp(argv[i], "-m", 2)) ||
> +			    (strlen(argv[i]) > 10 &&
> +			     !strncmp(argv[i], "--message=", 10)))
> +				continue;
> +
> +			usage_with_options(git_stash_usage, options);
> +		}
> +	}
>  
> -	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
> -		      git_stash_helper_usage, options);
> +	argv_array_push(&args, "push");
> +	argv_array_pushv(&args, argv);
> +	return !!push_stash(args.argc, args.argv, prefix);
>  }
> diff --git a/git-stash.sh b/git-stash.sh
> deleted file mode 100755
> index 695f1feba3..0000000000
> --- a/git-stash.sh
> +++ /dev/null
> @@ -1,153 +0,0 @@
> -#!/bin/sh
> -# Copyright (c) 2007, Nanako Shiraishi
> -
> -dashless=$(basename "$0" | sed -e 's/-/ /')
> -USAGE="list [<options>]
> -   or: $dashless show [<stash>]
> -   or: $dashless drop [-q|--quiet] [<stash>]
> -   or: $dashless ( pop | apply ) [--index] [-q|--quiet] [<stash>]
> -   or: $dashless branch <branchname> [<stash>]
> -   or: $dashless save [--patch] [-k|--[no-]keep-index] [-q|--quiet]
> -		      [-u|--include-untracked] [-a|--all] [<message>]
> -   or: $dashless [push [--patch] [-k|--[no-]keep-index] [-q|--quiet]
> -		       [-u|--include-untracked] [-a|--all] [-m <message>]
> -		       [-- <pathspec>...]]
> -   or: $dashless clear"
> -
> -SUBDIRECTORY_OK=Yes
> -OPTIONS_SPEC=
> -START_DIR=$(pwd)
> -. git-sh-setup
> -require_work_tree
> -prefix=$(git rev-parse --show-prefix) || exit 1
> -cd_to_toplevel
> -
> -TMP="$GIT_DIR/.git-stash.$$"
> -TMPindex=${GIT_INDEX_FILE-"$(git rev-parse --git-path index)"}.stash.$$
> -trap 'rm -f "$TMP-"* "$TMPindex"' 0
> -
> -ref_stash=refs/stash
> -
> -if git config --get-colorbool color.interactive; then
> -       help_color="$(git config --get-color color.interactive.help 'red bold')"
> -       reset_color="$(git config --get-color '' reset)"
> -else
> -       help_color=
> -       reset_color=
> -fi
> -
> -#
> -# Parses the remaining options looking for flags and
> -# at most one revision defaulting to ${ref_stash}@{0}
> -# if none found.
> -#
> -# Derives related tree and commit objects from the
> -# revision, if one is found.
> -#
> -# stash records the work tree, and is a merge between the
> -# base commit (first parent) and the index tree (second parent).
> -#
> -#   REV is set to the symbolic version of the specified stash-like commit
> -#   IS_STASH_LIKE is non-blank if ${REV} looks like a stash
> -#   IS_STASH_REF is non-blank if the ${REV} looks like a stash ref
> -#   s is set to the SHA1 of the stash commit
> -#   w_commit is set to the commit containing the working tree
> -#   b_commit is set to the base commit
> -#   i_commit is set to the commit containing the index tree
> -#   u_commit is set to the commit containing the untracked files tree
> -#   w_tree is set to the working tree
> -#   b_tree is set to the base tree
> -#   i_tree is set to the index tree
> -#   u_tree is set to the untracked files tree
> -#
> -#   GIT_QUIET is set to t if -q is specified
> -#   INDEX_OPTION is set to --index if --index is specified.
> -#   FLAGS is set to the remaining flags (if allowed)
> -#
> -# dies if:
> -#   * too many revisions specified
> -#   * no revision is specified and there is no stash stack
> -#   * a revision is specified which cannot be resolve to a SHA1
> -#   * a non-existent stash reference is specified
> -#   * unknown flags were set and ALLOW_UNKNOWN_FLAGS is not "t"
> -#
> -
> -test "$1" = "-p" && set "push" "$@"
> -
> -PARSE_CACHE='--not-parsed'
> -# The default command is "push" if nothing but options are given
> -seen_non_option=
> -for opt
> -do
> -	case "$opt" in
> -	--) break ;;
> -	-*) ;;
> -	*) seen_non_option=t; break ;;
> -	esac
> -done
> -
> -test -n "$seen_non_option" || set "push" "$@"
> -
> -# Main command set
> -case "$1" in
> -list)
> -	shift
> -	git stash--helper list "$@"
> -	;;
> -show)
> -	shift
> -	git stash--helper show "$@"
> -	;;
> -save)
> -	shift
> -	cd "$START_DIR"
> -	git stash--helper save "$@"
> -	;;
> -push)
> -	shift
> -	cd "$START_DIR"
> -	git stash--helper push "$@"
> -	;;
> -apply)
> -	shift
> -	cd "$START_DIR"
> -	git stash--helper apply "$@"
> -	;;
> -clear)
> -	shift
> -	git stash--helper clear "$@"
> -	;;
> -create)
> -	shift
> -	git stash--helper create --message "$*"
> -	;;
> -store)
> -	shift
> -	git stash--helper store "$@"
> -	;;
> -drop)
> -	shift
> -	git stash--helper drop "$@"
> -	;;
> -pop)
> -	shift
> -	cd "$START_DIR"
> -	git stash--helper pop "$@"
> -	;;
> -branch)
> -	shift
> -	cd "$START_DIR"
> -	git stash--helper branch "$@"
> -	;;
> -*)
> -	case $# in
> -	0)
> -		cd "$START_DIR"
> -		git stash--helper push &&
> -		say "$(gettext "(To restore them type \"git stash apply\")")"
> -		;;
> -	*)
> -		usage
> -	esac
> -	;;
> -esac
> diff --git a/git.c b/git.c
> index 3c0e762d7d..78548397cf 100644
> --- a/git.c
> +++ b/git.c
> @@ -544,7 +544,7 @@ static struct cmd_struct commands[] = {
>  	{ "show-index", cmd_show_index },
>  	{ "show-ref", cmd_show_ref, RUN_SETUP },
>  	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
> -	{ "stash--helper", cmd_stash__helper, RUN_SETUP | NEED_WORK_TREE },
> +	{ "stash", cmd_stash, RUN_SETUP | NEED_WORK_TREE },
>  	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
>  	{ "stripspace", cmd_stripspace },
>  	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX | NO_PARSEOPT },
> -- 
> 2.19.0.rc0.22.gc26283d74e
> 
> 
