Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 667A31F461
	for <e@80x24.org>; Mon, 19 Aug 2019 09:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfHSJS0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 05:18:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54697 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbfHSJSZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 05:18:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id p74so922608wme.4
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 02:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Pn1zisJa/itZ1qu9pFRiQQuQbcll28ID8PPpAD/dL+U=;
        b=HNi4lDVf6l4qrpbkuSZBblH+39+eq4tH6IpYMMxoTjgYOv7ttZyWaNcvhR0P1ShaTa
         yItyXKXHyI2/+jK0YgT8Q1iRVFPG0+q7fo1Pd9Fxsynh1GAV95MP8YvSBaXLTEjQ25nZ
         cWkaUVzl6XaMaLqGmiZMNYKZhlJXfFpOR7mKTyeEnGcoDZ2Lbrk11U19vgcFFQ4NdR1h
         SdD6NqyszkNUwxx7EpTUmuaW9C23L6sn/YIT+W5McORG5Fco2gIlMpkXW3mGlx767uXu
         UrIhgOb8JAkMNVcAGKk/5zWF60KQk+kswPPwqDaKxZteASj6sme4Iz/V3sxS06c+EjTL
         M/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Pn1zisJa/itZ1qu9pFRiQQuQbcll28ID8PPpAD/dL+U=;
        b=IbiVS0QTCSBbTbRslLCmqDNL4ozQTKGa7tuAemXkdceex6ri3bJz4C6f6eexYiQ2vX
         8kaA/B3UjiXZo8MEAG30fJCo+fC5hYNHVI5bwdyJS6YAWXnpVCAIZYsTS3gY2k0Em6so
         OVdL3tqrJClAPWFZnjgfW9F+DjMqsVOvKhqvrMZHGBKUnGcZcu6fGpLg86R4vefL498P
         kYmJXx0TQ474xy0ygZu2KCp3h3Xc34RPKCDsr3HVbQFrrPT2zst1K5N7nDNTEjvYIzrR
         TDdp8bGuBwiqR1+22+Gtsx3z3vZ+OIZ+db+OipF9z5OpJL8DEbv0hfXTDDTMB19pGnbk
         4LGw==
X-Gm-Message-State: APjAAAUIrBGA8MzWZ7osLQFwU8o0Q1qYPzeVudL4iMlhHfMRkSIgZ1pC
        1vDPPG3ze42uO9eWv6gtjfHnadQw
X-Google-Smtp-Source: APXvYqzUN0bcUHx1QJPTJa9w+0/o5gy1v7xkdjIy8yNVe63gX53+EHE/YVnAWdAphOC4saE+0BzFOQ==
X-Received: by 2002:a1c:ca11:: with SMTP id a17mr15479650wmg.45.1566206303386;
        Mon, 19 Aug 2019 02:18:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p13sm16490976wrw.90.2019.08.19.02.18.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 02:18:22 -0700 (PDT)
Date:   Mon, 19 Aug 2019 02:18:22 -0700 (PDT)
X-Google-Original-Date: Mon, 19 Aug 2019 09:18:19 GMT
Message-Id: <7839a84778d085665da70910d9a5897f3353ff45.1566206300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.312.git.gitgitgadget@gmail.com>
References: <pull.312.git.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/3] rebase -i: check for updated todo after squash and reword
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

While a rebase is stopped for the user to edit a commit message it can
be convenient for them to also edit the todo list. The scripted version
of rebase supported this but the C version does not. We already check to
see if the todo list has been updated by an exec command so extend this
to rewords and squashes. It only costs a single stat call to do this so
it should not affect the speed of the rebase (especially as it has just
stopped for the user to edit a message)

Note that for squashes the editor may be opened on a different pick to
the squash itself as we edit the message at the end of a chain fixups
and squashes.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c                 | 42 ++++++++++++++++++++++++-------------
 t/t3429-rebase-edit-todo.sh | 21 ++++++++++++++++++-
 2 files changed, 47 insertions(+), 16 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 085777f4a1..a13e1a7466 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1773,7 +1773,7 @@ static int do_pick_commit(struct repository *r,
 			  enum todo_command command,
 			  struct commit *commit,
 			  struct replay_opts *opts,
-			  int final_fixup)
+			  int final_fixup, int *check_todo)
 {
 	unsigned int flags = opts->edit ? EDIT_MSG : 0;
 	const char *msg_file = opts->edit ? NULL : git_path_merge_msg(r);
@@ -1999,11 +1999,14 @@ static int do_pick_commit(struct repository *r,
 			res = do_commit(r, msg_file, author, opts, flags);
 		else
 			res = error(_("unable to parse commit author"));
-		if (!res && reword)
+		*check_todo = !!(flags & EDIT_MSG);
+		if (!res && reword) {
 fast_forward_edit:
 			res = run_git_commit(r, NULL, opts, EDIT_MSG |
 					     VERIFY_MSG | AMEND_MSG |
 					     (flags & ALLOW_EMPTY));
+			*check_todo = 1;
+		}
 	}
 
 
@@ -3821,6 +3824,7 @@ static int pick_commits(struct repository *r,
 	while (todo_list->current < todo_list->nr) {
 		struct todo_item *item = todo_list->items + todo_list->current;
 		const char *arg = todo_item_get_arg(todo_list, item);
+		int check_todo = 0;
 
 		if (save_todo(todo_list, opts))
 			return -1;
@@ -3859,7 +3863,8 @@ static int pick_commits(struct repository *r,
 					command_to_string(item->command), NULL),
 					1);
 			res = do_pick_commit(r, item->command, item->commit,
-					opts, is_final_fixup(todo_list));
+					     opts, is_final_fixup(todo_list),
+					     &check_todo);
 			if (is_rebase_i(opts) && res < 0) {
 				/* Reschedule */
 				advise(_(rescheduled_advice),
@@ -3916,7 +3921,6 @@ static int pick_commits(struct repository *r,
 		} else if (item->command == TODO_EXEC) {
 			char *end_of_arg = (char *)(arg + item->arg_len);
 			int saved = *end_of_arg;
-			struct stat st;
 
 			if (!opts->verbose)
 				term_clear_line();
@@ -3927,17 +3931,8 @@ static int pick_commits(struct repository *r,
 			if (res) {
 				if (opts->reschedule_failed_exec)
 					reschedule = 1;
-			} else if (stat(get_todo_path(opts), &st))
-				res = error_errno(_("could not stat '%s'"),
-						  get_todo_path(opts));
-			else if (match_stat_data(&todo_list->stat, &st)) {
-				/* Reread the todo file if it has changed. */
-				todo_list_release(todo_list);
-				if (read_populate_todo(r, todo_list, opts))
-					res = -1; /* message was printed */
-				/* `current` will be incremented below */
-				todo_list->current = -1;
 			}
+			check_todo = 1;
 		} else if (item->command == TODO_LABEL) {
 			if ((res = do_label(r, arg, item->arg_len)))
 				reschedule = 1;
@@ -3973,6 +3968,20 @@ static int pick_commits(struct repository *r,
 							item->commit,
 							arg, item->arg_len,
 							opts, res, 0);
+		} else if (check_todo && !res) {
+			struct stat st;
+
+			if (stat(get_todo_path(opts), &st)) {
+				res = error_errno(_("could not stat '%s'"),
+						  get_todo_path(opts));
+			} else if (match_stat_data(&todo_list->stat, &st)) {
+				/* Reread the todo file if it has changed. */
+				todo_list_release(todo_list);
+				if (read_populate_todo(r, todo_list, opts))
+					res = -1; /* message was printed */
+				/* `current` will be incremented below */
+				todo_list->current = -1;
+			}
 		}
 
 		todo_list->current++;
@@ -4299,9 +4308,12 @@ static int single_pick(struct repository *r,
 		       struct commit *cmit,
 		       struct replay_opts *opts)
 {
+	int check_todo;
+
 	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
 	return do_pick_commit(r, opts->action == REPLAY_PICK ?
-		TODO_PICK : TODO_REVERT, cmit, opts, 0);
+			      TODO_PICK : TODO_REVERT, cmit, opts, 0,
+			      &check_todo);
 }
 
 int sequencer_pick_revisions(struct repository *r,
diff --git a/t/t3429-rebase-edit-todo.sh b/t/t3429-rebase-edit-todo.sh
index 76f6d306ea..8739cb60a7 100755
--- a/t/t3429-rebase-edit-todo.sh
+++ b/t/t3429-rebase-edit-todo.sh
@@ -3,9 +3,15 @@
 test_description='rebase should reread the todo file if an exec modifies it'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+test_expect_success 'setup' '
+	test_commit first file &&
+	test_commit second file &&
+	test_commit third file
+'
 
 test_expect_success 'rebase exec modifies rebase-todo' '
-	test_commit initial &&
 	todo=.git/rebase-merge/git-rebase-todo &&
 	git rebase HEAD -x "echo exec touch F >>$todo" &&
 	test -e F
@@ -33,4 +39,17 @@ test_expect_success SHA1 'loose object cache vs re-reading todo list' '
 	git rebase HEAD -x "./append-todo.sh 5 6"
 '
 
+test_expect_success 'todo is re-read after reword and squash' '
+	write_script reword-editor.sh <<-\EOS &&
+	GIT_SEQUENCE_EDITOR="echo \"exec echo $(cat file) >>actual\" >>" \
+		git rebase --edit-todo
+	EOS
+
+	test_write_lines first third >expected &&
+	set_fake_editor &&
+	GIT_SEQUENCE_EDITOR="$EDITOR" FAKE_LINES="reword 1 squash 2 fixup 3" \
+		GIT_EDITOR=./reword-editor.sh git rebase -i --root third &&
+	test_cmp expected actual
+'
+
 test_done
-- 
gitgitgadget

