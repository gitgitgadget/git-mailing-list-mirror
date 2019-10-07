Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB6061F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 20:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbfJGUIs (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 16:08:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34137 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729263AbfJGUIq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 16:08:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id j11so10984639wrp.1
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 13:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9j6nWw2fAQPggNXYEgI5d27Exl4DiK+suihtZts4KYY=;
        b=lKehib71FH6wtBX5TVn4b1iJWcRGnOz91K/yvWSaa5d/FhEKk2JjHAqFQo7HHU60a0
         o+YJISrEXHha8GHhWmfvqlqwPQ01j8dxC+YLkh3JABBH76mDuRl0VQngyB/HHw7Oq5Hi
         7lvxssbpSn/x/fBDcnlwHeJJ2eXwfVtwz2P7o6/C0G+0oTz1UmpHBIB1DqWN8J42Fwak
         le03yYwRYUPEBjV8ViDEtmSH+xwYk9sOPFHEefC7EE6AcBZD/BNmX89u/8kafeL5w9Vo
         jwozN1I5X4MTvvEfgCmtHdpGvJ9HWBBp0l3J75yE2sVF6K/USZ+TQptXuMn7maxS8dYE
         Y/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9j6nWw2fAQPggNXYEgI5d27Exl4DiK+suihtZts4KYY=;
        b=Pic8Q9H1HlgOSbP2DTUo2QBibhCBIzEK6lS/cbOXrSYgNwQdPW+o9d0Uqfq348vWoU
         m9keqHJa5o15xLBs916z4IoJOaQrdR/AZP8ODXvVi0dBXmrJBVma6zTgUN1T949C8dfj
         JwB31EH7vCdhAqGdPk08prEq429U8hB7yH1byhkkVSEkSegY6+PP1M0Ji627TUozwFFL
         7lwdlCm/7PTyv3vVJVeSH2a5ZejHu4Fc9nfdgqb9pSVl8hmKjwF8OxY7HIj8/mz3aG0t
         jM9GPjx8wGkumBjLTuvTe9BC8CRVwNXPlbwvZfHp8ELzBAW2qeF5+TsSy9CK8tcJTnuq
         Olgw==
X-Gm-Message-State: APjAAAVQgMewGqWlAy+ViEi86hytDnzvPiH035RFsKboUXMRJJGw4KbD
        F4etruh0jQ6w01R/ZDOOZUery8ob
X-Google-Smtp-Source: APXvYqzQHMlTAGoDG/EHYtJJfLpFau4NghuAOfikzVheME58ItgPoFMvZ855xRBcF/uNAcvz8LjRiQ==
X-Received: by 2002:a5d:52c2:: with SMTP id r2mr24688847wrv.367.1570478922393;
        Mon, 07 Oct 2019 13:08:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u1sm399928wmc.38.2019.10.07.13.08.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 13:08:41 -0700 (PDT)
Date:   Mon, 07 Oct 2019 13:08:41 -0700 (PDT)
X-Google-Original-Date: Mon, 07 Oct 2019 20:08:23 GMT
Message-Id: <a6f17e9a77d86f8ec856ea08617d1c1af2853d54.1570478905.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v3.git.gitgitgadget@gmail.com>
References: <pull.316.v2.git.gitgitgadget@gmail.com>
        <pull.316.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 15/17] sparse-checkout: update working directory in-process
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The sparse-checkout builtin used 'git read-tree -mu HEAD' to update the
skip-worktree bits in the index and to update the working directory.
This extra process is overly complex, and prone to failure. It also
requires that we write our changes to the sparse-checkout file before
trying to update the index.

Remove this extra process call by creating a direct call to
unpack_trees() in the same way 'git read-tree -mu HEAD' does. In
adition, provide an in-memory list of patterns so we can avoid
reading from the sparse-checkout file. This allows us to test a
proposed change to the file before writing to it.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/read-tree.c                |  2 +-
 builtin/sparse-checkout.c          | 85 +++++++++++++++++++++++++-----
 t/t1091-sparse-checkout-builtin.sh | 17 ++++++
 unpack-trees.c                     |  5 +-
 unpack-trees.h                     |  3 +-
 5 files changed, 95 insertions(+), 17 deletions(-)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 69963d83dc..d7eeaa26ec 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -186,7 +186,7 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 
 	if (opts.reset || opts.merge || opts.prefix) {
 		if (read_cache_unmerged() && (opts.prefix || opts.merge))
-			die("You need to resolve your current index first");
+			die(_("You need to resolve your current index first"));
 		stage = opts.merge = 1;
 	}
 	resolve_undo_clear();
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 25786f8bb0..542d57fac6 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -7,6 +7,11 @@
 #include "run-command.h"
 #include "strbuf.h"
 #include "string-list.h"
+#include "cache.h"
+#include "cache-tree.h"
+#include "lockfile.h"
+#include "resolve-undo.h"
+#include "unpack-trees.h"
 
 static char const * const builtin_sparse_checkout_usage[] = {
 	N_("git sparse-checkout [init|list|set|disable] <options>"),
@@ -60,18 +65,53 @@ static int sparse_checkout_list(int argc, const char **argv)
 	return 0;
 }
 
-static int update_working_directory(void)
+static int update_working_directory(struct pattern_list *pl)
 {
-	struct argv_array argv = ARGV_ARRAY_INIT;
 	int result = 0;
-	argv_array_pushl(&argv, "read-tree", "-m", "-u", "HEAD", NULL);
+	struct unpack_trees_options o;
+	struct lock_file lock_file = LOCK_INIT;
+	struct object_id oid;
+	struct tree *tree;
+	struct tree_desc t;
+	struct repository *r = the_repository;
 
-	if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
-		error(_("failed to update index with new sparse-checkout paths"));
-		result = 1;
+	if (repo_read_index_unmerged(r))
+		die(_("You need to resolve your current index first"));
+
+	if (get_oid("HEAD", &oid))
+		return 0;
+
+	tree = parse_tree_indirect(&oid);
+	parse_tree(tree);
+	init_tree_desc(&t, tree->buffer, tree->size);
+
+	memset(&o, 0, sizeof(o));
+	o.verbose_update = isatty(2);
+	o.merge = 1;
+	o.update = 1;
+	o.fn = oneway_merge;
+	o.head_idx = -1;
+	o.src_index = r->index;
+	o.dst_index = r->index;
+	o.skip_sparse_checkout = 0;
+	o.pl = pl;
+	o.keep_pattern_list = !!pl;
+
+	resolve_undo_clear_index(r->index);
+	setup_work_tree();
+
+	cache_tree_free(&r->index->cache_tree);
+
+	repo_hold_locked_index(r, &lock_file, LOCK_DIE_ON_ERROR);
+
+	core_apply_sparse_checkout = 1;
+	result = unpack_trees(1, &t, &o);
+
+	if (!result) {
+		prime_cache_tree(r, r->index, tree);
+		write_locked_index(r->index, &lock_file, COMMIT_LOCK);
 	}
 
-	argv_array_clear(&argv);
 	return result;
 }
 
@@ -147,7 +187,11 @@ static int sparse_checkout_init(int argc, const char **argv)
 			     builtin_sparse_checkout_init_options,
 			     builtin_sparse_checkout_init_usage, 0);
 
-	mode = init_opts.cone_mode ? MODE_CONE : MODE_FULL;
+	if (init_opts.cone_mode) {
+		mode = MODE_CONE;
+		core_sparse_checkout_cone = 1;
+	} else
+		mode = MODE_FULL;
 
 	if (sc_set_config(mode))
 		return 1;
@@ -175,12 +219,14 @@ static int sparse_checkout_init(int argc, const char **argv)
 	}
 
 reset_dir:
-	return update_working_directory();
+	core_apply_sparse_checkout = 1;
+	return update_working_directory(NULL);
 }
 
 static void insert_recursive_pattern(struct pattern_list *pl, struct strbuf *path)
 {
-	struct pattern_entry *e = xmalloc(sizeof(struct pattern_entry));
+	struct pattern_entry *e = xmalloc(sizeof(*e));
+
 	e->patternlen = path->len;
 	e->pattern = strbuf_detach(path, NULL);
 	hashmap_entry_init(e, memhash(e->pattern, e->patternlen));
@@ -262,12 +308,21 @@ static int write_patterns_and_update(struct pattern_list *pl)
 {
 	char *sparse_filename;
 	FILE *fp;
-
+	int result;
+	
 	if (!core_apply_sparse_checkout) {
 		warning(_("core.sparseCheckout is disabled, so changes to the sparse-checkout file will have no effect"));
 		warning(_("run 'git sparse-checkout init' to enable the sparse-checkout feature"));
 	}
 
+	result = update_working_directory(pl);
+
+	if (result) {
+		clear_pattern_list(pl);
+		update_working_directory(NULL);
+		return result;
+	}
+
 	sparse_filename = get_sparse_checkout_filename();
 	fp = fopen(sparse_filename, "w");
 
@@ -277,9 +332,11 @@ static int write_patterns_and_update(struct pattern_list *pl)
 		write_patterns_to_file(fp, pl);
 
 	fclose(fp);
+
 	free(sparse_filename);
+	clear_pattern_list(pl);
 
-	return update_working_directory();
+	return 0;
 }
 
 static void strbuf_to_cone_pattern(struct strbuf *line, struct pattern_list *pl)
@@ -330,6 +387,7 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 		struct strbuf line = STRBUF_INIT;
 		hashmap_init(&pl.recursive_hashmap, pl_hashmap_cmp, NULL, 0);
 		hashmap_init(&pl.parent_hashmap, pl_hashmap_cmp, NULL, 0);
+		pl.use_cone_patterns = 1;
 
 		if (set_opts.use_stdin) {
 			while (!strbuf_getline(&line, stdin))
@@ -375,7 +433,8 @@ static int sparse_checkout_disable(int argc, const char **argv)
 	fprintf(fp, "/*\n");
 	fclose(fp);
 
-	if (update_working_directory())
+	core_apply_sparse_checkout = 1;
+	if (update_working_directory(NULL))
 		die(_("error while refreshing working directory"));
 
 	unlink(sparse_filename);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index ee4d361787..82eb5fb2f8 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -199,11 +199,13 @@ test_expect_success 'cone mode: init and set' '
 		a
 		deep
 	EOF
+	test_cmp dir expect &&
 	ls repo/deep >dir  &&
 	cat >expect <<-EOF &&
 		a
 		deeper1
 	EOF
+	test_cmp dir expect &&
 	ls repo/deep/deeper1 >dir  &&
 	cat >expect <<-EOF &&
 		a
@@ -245,4 +247,19 @@ test_expect_success 'cone mode: set with nested folders' '
 	test_cmp repo/.git/info/sparse-checkout expect
 '
 
+test_expect_success 'revert to old sparse-checkout on bad update' '
+	echo update >repo/deep/deeper2/a &&
+	cp repo/.git/info/sparse-checkout expect &&
+	test_must_fail git -C repo sparse-checkout set deep/deeper1 2>err &&
+	test_i18ngrep "Cannot update sparse checkout" err &&
+	test_cmp repo/.git/info/sparse-checkout expect &&
+	ls repo/deep >dir &&
+	cat >expect <<-EOF &&
+		a
+		deeper1
+		deeper2
+	EOF
+	test_cmp dir expect
+'
+
 test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index edf0fb4673..f0fee5adf2 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1508,7 +1508,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	memset(&pl, 0, sizeof(pl));
 	if (!core_apply_sparse_checkout || !o->update)
 		o->skip_sparse_checkout = 1;
-	if (!o->skip_sparse_checkout) {
+	if (!o->skip_sparse_checkout && !o->pl) {
 		char *sparse = git_pathdup("info/sparse-checkout");
 		pl.use_cone_patterns = core_sparse_checkout_cone;
 		if (add_patterns_from_file_to_list(sparse, "", 0, &pl, NULL) < 0)
@@ -1681,7 +1681,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 done:
 	trace_performance_leave("unpack_trees");
-	clear_pattern_list(&pl);
+	if (!o->keep_pattern_list)
+		clear_pattern_list(&pl);
 	return ret;
 
 return_failed:
diff --git a/unpack-trees.h b/unpack-trees.h
index f2eee0c7c5..ca94a421a5 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -59,7 +59,8 @@ struct unpack_trees_options {
 		     quiet,
 		     exiting_early,
 		     show_all_errors,
-		     dry_run;
+		     dry_run,
+		     keep_pattern_list;
 	const char *prefix;
 	int cache_bottom;
 	struct dir_struct *dir;
-- 
gitgitgadget

