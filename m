Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18E6320229
	for <e@80x24.org>; Fri, 21 Oct 2016 12:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932799AbcJUM0e (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 08:26:34 -0400
Received: from mout.gmx.net ([212.227.15.18]:55730 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754368AbcJUM0d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 08:26:33 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LqALY-1cbJZ411lo-00dqDF; Fri, 21 Oct 2016 14:26:26
 +0200
Date:   Fri, 21 Oct 2016 14:26:25 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 26/27] sequencer: start error messages consistently with
 lower case
In-Reply-To: <cover.1477052405.git.johannes.schindelin@gmx.de>
Message-ID: <27c06023494d7719a4c7bc29542cfd299b9afcaf.1477052405.git.johannes.schindelin@gmx.de>
References: <cover.1476450940.git.johannes.schindelin@gmx.de> <cover.1477052405.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:QpX0mu58IQQzude3H2ep7KSAvzN1fjHXMhMo7Lw2qUGSWhEjMSA
 fSardUupF6efp3EdcAWZmJczpEfRmUu7Nucc1WklQBU6FaYmOuVFLhMRkyy/Iw8lM4D4jId
 BdgASvYgkQMjPunO9RoQbihXBBJjWjyt9hWxgVCjBjRWB1ueH03cyo9VdPYpwvbVOd6AoUF
 KXqFxJpeJxJYTa6k1Qi0w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0SVMsSIGZBM=:bp/q/Vko2Mk9waXk9TPuzr
 uT7P5kYkUB+4TRUZA1dZDwjg14TQrSYdDNVTBbwCZjIQkhqHIhLzcVeSYJDPPdxezHTNGP8Fs
 iG/NyR1Sf5ZUYZ/LrgpAiTzZBPA1wwAEES2GiEyL2A0cCuJuxCNRUAxoZhG+egEx36oRisLj0
 hN2l6ziZdCKdy+ef8ayYZiWVTfm6QuAFnSoaaGDfjl4gB7Xhn07Nhjlc7GEDu3mbgiZVdpoHO
 mndHZQvSiozBSWqudR4Y7dCOciuB3zkFS0QtAmhPHZUi9EBR/m6l2+PsD2LK/sbyaDecnHC05
 NWqVn9E9tTQaklzFPUEah9hUHuoFyynEplA6U8p+RC3qch63tfj8X9fpQq+yHXqbKKm9uWM1f
 vSyEyKs90JVq8rachRWwEy0ZQiTGu1R+xv6/oteQO0jqfmXxShdmYl8aP/HGc1V5JNpnXZUoJ
 ljxegtct5DBpMAgp+2QUenZsmAJxxJBS9zvYKBTMGM55NdO1JgPQ40nwyjw/YwN5bA9MIH0OU
 righdw/6yBQ+4RtRfZU32q5Vlf+ilAbIrwpZkcOO1G72EPozRmdJnhCEonvIbQhdE0F6nBUZS
 NaFxQuw44l0omuPuwweQcJ1Obonl3t7TPPFqiF96IXZSaO6nYsgqxqgHT535tgQSXf+cgdNbO
 bqE9QTpQqkG5fwKXVvtqSonOqHu7RUcJ1OaiFBlSOApR3ZSOHocsrKM7Op+OdaduRRxrrtjwg
 cnENHJ4UUj/sy35ikY+tft3v4G5/Rgfy996v3PjixRoQvEucuAwXnFUp6e9cE9LkXrY34EYDR
 jTGS5Y8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Quite a few error messages touched by this developer during the work to
speed up rebase -i started with an upper case letter, violating our
current conventions. Instead of sneaking in this fix (and forgetting
quite a few error messages), let's just have one wholesale patch fixing
all of the error messages in the sequencer.

While at it, the funny "error: Error wrapping up..." was changed to a
less funny, but more helpful, "error: failed to finalize...".

Pointed out by Junio Hamano.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c                   | 68 +++++++++++++++++++++----------------------
 t/t3501-revert-cherry-pick.sh |  2 +-
 2 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 340d0ed..4c10c93 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -241,18 +241,18 @@ static int write_message(const void *buf, size_t len, const char *filename,
 
 	int msg_fd = hold_lock_file_for_update(&msg_file, filename, 0);
 	if (msg_fd < 0)
-		return error_errno(_("Could not lock '%s'"), filename);
+		return error_errno(_("could not lock '%s'"), filename);
 	if (write_in_full(msg_fd, buf, len) < 0) {
 		rollback_lock_file(&msg_file);
-		return error_errno(_("Could not write to '%s'"), filename);
+		return error_errno(_("could not write to '%s'"), filename);
 	}
 	if (append_eol && write(msg_fd, "\n", 1) < 0) {
 		rollback_lock_file(&msg_file);
-		return error_errno(_("Could not write eol to '%s"), filename);
+		return error_errno(_("could not write eol to '%s"), filename);
 	}
 	if (commit_lock_file(&msg_file) < 0) {
 		rollback_lock_file(&msg_file);
-		return error(_("Error wrapping up '%s'."), filename);
+		return error(_("failed to finalize '%s'."), filename);
 	}
 
 	return 0;
@@ -302,11 +302,11 @@ static int error_dirty_index(struct replay_opts *opts)
 	if (read_cache_unmerged())
 		return error_resolve_conflict(_(action_name(opts)));
 
-	error(_("Your local changes would be overwritten by %s."),
+	error(_("your local changes would be overwritten by %s."),
 		_(action_name(opts)));
 
 	if (advice_commit_before_merge)
-		advise(_("Commit your changes or stash them to proceed."));
+		advise(_("commit your changes or stash them to proceed."));
 	return -1;
 }
 
@@ -415,7 +415,7 @@ static int is_index_unchanged(void)
 	struct commit *head_commit;
 
 	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, head_sha1, NULL))
-		return error(_("Could not resolve HEAD commit\n"));
+		return error(_("could not resolve HEAD commit\n"));
 
 	head_commit = lookup_commit(head_sha1);
 
@@ -435,7 +435,7 @@ static int is_index_unchanged(void)
 
 	if (!cache_tree_fully_valid(active_cache_tree))
 		if (cache_tree_update(&the_index, 0))
-			return error(_("Unable to update cache tree\n"));
+			return error(_("unable to update cache tree\n"));
 
 	return !hashcmp(active_cache_tree->sha1, head_commit->tree->object.oid.hash);
 }
@@ -505,7 +505,7 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 		if (!env) {
 			const char *gpg_opt = gpg_sign_opt_quoted(opts);
 
-			return error("You have staged changes in your working "
+			return error("you have staged changes in your working "
 				"tree. If these changes are meant to be\n"
 				"squashed into the previous commit, run:\n\n"
 				"  git commit --amend %s\n\n"
@@ -558,12 +558,12 @@ static int is_original_commit_empty(struct commit *commit)
 	const unsigned char *ptree_sha1;
 
 	if (parse_commit(commit))
-		return error(_("Could not parse commit %s\n"),
+		return error(_("could not parse commit %s\n"),
 			     oid_to_hex(&commit->object.oid));
 	if (commit->parents) {
 		struct commit *parent = commit->parents->item;
 		if (parse_commit(parent))
-			return error(_("Could not parse parent commit %s\n"),
+			return error(_("could not parse parent commit %s\n"),
 				oid_to_hex(&parent->object.oid));
 		ptree_sha1 = parent->tree->object.oid.hash;
 	} else {
@@ -647,7 +647,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		 * to work on.
 		 */
 		if (write_cache_as_tree(head, 0, NULL))
-			return error(_("Your index file is unmerged."));
+			return error(_("your index file is unmerged."));
 	} else {
 		unborn = get_sha1("HEAD", head);
 		if (unborn)
@@ -666,7 +666,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		struct commit_list *p;
 
 		if (!opts->mainline)
-			return error(_("Commit %s is a merge but no -m option was given."),
+			return error(_("commit %s is a merge but no -m option was given."),
 				oid_to_hex(&commit->object.oid));
 
 		for (cnt = 1, p = commit->parents;
@@ -674,11 +674,11 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		     cnt++)
 			p = p->next;
 		if (cnt != opts->mainline || !p)
-			return error(_("Commit %s does not have parent %d"),
+			return error(_("commit %s does not have parent %d"),
 				oid_to_hex(&commit->object.oid), opts->mainline);
 		parent = p->item;
 	} else if (0 < opts->mainline)
-		return error(_("Mainline was specified but commit %s is not a merge."),
+		return error(_("mainline was specified but commit %s is not a merge."),
 			oid_to_hex(&commit->object.oid));
 	else
 		parent = commit->parents->item;
@@ -696,7 +696,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 			oid_to_hex(&parent->object.oid));
 
 	if (get_message(commit, &msg) != 0)
-		return error(_("Cannot get commit message for %s"),
+		return error(_("cannot get commit message for %s"),
 			oid_to_hex(&commit->object.oid));
 
 	/*
@@ -935,13 +935,13 @@ static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
 		item = append_new_todo(todo_list);
 		item->offset_in_buf = p - todo_list->buf.buf;
 		if (parse_insn_line(item, p, eol)) {
-			res = error(_("Invalid line %d: %.*s"),
+			res = error(_("invalid line %d: %.*s"),
 				i, (int)(eol - p), p);
 			item->command = -1;
 		}
 	}
 	if (!todo_list->nr)
-		return error(_("No commits parsed."));
+		return error(_("no commits parsed."));
 	return res;
 }
 
@@ -954,16 +954,16 @@ static int read_populate_todo(struct todo_list *todo_list,
 	strbuf_reset(&todo_list->buf);
 	fd = open(todo_file, O_RDONLY);
 	if (fd < 0)
-		return error_errno(_("Could not open '%s'"), todo_file);
+		return error_errno(_("could not open '%s'"), todo_file);
 	if (strbuf_read(&todo_list->buf, fd, 0) < 0) {
 		close(fd);
-		return error(_("Could not read '%s'."), todo_file);
+		return error(_("could not read '%s'."), todo_file);
 	}
 	close(fd);
 
 	res = parse_insn_buffer(todo_list->buf.buf, todo_list);
 	if (res)
-		return error(_("Unusable instruction sheet: '%s'"), todo_file);
+		return error(_("unusable instruction sheet: '%s'"), todo_file);
 
 	if (!is_rebase_i(opts)) {
 		enum todo_command valid =
@@ -974,9 +974,9 @@ static int read_populate_todo(struct todo_list *todo_list,
 			if (valid == todo_list->items[i].command)
 				continue;
 			else if (valid == TODO_PICK)
-				return error(_("Cannot cherry-pick during a revert."));
+				return error(_("cannot cherry-pick during a revert."));
 			else
-				return error(_("Cannot revert during a cherry-pick."));
+				return error(_("cannot revert during a cherry-pick."));
 	}
 
 	return 0;
@@ -1019,10 +1019,10 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 		ALLOC_GROW(opts->xopts, opts->xopts_nr + 1, opts->xopts_alloc);
 		opts->xopts[opts->xopts_nr++] = xstrdup(value);
 	} else
-		return error(_("Invalid key: %s"), key);
+		return error(_("invalid key: %s"), key);
 
 	if (!error_flag)
-		return error(_("Invalid value for %s: %s"), key, value);
+		return error(_("invalid value for %s: %s"), key, value);
 
 	return 0;
 }
@@ -1054,7 +1054,7 @@ static int read_populate_opts(struct replay_opts *opts)
 	 * are pretty certain that it is syntactically correct.
 	 */
 	if (git_config_from_file(populate_opts_cb, git_path_opts_file(), opts) < 0)
-		return error(_("Malformed options sheet: '%s'"),
+		return error(_("malformed options sheet: '%s'"),
 			git_path_opts_file());
 	return 0;
 }
@@ -1097,7 +1097,7 @@ static int create_seq_dir(void)
 		return -1;
 	}
 	else if (mkdir(git_path_seq_dir(), 0777) < 0)
-		return error_errno(_("Could not create sequencer directory '%s'"),
+		return error_errno(_("could not create sequencer directory '%s'"),
 				   git_path_seq_dir());
 	return 0;
 }
@@ -1111,17 +1111,17 @@ static int save_head(const char *head)
 	fd = hold_lock_file_for_update(&head_lock, git_path_head_file(), 0);
 	if (fd < 0) {
 		rollback_lock_file(&head_lock);
-		return error_errno(_("Could not lock HEAD"));
+		return error_errno(_("could not lock HEAD"));
 	}
 	strbuf_addf(&buf, "%s\n", head);
 	if (write_in_full(fd, buf.buf, buf.len) < 0) {
 		rollback_lock_file(&head_lock);
-		return error_errno(_("Could not write to '%s'"),
+		return error_errno(_("could not write to '%s'"),
 				   git_path_head_file());
 	}
 	if (commit_lock_file(&head_lock) < 0) {
 		rollback_lock_file(&head_lock);
-		return error(_("Error wrapping up '%s'."), git_path_head_file());
+		return error(_("failed to finalize '%s'."), git_path_head_file());
 	}
 	return 0;
 }
@@ -1200,14 +1200,14 @@ static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
 
 	fd = hold_lock_file_for_update(&todo_lock, todo_path, 0);
 	if (fd < 0)
-		return error_errno(_("Could not lock '%s'"), todo_path);
+		return error_errno(_("could not lock '%s'"), todo_path);
 	offset = next < todo_list->nr ?
 		todo_list->items[next].offset_in_buf : todo_list->buf.len;
 	if (write_in_full(fd, todo_list->buf.buf + offset,
 			todo_list->buf.len - offset) < 0)
-		return error_errno(_("Could not write to '%s'"), todo_path);
+		return error_errno(_("could not write to '%s'"), todo_path);
 	if (commit_lock_file(&todo_lock) < 0)
-		return error(_("Error wrapping up '%s'."), todo_path);
+		return error(_("failed to finalize '%s'."), todo_path);
 	return 0;
 }
 
@@ -1382,7 +1382,7 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 			create_seq_dir() < 0)
 		return -1;
 	if (get_sha1("HEAD", sha1) && (opts->action == REPLAY_REVERT))
-		return error(_("Can't revert as initial commit"));
+		return error(_("can't revert as initial commit"));
 	if (save_head(sha1_to_hex(sha1)))
 		return -1;
 	if (save_opts(opts))
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 51f3bbb..394f000 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -96,7 +96,7 @@ test_expect_success 'revert forbidden on dirty working tree' '
 	echo content >extra_file &&
 	git add extra_file &&
 	test_must_fail git revert HEAD 2>errors &&
-	test_i18ngrep "Your local changes would be overwritten by " errors
+	test_i18ngrep "your local changes would be overwritten by " errors
 
 '
 
-- 
2.10.1.583.g721a9e0


