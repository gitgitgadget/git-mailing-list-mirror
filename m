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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AEE91F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 20:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbfJGUIk (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 16:08:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45095 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbfJGUIk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 16:08:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id r5so16709468wrm.12
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 13:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JTGHt71DjZPpsG/NgdbvVHx6G1Lz591FQk7Hz0jQsZ4=;
        b=UBVfKNRfPlo5s3G+XEWkEAbdPc4tFl1x6MC5JWlxJ3//LGVk+a3CZ3R0vadD/2LA6Y
         NnVvyx/O9AUsjhAnAGoma/gFfVpGhFkT3S9q/krvK11162U5GHDO/SlfHzUxpd7tgL9c
         D8krEQ7/LuVihxpzjewdVblxGzQVfvPV3K4PiVX8mrQovFePlCwaWvN2JRHr5Y2JKlAt
         DeYkfXRgrLSQOJG3oBROITtfx7yYwmS9Xm41fXpSo29mSf/9IVtrunILOcJddlz05z1f
         HJ4G/+bTijc4cUTudgMz1m1iu0AW1FRWzxO/el2qT8qnK2xmYp893xTJ8lYbgl0Jzhyz
         tlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JTGHt71DjZPpsG/NgdbvVHx6G1Lz591FQk7Hz0jQsZ4=;
        b=pR3geuJxmB1JXPJ4XIutC3Ba5e5pSnmpV2D6H+RGGveIvnmxsUyUUxW29cGC38437+
         vx9av+idSJLeuyNXdtv6rBK90zBr2Cm5FjNBIvUPGHUQw3HQFWBKvRdU4dN5orngws3D
         tyfQqRYMXoLhl6qnCTDoRh9PRSdmWaeSan2dasyIrSWiybcjaOH1sGRwo081bVCSSgyW
         CELl51a/0ri/T7MDi7m7qmqEQ4WcifU7bBt8EZgHqewFUC6t0SuvoVUjTHHPatnQTmpO
         VdFFNwgJhLQYQsTLphgV2vDAWSGwqDK6cweIVUw0nAmo4bBsUzXodJohH/LEp33MBmWG
         lc0A==
X-Gm-Message-State: APjAAAUqz5AaX9cXMUXycbzDhIhMWqld4LOfTIbWQD1v0XUy+f6Uj5+R
        MBXbxMYKBSBUknTmGIDbt1A8eT0T
X-Google-Smtp-Source: APXvYqyNOHGI89D2SVLf6RWf/4OSEFNaxcq3E/gm8ZjCn7w6wQvauR1pprhs1n6NlRYlJRDLzFO5ZQ==
X-Received: by 2002:adf:fb48:: with SMTP id c8mr18705206wrs.247.1570478917933;
        Mon, 07 Oct 2019 13:08:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t83sm1180852wmt.18.2019.10.07.13.08.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 13:08:37 -0700 (PDT)
Date:   Mon, 07 Oct 2019 13:08:37 -0700 (PDT)
X-Google-Original-Date: Mon, 07 Oct 2019 20:08:18 GMT
Message-Id: <69bd707e96bd5381b64c7f43e3e5672ac8655471.1570478905.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v3.git.gitgitgadget@gmail.com>
References: <pull.316.v2.git.gitgitgadget@gmail.com>
        <pull.316.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 10/17] sparse-checkout: init and set in cone mode
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

To make the cone pattern set easy to use, update the behavior of
'git sparse-checkout [init|set]'.

Add '--cone' flag to 'git sparse-checkout init' to set the config
option 'core.sparseCheckoutCone=true'.

When running 'git sparse-checkout set' in cone mode, a user only
needs to supply a list of recursive folder matches. Git will
automatically add the necessary parent matches for the leading
directories.

When testing 'git sparse-checkout set' in cone mode, check the
error stream to ensure we do not see any errors. Specifically,
we want to avoid the warning that the patterns do not match
the cone-mode patterns.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c          | 161 +++++++++++++++++++++++++++--
 dir.c                              |   4 +-
 dir.h                              |   2 +
 t/t1091-sparse-checkout-builtin.sh |  49 +++++++++
 4 files changed, 204 insertions(+), 12 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index ab02acc125..b220f15741 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -6,6 +6,7 @@
 #include "repository.h"
 #include "run-command.h"
 #include "strbuf.h"
+#include "string-list.h"
 
 static char const * const builtin_sparse_checkout_usage[] = {
 	N_("git sparse-checkout [init|list|set|disable] <options>"),
@@ -77,11 +78,13 @@ static int update_working_directory(void)
 enum sparse_checkout_mode {
 	MODE_NONE = 0,
 	MODE_FULL = 1,
+	MODE_CONE = 2,
 };
 
 static int sc_set_config(enum sparse_checkout_mode mode)
 {
 	struct argv_array argv = ARGV_ARRAY_INIT;
+	struct argv_array cone_argv = ARGV_ARRAY_INIT;
 
 	if (git_config_set_gently("extensions.worktreeConfig", "true")) {
 		error(_("failed to set extensions.worktreeConfig setting"));
@@ -100,9 +103,31 @@ static int sc_set_config(enum sparse_checkout_mode mode)
 		return 1;
 	}
 
+	argv_array_pushl(&cone_argv, "config", "--worktree",
+			 "core.sparseCheckoutCone", NULL);
+
+	if (mode == MODE_CONE)
+		argv_array_push(&cone_argv, "true");
+	else
+		argv_array_push(&cone_argv, "false");
+
+	if (run_command_v_opt(cone_argv.argv, RUN_GIT_CMD)) {
+		error(_("failed to enable core.sparseCheckoutCone"));
+		return 1;
+	}
+
 	return 0;
 }
 
+static char const * const builtin_sparse_checkout_init_usage[] = {
+	N_("git sparse-checkout init [--cone]"),
+	NULL
+};
+
+static struct sparse_checkout_init_opts {
+	int cone_mode;
+} init_opts;
+
 static int sparse_checkout_init(int argc, const char **argv)
 {
 	struct pattern_list pl;
@@ -110,8 +135,21 @@ static int sparse_checkout_init(int argc, const char **argv)
 	FILE *fp;
 	int res;
 	struct object_id oid;
+	int mode;
 
-	if (sc_set_config(MODE_FULL))
+	static struct option builtin_sparse_checkout_init_options[] = {
+		OPT_BOOL(0, "cone", &init_opts.cone_mode,
+			 N_("initialize the sparse-checkout in cone mode")),
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, NULL,
+			     builtin_sparse_checkout_init_options,
+			     builtin_sparse_checkout_init_usage, 0);
+
+	mode = init_opts.cone_mode ? MODE_CONE : MODE_FULL;
+
+	if (sc_set_config(mode))
 		return 1;
 
 	memset(&pl, 0, sizeof(pl));
@@ -140,6 +178,72 @@ static int sparse_checkout_init(int argc, const char **argv)
 	return update_working_directory();
 }
 
+static void insert_recursive_pattern(struct pattern_list *pl, struct strbuf *path)
+{
+	struct pattern_entry *e = xmalloc(sizeof(struct pattern_entry));
+	e->patternlen = path->len;
+	e->pattern = strbuf_detach(path, NULL);
+	hashmap_entry_init(e, memhash(e->pattern, e->patternlen));
+
+	hashmap_add(&pl->recursive_hashmap, e);
+
+	while (e->patternlen) {
+		char *slash = strrchr(e->pattern, '/');
+		char *oldpattern = e->pattern;
+		size_t newlen;
+
+		if (slash == e->pattern)
+			break;
+
+		newlen = slash - e->pattern;
+		e = xmalloc(sizeof(struct pattern_entry));
+		e->patternlen = newlen;
+		e->pattern = xstrndup(oldpattern, newlen);
+		hashmap_entry_init(e, memhash(e->pattern, e->patternlen));
+
+		if (!hashmap_get(&pl->parent_hashmap, e, NULL))
+			hashmap_add(&pl->parent_hashmap, e);
+	}
+}
+
+static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
+{
+	int i;
+	struct pattern_entry *entry;
+	struct hashmap_iter iter;
+	struct string_list sl = STRING_LIST_INIT_DUP;
+
+	hashmap_iter_init(&pl->parent_hashmap, &iter);
+	while ((entry = hashmap_iter_next(&iter)))
+		string_list_insert(&sl, entry->pattern);
+
+	string_list_sort(&sl);
+	string_list_remove_duplicates(&sl, 0);
+
+	fprintf(fp, "/*\n!/*/\n");
+
+	for (i = 0; i < sl.nr; i++) {
+		char *pattern = sl.items[i].string;
+
+		if (strlen(pattern))
+			fprintf(fp, "%s/\n!%s/*/\n", pattern, pattern);
+	}
+
+	string_list_clear(&sl, 0);
+
+	hashmap_iter_init(&pl->recursive_hashmap, &iter);
+	while ((entry = hashmap_iter_next(&iter)))
+		string_list_insert(&sl, entry->pattern);
+
+	string_list_sort(&sl);
+	string_list_remove_duplicates(&sl, 0);
+
+	for (i = 0; i < sl.nr; i++) {
+		char *pattern = sl.items[i].string;
+		fprintf(fp, "%s/\n", pattern);
+	}
+}
+
 static int write_patterns_and_update(struct pattern_list *pl)
 {
 	char *sparse_filename;
@@ -152,13 +256,33 @@ static int write_patterns_and_update(struct pattern_list *pl)
 
 	sparse_filename = get_sparse_checkout_filename();
 	fp = fopen(sparse_filename, "w");
-	write_patterns_to_file(fp, pl);
+
+	if (core_sparse_checkout_cone)
+		write_cone_to_file(fp, pl);
+	else
+		write_patterns_to_file(fp, pl);
+
 	fclose(fp);
 	free(sparse_filename);
 
 	return update_working_directory();
 }
 
+static void strbuf_to_cone_pattern(struct strbuf *line, struct pattern_list *pl)
+{
+	strbuf_trim(line);
+
+	strbuf_trim_trailing_dir_sep(line);
+
+	if (!line->len)
+		return;
+
+	if (line->buf[0] != '/')
+		strbuf_insert(line, 0, "/", 1);
+
+	insert_recursive_pattern(pl, line);
+}
+
 static char const * const builtin_sparse_checkout_set_usage[] = {
 	N_("git sparse-checkout set [--stdin|<patterns>]"),
 	NULL
@@ -188,17 +312,34 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 			     builtin_sparse_checkout_set_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
-	if (set_opts.use_stdin) {
+	if (core_sparse_checkout_cone) {
 		struct strbuf line = STRBUF_INIT;
-
-		while (!strbuf_getline(&line, stdin)) {
-			size_t len;
-			char *buf = strbuf_detach(&line, &len);
-			add_pattern(buf, empty_base, 0, &pl, 0);
+		hashmap_init(&pl.recursive_hashmap, pl_hashmap_cmp, NULL, 0);
+		hashmap_init(&pl.parent_hashmap, pl_hashmap_cmp, NULL, 0);
+
+		if (set_opts.use_stdin) {
+			while (!strbuf_getline(&line, stdin))
+				strbuf_to_cone_pattern(&line, &pl);
+		} else {
+			for (i = 0; i < argc; i++) {
+				strbuf_setlen(&line, 0);
+				strbuf_addstr(&line, argv[i]);
+				strbuf_to_cone_pattern(&line, &pl);
+			}
 		}
 	} else {
-		for (i = 0; i < argc; i++)
-			add_pattern(argv[i], empty_base, 0, &pl, 0);
+		if (set_opts.use_stdin) {
+			struct strbuf line = STRBUF_INIT;
+
+			while (!strbuf_getline(&line, stdin)) {
+				size_t len;
+				char *buf = strbuf_detach(&line, &len);
+				add_pattern(buf, empty_base, 0, &pl, 0);
+			}
+		} else {
+			for (i = 0; i < argc; i++)
+				add_pattern(argv[i], empty_base, 0, &pl, 0);
+		}
 	}
 
 	result = write_patterns_and_update(&pl);
diff --git a/dir.c b/dir.c
index 7ba4bc044e..2b240111aa 100644
--- a/dir.c
+++ b/dir.c
@@ -599,8 +599,8 @@ void parse_path_pattern(const char **pattern,
 	*patternlen = len;
 }
 
-static int pl_hashmap_cmp(const void *unused_cmp_data,
-			  const void *a, const void *b, const void *key)
+int pl_hashmap_cmp(const void *unused_cmp_data,
+		   const void *a, const void *b, const void *key)
 {
 	const struct pattern_entry *ee1 = (const struct pattern_entry *)a;
 	const struct pattern_entry *ee2 = (const struct pattern_entry *)b;
diff --git a/dir.h b/dir.h
index c6c188669a..f7a2f000c3 100644
--- a/dir.h
+++ b/dir.h
@@ -297,6 +297,8 @@ int is_excluded(struct dir_struct *dir,
 		struct index_state *istate,
 		const char *name, int *dtype);
 
+int pl_hashmap_cmp(const void *unused_cmp_data,
+		   const void *a, const void *b, const void *key);
 int hashmap_contains_parent(struct hashmap *map,
 			    const char *path,
 			    struct strbuf *buffer);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index b0d5aeb33a..db6371b079 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -185,4 +185,53 @@ test_expect_success 'sparse-checkout disable' '
 	test_cmp expect dir
 '
 
+test_expect_success 'cone mode: init and set' '
+	git -C repo sparse-checkout init --cone &&
+	git -C repo config --list >config &&
+	test_i18ngrep "core.sparsecheckoutcone=true" config &&
+	ls repo >dir  &&
+	echo a >expect &&
+	test_cmp expect dir &&
+	git -C repo sparse-checkout set deep/deeper1/deepest/ 2>err &&
+	test_line_count = 0 err &&
+	ls repo >dir  &&
+	cat >expect <<-EOF &&
+		a
+		deep
+	EOF
+	ls repo/deep >dir  &&
+	cat >expect <<-EOF &&
+		a
+		deeper1
+	EOF
+	ls repo/deep/deeper1 >dir  &&
+	cat >expect <<-EOF &&
+		a
+		deepest
+	EOF
+	test_cmp expect dir &&
+	cat >expect <<-EOF &&
+		/*
+		!/*/
+		/deep/
+		!/deep/*/
+		/deep/deeper1/
+		!/deep/deeper1/*/
+		/deep/deeper1/deepest/
+	EOF
+	test_cmp expect repo/.git/info/sparse-checkout &&
+	git -C repo sparse-checkout set --stdin 2>err <<-EOF &&
+		folder1
+		folder2
+	EOF
+	test_line_count = 0 err &&
+	cat >expect <<-EOF &&
+		a
+		folder1
+		folder2
+	EOF
+	ls repo >dir &&
+	test_cmp expect dir
+'
+
 test_done
-- 
gitgitgadget

