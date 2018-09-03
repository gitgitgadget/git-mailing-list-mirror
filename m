Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85E831F404
	for <e@80x24.org>; Mon,  3 Sep 2018 16:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbeICUVX (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 16:21:23 -0400
Received: from mout.gmx.net ([212.227.15.19]:36401 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725969AbeICUVW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 16:21:22 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lymoh-1frir81bUd-016AVP; Mon, 03
 Sep 2018 18:00:33 +0200
Date:   Mon, 3 Sep 2018 18:00:32 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v8 14/20] stash: convert create to builtin
In-Reply-To: <a4faed3c8aa5ea8f0d4c578b693f3b5de3e3a709.1535665109.git.ungureanupaulsebastian@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1809031718230.71@tvgsbejvaqbjf.bet>
References: <cover.1535665109.git.ungureanupaulsebastian@gmail.com> <a4faed3c8aa5ea8f0d4c578b693f3b5de3e3a709.1535665109.git.ungureanupaulsebastian@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4Gb4zGRCUBnW6VJy+FRI2/Izf7Oiyc3XUpkf3b3uTvYPbqW3p1J
 rrWIB/UUAUUy+Y9gM15YszNsTfmmgmsq+hdzMgKAfgOd6owcUWWyfxeLv2FP7jxOlAoPxdh
 hLv9DOi3BzuuFAC56bXWSk06jhAbf15sYBRRbGycuCDLJ3M/zOzlrtEtyuSEIwcnXcpkfMR
 ipnPSyoMNKmyf6ILUppkQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+zPc7SRZUpc=:BAjNugeKZs5wuqhK9uPDSq
 Dvkcq+AGJNj9rt5L5dxEHQvchAZS4BLhKB4lqsT5NUmMFTumYY6uOA9Xoa/R+HeKJ2MocXfT/
 oOnX0kRxNvKtbvldcP0kfG+b/eLGRBAnCDZJbor/hVnUdI98c8opq4yOUitYvvtr+CeTEGLig
 b/GBAxpxhCBKzNpchGcIy/aQUFjpV6FUifToMB/uUOTVwwykM0Z5CJj0fH4U8B44cgWFsZ+QW
 6i/IUBTOJb99Au4ZbrODZktwRWnwgdAo1B75I1gSVIrsX7IWoha6ECjryHpqv8z6gJcvbFL81
 pqUFXzaRSeA2rnltqgPdEpf0nMC9/SFHNxhodG21qZCIjDOcankMfT++ZqEpDibiOXlaRyHlr
 RPrbLKJYdEPRVsrlvYtRan4EnRrVXfKj7BTPwmeuwBjrNd/EjVxw0TT6WNX6N0sUMqC4I+Y7p
 t1caYuxPpzQw8i3pbf6yewt4ryJDhVz0kf+kE1pMocpmWknt//5SF4LkCWL+uBsDcbL/b8pc9
 GwBnrcwgmzYKXRZACXcHI7onAXEl7oRsKXuTejtZc7q2P+wNYuwxdecnBFSWI5v6Jkz2KI0IB
 TJg4ClasdOFA6HPhJXUIP43YaqfZ+50zD6wlBbhYWcHRUiQA2KUblHL45h/DoxE1coStjPR2G
 TDE7h8vpDswPygPI1DpygrpPGI9pjVnYbYsXaRh8zB5CFwxFk4eLYWR3SmwWHfrZJSrO9LPkK
 10v0duSi4yfg43/sjZy1zPlhoy6r1eAO2BPbe6E6VRzq/2195mPRwY90h6m3yqfLSaEqngNu7
 XNE37gW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul,

On Fri, 31 Aug 2018, Paul-Sebastian Ungureanu wrote:

> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> index 87568b0f34..ce360a569d 100644
> --- a/builtin/stash--helper.c
> +++ b/builtin/stash--helper.c
> @@ -290,6 +296,18 @@ static int reset_head(void)
>  	return run_command(&cp);
>  }
>  
> +static void add_diff_to_buf(struct diff_queue_struct *q,
> +			    struct diff_options *options,
> +			    void *data)
> +{
> +	int i;
> +	for (i = 0; i < q->nr; i++) {
> +		struct diff_filepair *p = q->queue[i];
> +		strbuf_addstr(data, p->one->path);

Maybe `q->queue[i]->one->path` would be okay, too? Dunno.

> +		strbuf_addch(data, 0);

Neat trick. However, I had to study the code to see that the output of
this function will be fed to `update-index -z` to see why the NUL is
appended here. Maybe add a code comment here?

> +	}
> +}
> +
>  static int get_newly_staged(struct strbuf *out, struct object_id *c_tree)
>  {
>  	struct child_process cp = CHILD_PROCESS_INIT;
> @@ -776,6 +794,416 @@ static int store_stash(int argc, const char **argv, const char *prefix)
>  	return do_store_stash(argv[0], stash_msg, quiet);
>  }
>  
> +/*
> + * `out` will be filled with the names of untracked files. The return value is:
> + *
> + * = 0 if there are not any untracked files
> + * > 0 if there are untracked files
> + */
> +static int get_untracked_files(struct pathspec ps, int include_untracked,
> +			       struct strbuf *out)
> +{
> +	int max_len;
> +	int i;
> +	char *seen;
> +	struct dir_struct dir;
> +
> +	memset(&dir, 0, sizeof(dir));
> +	if (include_untracked != 2)

If you follow my suggestion to replace this magic `2` by a symbol that
describes the meaning "include all", then this line would need to be
changed, too.

> +		setup_standard_excludes(&dir);
> +
> +	seen = xcalloc(ps.nr, 1);
> +
> +	max_len = fill_directory(&dir, the_repository->index, &ps);
> +	for (i = 0; i < dir.nr; i++) {
> +		struct dir_entry *ent = dir.entries[i];
> +		if (!dir_path_match(&the_index, ent, &ps, max_len, seen)) {
> +			free(ent);
> +			continue;
> +		}
> +		strbuf_addf(out, "%s%c", ent->name, '\0');
> +		free(ent);

This is a *very* minor nit pick... I would have written it this way
instead:

		if (dir_path_match(&the_index, ent, &ps, max_len, seen)) {
			strbuf_addstr(out, ent->name);
			/* NUL-terminate: will be fed to update-index -z */
			strbuf_addch(out, 0);
		}
		free(ent);

Just an idea...

> +	}
> +
> +	free(dir.entries);
> +	free(dir.ignored);
> +	clear_directory(&dir);
> +	free(seen);
> +	return out->len;
> +}

If you introduce a local variable `found` and increase it whenever a match
was found, then you could also handle `out == NULL` by skipping the
`strbuf_*()` calls, which would come in handin in the `check_changes()`
function that does not actually want to use the output.

> +
> +/*
> + * The return value of `check_changes()` can be:
> + *
> + * < 0 if there was an error
> + * = 0 if there are no changes.
> + * > 0 if there are changes.
> + */
> +static int check_changes(struct pathspec ps, int include_untracked)
> +{
> +	int result;
> +	int ret = 0;
> +	struct rev_info rev;
> +	struct object_id dummy;
> +	struct strbuf out = STRBUF_INIT;
> +
> +	init_revisions(&rev, NULL);
> +	rev.prune_data = ps;
> +
> +	rev.diffopt.flags.quick = 1;
> +	rev.diffopt.flags.ignore_submodules = 1;
> +	rev.abbrev = 0;
> +
> +	/* No initial commit. */
> +	if (get_oid("HEAD", &dummy))
> +		return -1;
> +
> +	add_head_to_pending(&rev);
> +	diff_setup_done(&rev.diffopt);
> +
> +	if (read_cache() < 0)
> +		return 1;
> +	result = run_diff_index(&rev, 1);
> +	if (diff_result_code(&rev.diffopt, result))
> +		return 1;
> +
> +	object_array_clear(&rev.pending);
> +	result = run_diff_files(&rev, 0);
> +	if (diff_result_code(&rev.diffopt, result))
> +		return 1;

These lines look familiar... Maybe call has_unstaged_changes() and
has_uncommitted_changes() here? (I have to admit that I have no idea what
those functions do with unborn branches.)

> +
> +	if (include_untracked && get_untracked_files(ps, include_untracked,
> +						     &out)) {
> +		strbuf_release(&out);
> +		return 1;
> +	}
> +
> +	strbuf_release(&out);
> +	return 0;
> +}
> +
> +static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
> +				struct strbuf *in)
> +{
> +	int ret = 0;
> +	struct strbuf untracked_msg = STRBUF_INIT;
> +	struct strbuf out = STRBUF_INIT;
> +	struct child_process cp_upd_index = CHILD_PROCESS_INIT;
> +	struct child_process cp_write_tree = CHILD_PROCESS_INIT;
> +
> +	cp_upd_index.git_cmd = 1;
> +	argv_array_pushl(&cp_upd_index.args, "update-index", "-z", "--add",
> +			 "--remove", "--stdin", NULL);
> +	argv_array_pushf(&cp_upd_index.env_array, "GIT_INDEX_FILE=%s",
> +			 stash_index_path.buf);
> +
> +	strbuf_addf(&untracked_msg, "untracked files on %s\n", msg->buf);
> +	if (pipe_command(&cp_upd_index, in->buf, in->len, NULL, 0, NULL, 0)) {
> +		ret = -1;
> +		goto done;
> +	}
> +
> +	cp_write_tree.git_cmd = 1;
> +	argv_array_push(&cp_write_tree.args, "write-tree");
> +	argv_array_pushf(&cp_write_tree.env_array, "GIT_INDEX_FILE=%s",
> +			 stash_index_path.buf);
> +	if (pipe_command(&cp_write_tree, NULL, 0, &out, 0,NULL, 0)) {
> +		ret = -1;
> +		goto done;
> +	}
> +	get_oid_hex(out.buf, &info->u_tree);
> +
> +	if (commit_tree(untracked_msg.buf, untracked_msg.len,
> +			&info->u_tree, NULL, &info->u_commit, NULL, NULL)) {
> +		ret = -1;
> +		goto done;
> +	}
> +
> +done:
> +	strbuf_release(&untracked_msg);
> +	strbuf_release(&out);
> +	remove_path(stash_index_path.buf);
> +	return ret;
> +}
> +
> +static struct strbuf patch = STRBUF_INIT;

As far as I can see, this variable should be local to `stash_patch` (and
released at the end).

[Coming back after reading the shell script code and realizing that it
wrote the $TMP-patch file that is then used in `push_stash`]

Ah! So the output of `stash_patch()` is not just a return value indicating
success, but it also wants to return the patch. How about passing this in
via a parameter after `struct pathspec ps`, say, `struct strbuf
*out_patch`?

> +
> +static int stash_patch(struct stash_info *info, struct pathspec ps)
> +{
> +	int i;
> +	int ret = 0;
> +	struct strbuf out = STRBUF_INIT;
> +	struct child_process cp_read_tree = CHILD_PROCESS_INIT;
> +	struct child_process cp_add_i = CHILD_PROCESS_INIT;
> +	struct child_process cp_write_tree = CHILD_PROCESS_INIT;
> +	struct child_process cp_diff_tree = CHILD_PROCESS_INIT;
> +
> +	remove_path(stash_index_path.buf);
> +
> +	cp_read_tree.git_cmd = 1;
> +	argv_array_pushl(&cp_read_tree.args, "read-tree", "HEAD", NULL);
> +	argv_array_pushf(&cp_read_tree.env_array, "GIT_INDEX_FILE=%s",
> +			 stash_index_path.buf);
> +	if (run_command(&cp_read_tree)) {
> +		ret = -1;
> +		goto done;
> +	}
> +

Maybe insert the comment "find out what the user wants" here?

> +	cp_add_i.git_cmd = 1;
> +	argv_array_pushl(&cp_add_i.args, "add--interactive", "--patch=stash",
> +			"--", NULL);
> +	for (i = 0; i < ps.nr; ++i)
> +		argv_array_push(&cp_add_i.args, ps.items[i].match);

I guess you could use `add_ps_items_to_argv_array(&cp_add_i.args, &ps)` here.

> +	argv_array_pushf(&cp_add_i.env_array, "GIT_INDEX_FILE=%s",
> +			 stash_index_path.buf);
> +	if (run_command(&cp_add_i)) {
> +		ret = -1;
> +		goto done;
> +	}
> +

Maybe insert the comment "state of the working tree" here?

> +	cp_write_tree.git_cmd = 1;
> +	argv_array_push(&cp_write_tree.args, "write-tree");
> +	argv_array_pushf(&cp_write_tree.env_array, "GIT_INDEX_FILE=%s",
> +			 stash_index_path.buf);
> +	if (pipe_command(&cp_write_tree, NULL, 0, &out, 0,NULL, 0)) {
> +		ret = -1;
> +		goto done;
> +	}
> +
> +	get_oid_hex(out.buf, &info->w_tree);
> +
> +	cp_diff_tree.git_cmd = 1;
> +	argv_array_pushl(&cp_diff_tree.args, "diff-tree", "-p", "HEAD",
> +			 oid_to_hex(&info->w_tree), "--", NULL);
> +	if (pipe_command(&cp_diff_tree, NULL, 0, &patch, 0, NULL, 0)) {
> +		ret = -1;
> +		goto done;
> +	}
> +
> +	if (!patch.len) {
> +		fprintf_ln(stderr, _("No changes selected"));
> +		ret = 1;
> +	}
> +
> +done:
> +	strbuf_release(&out);
> +	remove_path(stash_index_path.buf);
> +	return ret;
> +}
> +
> +static int stash_working_tree(struct stash_info *info, struct pathspec ps)
> +{
> +	int ret = 0;
> +	struct child_process cp_upd_index = CHILD_PROCESS_INIT;
> +	struct child_process cp_write_tree = CHILD_PROCESS_INIT;
> +	struct strbuf out = STRBUF_INIT;
> +	struct strbuf diff_output = STRBUF_INIT;
> +	struct rev_info rev;
> +
> +	set_alternate_index_output(stash_index_path.buf);
> +	if (reset_tree(&info->i_tree, 0, 0)) {

So this is the `git read-tree --index-output="$TMPindex" -m $i_tree` call.

At first, I thought that one of the zeros meant that the `merge` flag
would be turned off, but that is always turned on. Okay. (I guess
positional parameters make this a bit less readable, not your fault, but
C's.)

> +		ret = -1;
> +		goto done;
> +	}
> +	set_alternate_index_output(NULL);

Side note (i.e. rant): I wish this was more thread-safe. Granted, right
now it does not make sense to reset_tree() in parallel. But Stefan Beller
is working on being able to reset_tree() submodules, in which case
running reset_tree() in parallel will make a ton of sense.

> +
> +	git_config(git_diff_basic_config, NULL);

Is this not called in as part of `git_config(git_default_config, NULL);`
in cmd_stash() already?

*clicketyclick*

I guess not. But then, maybe it would make sense to run with
`git_diff_basic_config` from the get go, to avoid having to run
`git_config()` twice.

> +	init_revisions(&rev, NULL);
> +	rev.prune_data = ps;
> +	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
> +	rev.diffopt.format_callback = add_diff_to_buf;
> +	rev.diffopt.format_callback_data = &diff_output;
> +
> +	if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
> +		ret = -1;
> +		goto done;
> +	}
> +
> +	add_pending_object(&rev, parse_object(the_repository, &info->b_commit), "");
> +	if (run_diff_index(&rev, 0)) {
> +		ret = -1;
> +		goto done;
> +	}
> +
> +	cp_upd_index.git_cmd = 1;
> +	argv_array_pushl(&cp_upd_index.args, "update-index", "-z", "--add",
> +			 "--remove", "--stdin", NULL);
> +	argv_array_pushf(&cp_upd_index.env_array, "GIT_INDEX_FILE=%s",
> +			 stash_index_path.buf);
> +
> +	if (pipe_command(&cp_upd_index, diff_output.buf, diff_output.len,
> +			 NULL, 0, NULL, 0)) {
> +		ret = -1;
> +		goto done;
> +	}
> +
> +	cp_write_tree.git_cmd = 1;
> +	argv_array_push(&cp_write_tree.args, "write-tree");
> +	argv_array_pushf(&cp_write_tree.env_array, "GIT_INDEX_FILE=%s",
> +			 stash_index_path.buf);
> +	if (pipe_command(&cp_write_tree, NULL, 0, &out, 0,NULL, 0)) {
> +		ret = -1;
> +		goto done;
> +	}
> +
> +	get_oid_hex(out.buf, &info->w_tree);
> +
> +done:
> +	UNLEAK(rev);
> +	strbuf_release(&out);
> +	object_array_clear(&rev.pending);
> +	strbuf_release(&diff_output);
> +	remove_path(stash_index_path.buf);
> +	return ret;
> +}
> +
> +static int do_create_stash(struct pathspec ps, const char **stash_msg,

As the `stash_msg` will receive an allocated buffer that will need to be
released by the caller, this should be a `char **stash_msg` (no `const`).

> +			   int include_untracked, int patch_mode,
> +			   struct stash_info *info)
> +{
> +	int untracked_commit_option = 0;
> +	int ret = 0;
> +	int flags;
> +	const char *head_short_sha1 = NULL;
> +	const char *branch_ref = NULL;
> +	const char *branch_name = "(no branch)";
> +	struct commit *head_commit = NULL;
> +	struct commit_list *parents = NULL;
> +	struct strbuf msg = STRBUF_INIT;
> +	struct strbuf commit_tree_label = STRBUF_INIT;
> +	struct strbuf out = STRBUF_INIT;
> +	struct strbuf stash_msg_buf = STRBUF_INIT;
> +
> +	read_cache_preload(NULL);
> +	refresh_cache(REFRESH_QUIET);
> +
> +	if (!check_changes(ps, include_untracked)) {
> +		ret = 1;
> +		*stash_msg = NULL;
> +		goto done;
> +	}
> +
> +	if (get_oid("HEAD", &info->b_commit)) {
> +		fprintf_ln(stderr, _("You do not have the initial commit yet"));
> +		ret = -1;
> +		*stash_msg = NULL;

Oh, so we actually do not even have to handle an unborn branch if we move
the `check_changes()` call after this block?

> +		goto done;
> +	} else {
> +		head_commit = lookup_commit(the_repository, &info->b_commit);
> +	}
> +
> +	branch_ref = resolve_ref_unsafe("HEAD", 0, NULL, &flags);
> +	if (flags & REF_ISSYMREF)
> +		branch_name = strrchr(branch_ref, '/') + 1;
> +	head_short_sha1 = find_unique_abbrev(&head_commit->object.oid,
> +					     DEFAULT_ABBREV);
> +	strbuf_addf(&msg, "%s: %s ", branch_name, head_short_sha1);
> +	pp_commit_easy(CMIT_FMT_ONELINE, head_commit, &msg);
> +
> +	strbuf_addf(&commit_tree_label, "index on %s\n", msg.buf);
> +	commit_list_insert(head_commit, &parents);
> +	if (write_cache_as_tree(&info->i_tree, 0, NULL) ||
> +	    commit_tree(commit_tree_label.buf, commit_tree_label.len,
> +			&info->i_tree, parents, &info->i_commit, NULL, NULL)) {
> +		fprintf_ln(stderr, _("Cannot save the current index state"));
> +		ret = -1;
> +		*stash_msg = NULL;
> +		goto done;
> +	}
> +
> +	if (include_untracked && get_untracked_files(ps, include_untracked,
> +						     &out)) {
> +		if (save_untracked_files(info, &msg, &out)) {
> +			fprintf_ln(stderr, _("Cannot save the untracked files"));
> +			ret = -1;
> +			*stash_msg = NULL;
> +			goto done;
> +		}
> +		untracked_commit_option = 1;
> +	}
> +	if (patch_mode) {
> +		ret = stash_patch(info, ps);
> +		*stash_msg = NULL;
> +		if (ret < 0) {
> +			fprintf_ln(stderr, _("Cannot save the current worktree state"));
> +			goto done;
> +		} else if (ret > 0) {
> +			goto done;
> +		}
> +	} else {
> +		if (stash_working_tree(info, ps)) {
> +			fprintf_ln(stderr, _("Cannot save the current worktree state"));
> +			ret = -1;
> +			*stash_msg = NULL;
> +			goto done;
> +		}
> +	}
> +
> +	if (!*stash_msg || !strlen(*stash_msg))
> +		strbuf_addf(&stash_msg_buf, "WIP on %s", msg.buf);
> +	else
> +		strbuf_addf(&stash_msg_buf, "On %s: %s", branch_name,
> +			    *stash_msg);
> +	*stash_msg = strbuf_detach(&stash_msg_buf, NULL);
> +
> +	/*
> +	 * `parents` will be empty after calling `commit_tree()`, so there is
> +	 * no need to call `free_commit_list()`

If it is empty, why do we need to set it to `NULL` explicitly?

> +	 */
> +	parents = NULL;
> +	if (untracked_commit_option)
> +		commit_list_insert(lookup_commit(the_repository, &info->u_commit), &parents);
> +	commit_list_insert(lookup_commit(the_repository, &info->i_commit), &parents);
> +	commit_list_insert(head_commit, &parents);
> +
> +	if (commit_tree(*stash_msg, strlen(*stash_msg), &info->w_tree,
> +			parents, &info->w_commit, NULL, NULL)) {
> +		fprintf_ln(stderr, _("Cannot record working tree state"));
> +		ret = -1;
> +		goto done;
> +	}
> +
> +done:
> +	strbuf_release(&commit_tree_label);
> +	strbuf_release(&msg);
> +	strbuf_release(&out);
> +	strbuf_release(&stash_msg_buf);
> +	return ret;
> +}
> +
> +static int create_stash(int argc, const char **argv, const char *prefix)
> +{
> +	int include_untracked = 0;
> +	int ret = 0;
> +	const char *stash_msg = NULL;

As we are taking custody of the buffer here, `stash_msg` should be of type
`char *`, i.e. no `const`.

The rest of the patch looks good to me.

Phew! What a patch! This took quite a while to review, so I am taking a
break with this patch series here, and hope to continue in a few hours
from now.

Thanks,
Dscho

> +	struct stash_info info;
> +	struct pathspec ps;
> +	struct option options[] = {
> +		OPT_BOOL('u', "include-untracked", &include_untracked,
> +			 N_("include untracked files in stash")),
> +		OPT_STRING('m', "message", &stash_msg, N_("message"),
> +			 N_("stash message")),
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options,
> +			     git_stash_helper_create_usage,
> +			     0);
> +
> +	memset(&ps, 0, sizeof(ps));
> +	ret = do_create_stash(ps, &stash_msg, include_untracked, 0, &info);
> +
> +	if (!ret)
> +		printf_ln("%s", oid_to_hex(&info.w_commit));
> +
> +	/*
> +	 * ret can be 1 if there were no changes. In this case, we should
> +	 * not error out.
> +	 */
> +	free((char *) stash_msg);
> +	return ret < 0;
> +}
> +
>  int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  {
>  	pid_t pid = getpid();
> @@ -812,6 +1240,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>  		return !!show_stash(argc, argv, prefix);
>  	else if (!strcmp(argv[0], "store"))
>  		return !!store_stash(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "create"))
> +		return !!create_stash(argc, argv, prefix);
>  
>  	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
>  		      git_stash_helper_usage, options);
> diff --git a/git-stash.sh b/git-stash.sh
> index 5739c51527..ab06e4ffb8 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -425,7 +425,7 @@ clear)
>  	;;
>  create)
>  	shift
> -	create_stash -m "$*" && echo "$w_commit"
> +	git stash--helper create --message "$*"
>  	;;
>  store)
>  	shift
> -- 
> 2.19.0.rc0.22.gc26283d74e
> 
> 
