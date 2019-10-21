Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7FD61F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 13:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbfJUN4q (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 09:56:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51723 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729251AbfJUN4n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 09:56:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id q70so6276182wme.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 06:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DGEq05n6zWIGYB1Q74QUmDNQgYqoICLynjfwMW2q5Js=;
        b=iOXvniG8XIYOHUmYHDRZzwfz6k7WSFwEaPOVDyEgZJ28IMxyZOyXr0B+IPGx8Jd/1o
         K1mVIGbMeEzVCLkytF0PRPhRPf/3hl9Iwn3ZZgaY6igUAMxCXY16xwtyjFGiIrqjYdte
         dN5HNDIZWXel/aXusCRvpIzRIP1IqYSsOftGcxi0jnHEUAQSXU+mIQ0roI2PDVvJzQY8
         L1y91JmnB5pHqW05YgKZMtM+D9axLbtIgV5mAtJHKqrtYALDQUSN40LOZ7skNv7NYlWk
         AZjlJ6ZCZ7kth73o/IpFPt6aXh05cKMFYW6rYyqnHoohLmmzGx8++asLeAFCPjEhJkox
         e6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DGEq05n6zWIGYB1Q74QUmDNQgYqoICLynjfwMW2q5Js=;
        b=F+A5f6Yl4uTY0Mg1pgaLPUnZ8jfDzCdnua5Egz+72xUWmFReg47LCiXOwOHI+LzFxN
         XyBydVMeB4CZYz66yZtbr7bB1CQj8hwJBRELoKb2H9tvAsTh2348Ku6uptgydL+ukSo3
         JV0svMfXMuxGSLQe5znrFMFRrNbnZA3rxv3q7hyuFiu7fHskCylr1/KumjeWyTbHXVb2
         MHKzjlgKPgfPm0fsmwKlY1O18kR5OVufkJfadxRgzleQv2LAbvw1CKUkL4JLZ1USM8UL
         Xm5HFrkyjjKCRtqlg7jYmKyR+zdoG8PFXSBOnxJO5U4HyJp79ja8XroKe/6/proTEWpm
         OquQ==
X-Gm-Message-State: APjAAAUnldXDS8xbvux1bIv489QTMwkycRg2oYkJqzwQjoq95F6sR3kJ
        TCdo6FFXCU6/7vZ5jdVxW01O2eC4
X-Google-Smtp-Source: APXvYqxR7KIli9Mfu8t299udr50T7sPfp9jreNi9Pvvfq5rNgWcTMfrsJ7ucWjtvWb8MElDZ1BX/gQ==
X-Received: by 2002:a7b:c94f:: with SMTP id i15mr20530263wml.31.1571666200662;
        Mon, 21 Oct 2019 06:56:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w17sm15998581wra.34.2019.10.21.06.56.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 06:56:40 -0700 (PDT)
Message-Id: <d7af75672ba20ed208d51a35243b96ce10202a54.1571666187.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
        <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Oct 2019 13:56:24 +0000
Subject: [PATCH v5 15/17] sparse-checkout: update working directory in-process
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, jon@jonsimons.org, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
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
addition, provide an in-memory list of patterns so we can avoid
reading from the sparse-checkout file. This allows us to test a
proposed change to the file before writing to it.

An earlier version of this patch included a bug when the 'set' command
failed due to the "Sparse checkout leaves no entry on working directory"
error. It would not rollback the index.lock file, so the replay of the
old sparse-checkout specification would fail. A test in t1091 now
covers that scenario.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/read-tree.c                |  2 +-
 builtin/sparse-checkout.c          | 83 +++++++++++++++++++++++++-----
 t/t1091-sparse-checkout-builtin.sh | 28 ++++++++++
 unpack-trees.c                     |  5 +-
 unpack-trees.h                     |  3 +-
 5 files changed, 105 insertions(+), 16 deletions(-)

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
index b02e085495..ea2e7ee51b 100644
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
 	N_("git sparse-checkout (init|list|set|disable) <options>"),
@@ -60,18 +65,54 @@ static int sparse_checkout_list(int argc, const char **argv)
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
-	}
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
+	} else
+		rollback_lock_file(&lock_file);
 
-	argv_array_clear(&argv);
 	return result;
 }
 
@@ -147,7 +188,11 @@ static int sparse_checkout_init(int argc, const char **argv)
 			     builtin_sparse_checkout_init_options,
 			     builtin_sparse_checkout_init_usage, 0);
 
-	mode = init_opts.cone_mode ? MODE_CONE_PATTERNS : MODE_ALL_PATTERNS;
+	if (init_opts.cone_mode) {
+		mode = MODE_CONE_PATTERNS;
+		core_sparse_checkout_cone = 1;
+	} else
+		mode = MODE_ALL_PATTERNS;
 
 	if (sc_set_config(mode))
 		return 1;
@@ -175,7 +220,8 @@ static int sparse_checkout_init(int argc, const char **argv)
 	}
 
 reset_dir:
-	return update_working_directory();
+	core_apply_sparse_checkout = 1;
+	return update_working_directory(NULL);
 }
 
 static void insert_recursive_pattern(struct pattern_list *pl, struct strbuf *path)
@@ -260,6 +306,15 @@ static int write_patterns_and_update(struct pattern_list *pl)
 {
 	char *sparse_filename;
 	FILE *fp;
+	int result;
+
+	result = update_working_directory(pl);
+
+	if (result) {
+		clear_pattern_list(pl);
+		update_working_directory(NULL);
+		return result;
+	}
 
 	sparse_filename = get_sparse_checkout_filename();
 	fp = fopen(sparse_filename, "w");
@@ -270,9 +325,11 @@ static int write_patterns_and_update(struct pattern_list *pl)
 		write_patterns_to_file(fp, pl);
 
 	fclose(fp);
+
 	free(sparse_filename);
+	clear_pattern_list(pl);
 
-	return update_working_directory();
+	return 0;
 }
 
 static void strbuf_to_cone_pattern(struct strbuf *line, struct pattern_list *pl)
@@ -324,6 +381,7 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 		struct strbuf line = STRBUF_INIT;
 		hashmap_init(&pl.recursive_hashmap, pl_hashmap_cmp, NULL, 0);
 		hashmap_init(&pl.parent_hashmap, pl_hashmap_cmp, NULL, 0);
+		pl.use_cone_patterns = 1;
 
 		if (set_opts.use_stdin) {
 			while (!strbuf_getline(&line, stdin))
@@ -378,7 +436,8 @@ static int sparse_checkout_disable(int argc, const char **argv)
 	fprintf(fp, "/*\n");
 	fclose(fp);
 
-	if (update_working_directory())
+	core_apply_sparse_checkout = 1;
+	if (update_working_directory(NULL))
 		die(_("error while refreshing working directory"));
 
 	unlink(sparse_filename);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 0792caeb7e..a580b79595 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -248,4 +248,32 @@ test_expect_success 'cone mode: set with nested folders' '
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
+test_expect_success 'revert to old sparse-checkout on empty update' '
+	git init empty-test &&
+	(
+		echo >file &&
+		git add file &&
+		git commit -m "test" &&
+		test_must_fail git sparse-checkout set nothing 2>err &&
+		test_i18ngrep "Sparse checkout leaves no entry on working directory" err &&
+		test_i18ngrep ! ".git/index.lock" err &&
+		git sparse-checkout set file
+	)
+'
+
 test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 8bb684ad62..3789a22cf0 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1511,7 +1511,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	memset(&pl, 0, sizeof(pl));
 	if (!core_apply_sparse_checkout || !o->update)
 		o->skip_sparse_checkout = 1;
-	if (!o->skip_sparse_checkout) {
+	if (!o->skip_sparse_checkout && !o->pl) {
 		char *sparse = git_pathdup("info/sparse-checkout");
 		pl.use_cone_patterns = core_sparse_checkout_cone;
 		if (add_patterns_from_file_to_list(sparse, "", 0, &pl, NULL) < 0)
@@ -1684,7 +1684,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
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

