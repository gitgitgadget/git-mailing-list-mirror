Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38FAB1F42D
	for <e@80x24.org>; Tue, 10 Apr 2018 12:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752996AbeDJM3y (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 08:29:54 -0400
Received: from mout.gmx.net ([212.227.15.19]:45149 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752962AbeDJM3v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 08:29:51 -0400
Received: from MININT-AIVCFQ2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LvV1X-1eObJC0oCp-010c95; Tue, 10 Apr 2018 14:29:45 +0200
Date:   Tue, 10 Apr 2018 14:29:41 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v6 04/15] sequencer: introduce new commands to reset the
 revision
In-Reply-To: <cover.1523362469.git.johannes.schindelin@gmx.de>
Message-ID: <fb797f32b7385317b9dc18524e3863ba627f6c98.1523362469.git.johannes.schindelin@gmx.de>
References: <cover.1519680483.git.johannes.schindelin@gmx.de> <cover.1523362469.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zT/YcWGNtQ0JqILkI4mjsJPiVJgP0CYMVa7YJydD/xFZK+ob7+4
 Um6tvFVqPTC/+pPopecxvVLaIvoELz1c1gmtHVW2K3wW1WC0Msmman8enb18ozAQUK37vI0
 fKwbRGJvH9M3mizATaB9zAQWdRmN1bRBHRsPjN1z1R5gm4vPW6/tMXGNrdaxwig5Q9Rl7l2
 Jp9Ziq3Y/0zJAmWdnGcaw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CMPEus0/4t0=:c6874pywk5sAv0swcrJ/eM
 /Sgylbf8TxIsV2P34soRr0aeEMpXtjrX/261fAng0rq6tFatLQTvjhtgUJFIHK0z1YKNHccq4
 2no0ynUZSYF1JC8uJyZv4oaNrgDA1dRysX9xtfXQWbifAnLVj6iCGwQwGvxNZF8gUer6m8LpB
 Ot9vzDXRz4FDBDU6ScyMb8+RdLvoIslE2PsyccaXbja9AS1Own1+R8Xg1B/nGb2zxQ3s3J8Wi
 J4+O9yoW8lAGOWwAmjVGlxGoCvFzwsKyZTQzMYr/KQ5c9aAZYKTOQiBL6l2xB3GMQ5dsHDpeT
 aXWKu/AEShGj2R59UqsYwaVpYc3m6z187vC89VL4P7t1UjVji6ImKpUqYZ7BRZFpkuQrHYdzs
 Eg87gj7qJJvnQCb7F+a+EMUSGz75GMOsEKPCL8OoCovwLIuq9XXqaAokMKfIxvzz5veARiJaL
 /B6jRuf3bZPUWU7ngZOUPgZ6PKInVQUhc+WA+gU4l5gykoPIea45+kxke91dPTtQ+Omk1ThSg
 NfsSWT2dAteu26PZOI93y33YOZFUyKcXfASwA5lPaWHHQjqAyiSehnRP+2uejX8BbA0vPCEmp
 UkBrPBV8Rdkz86ACX4m1OsjFQ7V3GfOCQ4OrzglfbxVGduFaYsRVPNNosV0cojfgLOhxUCaLr
 bD3iUu/ouBt6PUvRHFJFzYSklPHYQmOB3GHPNVMq2NddS99H4pQ1qbgjgZ5Ie6pCXUcG00Qzl
 dCbs8wTTqdJN73SkcdSbELcFMpbW28HNOz3wPqvQuXK88QCrlcL2XkJISRYadDjuHgZVrr9vk
 Kq6idlA9jzBUtZAFuF69Yi5WHoOC+Rg0xayFKjhCur5ZAHqAhI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the upcoming commits, we will teach the sequencer to rebase merges.
This will be done in a very different way from the unfortunate design of
`git rebase --preserve-merges` (which does not allow for reordering
commits, or changing the branch topology).

The main idea is to introduce new todo list commands, to support
labeling the current revision with a given name, resetting the current
revision to a previous state, and  merging labeled revisions.

This idea was developed in Git for Windows' Git garden shears (that are
used to maintain Git for Windows' "thicket of branches" on top of
upstream Git), and this patch is part of the effort to make it available
to a wider audience, as well as to make the entire process more robust
(by implementing it in a safe and portable language rather than a Unix
shell script).

This commit implements the commands to label, and to reset to, given
revisions. The syntax is:

	label <name>
	reset <name>

Internally, the `label <name>` command creates the ref
`refs/rewritten/<name>`. This makes it possible to work with the labeled
revisions interactively, or in a scripted fashion (e.g. via the todo
list command `exec`).

These temporary refs are removed upon sequencer_remove_state(), so that
even a `git rebase --abort` cleans them up.

We disallow '#' as label because that character will be used as separator
in the upcoming `merge` command.

Later in this patch series, we will mark the `refs/rewritten/` refs as
worktree-local, to allow for interactive rebases to be run in parallel in
worktrees linked to the same repository.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh |   2 +
 sequencer.c                | 198 +++++++++++++++++++++++++++++++++++--
 2 files changed, 194 insertions(+), 6 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index e1b865f43f2..e8d3a7d7588 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -162,6 +162,8 @@ s, squash <commit> = use commit, but meld into previous commit
 f, fixup <commit> = like \"squash\", but discard this commit's log message
 x, exec <commit> = run command (the rest of the line) using shell
 d, drop <commit> = remove commit
+l, label <label> = label current HEAD with a name
+t, reset <label> = reset HEAD to a label
 
 These lines can be re-ordered; they are executed from top to bottom.
 " | git stripspace --comment-lines >>"$todo"
diff --git a/sequencer.c b/sequencer.c
index 1ee70d843c1..c63d47f5e09 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -23,6 +23,8 @@
 #include "hashmap.h"
 #include "notes-utils.h"
 #include "sigchain.h"
+#include "unpack-trees.h"
+#include "worktree.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -120,6 +122,13 @@ static GIT_PATH_FUNC(rebase_path_stopped_sha, "rebase-merge/stopped-sha")
 static GIT_PATH_FUNC(rebase_path_rewritten_list, "rebase-merge/rewritten-list")
 static GIT_PATH_FUNC(rebase_path_rewritten_pending,
 	"rebase-merge/rewritten-pending")
+
+/*
+ * The path of the file listing refs that need to be deleted after the rebase
+ * finishes. This is used by the `label` command to record the need for cleanup.
+ */
+static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
+
 /*
  * The following files are written by git-rebase just after parsing the
  * command-line (and are only consumed, not modified, by the sequencer).
@@ -244,18 +253,33 @@ static const char *gpg_sign_opt_quoted(struct replay_opts *opts)
 
 int sequencer_remove_state(struct replay_opts *opts)
 {
-	struct strbuf dir = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT;
 	int i;
 
+	if (strbuf_read_file(&buf, rebase_path_refs_to_delete(), 0) > 0) {
+		char *p = buf.buf;
+		while (*p) {
+			char *eol = strchr(p, '\n');
+			if (eol)
+				*eol = '\0';
+			if (delete_ref("(rebase -i) cleanup", p, NULL, 0) < 0)
+				warning(_("could not delete '%s'"), p);
+			if (!eol)
+				break;
+			p = eol + 1;
+		}
+	}
+
 	free(opts->gpg_sign);
 	free(opts->strategy);
 	for (i = 0; i < opts->xopts_nr; i++)
 		free(opts->xopts[i]);
 	free(opts->xopts);
 
-	strbuf_addstr(&dir, get_dir(opts));
-	remove_dir_recursively(&dir, 0);
-	strbuf_release(&dir);
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, get_dir(opts));
+	remove_dir_recursively(&buf, 0);
+	strbuf_release(&buf);
 
 	return 0;
 }
@@ -1279,6 +1303,8 @@ enum todo_command {
 	TODO_SQUASH,
 	/* commands that do something else than handling a single commit */
 	TODO_EXEC,
+	TODO_LABEL,
+	TODO_RESET,
 	/* commands that do nothing but are counted for reporting progress */
 	TODO_NOOP,
 	TODO_DROP,
@@ -1297,6 +1323,8 @@ static struct {
 	{ 'f', "fixup" },
 	{ 's', "squash" },
 	{ 'x', "exec" },
+	{ 'l', "label" },
+	{ 't', "reset" },
 	{ 0,   "noop" },
 	{ 'd', "drop" },
 	{ 0,   NULL }
@@ -1802,7 +1830,8 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 		return error(_("missing arguments for %s"),
 			     command_to_string(item->command));
 
-	if (item->command == TODO_EXEC) {
+	if (item->command == TODO_EXEC || item->command == TODO_LABEL ||
+	    item->command == TODO_RESET) {
 		item->commit = NULL;
 		item->arg = bol;
 		item->arg_len = (int)(eol - bol);
@@ -2450,6 +2479,159 @@ static int do_exec(const char *command_line)
 	return status;
 }
 
+static int safe_append(const char *filename, const char *fmt, ...)
+{
+	va_list ap;
+	struct lock_file lock = LOCK_INIT;
+	int fd = hold_lock_file_for_update(&lock, filename,
+					   LOCK_REPORT_ON_ERROR);
+	struct strbuf buf = STRBUF_INIT;
+
+	if (fd < 0)
+		return -1;
+
+	if (strbuf_read_file(&buf, filename, 0) < 0 && errno != ENOENT) {
+		error_errno(_("could not read '%s'"), filename);
+		rollback_lock_file(&lock);
+		return -1;
+	}
+	strbuf_complete(&buf, '\n');
+	va_start(ap, fmt);
+	strbuf_vaddf(&buf, fmt, ap);
+	va_end(ap);
+
+	if (write_in_full(fd, buf.buf, buf.len) < 0) {
+		error_errno(_("could not write to '%s'"), filename);
+		strbuf_release(&buf);
+		rollback_lock_file(&lock);
+		return -1;
+	}
+	if (commit_lock_file(&lock) < 0) {
+		strbuf_release(&buf);
+		rollback_lock_file(&lock);
+		return error(_("failed to finalize '%s'"), filename);
+	}
+
+	strbuf_release(&buf);
+	return 0;
+}
+
+static int do_label(const char *name, int len)
+{
+	struct ref_store *refs = get_main_ref_store();
+	struct ref_transaction *transaction;
+	struct strbuf ref_name = STRBUF_INIT, err = STRBUF_INIT;
+	struct strbuf msg = STRBUF_INIT;
+	int ret = 0;
+	struct object_id head_oid;
+
+	if (len == 1 && *name == '#')
+		return error("Illegal label name: '%.*s'", len, name);
+
+	strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
+	strbuf_addf(&msg, "rebase -i (label) '%.*s'", len, name);
+
+	transaction = ref_store_transaction_begin(refs, &err);
+	if (!transaction) {
+		error("%s", err.buf);
+		ret = -1;
+	} else if (get_oid("HEAD", &head_oid)) {
+		error(_("could not read HEAD"));
+		ret = -1;
+	} else if (ref_transaction_update(transaction, ref_name.buf, &head_oid,
+					  NULL, 0, msg.buf, &err) < 0 ||
+		   ref_transaction_commit(transaction, &err)) {
+		error("%s", err.buf);
+		ret = -1;
+	}
+	ref_transaction_free(transaction);
+	strbuf_release(&err);
+	strbuf_release(&msg);
+
+	if (!ret)
+		ret = safe_append(rebase_path_refs_to_delete(),
+				  "%s\n", ref_name.buf);
+	strbuf_release(&ref_name);
+
+	return ret;
+}
+
+static const char *reflog_message(struct replay_opts *opts,
+	const char *sub_action, const char *fmt, ...);
+
+static int do_reset(const char *name, int len, struct replay_opts *opts)
+{
+	struct strbuf ref_name = STRBUF_INIT;
+	struct object_id oid;
+	struct lock_file lock = LOCK_INIT;
+	struct tree_desc desc;
+	struct tree *tree;
+	struct unpack_trees_options unpack_tree_opts;
+	int ret = 0, i;
+
+	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
+		return -1;
+
+	/* Determine the length of the label */
+	for (i = 0; i < len; i++)
+		if (isspace(name[i]))
+			len = i;
+
+	strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
+	if (get_oid(ref_name.buf, &oid) &&
+	    get_oid(ref_name.buf + strlen("refs/rewritten/"), &oid)) {
+		error(_("could not read '%s'"), ref_name.buf);
+		rollback_lock_file(&lock);
+		strbuf_release(&ref_name);
+		return -1;
+	}
+
+	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
+	unpack_tree_opts.head_idx = 1;
+	unpack_tree_opts.src_index = &the_index;
+	unpack_tree_opts.dst_index = &the_index;
+	unpack_tree_opts.fn = oneway_merge;
+	unpack_tree_opts.merge = 1;
+	unpack_tree_opts.update = 1;
+	unpack_tree_opts.reset = 1;
+
+	if (read_cache_unmerged()) {
+		rollback_lock_file(&lock);
+		strbuf_release(&ref_name);
+		return error_resolve_conflict(_(action_name(opts)));
+	}
+
+	if (!fill_tree_descriptor(&desc, &oid)) {
+		error(_("failed to find tree of %s"), oid_to_hex(&oid));
+		rollback_lock_file(&lock);
+		free((void *)desc.buffer);
+		strbuf_release(&ref_name);
+		return -1;
+	}
+
+	if (unpack_trees(1, &desc, &unpack_tree_opts)) {
+		rollback_lock_file(&lock);
+		free((void *)desc.buffer);
+		strbuf_release(&ref_name);
+		return -1;
+	}
+
+	tree = parse_tree_indirect(&oid);
+	prime_cache_tree(&the_index, tree);
+
+	if (write_locked_index(&the_index, &lock, COMMIT_LOCK) < 0)
+		ret = error(_("could not write index"));
+	free((void *)desc.buffer);
+
+	if (!ret)
+		ret = update_ref(reflog_message(opts, "reset", "'%.*s'",
+						len, name), "HEAD", &oid,
+				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
+
+	strbuf_release(&ref_name);
+	return ret;
+}
+
 static int is_final_fixup(struct todo_list *todo_list)
 {
 	int i = todo_list->current;
@@ -2634,7 +2816,11 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 				/* `current` will be incremented below */
 				todo_list->current = -1;
 			}
-		} else if (!is_noop(item->command))
+		} else if (item->command == TODO_LABEL)
+			res = do_label(item->arg, item->arg_len);
+		else if (item->command == TODO_RESET)
+			res = do_reset(item->arg, item->arg_len, opts);
+		else if (!is_noop(item->command))
 			return error(_("unknown command %d"), item->command);
 
 		todo_list->current++;
-- 
2.17.0.windows.1.4.g7e4058d72e3


