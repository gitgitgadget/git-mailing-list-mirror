Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CCA41F453
	for <e@80x24.org>; Mon, 15 Oct 2018 09:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbeJOQye (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 12:54:34 -0400
Received: from mout.gmx.net ([212.227.17.22]:35159 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbeJOQyd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 12:54:33 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lmvlg-1fiOpY0hjA-00h9Y0; Mon, 15
 Oct 2018 11:10:08 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lmvlg-1fiOpY0hjA-00h9Y0; Mon, 15
 Oct 2018 11:10:08 +0200
Date:   Mon, 15 Oct 2018 11:10:10 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
cc:     git@vger.kernel.org, t.gummerer@gmail.com
Subject: Re: [PATCH v10 08/21] stash: convert apply to builtin
In-Reply-To: <fac126b6e4aebf8f3795a7a4f560cc1e67e95ff9.1539553398.git.ungureanupaulsebastian@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1810151108250.561@tvgsbejvaqbjf.bet>
References: <cover.1539553398.git.ungureanupaulsebastian@gmail.com> <fac126b6e4aebf8f3795a7a4f560cc1e67e95ff9.1539553398.git.ungureanupaulsebastian@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zbIzcEQ2f4jozdy36ITeOGHNuSB7Rcbq/haNCXelrpJ/cLqEveI
 eu4pZMvm4j3jHTND6uGvZlkNAKzf6cSzXN/VQC2/Aqli9TKNEIAWdEaIomAIm3BisagPIMz
 oQ0gqJ4L/kRFXcrkJE1hca+zb7PzveEFJKoyZxM74HszWEJ8ZuF+uU/YiJgtPfhmhgado1I
 Nh/7QUIIvzR+43j1jahOg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NZukxrkB0T4=:5+H197pDUU3q6JN61Ab80O
 cLx3ovnpunp/yfwusQbM6C+FxY6fS4Uz4JSqyaXXLnGA9Zthj0utWEXLrKM0fTsVzAuYqjXb9
 ASCOcfiBA/x269JGTyixcCVZ/1iY9jnZk2n4Z+ASqJ1zoDxpErIqVvGcd6UsAp5eUdLtIGFhG
 Fxg68qOBubc9Fz+zh6JzMrjpzw0f9qkN2wlgvX9hKh3f1UD+h/29RBf7brer3+hPtFMScrxSw
 OgodyBPRWZr7A7M6bVCJCprX6Jmb2BzXbbEbXjkeLhx6atzL7xGYLpaSKMiD0y965zF+FKqb/
 mdg+u3nWf+e4Y9+fW/CEmRIOHOylsq7ELyVkI276DCc6k9N+qJiaVOyMCH4MITVGDVhZq8sdc
 ekeAyiqDKarhF6JXDiNh/UH7c6g9ceLfHZFEX1FnqBRYDFcGZSC8DW8z48vcNCJB64i942uwW
 VoYnnfatA7dQ7+FEnU7ptjUjtJ/hVxe2siOxouEeS7auafHlF/+ZVNY2Ez9M9kF4MT1giDuP+
 glSHt5Kpjw5tZ3zYTKJnDnWh4omnVyvDrJmFTuTokzb5dC/ymaBLDJ1ZZw+xXnp3IWshfcq2Y
 npZsEZOoG0jEPclLO3U7V1MrXyMqiOMQLe1bReVhUpgE9VhelzTkzJ9CvXhsdCGaKmnx8SUw4
 a5F3VZV2VTT9t1EAN8JCzzvnVmXji9sT8xgAUSAVAy6Hdwh885LEwUrAtCCCFDZCeb8MOOhQ/
 4s+UCVCoFyNOiyOEZEPnz/8anMuKMkXanTG3LS7mpJqFmFH9G2bXRPednl26mYyj1K+63CSgB
 EbK3UR4Vkss33HeBx4wf6j6M/QHR//t2aHZAvjo0Izq8ZTL53E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul,

On Mon, 15 Oct 2018, Paul-Sebastian Ungureanu wrote:

> +static void assert_stash_like(struct stash_info *info, const char *revision)
> +{
> +	if (get_oidf(&info->b_commit, "%s^1", revision) ||
> +	    get_oidf(&info->w_tree, "%s:", revision) ||
> +	    get_oidf(&info->b_tree, "%s^1:", revision) ||
> +	    get_oidf(&info->i_tree, "%s^2:", revision)) {
> +		error(_("'%s' is not a stash-like commit"), revision);
> +		free_stash_info(info);
> +		exit(128);

Thomas had mentioned earlier that this should probably be a die() (and
that the `free_stash_info()` should simply be dropped), see
https://public-inbox.org/git/20180930174848.GE2253@hank.intra.tgummerer.com/

> +	}
> +}
> +
> +static int get_stash_info(struct stash_info *info, int argc, const char **argv)
> +{
> +	int ret;
> +	char *end_of_rev;
> +	char *expanded_ref;
> +	const char *revision;
> +	const char *commit = NULL;
> +	struct object_id dummy;
> +	struct strbuf symbolic = STRBUF_INIT;
> +
> +	if (argc > 1) {
> +		int i;
> +		struct strbuf refs_msg = STRBUF_INIT;
> +		for (i = 0; i < argc; i++)
> +			strbuf_addf(&refs_msg, " '%s'", argv[i]);

Thomas had also mentioned that this should be a `strbuf_join_argv()` call
now.

Maybe v10 is an accidental re-send of v9?

Ciao,
Dscho

> +
> +		fprintf_ln(stderr, _("Too many revisions specified:%s"),
> +			   refs_msg.buf);
> +		strbuf_release(&refs_msg);
> +
> +		return -1;
> +	}
> +
> +	if (argc == 1)
> +		commit = argv[0];
> +
> +	strbuf_init(&info->revision, 0);
> +	if (!commit) {
> +		if (!ref_exists(ref_stash)) {
> +			free_stash_info(info);
> +			fprintf_ln(stderr, _("No stash entries found."));
> +			return -1;
> +		}
> +
> +		strbuf_addf(&info->revision, "%s@{0}", ref_stash);
> +	} else if (strspn(commit, "0123456789") == strlen(commit)) {
> +		strbuf_addf(&info->revision, "%s@{%s}", ref_stash, commit);
> +	} else {
> +		strbuf_addstr(&info->revision, commit);
> +	}
> +
> +	revision = info->revision.buf;
> +
> +	if (get_oid(revision, &info->w_commit)) {
> +		error(_("%s is not a valid reference"), revision);
> +		free_stash_info(info);
> +		return -1;
> +	}
> +
> +	assert_stash_like(info, revision);
> +
> +	info->has_u = !get_oidf(&info->u_tree, "%s^3:", revision);
> +
> +	end_of_rev = strchrnul(revision, '@');
> +	strbuf_add(&symbolic, revision, end_of_rev - revision);
> +
> +	ret = dwim_ref(symbolic.buf, symbolic.len, &dummy, &expanded_ref);
> +	strbuf_release(&symbolic);
> +	switch (ret) {
> +	case 0: /* Not found, but valid ref */
> +		info->is_stash_ref = 0;
> +		break;
> +	case 1:
> +		info->is_stash_ref = !strcmp(expanded_ref, ref_stash);
> +		break;
> +	default: /* Invalid or ambiguous */
> +		free_stash_info(info);
> +	}
> +
> +	free(expanded_ref);
> +	return !(ret == 0 || ret == 1);
> +}
> +
> +static int reset_tree(struct object_id *i_tree, int update, int reset)
> +{
> +	int nr_trees = 1;
> +	struct unpack_trees_options opts;
> +	struct tree_desc t[MAX_UNPACK_TREES];
> +	struct tree *tree;
> +	struct lock_file lock_file = LOCK_INIT;
> +
> +	read_cache_preload(NULL);
> +	if (refresh_cache(REFRESH_QUIET))
> +		return -1;
> +
> +	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
> +
> +	memset(&opts, 0, sizeof(opts));
> +
> +	tree = parse_tree_indirect(i_tree);
> +	if (parse_tree(tree))
> +		return -1;
> +
> +	init_tree_desc(t, tree->buffer, tree->size);
> +
> +	opts.head_idx = 1;
> +	opts.src_index = &the_index;
> +	opts.dst_index = &the_index;
> +	opts.merge = 1;
> +	opts.reset = reset;
> +	opts.update = update;
> +	opts.fn = oneway_merge;
> +
> +	if (unpack_trees(nr_trees, t, &opts))
> +		return -1;
> +
> +	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
> +		return error(_("unable to write new index file"));
> +
> +	return 0;
> +}
> +
> +static int diff_tree_binary(struct strbuf *out, struct object_id *w_commit)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	const char *w_commit_hex = oid_to_hex(w_commit);
> +
> +	/*
> +	 * Diff-tree would not be very hard to replace with a native function,
> +	 * however it should be done together with apply_cached.
> +	 */
> +	cp.git_cmd = 1;
> +	argv_array_pushl(&cp.args, "diff-tree", "--binary", NULL);
> +	argv_array_pushf(&cp.args, "%s^2^..%s^2", w_commit_hex, w_commit_hex);
> +
> +	return pipe_command(&cp, NULL, 0, out, 0, NULL, 0);
> +}
> +
> +static int apply_cached(struct strbuf *out)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +
> +	/*
> +	 * Apply currently only reads either from stdin or a file, thus
> +	 * apply_all_patches would have to be updated to optionally take a
> +	 * buffer.
> +	 */
> +	cp.git_cmd = 1;
> +	argv_array_pushl(&cp.args, "apply", "--cached", NULL);
> +	return pipe_command(&cp, out->buf, out->len, NULL, 0, NULL, 0);
> +}
> +
> +static int reset_head(void)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +
> +	/*
> +	 * Reset is overall quite simple, however there is no current public
> +	 * API for resetting.
> +	 */
> +	cp.git_cmd = 1;
> +	argv_array_push(&cp.args, "reset");
> +
> +	return run_command(&cp);
> +}
> +
> +static int get_newly_staged(struct strbuf *out, struct object_id *c_tree)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	const char *c_tree_hex = oid_to_hex(c_tree);
> +
> +	/*
> +	 * diff-index is very similar to diff-tree above, and should be
> +	 * converted together with update_index.
> +	 */
> +	cp.git_cmd = 1;
> +	argv_array_pushl(&cp.args, "diff-index", "--cached", "--name-only",
> +			 "--diff-filter=A", NULL);
> +	argv_array_push(&cp.args, c_tree_hex);
> +	return pipe_command(&cp, NULL, 0, out, 0, NULL, 0);
> +}
> +
> +static int update_index(struct strbuf *out)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +
> +	/*
> +	 * Update-index is very complicated and may need to have a public
> +	 * function exposed in order to remove this forking.
> +	 */
> +	cp.git_cmd = 1;
> +	argv_array_pushl(&cp.args, "update-index", "--add", "--stdin", NULL);
> +	return pipe_command(&cp, out->buf, out->len, NULL, 0, NULL, 0);
> +}
> +
> +static int restore_untracked(struct object_id *u_tree)
> +{
> +	int res;
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +
> +	/*
> +	 * We need to run restore files from a given index, but without
> +	 * affecting the current index, so we use GIT_INDEX_FILE with
> +	 * run_command to fork processes that will not interfere.
> +	 */
> +	cp.git_cmd = 1;
> +	argv_array_push(&cp.args, "read-tree");
> +	argv_array_push(&cp.args, oid_to_hex(u_tree));
> +	argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=%s",
> +			 stash_index_path.buf);
> +	if (run_command(&cp)) {
> +		remove_path(stash_index_path.buf);
> +		return -1;
> +	}
> +
> +	child_process_init(&cp);
> +	cp.git_cmd = 1;
> +	argv_array_pushl(&cp.args, "checkout-index", "--all", NULL);
> +	argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=%s",
> +			 stash_index_path.buf);
> +
> +	res = run_command(&cp);
> +	remove_path(stash_index_path.buf);
> +	return res;
> +}
> +
> +static int do_apply_stash(const char *prefix, struct stash_info *info,
> +			  int index, int quiet)
> +{
> +	int ret;
> +	int has_index = index;
> +	struct merge_options o;
> +	struct object_id c_tree;
> +	struct object_id index_tree;
> +	struct commit *result;
> +	const struct object_id *bases[1];
> +
> +	read_cache_preload(NULL);
> +	if (refresh_cache(REFRESH_QUIET))
> +		return -1;
> +
> +	if (write_cache_as_tree(&c_tree, 0, NULL) || reset_tree(&c_tree, 0, 0))
> +		return error(_("cannot apply a stash in the middle of a merge"));
> +
> +	if (index) {
> +		if (!oidcmp(&info->b_tree, &info->i_tree) ||
> +		    !oidcmp(&c_tree, &info->i_tree)) {
> +			has_index = 0;
> +		} else {
> +			struct strbuf out = STRBUF_INIT;
> +
> +			if (diff_tree_binary(&out, &info->w_commit)) {
> +				strbuf_release(&out);
> +				return error(_("Could not generate diff %s^!."),
> +					     oid_to_hex(&info->w_commit));
> +			}
> +
> +			ret = apply_cached(&out);
> +			strbuf_release(&out);
> +			if (ret)
> +				return error(_("Conflicts in index."
> +					       "Try without --index."));
> +
> +			discard_cache();
> +			read_cache();
> +			if (write_cache_as_tree(&index_tree, 0, NULL))
> +				return error(_("Could not save index tree"));
> +
> +			reset_head();
> +		}
> +	}
> +
> +	if (info->has_u && restore_untracked(&info->u_tree))
> +		return error(_("could not restore untracked files from stash"));
> +
> +	init_merge_options(&o);
> +
> +	o.branch1 = "Updated upstream";
> +	o.branch2 = "Stashed changes";
> +
> +	if (!oidcmp(&info->b_tree, &c_tree))
> +		o.branch1 = "Version stash was based on";
> +
> +	if (quiet)
> +		o.verbosity = 0;
> +
> +	if (o.verbosity >= 3)
> +		printf_ln(_("Merging %s with %s"), o.branch1, o.branch2);
> +
> +	bases[0] = &info->b_tree;
> +
> +	ret = merge_recursive_generic(&o, &c_tree, &info->w_tree, 1, bases,
> +				      &result);
> +	if (ret) {
> +		rerere(0);
> +
> +		if (index)
> +			fprintf_ln(stderr, _("Index was not unstashed."));
> +
> +		return ret;
> +	}
> +
> +	if (has_index) {
> +		if (reset_tree(&index_tree, 0, 0))
> +			return -1;
> +	} else {
> +		struct strbuf out = STRBUF_INIT;
> +
> +		if (get_newly_staged(&out, &c_tree)) {
> +			strbuf_release(&out);
> +			return -1;
> +		}
> +
> +		if (reset_tree(&c_tree, 0, 1)) {
> +			strbuf_release(&out);
> +			return -1;
> +		}
> +
> +		ret = update_index(&out);
> +		strbuf_release(&out);
> +		if (ret)
> +			return -1;
> +
> +		discard_cache();
> +	}
> +
> +	if (quiet) {
> +		if (refresh_cache(REFRESH_QUIET))
> +			warning("could not refresh index");
> +	} else {
> +		struct child_process cp = CHILD_PROCESS_INIT;
> +
> +		/*
> +		 * Status is quite simple and could be replaced with calls to
> +		 * wt_status in the future, but it adds complexities which may
> +		 * require more tests.
> +		 */
> +		cp.git_cmd = 1;
> +		cp.dir = prefix;
> +		argv_array_push(&cp.args, "status");
> +		run_command(&cp);
> +	}
> +
> +	return 0;
> +}
> +
> +static int apply_stash(int argc, const char **argv, const char *prefix)
> +{
> +	int ret;
> +	int quiet = 0;
> +	int index = 0;
> +	struct stash_info info;
> +	struct option options[] = {
> +		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
> +		OPT_BOOL(0, "index", &index,
> +			 N_("attempt to recreate the index")),
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options,
> +			     git_stash_helper_apply_usage, 0);
> +
> +	if (get_stash_info(&info, argc, argv))
> +		return -1;
> +
> +	ret = do_apply_stash(prefix, &info, index, quiet);
> +	free_stash_info(&info);
> +	return ret;
> +}
> +
> +int cmd_stash__helper(int argc, const char **argv, const char *prefix)
> +{
> +	pid_t pid = getpid();
> +	const char *index_file;
> +
> +	struct option options[] = {
> +		OPT_END()
> +	};
> +
> +	git_config(git_default_config, NULL);
> +
> +	argc = parse_options(argc, argv, prefix, options, git_stash_helper_usage,
> +			     PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDASH);
> +
> +	index_file = get_index_file();
> +	strbuf_addf(&stash_index_path, "%s.stash.%" PRIuMAX, index_file,
> +		    (uintmax_t)pid);
> +
> +	if (argc < 1)
> +		usage_with_options(git_stash_helper_usage, options);
> +	if (!strcmp(argv[0], "apply"))
> +		return !!apply_stash(argc, argv, prefix);
> +
> +	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
> +		      git_stash_helper_usage, options);
> +}
> diff --git a/git-stash.sh b/git-stash.sh
> index 94793c1a91..809b1c2d1d 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -566,76 +566,11 @@ assert_stash_ref() {
>  }
>  
>  apply_stash () {
> -
> -	assert_stash_like "$@"
> -
> -	git update-index -q --refresh || die "$(gettext "unable to refresh index")"
> -
> -	# current index state
> -	c_tree=$(git write-tree) ||
> -		die "$(gettext "Cannot apply a stash in the middle of a merge")"
> -
> -	unstashed_index_tree=
> -	if test -n "$INDEX_OPTION" && test "$b_tree" != "$i_tree" &&
> -			test "$c_tree" != "$i_tree"
> -	then
> -		git diff-tree --binary $s^2^..$s^2 | git apply --cached
> -		test $? -ne 0 &&
> -			die "$(gettext "Conflicts in index. Try without --index.")"
> -		unstashed_index_tree=$(git write-tree) ||
> -			die "$(gettext "Could not save index tree")"
> -		git reset
> -	fi
> -
> -	if test -n "$u_tree"
> -	then
> -		GIT_INDEX_FILE="$TMPindex" git read-tree "$u_tree" &&
> -		GIT_INDEX_FILE="$TMPindex" git checkout-index --all &&
> -		rm -f "$TMPindex" ||
> -		die "$(gettext "Could not restore untracked files from stash entry")"
> -	fi
> -
> -	eval "
> -		GITHEAD_$w_tree='Stashed changes' &&
> -		GITHEAD_$c_tree='Updated upstream' &&
> -		GITHEAD_$b_tree='Version stash was based on' &&
> -		export GITHEAD_$w_tree GITHEAD_$c_tree GITHEAD_$b_tree
> -	"
> -
> -	if test -n "$GIT_QUIET"
> -	then
> -		GIT_MERGE_VERBOSITY=0 && export GIT_MERGE_VERBOSITY
> -	fi
> -	if git merge-recursive $b_tree -- $c_tree $w_tree
> -	then
> -		# No conflict
> -		if test -n "$unstashed_index_tree"
> -		then
> -			git read-tree "$unstashed_index_tree"
> -		else
> -			a="$TMP-added" &&
> -			git diff-index --cached --name-only --diff-filter=A $c_tree >"$a" &&
> -			git read-tree --reset $c_tree &&
> -			git update-index --add --stdin <"$a" ||
> -				die "$(gettext "Cannot unstage modified files")"
> -			rm -f "$a"
> -		fi
> -		squelch=
> -		if test -n "$GIT_QUIET"
> -		then
> -			squelch='>/dev/null 2>&1'
> -		fi
> -		(cd "$START_DIR" && eval "git status $squelch") || :
> -	else
> -		# Merge conflict; keep the exit status from merge-recursive
> -		status=$?
> -		git rerere
> -		if test -n "$INDEX_OPTION"
> -		then
> -			gettextln "Index was not unstashed." >&2
> -		fi
> -		exit $status
> -	fi
> +	cd "$START_DIR"
> +	git stash--helper apply "$@"
> +	res=$?
> +	cd_to_toplevel
> +	return $res
>  }
>  
>  pop_stash() {
> @@ -713,7 +648,8 @@ push)
>  	;;
>  apply)
>  	shift
> -	apply_stash "$@"
> +	cd "$START_DIR"
> +	git stash--helper apply "$@"
>  	;;
>  clear)
>  	shift
> diff --git a/git.c b/git.c
> index c27c38738b..3c0e762d7d 100644
> --- a/git.c
> +++ b/git.c
> @@ -544,6 +544,7 @@ static struct cmd_struct commands[] = {
>  	{ "show-index", cmd_show_index },
>  	{ "show-ref", cmd_show_ref, RUN_SETUP },
>  	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
> +	{ "stash--helper", cmd_stash__helper, RUN_SETUP | NEED_WORK_TREE },
>  	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
>  	{ "stripspace", cmd_stripspace },
>  	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX | NO_PARSEOPT },
> -- 
> 2.19.0.rc0.23.g10a62394e7
> 
> 
