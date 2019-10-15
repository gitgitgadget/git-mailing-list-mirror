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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FCFA1F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 13:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732325AbfJON42 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 09:56:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41650 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732092AbfJON4W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 09:56:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id p4so8118592wrm.8
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 06:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FXKFL27stFSP1Y/SGhgw3WCAU19n9PSD9j637T8MQvs=;
        b=pA48wR8NdJumYoOxZ+0OkVEKcCfGatKeLbFsLxDiXrotczdLVhTBCg7ZT8ayRipElg
         5lJNAd+US/C+ueXgK9nZ5UZo3LP8QQnW6kFYjelmcRLIq9V/VmOwJ1FdtwMB3N54ztmb
         hKVllephm6s6unGBxC1I/OVCUkQKewVUIPcOHAorWtigmnbrLkqY79CwNv6JVuHkqAhH
         nqJ3aeeXBQx0Y5wrF4PumarMAvErhzxDBiQ2yBUbOrSduXupXvh5hxqmkXUsFG0TSjJF
         sW/iUROErZlwxCyfhdv3oBWLnnRJysTIJL+oYl2tkN0+MFZbPff0FdsoQ/MOW8oGvvTC
         ZRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FXKFL27stFSP1Y/SGhgw3WCAU19n9PSD9j637T8MQvs=;
        b=UU6SnCjcOiMF9SJ9HJ1yH/NpQCyi5ewCnYnxWFIWm59w7TiItsHCXsSg30DkHqCYji
         AJzCCT8rXHw/zKlhCSm1PiAn0+0ZpDCMJ3EHXvRsJJ6kBpCDQJyHDd3fSKonuzOioGgx
         XwyrgLViQGM+ByRYy5MufPbhRZ++0KSb5W6syZgYh4BUwcIQxFs2eLoXPJB/CgH5/Og4
         Uyy9idGTKQ6neXzm6SjzJmWpJCZapCSoKItEa3YzHjU6Q3hUHQJt+TxqlYDps+hjKZCQ
         OOHGy2o5CCSLrT8iVV0Sh1AzOuemsymXbA/eUIUyBheDPzwGHnQbPhPGg+mwu5iMWjWI
         a0Uw==
X-Gm-Message-State: APjAAAVFL/hTNbp6NKWRAZynEHmwruuKT4/EfKyAwcAeL+/bW2WeikBh
        7RQKv7Y6fOQ/vyoyiErs8BRErDUg
X-Google-Smtp-Source: APXvYqzLsY5Tu9+UjQ6MmBpPnLDwwYIUDugaQeEseCB8naeM72DgsVAoLSDmg5WCyN7OOYksyckQXQ==
X-Received: by 2002:a5d:4108:: with SMTP id l8mr29658833wrp.391.1571147780308;
        Tue, 15 Oct 2019 06:56:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c6sm23538675wrm.71.2019.10.15.06.56.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 06:56:19 -0700 (PDT)
Message-Id: <9ccec3ca9a1efe038da6d69f076f32cc407bcf9f.1571147765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
References: <pull.316.v3.git.gitgitgadget@gmail.com>
        <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 13:56:02 +0000
Subject: [PATCH v4 15/17] sparse-checkout: update working directory in-process
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <dstolee@microsoft.com>,
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

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/read-tree.c                |  2 +-
 builtin/sparse-checkout.c          | 80 ++++++++++++++++++++++++++----
 t/t1091-sparse-checkout-builtin.sh | 15 ++++++
 unpack-trees.c                     |  5 +-
 unpack-trees.h                     |  3 +-
 5 files changed, 90 insertions(+), 15 deletions(-)

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
index 40b6c599dc..595955d4fc 100644
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
 
-	mode = init_opts.cone_mode ? MODE_CONE_PATTERNS : MODE_ALL_PATTERNS;
+	if (init_opts.cone_mode) {
+		mode = MODE_CONE_PATTERNS;
+		core_sparse_checkout_cone = 1;
+	} else
+		mode = MODE_ALL_PATTERNS;
 
 	if (sc_set_config(mode))
 		return 1;
@@ -175,7 +219,8 @@ static int sparse_checkout_init(int argc, const char **argv)
 	}
 
 reset_dir:
-	return update_working_directory();
+	core_apply_sparse_checkout = 1;
+	return update_working_directory(NULL);
 }
 
 static void insert_recursive_pattern(struct pattern_list *pl, struct strbuf *path)
@@ -260,12 +305,21 @@ static int write_patterns_and_update(struct pattern_list *pl)
 {
 	char *sparse_filename;
 	FILE *fp;
+	int result;
 
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
 
@@ -275,9 +329,11 @@ static int write_patterns_and_update(struct pattern_list *pl)
 		write_patterns_to_file(fp, pl);
 
 	fclose(fp);
+
 	free(sparse_filename);
+	clear_pattern_list(pl);
 
-	return update_working_directory();
+	return 0;
 }
 
 static void strbuf_to_cone_pattern(struct strbuf *line, struct pattern_list *pl)
@@ -328,6 +384,7 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 		struct strbuf line = STRBUF_INIT;
 		hashmap_init(&pl.recursive_hashmap, pl_hashmap_cmp, NULL, 0);
 		hashmap_init(&pl.parent_hashmap, pl_hashmap_cmp, NULL, 0);
+		pl.use_cone_patterns = 1;
 
 		if (set_opts.use_stdin) {
 			while (!strbuf_getline(&line, stdin))
@@ -373,7 +430,8 @@ static int sparse_checkout_disable(int argc, const char **argv)
 	fprintf(fp, "/*\n");
 	fclose(fp);
 
-	if (update_working_directory())
+	core_apply_sparse_checkout = 1;
+	if (update_working_directory(NULL))
 		die(_("error while refreshing working directory"));
 
 	unlink(sparse_filename);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index e752f3ba0f..ecb5a63671 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -247,4 +247,19 @@ test_expect_success 'cone mode: set with nested folders' '
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

