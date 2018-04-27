Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00A921F424
	for <e@80x24.org>; Fri, 27 Apr 2018 20:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759264AbeD0Us2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 16:48:28 -0400
Received: from mout.gmx.net ([212.227.17.20]:56171 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758703AbeD0Us0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 16:48:26 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LdYSM-1eTW540W4g-00igZ4; Fri, 27 Apr 2018 22:48:16 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 0/4] rebase -i: avoid stale "# This is a combination of" in commit messages
Date:   Fri, 27 Apr 2018 22:48:13 +0200
Message-Id: <cover.1524862093.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com>
References: <CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:u5/9z+ni08TMfPtDuY7rN8PxVcSZwvGbRdXesI1zT9vJScdfBbI
 wWCZ7FI1kwqrNt9Y0P0q4JSdeZAVmO1t/Z8Fg9fufp6b8mEcIZdUEyLV6SmSuOOwfE7RjRy
 jeHr4T/Po/YjhlWJjRQOSp9PJJcnuAeo5QZ6DyZf29eZcSPeRuNO80peqLfydWQZsGRMmNL
 1gXA+2XEYjabBJafPON5Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aHgG6dMfLJ8=:Dtre4w2qnmYvxP+K8i7Mmj
 rS+4iK/Klswb4DabtSCfoA8uGi3SzT2NR8K82ABz0B2fQJtgjgd8TFIZEZgKEfqe0ZedsQ1qE
 kaJj0ZCFEKBADaxeCwonyLCd9dw0+zx1Ok4sRX4oTXWox7wt+nhExwZajci4XXR1/F4/ctUY0
 ih+VB8XIJGcRwjxBUGTuYUxsJL4Rw7oK16Prhd4szV7FmOIbu/Rrrb7JJGC7VFZxqwI/hym+z
 BiQlvQYVwl2pP5TghCki+lyln+9xgVgE+PI2h841x6ztudUiuMBT360PsvaUcIyO0hzfshUbz
 Gk0Utd6zM/RXNen5GaREl/eHD6IhS3uMvzfJxHGuPpSS75OdzZoX2otgnbCtmjZlQp1CNZo2v
 XUma/56v8zBCCXHfMMTdUBdyrzvR66qWjPorh5AlVvX3113+R/7O3myuNq4FFnHiHnqt4Aqet
 TQO/+sxBymwcGG68MLUXmiDosyL4vzOM02964XzC3gy/Zi7BDSVg6pEsiDzpdCCs8u1SlkRE0
 LErjNeCw9GK9nivt7XG/XeglYpgJ2eIZB2JQ4FI6UoEvNArV8HaEMHoWu9bKB59w03aFzVo0X
 j4TeeRmejMyKIZoopdimwS+CwlPHiMm2HNoIGSutObl6EC5RY06Jwv3SBeFGNIK+s1n4Tfh16
 UiB3Kiou3Jqw7SVYgowtKAZ1JSatGqrY+EdlCR0MTNpVPFUGExbYBqeSqv0suPM+QlH0VMlSt
 c4hzruuGXPwfNtCJdobb7PEud9GdSmVYzj09VclNk9W6SGzyD3a6YLlZ8EDAGbvnPFenkCqvM
 i7A6wUN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine pointed out that I had such a commit message in
https://public-inbox.org/git/CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com/
and I went on a hunt to figure out how the heck this happened.

Turns out that if there is a fixup/squash chain where the *last* command
fails with merge conflicts, and we either --skip ahead or resolve the
conflict to a clean tree and then --continue, our code does not do a
final cleanup.

Contrary to my initial gut feeling, this bug was not introduced by my
rewrite in C of the core parts of rebase -i, but it looks to me as if
that bug was with us for a very long time (at least the --skip part).

The developer (read: user of rebase -i) in me says that we would want to
fast-track this, but the author of rebase -i in me says that we should
be cautious and cook this in `next` for a while.

Fixes since v3 (thanks, Phillip, for the really fruitful discussion!):

- We now avoid using the commit message prepared for the skipped
  fixup/squash.

- Replaced the "rebase -i: Handle "combination of <n> commits" with
  GETTEXT_POISON" patch by a *real* fix instead of a work-around: Instead
  of parsing the first line of the commit message and punting when it is
  missing an ASCII-encoded number, we determine <n> separately
  (independent from any localized text).

- Fixed quite a couple more corner cases, using the `current-fixups`
  file introduced for the GETTEXT_POISON fix:

  * we only need to re-commit if this was the final fixup/squash in the
    fixup/squash chain,

  * we only need to commit interactively if there was *any* non-skipped
    squash,

  * if the fixup/squash chain continues, the <N> was incorrect in the
    "This is a combination of <N> commits" comment in the intermediate
    commit message (it included the now-skipped commits), and

  * even if a filed fixup/squash in the middle of a fixup/squash chain
    failed, and its merge conflicts were resolved and committed, the
    "This is a combination of <N> commits" comment was incorrect: we
    had already deleted message-fixup and message-squash, so the next
    update_squash_message() would mistakenly assume that we were
    starting afresh. Worse: if only fixup commands were remaining, but
    there had been a squash command, we would retain the "squash!" line
    in the commit message and not give the user a chance to clean things
    up in the final fixup!


Johannes Schindelin (4):
  rebase -i: demonstrate bugs with fixup!/squash! commit messages
  rebase -i: Handle "combination of <n> commits" with GETTEXT_POISON
  sequencer: always commit without editing when asked for
  rebase --skip: clean up commit message after a failed fixup/squash

 sequencer.c                | 193 ++++++++++++++++++++++++++++---------
 sequencer.h                |   6 +-
 t/t3418-rebase-continue.sh |  49 ++++++++++
 3 files changed, 200 insertions(+), 48 deletions(-)


base-commit: 1f1cddd558b54bb0ce19c8ace353fd07b758510d
Published-As: https://github.com/dscho/git/releases/tag/clean-msg-after-fixup-continue-v4
Fetch-It-Via: git fetch https://github.com/dscho/git clean-msg-after-fixup-continue-v4

Interdiff vs v3:
 diff --git a/sequencer.c b/sequencer.c
 index e1efb0ebf31..cec180714ef 100644
 --- a/sequencer.c
 +++ b/sequencer.c
 @@ -74,13 +74,6 @@ static GIT_PATH_FUNC(rebase_path_message, "rebase-merge/message")
   * previous commit and from the first squash/fixup commit are written
   * to it. The commit message for each subsequent squash/fixup commit
   * is appended to the file as it is processed.
 - *
 - * The first line of the file is of the form
 - *     # This is a combination of $count commits.
 - * where $count is the number of commits whose messages have been
 - * written to the file so far (including the initial "pick" commit).
 - * Each time that a commit message is processed, this line is read and
 - * updated. It is deleted just before the combined commit is made.
   */
  static GIT_PATH_FUNC(rebase_path_squash_msg, "rebase-merge/message-squash")
  /*
 @@ -91,6 +84,11 @@ static GIT_PATH_FUNC(rebase_path_squash_msg, "rebase-merge/message-squash")
   * commit without opening the editor.)
   */
  static GIT_PATH_FUNC(rebase_path_fixup_msg, "rebase-merge/message-fixup")
 +/*
 + * This file contains the list fixup/squash commands that have been
 + * accumulated into message-fixup or message-squash so far.
 + */
 +static GIT_PATH_FUNC(rebase_path_current_fixups, "rebase-merge/current-fixups")
  /*
   * A script to set the GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and
   * GIT_AUTHOR_DATE that will be used for the commit that is currently
 @@ -106,13 +104,6 @@ static GIT_PATH_FUNC(rebase_path_author_script, "rebase-merge/author-script")
   * command is processed, this file is deleted.
   */
  static GIT_PATH_FUNC(rebase_path_amend, "rebase-merge/amend")
 -/*
 - * If there was a merge conflict in a fixup/squash series, we need to
 - * record the type so that a `git rebase --skip` can clean up the commit
 - * message as appropriate. This file will contain that type (`fixup` or
 - * `squash`), and not exist otherwise.
 - */
 -static GIT_PATH_FUNC(rebase_path_amend_type, "rebase-merge/amend-type")
  /*
   * When we stop at a given patch via the "edit" command, this file contains
   * the abbreviated commit name of the corresponding patch.
 @@ -260,6 +251,7 @@ int sequencer_remove_state(struct replay_opts *opts)
  	for (i = 0; i < opts->xopts_nr; i++)
  		free(opts->xopts[i]);
  	free(opts->xopts);
 +	strbuf_release(&opts->current_fixups);
  
  	strbuf_addstr(&dir, get_dir(opts));
  	remove_dir_recursively(&dir, 0);
 @@ -725,6 +717,8 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
  		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
  	if (defmsg)
  		argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
 +	else if (!(flags & EDIT_MSG))
 +		argv_array_pushl(&cmd.args, "-C", "HEAD", NULL);
  	if ((flags & CLEANUP_MSG))
  		argv_array_push(&cmd.args, "--cleanup=strip");
  	if ((flags & EDIT_MSG))
 @@ -1336,33 +1330,23 @@ static int update_squash_messages(enum todo_command command,
  		struct commit *commit, struct replay_opts *opts)
  {
  	struct strbuf buf = STRBUF_INIT;
 -	int count, res;
 +	int res;
  	const char *message, *body;
  
 -	if (file_exists(rebase_path_squash_msg())) {
 +	if (opts->current_fixup_count > 0) {
  		struct strbuf header = STRBUF_INIT;
 -		char *eol, *p;
 +		char *eol;
  
 -		if (strbuf_read_file(&buf, rebase_path_squash_msg(), 2048) <= 0)
 +		if (strbuf_read_file(&buf, rebase_path_squash_msg(), 9) <= 0)
  			return error(_("could not read '%s'"),
  				rebase_path_squash_msg());
  
 -		p = buf.buf + 1;
 -		eol = strchrnul(buf.buf, '\n');
 -		if (buf.buf[0] != comment_line_char ||
 -		    (p += strcspn(p, "0123456789\n")) == eol)
 -			count = -1;
 -		else
 -			count = strtol(p, NULL, 10);
 +		eol = buf.buf[0] != comment_line_char ?
 +			buf.buf : strchrnul(buf.buf, '\n');
  
  		strbuf_addf(&header, "%c ", comment_line_char);
 -		if (count < 1)
 -			strbuf_addf(&header, _("This is a combination of "
 -					       "several commits."));
 -		else
 -			strbuf_addf(&header,
 -				    _("This is a combination of %d commits."),
 -				    ++count);
 +		strbuf_addf(&header, _("This is a combination of %d commits."),
 +			    opts->current_fixup_count + 2);
  		strbuf_splice(&buf, 0, eol - buf.buf, header.buf, header.len);
  		strbuf_release(&header);
  	} else {
 @@ -1385,10 +1369,8 @@ static int update_squash_messages(enum todo_command command,
  				     rebase_path_fixup_msg());
  		}
  
 -		count = 2;
  		strbuf_addf(&buf, "%c ", comment_line_char);
 -		strbuf_addf(&buf, _("This is a combination of %d commits."),
 -			    count);
 +		strbuf_addf(&buf, _("This is a combination of %d commits."), 2);
  		strbuf_addf(&buf, "\n%c ", comment_line_char);
  		strbuf_addstr(&buf, _("This is the 1st commit message:"));
  		strbuf_addstr(&buf, "\n\n");
 @@ -1405,22 +1387,14 @@ static int update_squash_messages(enum todo_command command,
  	if (command == TODO_SQUASH) {
  		unlink(rebase_path_fixup_msg());
  		strbuf_addf(&buf, "\n%c ", comment_line_char);
 -		if (count < 2)
 -			strbuf_addf(&buf, _("This is the next commit "
 -					    "message:"));
 -		else
 -			strbuf_addf(&buf, _("This is the commit message #%d:"),
 -				    count);
 +		strbuf_addf(&buf, _("This is the commit message #%d:"),
 +			    ++opts->current_fixup_count);
  		strbuf_addstr(&buf, "\n\n");
  		strbuf_addstr(&buf, body);
  	} else if (command == TODO_FIXUP) {
  		strbuf_addf(&buf, "\n%c ", comment_line_char);
 -		if (count < 2)
 -			strbuf_addf(&buf, _("The next commit message will be "
 -					    "skipped:"));
 -		else
 -			strbuf_addf(&buf, _("The commit message #%d will be "
 -					    "skipped:"), count);
 +		strbuf_addf(&buf, _("The commit message #%d will be skipped:"),
 +			    ++opts->current_fixup_count);
  		strbuf_addstr(&buf, "\n\n");
  		strbuf_add_commented_lines(&buf, body, strlen(body));
  	} else
 @@ -1429,6 +1403,17 @@ static int update_squash_messages(enum todo_command command,
  
  	res = write_message(buf.buf, buf.len, rebase_path_squash_msg(), 0);
  	strbuf_release(&buf);
 +
 +	if (!res) {
 +		strbuf_addf(&opts->current_fixups, "%s%s %s",
 +			    opts->current_fixups.len ? "\n" : "",
 +			    command_to_string(command),
 +			    oid_to_hex(&commit->object.oid));
 +		res = write_message(opts->current_fixups.buf,
 +				    opts->current_fixups.len,
 +				    rebase_path_current_fixups(), 0);
 +	}
 +
  	return res;
  }
  
 @@ -1691,6 +1676,9 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
  	if (!res && final_fixup) {
  		unlink(rebase_path_fixup_msg());
  		unlink(rebase_path_squash_msg());
 +		unlink(rebase_path_current_fixups());
 +		strbuf_reset(&opts->current_fixups);
 +		opts->current_fixup_count = 0;
  	}
  
  leave:
 @@ -2067,6 +2055,16 @@ static int read_populate_opts(struct replay_opts *opts)
  		read_strategy_opts(opts, &buf);
  		strbuf_release(&buf);
  
 +		if (read_oneliner(&opts->current_fixups,
 +				  rebase_path_current_fixups(), 1)) {
 +			const char *p = opts->current_fixups.buf;
 +			opts->current_fixup_count = 1;
 +			while ((p = strchr(p, '\n'))) {
 +				opts->current_fixup_count++;
 +				p++;
 +			}
 +		}
 +
  		return 0;
  	}
  
 @@ -2413,21 +2411,9 @@ static int error_with_patch(struct commit *commit,
  static int error_failed_squash(struct commit *commit,
  	struct replay_opts *opts, int subject_len, const char *subject)
  {
 -	const char *amend_type = "squash";
 -
 -	if (rename(rebase_path_squash_msg(), rebase_path_message()))
 -		return error(_("could not rename '%s' to '%s'"),
 +	if (copy_file(rebase_path_message(), rebase_path_squash_msg(), 0666))
 +		return error(_("could not copy '%s' to '%s'"),
  			rebase_path_squash_msg(), rebase_path_message());
 -
 -	if (file_exists(rebase_path_fixup_msg())) {
 -		unlink(rebase_path_fixup_msg());
 -		amend_type = "fixup";
 -	}
 -	if (write_message(amend_type, strlen(amend_type),
 -		       rebase_path_amend_type(), 0))
 -		return error(_("could not write '%s'"),
 -			     rebase_path_amend_type());
 -
  	unlink(git_path_merge_msg());
  	if (copy_file(git_path_merge_msg(), rebase_path_message(), 0666))
  		return error(_("could not copy '%s' to '%s'"),
 @@ -2604,7 +2590,6 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
  			unlink(rebase_path_author_script());
  			unlink(rebase_path_stopped_sha());
  			unlink(rebase_path_amend());
 -			unlink(rebase_path_amend_type());
  			delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
  		}
  		if (item->command <= TODO_SQUASH) {
 @@ -2794,9 +2779,11 @@ static int continue_single_pick(void)
  	return run_command_v_opt(argv, RUN_GIT_CMD);
  }
  
 -static int commit_staged_changes(struct replay_opts *opts)
 +static int commit_staged_changes(struct replay_opts *opts,
 +				 struct todo_list *todo_list)
  {
 -	unsigned int flags = ALLOW_EMPTY | EDIT_MSG, is_fixup = 0, is_clean;
 +	unsigned int flags = ALLOW_EMPTY | EDIT_MSG;
 +	unsigned int final_fixup = 0, is_clean;
  
  	if (has_unstaged_changes(1))
  		return error(_("cannot rebase: You have unstaged changes."));
 @@ -2819,21 +2806,69 @@ static int commit_staged_changes(struct replay_opts *opts)
  				       "working tree. Please, commit them\n"
  				       "first and then run 'git rebase "
  				       "--continue' again."));
 -		if (is_clean && !oidcmp(&head, &to_amend)) {
 -			strbuf_reset(&rev);
 +		/*
 +		 * When skipping a failed fixup/squash, we need to edit the
 +		 * commit message, the current fixup list and count, and if it
 +		 * was the last fixup/squash in the chain, we need to clean up
 +		 * the commit message and if there was a squash, let the user
 +		 * edit it.
 +		 */
 +		if (is_clean && !oidcmp(&head, &to_amend) &&
 +		    opts->current_fixup_count > 0 &&
 +		    file_exists(rebase_path_stopped_sha())) {
 +			const char *p = opts->current_fixups.buf;
 +			int len = opts->current_fixups.len;
 +
 +			opts->current_fixup_count--;
 +			if (!len)
 +				BUG("Incorrect current_fixups:\n%s", p);
 +			while (len && p[len - 1] != '\n')
 +				len--;
 +			strbuf_setlen(&opts->current_fixups, len);
 +			if (write_message(p, len, rebase_path_current_fixups(),
 +					  0) < 0)
 +				return error(_("could not write file: '%s'"),
 +					     rebase_path_current_fixups());
 +
  			/*
 -			 * Clean tree, but we may need to finalize a
 -			 * fixup/squash chain. A failed fixup/squash leaves the
 -			 * file amend-type in rebase-merge/; It is okay if that
 -			 * file is missing, in which case there is no such
 -			 * chain to finalize.
 +			 * If a fixup/squash in a fixup/squash chain failed, the
 +			 * commit message is already correct, no need to commit
 +			 * it again.
 +			 *
 +			 * Only if it is the final command in the fixup/squash
 +			 * chain, and only if the chain is longer than a single
 +			 * fixup/squash command (which was just skipped), do we
 +			 * actually need to re-commit with a cleaned up commit
 +			 * message.
  			 */
 -			read_oneliner(&rev, rebase_path_amend_type(), 0);
 -			if (!strcmp("squash", rev.buf))
 -				is_fixup = TODO_SQUASH;
 -			else if (!strcmp("fixup", rev.buf)) {
 -				is_fixup = TODO_FIXUP;
 -				flags = (flags & ~EDIT_MSG) | CLEANUP_MSG;
 +			if (opts->current_fixup_count > 0 &&
 +			    !is_fixup(peek_command(todo_list, 0))) {
 +				final_fixup = 1;
 +				/*
 +				 * If there was not a single "squash" in the
 +				 * chain, we only need to clean up the commit
 +				 * message, no need to bother the user with
 +				 * opening the commit message in the editor.
 +				 */
 +				if (!starts_with(p, "squash ") &&
 +				    !strstr(p, "\nsquash "))
 +					flags = (flags & ~EDIT_MSG) | CLEANUP_MSG;
 +			} else if (is_fixup(peek_command(todo_list, 0))) {
 +				/*
 +				 * We need to update the squash message to skip
 +				 * the latest commit message.
 +				 */
 +				struct commit *commit;
 +				const char *path = rebase_path_squash_msg();
 +
 +				if (parse_head(&commit) ||
 +				    !(p = get_commit_buffer(commit, NULL)) ||
 +				    write_message(p, strlen(p), path, 0)) {
 +					unuse_commit_buffer(commit, p);
 +					return error(_("could not write file: "
 +						       "'%s'"), path);
 +				}
 +				unuse_commit_buffer(commit, p);
  			}
  		}
  
 @@ -2841,18 +2876,32 @@ static int commit_staged_changes(struct replay_opts *opts)
  		flags |= AMEND_MSG;
  	}
  
 -	if (is_clean && !is_fixup) {
 +	if (is_clean) {
  		const char *cherry_pick_head = git_path_cherry_pick_head();
  
  		if (file_exists(cherry_pick_head) && unlink(cherry_pick_head))
  			return error(_("could not remove CHERRY_PICK_HEAD"));
 -		return 0;
 +		if (!final_fixup)
 +			return 0;
  	}
  
 -	if (run_git_commit(rebase_path_message(), opts, flags))
 +	if (run_git_commit(final_fixup ? NULL : rebase_path_message(),
 +			   opts, flags))
  		return error(_("could not commit staged changes."));
  	unlink(rebase_path_amend());
 -	unlink(rebase_path_amend_type());
 +	if (final_fixup) {
 +		unlink(rebase_path_fixup_msg());
 +		unlink(rebase_path_squash_msg());
 +	}
 +	if (opts->current_fixup_count > 0) {
 +		/*
 +		 * Whether final fixup or not, we just cleaned up the commit
 +		 * message...
 +		 */
 +		unlink(rebase_path_current_fixups());
 +		strbuf_reset(&opts->current_fixups);
 +		opts->current_fixup_count = 0;
 +	}
  	return 0;
  }
  
 @@ -2864,14 +2913,16 @@ int sequencer_continue(struct replay_opts *opts)
  	if (read_and_refresh_cache(opts))
  		return -1;
  
 +	if (read_populate_opts(opts))
 +		return -1;
  	if (is_rebase_i(opts)) {
 -		if (commit_staged_changes(opts))
 +		if ((res = read_populate_todo(&todo_list, opts)))
 +			goto release_todo_list;
 +		if (commit_staged_changes(opts, &todo_list))
  			return -1;
  	} else if (!file_exists(get_todo_path(opts)))
  		return continue_single_pick();
 -	if (read_populate_opts(opts))
 -		return -1;
 -	if ((res = read_populate_todo(&todo_list, opts)))
 +	else if ((res = read_populate_todo(&todo_list, opts)))
  		goto release_todo_list;
  
  	if (!is_rebase_i(opts)) {
 diff --git a/sequencer.h b/sequencer.h
 index e45b178dfc4..1898158c52d 100644
 --- a/sequencer.h
 +++ b/sequencer.h
 @@ -44,10 +44,14 @@ struct replay_opts {
  	char **xopts;
  	size_t xopts_nr, xopts_alloc;
  
 +	/* Used by fixup/squash */
 +	struct strbuf current_fixups;
 +	int current_fixup_count;
 +
  	/* Only used by REPLAY_NONE */
  	struct rev_info *revs;
  };
 -#define REPLAY_OPTS_INIT { -1 }
 +#define REPLAY_OPTS_INIT { .action = -1, .current_fixups = STRBUF_INIT }
  
  /* Call this to setup defaults before parsing command line options */
  void sequencer_init_config(struct replay_opts *opts);
 diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
 index 693f92409ec..03bf1b8a3b3 100755
 --- a/t/t3418-rebase-continue.sh
 +++ b/t/t3418-rebase-continue.sh
 @@ -95,19 +95,46 @@ test_expect_success '--skip after failed fixup cleans commit message' '
  	test_commit "fixup! wants-fixup" wants-fixup.t 1 wants-fixup-1 &&
  	test_commit "fixup! wants-fixup" wants-fixup.t 2 wants-fixup-2 &&
  	test_commit "fixup! wants-fixup" wants-fixup.t 3 wants-fixup-3 &&
 -	test_must_fail env FAKE_LINES="1 fixup 2 fixup 4" \
 +	test_must_fail env FAKE_LINES="1 fixup 2 squash 4" \
  		git rebase -i HEAD~4 &&
  
  	: now there is a conflict, and comments in the commit message &&
  	git show HEAD >out &&
 -	test_i18ngrep "This is a combination of" out &&
 +	grep "fixup! wants-fixup" out &&
  
  	: skip and continue &&
 -	git rebase --skip &&
 +	echo "cp \"\$1\" .git/copy.txt" | write_script copy-editor.sh &&
 +	(test_set_editor "$PWD/copy-editor.sh" && git rebase --skip) &&
 +
 +	: the user should not have had to edit the commit message &&
 +	test_path_is_missing .git/copy.txt &&
  
  	: now the comments in the commit message should have been cleaned up &&
  	git show HEAD >out &&
 -	test_i18ngrep ! "This is a combination of" out
 +	! grep "fixup! wants-fixup" out &&
 +
 +	: now, let us ensure that "squash" is handled correctly &&
 +	git reset --hard wants-fixup-3 &&
 +	test_must_fail env FAKE_LINES="1 squash 4 squash 2 squash 4" \
 +		git rebase -i HEAD~4 &&
 +
 +	: the first squash failed, but there are two more in the chain &&
 +	(test_set_editor "$PWD/copy-editor.sh" &&
 +	 test_must_fail git rebase --skip) &&
 +
 +	: not the final squash, no need to edit the commit message &&
 +	test_path_is_missing .git/copy.txt &&
 +
 +	: The first squash was skipped, therefore: &&
 +	git show HEAD >out &&
 +	test_i18ngrep "# This is a combination of 2 commits" out &&
 +
 +	(test_set_editor "$PWD/copy-editor.sh" && git rebase --skip) &&
 +	git show HEAD >out &&
 +	test_i18ngrep ! "# This is a combination" out &&
 +
 +	: Final squash failed, but there was still a squash &&
 +	test_i18ngrep "# This is a combination of 2 commits" .git/copy.txt
  '
  
  test_expect_success 'setup rerere database' '
-- 
2.17.0.windows.1.33.gfcbb1fa0445

