Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D03D1F404
	for <e@80x24.org>; Mon,  3 Sep 2018 18:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbeICXFx (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 19:05:53 -0400
Received: from mout.gmx.net ([212.227.17.20]:46575 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727472AbeICXFx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 19:05:53 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MGip3-1g9sH83PG5-00Dbd4; Mon, 03
 Sep 2018 20:44:23 +0200
Date:   Mon, 3 Sep 2018 20:44:23 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v8 17/20] stash: convert save to builtin
In-Reply-To: <6832c979c8dca2a3584ed3cf828a6de060413cda.1535665109.git.ungureanupaulsebastian@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1809032031090.71@tvgsbejvaqbjf.bet>
References: <cover.1535665109.git.ungureanupaulsebastian@gmail.com> <6832c979c8dca2a3584ed3cf828a6de060413cda.1535665109.git.ungureanupaulsebastian@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NGRKeHjrgslbkEzWX95uBSafFamTnyaA7hyhfW48k3udO4w0dHP
 +hR1rQnoALTUH/+X3WU7yHu1Wssgp2YMrqLSsgOJZBwrRBPKLnGxWankdRvKF/GMGwpDvqX
 pMEHJcq5rRNdwRyZPX2JlmmlPmgUhbgWmwandzUaHCcUwDaclxU6n7zbrXVfY2dFddy8qrQ
 bscMzqLE785ooFIAyErGA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gH1sxWNrJ5k=:R5oUK8UgYQnih1xCkm9bAD
 DTesFJ/1kly+v25z91lX6pIbEE48skHS3xVdpPbMz/bDIU2YYAfLrnT5LAup2UeeSx1j7Dp8l
 N21kL2Or3y5I6DaiI++aPN+kvsfh1YxnvdfBOGzKA6l20Xxm+AANAtIJ+PoJ+UO8Ju2SMCzX+
 CnpjLQXnLiDTEJ1wBV33YSv7axJ5BuNuxLE2YdFyJ7XdevA42Ndh+r6Xge++Q7n6gM7x+DKQP
 5lNsvd1Chtkkng7XGbitfPb6BYvwWltSo05RGZZEnNmSMD/M9ZgYEclw4DplMTHibhuUvEjtI
 4kIHjWJYw7hHefQuAGlGVrCeNSJPZGScnJggRhsVLQL/pWrWpzeTrB0uH5ofwLVolP/BmA8aH
 a33K/kzTMsxQmkz5nHFzzytKjqqA1iBQt6y+CPlXDFD8Ul3YaL+NQVrjJQtxlbA2RI3kR4h1h
 +eo5Y+g4BvDetAxwgNSuh6/AoQPGWj6BOrGwtffkbyH1eluUJE2cLqKBBaTfA4NcjSgkx3e0t
 vsg4WHN7vcXdTPIRf3btagXovqSLdjz6FJSjayfoB/4M2aj1IbQVxvsuvZlobhHRAzCV6fVSK
 58kZr19ySvP981HPehe08SPspASdEyPGoGFOwllj+/IvZPjnlqoLSrwZ7J8YmC2+leGwOk6ir
 jQXW2Zr4VELJ/Edk+O4SXqETkRqBUd4/n85OmnqV1L9HXsjScdFMe2J0NmHTAOFNkzn6Q6pR6
 95b2cPUiW7p+pd0OZC2usEG1rYD3rDHRa+9gJAERMufaOOdpfC/nGBGu4WgOpV2Ia73RHQPFa
 XjRHcIu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul,

On Fri, 31 Aug 2018, Paul-Sebastian Ungureanu wrote:

> Add stash save to the helper and delete functions which are no
> longer needed (`show_help()`, `save_stash()`, `push_stash()`,
> `create_stash()`, `clear_stash()`, `untracked_files()` and
> `no_changes()`).
> 
> The `-m` option is no longer supported as it might not make
> sense to have two ways of passing a message. Even if this is
> a change in behaviour, the documentation remains the same
> because the `-m` parameter was omitted before.

It makes me slightly nervous to remove the `-m` option like this. And I
wonder how difficult it would be to allow for the `-m` option, still, just
to keep the occasional script running that might rely on this feature.

I could imagine that it would be as easy as

	const char *stash_msg = NULL;
	[...]
		OPT_STRING('m', "message", &stash_msg, "message",
			   N_("stash message")),
	[...]
	struct strbuf buf = STRBUF_INIT;

	[... parse_options() ...]
	if (argc)
		stash_msg = strbuf_join_argv(&buf, argc, argv, ' ');

	[...]

	strbuf_release(&buf);

where `strbuf_join_argv()` would be implemented like this (and I would put
it into strbuf.c and strbuf.h:

	const char *strbuf_join_argv(struct strbuf *buf,
				     int argc, const char **argv, char delim)
	{
		if (!argc)
			return buf->buf;

		strbuf_addstr(buf, *argv);
		while (--i) {
			strbuf_addch(buf, delim);
			strbuf_addstr(buf, *(++argv);
		}

		return buf->buf;
	}

> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> index e5153a63ea..1269f2548c 100644
> --- a/builtin/stash--helper.c
> +++ b/builtin/stash--helper.c
> @@ -1444,6 +1452,48 @@ static int push_stash(int argc, const char **argv, const char *prefix)
>  			     include_untracked);
>  }
>  
> +static int save_stash(int argc, const char **argv, const char *prefix)
> +{
> +	int i;
> +	int keep_index = -1;
> +	int patch_mode = 0;
> +	int include_untracked = 0;
> +	int quiet = 0;
> +	int ret = 0;
> +	const char *stash_msg = NULL;
> +	char *to_free = NULL;
> +	struct strbuf stash_msg_buf = STRBUF_INIT;
> +	struct pathspec ps;
> +	struct option options[] = {
> +		OPT_SET_INT('k', "keep-index", &keep_index,
> +			N_("keep index"), 1),
> +		OPT_BOOL('p', "patch", &patch_mode,
> +			N_("stash in patch mode")),
> +		OPT__QUIET(&quiet, N_("quiet mode")),
> +		OPT_BOOL('u', "include-untracked", &include_untracked,
> +			 N_("include untracked files in stash")),
> +		OPT_SET_INT('a', "all", &include_untracked,
> +			    N_("include ignore files"), 2),
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options,
> +			     git_stash_helper_save_usage,
> +			     0);
> +
> +	for (i = 0; i < argc; ++i)
> +		strbuf_addf(&stash_msg_buf, "%s ", argv[i]);

I think I saw this in another patch already, and now it makes sense to
introduce the `strbuf_join_argv()` function, methinks.

> +	stash_msg = strbuf_detach(&stash_msg_buf, NULL);
> +	to_free = (char *) stash_msg;
> +
> +	memset(&ps, 0, sizeof(ps));
> +	ret = do_push_stash(ps, stash_msg, quiet, keep_index, patch_mode,
> +			    include_untracked);
> +
> +	free(to_free);

As before, I would recommend to use stash_msg_buf.buf directly and call
strbuf_release() in the end (and drop the `to_free` variable altogether).

The rest looks good to me!

Thanks,
Dscho

> +	return ret;
> +}
> +
>  int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  {
>  	pid_t pid = getpid();
> @@ -1484,6 +1534,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  		return !!create_stash(argc, argv, prefix);
>  	else if (!strcmp(argv[0], "push"))
>  		return !!push_stash(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "save"))
> +		return !!save_stash(argc, argv, prefix);
>  
>  	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
>  		      git_stash_helper_usage, options);
> diff --git a/git-stash.sh b/git-stash.sh
> index c3146f62ab..695f1feba3 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -36,314 +36,6 @@ else
>         reset_color=
>  fi
>  
> -no_changes () {
> -	git diff-index --quiet --cached HEAD --ignore-submodules -- "$@" &&
> -	git diff-files --quiet --ignore-submodules -- "$@" &&
> -	(test -z "$untracked" || test -z "$(untracked_files "$@")")
> -}
> -
> -untracked_files () {
> -	if test "$1" = "-z"
> -	then
> -		shift
> -		z=-z
> -	else
> -		z=
> -	fi
> -	excl_opt=--exclude-standard
> -	test "$untracked" = "all" && excl_opt=
> -	git ls-files -o $z $excl_opt -- "$@"
> -}
> -
> -clear_stash () {
> -	if test $# != 0
> -	then
> -		die "$(gettext "git stash clear with parameters is unimplemented")"
> -	fi
> -	if current=$(git rev-parse --verify --quiet $ref_stash)
> -	then
> -		git update-ref -d $ref_stash $current
> -	fi
> -}
> -
> -create_stash () {
> -	stash_msg=
> -	untracked=
> -	while test $# != 0
> -	do
> -		case "$1" in
> -		-m|--message)
> -			shift
> -			stash_msg=${1?"BUG: create_stash () -m requires an argument"}
> -			;;
> -		-m*)
> -			stash_msg=${1#-m}
> -			;;
> -		--message=*)
> -			stash_msg=${1#--message=}
> -			;;
> -		-u|--include-untracked)
> -			shift
> -			untracked=${1?"BUG: create_stash () -u requires an argument"}
> -			;;
> -		--)
> -			shift
> -			break
> -			;;
> -		esac
> -		shift
> -	done
> -
> -	git update-index -q --refresh
> -	if no_changes "$@"
> -	then
> -		exit 0
> -	fi
> -
> -	# state of the base commit
> -	if b_commit=$(git rev-parse --verify HEAD)
> -	then
> -		head=$(git rev-list --oneline -n 1 HEAD --)
> -	else
> -		die "$(gettext "You do not have the initial commit yet")"
> -	fi
> -
> -	if branch=$(git symbolic-ref -q HEAD)
> -	then
> -		branch=${branch#refs/heads/}
> -	else
> -		branch='(no branch)'
> -	fi
> -	msg=$(printf '%s: %s' "$branch" "$head")
> -
> -	# state of the index
> -	i_tree=$(git write-tree) &&
> -	i_commit=$(printf 'index on %s\n' "$msg" |
> -		git commit-tree $i_tree -p $b_commit) ||
> -		die "$(gettext "Cannot save the current index state")"
> -
> -	if test -n "$untracked"
> -	then
> -		# Untracked files are stored by themselves in a parentless commit, for
> -		# ease of unpacking later.
> -		u_commit=$(
> -			untracked_files -z "$@" | (
> -				GIT_INDEX_FILE="$TMPindex" &&
> -				export GIT_INDEX_FILE &&
> -				rm -f "$TMPindex" &&
> -				git update-index -z --add --remove --stdin &&
> -				u_tree=$(git write-tree) &&
> -				printf 'untracked files on %s\n' "$msg" | git commit-tree $u_tree  &&
> -				rm -f "$TMPindex"
> -		) ) || die "$(gettext "Cannot save the untracked files")"
> -
> -		untracked_commit_option="-p $u_commit";
> -	else
> -		untracked_commit_option=
> -	fi
> -
> -	if test -z "$patch_mode"
> -	then
> -
> -		# state of the working tree
> -		w_tree=$( (
> -			git read-tree --index-output="$TMPindex" -m $i_tree &&
> -			GIT_INDEX_FILE="$TMPindex" &&
> -			export GIT_INDEX_FILE &&
> -			git diff-index --name-only -z HEAD -- "$@" >"$TMP-stagenames" &&
> -			git update-index -z --add --remove --stdin <"$TMP-stagenames" &&
> -			git write-tree &&
> -			rm -f "$TMPindex"
> -		) ) ||
> -			die "$(gettext "Cannot save the current worktree state")"
> -
> -	else
> -
> -		rm -f "$TMP-index" &&
> -		GIT_INDEX_FILE="$TMP-index" git read-tree HEAD &&
> -
> -		# find out what the user wants
> -		GIT_INDEX_FILE="$TMP-index" \
> -			git add--interactive --patch=stash -- "$@" &&
> -
> -		# state of the working tree
> -		w_tree=$(GIT_INDEX_FILE="$TMP-index" git write-tree) ||
> -		die "$(gettext "Cannot save the current worktree state")"
> -
> -		git diff-tree -p HEAD $w_tree -- >"$TMP-patch" &&
> -		test -s "$TMP-patch" ||
> -		die "$(gettext "No changes selected")"
> -
> -		rm -f "$TMP-index" ||
> -		die "$(gettext "Cannot remove temporary index (can't happen)")"
> -
> -	fi
> -
> -	# create the stash
> -	if test -z "$stash_msg"
> -	then
> -		stash_msg=$(printf 'WIP on %s' "$msg")
> -	else
> -		stash_msg=$(printf 'On %s: %s' "$branch" "$stash_msg")
> -	fi
> -	w_commit=$(printf '%s\n' "$stash_msg" |
> -	git commit-tree $w_tree -p $b_commit -p $i_commit $untracked_commit_option) ||
> -	die "$(gettext "Cannot record working tree state")"
> -}
> -
> -push_stash () {
> -	keep_index=
> -	patch_mode=
> -	untracked=
> -	stash_msg=
> -	while test $# != 0
> -	do
> -		case "$1" in
> -		-k|--keep-index)
> -			keep_index=t
> -			;;
> -		--no-keep-index)
> -			keep_index=n
> -			;;
> -		-p|--patch)
> -			patch_mode=t
> -			# only default to keep if we don't already have an override
> -			test -z "$keep_index" && keep_index=t
> -			;;
> -		-q|--quiet)
> -			GIT_QUIET=t
> -			;;
> -		-u|--include-untracked)
> -			untracked=untracked
> -			;;
> -		-a|--all)
> -			untracked=all
> -			;;
> -		-m|--message)
> -			shift
> -			test -z ${1+x} && usage
> -			stash_msg=$1
> -			;;
> -		-m*)
> -			stash_msg=${1#-m}
> -			;;
> -		--message=*)
> -			stash_msg=${1#--message=}
> -			;;
> -		--help)
> -			show_help
> -			;;
> -		--)
> -			shift
> -			break
> -			;;
> -		-*)
> -			option="$1"
> -			eval_gettextln "error: unknown option for 'stash push': \$option"
> -			usage
> -			;;
> -		*)
> -			break
> -			;;
> -		esac
> -		shift
> -	done
> -
> -	eval "set $(git rev-parse --sq --prefix "$prefix" -- "$@")"
> -
> -	if test -n "$patch_mode" && test -n "$untracked"
> -	then
> -		die "$(gettext "Can't use --patch and --include-untracked or --all at the same time")"
> -	fi
> -
> -	test -n "$untracked" || git ls-files --error-unmatch -- "$@" >/dev/null || exit 1
> -
> -	git update-index -q --refresh
> -	if no_changes "$@"
> -	then
> -		say "$(gettext "No local changes to save")"
> -		exit 0
> -	fi
> -
> -	git reflog exists $ref_stash ||
> -		clear_stash || die "$(gettext "Cannot initialize stash")"
> -
> -	create_stash -m "$stash_msg" -u "$untracked" -- "$@"
> -	git stash--helper store -m "$stash_msg" -q $w_commit ||
> -	die "$(gettext "Cannot save the current status")"
> -	say "$(eval_gettext "Saved working directory and index state \$stash_msg")"
> -
> -	if test -z "$patch_mode"
> -	then
> -		test "$untracked" = "all" && CLEAN_X_OPTION=-x || CLEAN_X_OPTION=
> -		if test -n "$untracked" && test $# = 0
> -		then
> -			git clean --force --quiet -d $CLEAN_X_OPTION
> -		fi
> -
> -		if test $# != 0
> -		then
> -			test -z "$untracked" && UPDATE_OPTION="-u" || UPDATE_OPTION=
> -			test "$untracked" = "all" && FORCE_OPTION="--force" || FORCE_OPTION=
> -			git add $UPDATE_OPTION $FORCE_OPTION -- "$@"
> -			git diff-index -p --cached --binary HEAD -- "$@" |
> -			git apply --index -R
> -		else
> -			git reset --hard -q
> -		fi
> -
> -		if test "$keep_index" = "t" && test -n "$i_tree"
> -		then
> -			git read-tree --reset $i_tree
> -			git ls-files -z --modified -- "$@" |
> -			git checkout-index -z --force --stdin
> -		fi
> -	else
> -		git apply -R < "$TMP-patch" ||
> -		die "$(gettext "Cannot remove worktree changes")"
> -
> -		if test "$keep_index" != "t"
> -		then
> -			git reset -q -- "$@"
> -		fi
> -	fi
> -}
> -
> -save_stash () {
> -	push_options=
> -	while test $# != 0
> -	do
> -		case "$1" in
> -		--)
> -			shift
> -			break
> -			;;
> -		-*)
> -			# pass all options through to push_stash
> -			push_options="$push_options $1"
> -			;;
> -		*)
> -			break
> -			;;
> -		esac
> -		shift
> -	done
> -
> -	stash_msg="$*"
> -
> -	if test -z "$stash_msg"
> -	then
> -		push_stash $push_options
> -	else
> -		push_stash $push_options -m "$stash_msg"
> -	fi
> -}
> -
> -show_help () {
> -	exec git help stash
> -	exit 1
> -}
> -
>  #
>  # Parses the remaining options looking for flags and
>  # at most one revision defaulting to ${ref_stash}@{0}
> @@ -408,7 +100,8 @@ show)
>  	;;
>  save)
>  	shift
> -	save_stash "$@"
> +	cd "$START_DIR"
> +	git stash--helper save "$@"
>  	;;
>  push)
>  	shift
> -- 
> 2.19.0.rc0.22.gc26283d74e
> 
> 
