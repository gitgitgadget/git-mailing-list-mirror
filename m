Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95A9020A10
	for <e@80x24.org>; Tue,  7 Nov 2017 01:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754723AbdKGBgo (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 20:36:44 -0500
Received: from mout.gmx.net ([212.227.17.21]:57961 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752603AbdKGBgm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 20:36:42 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MIiHs-1eE4fy1IS0-002FG8; Tue, 07
 Nov 2017 02:36:34 +0100
Date:   Tue, 7 Nov 2017 02:36:30 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 8/8] sequencer: try to commit without forking 'git
 commit'
In-Reply-To: <20171106112709.2121-9-phillip.wood@talktalk.net>
Message-ID: <alpine.DEB.2.21.1.1711070203230.6482@virtualbox>
References: <20170925101041.18344-1-phillip.wood@talktalk.net> <20171106112709.2121-1-phillip.wood@talktalk.net> <20171106112709.2121-9-phillip.wood@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:dyPQtcV5Ph5rcEjPOlQqUeyrwIwWo4GUj1bB9EnjPoh5nXnR1s3
 W0kcVBVaCvfIxuvycqHhF3dtovlGeSt0reP8BVpx7BaDuLJ3MEQT7t9qES/qPyuUHDL3vKy
 f5pvqEknksxbgTpmzmgP6JZBOY4kYyJK80TJIDgBpNKMibIB2Qj/apCawJjE0W7jSuR/EWN
 tITjEd8IqB6+PPFHFDcfQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/m/Z9NXd+5g=:NjOs6VHYzKS6hLJXlTOIdH
 HCfTrQuCDCwcmD7rr12DEC37fwlbu8JRLGzILuod3CnxZzJHbClLb4r93yQLDovE7/CY5Sqx3
 U6fBzAncPK0/4Td/N5QSr+3rMm+e7+CLsIDp2ersEhZshxNIwr+kzOmltE/O4x00Z3JONzElZ
 CNpszcLzET/pcTo7SW/VPgq5Fz9Zu2JGgiu9Pau70xyCWA4O/945vjAz0BrTQQ8ACbSt/uHzy
 1aJ6eNypTCNgeiqX/p/uIOiWAGgbDicZmQxW42iew/ZHHHxEXuSZbh+DLxpNtYqzRavSWQCYO
 Qy2UJ1Wr8GCKBm4ti9vGefWwx/J3+jzfF2GkBrYBFxAnPc8RHJ7q747O3qSHqDZJ9/JRqnDLM
 c1c2vth/f83d3iUH6SeYJdsGZn1V3PVWBl2aTJpbWr+RSFTrUqT3sMriOQA3Mw27aR574OD6X
 fydBBSlH9RVItBHfJi3yFZnWG5Euj4dzcH8o54gQlQ+uhazFCGA7Y4ZOrLPSdTZxLQEg8ZIrk
 YozbeJEOd6ovYHHl1ez4Bxs4seP8UulXNZlELbQ9hGvyEEvIef+zWQW/zxEsw1NR8yLhMkrys
 lHw9YgVtm4Y/q6ReDDaHGZqcHGFEWjIE2P0TNMX1WK4rmTLz0pWcA6wT+5a+DepU+1IBctRao
 kHyZdhEqm1XtrqNmBY5OtgbOmuKCNQCKkjeT1Bm+/AUJHle82Tj4S66Zk5D0wuiuRY1RGkyuG
 5JgLBlPMYoNErFVrPhSwPlnz0bFmUagebPFD3FyH9V/DxzIJk2VLOWZrVpgenc+rmJ9xB7IyF
 qPZDdyTJqDCjCbmdQ1g+V+xSXX0H5/YoZU5nUMrh1e20t0wjS4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, 6 Nov 2017, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> If the commit message does not need to be edited then create the
> commit without forking 'git commit'. Taking the best time of ten runs
> with a warm cache this reduces the time taken to cherry-pick 10
> commits by 27% (from 282ms to 204ms), and the time taken by 'git
> rebase --continue' to pick 10 commits by 45% (from 386ms to 212ms) on
> my computer running linux. Some of greater saving for rebase is
> because it longer wastes time creating the commit summary just to

I usually leave the grammar reviews to people who prefer to review grammar
over code, but in this case I think the "no" in "no longer" is rather
crucial.

> throw it away.

Those are impressive improvements, and I am certain that they will be even
more noticable on Windows, where creating processes is a lot more
expensive than on Linux (which is the reason why you will find a lot more
multi-threaded processes on Windows...).

> The code to create the commit is based on builtin/commit.c. It is
> slightly simplified as it doesn't have to deal with merges and
> modified so try and return an error rather than dying so that the
> sequencer exits cleanly, as it would when forking 'git commit'.
> 
> Even when not forking 'git commit' the commit message is written to a
> file and CHERRY_PICK_HEAD is created unnecessarily. This could be
> eliminated in future. I hacked up a version that does not write these
> files and just passed an strbuf (with the wrong message for fixup and
> squash commands) to do_commit() but I couldn't measure any significant
> time difference when running cherry-pick or rebase. I think
> eliminating the writes properly for rebase would require a bit of
> effort as the code would need to be restructured.

True. And it totally makes sense to go for the big bucks.

> diff --git a/sequencer.c b/sequencer.c
> index b8cf679751449591d6f97102904e060ebee9d7a1..0636d027e9e1cdebaab4802e5becd89e8398a425 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -592,6 +592,18 @@ static int read_env_script(struct argv_array *env)
>  	return 0;
>  }
>  
> +static char *get_author(const char* message)
> +{
> +	size_t len;
> +	const char *a;
> +
> +	a = find_commit_header(message, "author", &len);
> +	if (a)
> +		return xmemdupz(a, len);
> +
> +	return NULL;
> +}

I was surprised that there is no helper for that yet, so I looked, but it
seems that the three existing callers of `find_commit_header(...,
"author", ...)` want to split the ident line right away, and do not need
the duplicated buffer.

In short: the code added here is necessary.

> @@ -984,6 +996,151 @@ int print_commit_summary(const char *prefix, const struct object_id *oid,
>  	return ret;
>  }
>  
> +static int parse_head(struct commit **head)
> +{
> +	struct commit *current_head;
> +	struct object_id oid;
> +
> +	if (get_oid("HEAD", &oid)) {
> +		current_head = NULL;
> +	} else {
> +		current_head = lookup_commit_reference(&oid);
> +		if (!current_head)
> +			return error(_("could not parse HEAD"));
> +		if (oidcmp(&oid, &current_head->object.oid)) {
> +			warning(_("HEAD %s is not a commit!"),
> +				oid_to_hex(&oid));
> +		}
> +		if (parse_commit(current_head))
> +			return error(_("could not parse HEAD commit"));
> +	}
> +	*head = current_head;
> +
> +	return 0;
> +}
> +
> +static int try_to_commit(struct strbuf *msg, const char *author,
> +			 struct replay_opts *opts, unsigned int flags,
> +			 struct object_id *oid)

Since this is a file-local function, i.e. not in any way tied to a
process exit status, it should probably return -1 in the case of errors,
as Git does elsewhere, too.

> +{
> +	struct object_id tree;
> +	struct commit *current_head;
> +	struct commit_list *parents = NULL;
> +	struct commit_extra_header *extra = NULL;
> +	struct strbuf err = STRBUF_INIT;
> +	struct strbuf amend_msg = STRBUF_INIT;
> +	char *amend_author = NULL;
> +	const char *gpg_sign;
> +	enum cleanup_mode cleanup;
> +	int res = 0;
> +
> +	if (parse_head(&current_head))
> +		return -1;
> +
> +	if (flags & AMEND_MSG) {
> +		const char *exclude_gpgsig[2] = { "gpgsig", NULL };

Git's current source code seems to prefer to infer the array length; The
`2` is unnecessary here.

> +		const char *out_enc = get_commit_output_encoding();
> +		const char *message = logmsg_reencode(current_head, NULL,
> +						      out_enc);
> +
> +		if (!msg) {
> +			const char *body = NULL;
> +
> +			find_commit_subject(message, &body);

Maybe `orig_message` would be better here; I expected `body` to refer to
the part of the commit message *after* the subject, but reading the code
of `find_commit_subject()`, I find that it stores the beginning of the
commit message.

Dunno.

> +			msg = &amend_msg;
> +			strbuf_addstr(msg, body);
> +		}
> +		author = amend_author = get_author (message);

Please lose the space after the function name.

> +		unuse_commit_buffer(current_head, message);
> +		if (!author) {
> +			res = error(_("unable to parse commit author"));
> +			goto out;
> +		}
> +		parents = copy_commit_list(current_head->parents);
> +		extra = read_commit_extra_headers(current_head, exclude_gpgsig);
> +	} else if (current_head) {
> +		commit_list_insert(current_head, &parents);
> +	}
> +
> +	cleanup = (flags & CLEANUP_MSG) ? CLEANUP_ALL : default_msg_cleanup;
> +	if (cleanup != CLEANUP_NONE)
> +		strbuf_stripspace(msg, cleanup == CLEANUP_ALL);
> +	if (!opts->allow_empty_message && message_is_empty(msg, cleanup)) {
> +		res = 1;
> +		goto out;
> +	}
> +
> +	gpg_sign = (opts->gpg_sign) ? opts->gpg_sign : default_gpg_sign;

Others will probably complain about those extra parentheses. I am not
offended by them, though.

> +	if (write_cache_as_tree(tree.hash, 0, NULL)) {
> +		res = error(_("git write-tree failed to write a tree"));
> +		goto out;
> +	}
> +
> +	if (!(flags & ALLOW_EMPTY) && !oidcmp(current_head ?
> +					      &current_head->tree->object.oid :
> +					      &empty_tree_oid, &tree)) {

I'll leave it to Junio to comment on the formatting here.

> +		res = 1;
> +		goto out;
> +	}
> +
> +	if (commit_tree_extended(msg->buf, msg->len, tree.hash, parents,
> +				 oid->hash, author, gpg_sign, extra)) {
> +		res = error(_("failed to write commit object"));
> +		goto out;
> +	}
> +
> +	if (update_head(current_head, oid, getenv("GIT_REFLOG_ACTION"), msg,
> +			&err)){
> +		res = error("%s", err.buf);
> +		goto out;
> +	}
> +
> +	if (flags & AMEND_MSG)
> +		commit_post_rewrite(current_head, oid);
> +
> +out:
> +	free_commit_extra_headers(extra);
> +	strbuf_release(&err);
> +	strbuf_release(&amend_msg);
> +	if (amend_author)
> +		free(amend_author);

Git's source code uses the fact that `free(NULL);` is essentially a no-op
(and certainly allowed) to avoid conditionals in such cases.

That would make the `if (amend_author)` unnecessary.

> +
> +	return res;
> +}
> +
> +static int do_commit(const char *msg_file, const char* author,
> +		     struct replay_opts *opts, unsigned int flags)
> +{
> +	int res = 1;

Same as above, the error code should most likely be -1 instead.

> +	if (~flags & EDIT_MSG && ~flags & VERIFY_MSG) {

I *think* it is more common to write `!(flags & EDIT_MSG)` in Git's source
code.

> +		struct object_id oid;
> +		struct strbuf sb = STRBUF_INIT;
> +
> +		if (msg_file && strbuf_read_file(&sb, msg_file, 2048) < 0)
> +			return error_errno(_("unable to read commit message "
> +					     "from '%s'"),
> +					   msg_file);
> +
> +		res = try_to_commit(msg_file ? &sb : NULL, author, opts, flags,
> +				    &oid);
> +		strbuf_release(&sb);
> +		if (res == 0) {

Usually, Git's source code uses `if (!res)` in such cases.

> +			unlink(git_path_cherry_pick_head());
> +			unlink(git_path_merge_msg());
> +			if (!is_rebase_i(opts))
> +				res = print_commit_summary(NULL, &oid,
> +						SUMMARY_SHOW_AUTHOR_DATE);
> +			return res;
> +		}

I wonder whether we should move the `return res;` one line lower, to avoid
falling through to call `run_git_commit()` if `try_to_commit()` failed...

> +	}
> +	if (res == 1)
> +		return run_git_commit(msg_file, opts, flags);

Maybe this code could be simplified even further by moving this
conditional to the beginning of the function, as:

	if ((flags & (EDIT_MSG | VERIFY_MSG)))
		return run_git_commit(msg_file, opts, flags);

But maybe I misunderstood and you really wanted to fall back on
`run_git_commit()` if `try_to_commit()` failed?

> +
> +	return res;
> +}
> +
>  static int is_original_commit_empty(struct commit *commit)
>  {
>  	const struct object_id *ptree_oid;
> @@ -1235,6 +1392,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
>  	struct object_id head;
>  	struct commit *base, *next, *parent;
>  	const char *base_label, *next_label;
> +	char *author = NULL;
>  	struct commit_message msg = { NULL, NULL, NULL, NULL };
>  	struct strbuf msgbuf = STRBUF_INIT;
>  	int res, unborn = 0, allow;
> @@ -1350,6 +1508,8 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
>  			strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
>  			strbuf_addstr(&msgbuf, ")\n");
>  		}
> +		if (!is_fixup (command))
> +			author = get_author(msg.message);
>  	}
>  
>  	if (command == TODO_REWORD)
> @@ -1435,9 +1595,13 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
>  		goto leave;
>  	} else if (allow)
>  		flags |= ALLOW_EMPTY;
> -	if (!opts->no_commit)
> +	if (!opts->no_commit) {
>  fast_forward_edit:
> -		res = run_git_commit(msg_file, opts, flags);
> +		if (author || command == TODO_REVERT || (flags & AMEND_MSG))
> +			res = do_commit(msg_file, author, opts, flags);
> +		else
> +			res = error(_("unable to parse commit author"));

Would this be a bug here? Or do we expect `get_author()` to possibly fail?

> +	}
>  
>  	if (!res && final_fixup) {
>  		unlink(rebase_path_fixup_msg());
> @@ -1446,6 +1610,8 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
>  
>  leave:
>  	free_message(commit, &msg);
> +	if (author)
> +		free(author);

As above, please write an unconditional `free(author);` here.

All in all, this patch series was a nice an pleasant read. I am impressed
by the performance wins.

Thank you very much,
Dscho
