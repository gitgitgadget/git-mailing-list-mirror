Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F3061F463
	for <e@80x24.org>; Thu, 19 Sep 2019 14:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389387AbfISOnY (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 10:43:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41940 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389041AbfISOnW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 10:43:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id h7so3367814wrw.8
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 07:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ch1B1PQdv5t1YUEbo43+JNl+sht9+UErPZhpGcZTGgw=;
        b=k4C+P8JhdHb2DrUjMvACnRmoe4u9f7+dRUh3vzDIujBbOFMqxvIZTbXdReBIX/Iqkr
         zFo9PU/yk6zb4CZZOOqc3dkifqObkX8r5VEx/xxpE6yWcPK8/hEKfGq31ZhCDWEBynKu
         5QkS9nUYoFnuNbTrAIobqPjJixy8/RumUbtd+/8sqJJfMlTjNLubX3OfodlZ2sh7V/9t
         dB4iQQj8OGe2qo3Xv2vNu1GmcqwTPf2KywmDviUcpElg7VdzrgUk/ZODFs8lURqbNOMB
         d2un8OKqlM6EQZR3l0kurzoYp9+sloALgBb7ClxrrwVHkcHI2oASVslW3b6ZAvk6wA4G
         N3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ch1B1PQdv5t1YUEbo43+JNl+sht9+UErPZhpGcZTGgw=;
        b=SwDElhImDxQfBPkGwC1U2m0/iXHb3vbmzcwSavIoOk/IlQko7SGGxzuCDStzIWpNgV
         3VA1tdGuSvwVBnvpIiKtLnL8m8B/ey/0hu2hmi7vmw0U/oAxIe/sqq9UTsoG43O6eZCT
         +CB5M16mu5Kcrb00YAWK0sgKMYH6rYuqyjE8FZH3eGvoBKs5GrLoN0gdmwADhVgbaLpw
         WRrQO1cSvp7ddLm6mYml8WfmF/u+K5R/2fKBUAnPCVq1jYYhR5vdNgZgPP309OsmgnfZ
         CdKHxbS8Rg8jHyAsOTvg5dOI6ji3BJ+l40dw9nBTAPlww/FOwTwpjN6cUN6REdfvRK4i
         a2wQ==
X-Gm-Message-State: APjAAAWy7h4zC7LIWqEJbAVrY2cWIhFOBpiOUHas2A6XOTVrdOB6EIUL
        u13Vd45BiQVYL73Znz6qx0N6fNWW
X-Google-Smtp-Source: APXvYqy/C2gA8bd+3V8TU1RiGB+jdyoZyJ1eA4llC0bRQt9RKjZLKCy5NMNMo1WHnIg1eEH4lxmMmw==
X-Received: by 2002:adf:ee4a:: with SMTP id w10mr7486340wro.138.1568904198218;
        Thu, 19 Sep 2019 07:43:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d28sm13569203wrb.95.2019.09.19.07.43.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 07:43:17 -0700 (PDT)
Date:   Thu, 19 Sep 2019 07:43:17 -0700 (PDT)
X-Google-Original-Date: Thu, 19 Sep 2019 14:43:07 GMT
Message-Id: <995c5b8e2b4b4ba36c09165de1bc4719819c3ce4.1568904188.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v2.git.gitgitgadget@gmail.com>
References: <pull.316.git.gitgitgadget@gmail.com>
        <pull.316.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 10/11] sparse-checkout: init and set in cone mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
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
 builtin/sparse-checkout.c          | 171 +++++++++++++++++++++++++++--
 dir.c                              |   4 +-
 dir.h                              |   3 +
 t/t1091-sparse-checkout-builtin.sh |  49 +++++++++
 4 files changed, 213 insertions(+), 14 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index f858f0b1b5..111cbc96d9 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -6,6 +6,7 @@
 #include "repository.h"
 #include "run-command.h"
 #include "strbuf.h"
+#include "string-list.h"
 
 static char const * const builtin_sparse_checkout_usage[] = {
 	N_("git sparse-checkout [init|list|set|disable] <options>"),
@@ -74,9 +75,14 @@ static int update_working_directory(void)
 	return result;
 }
 
+#define SPARSE_CHECKOUT_NONE 0
+#define SPARSE_CHECKOUT_FULL 1
+#define SPARSE_CHECKOUT_CONE 2
+
 static int sc_set_config(int mode)
 {
 	struct argv_array argv = ARGV_ARRAY_INIT;
+	struct argv_array cone_argv = ARGV_ARRAY_INIT;
 
 	if (git_config_set_gently("extensions.worktreeConfig", "true")) {
 		error(_("failed to set extensions.worktreeConfig setting"));
@@ -95,9 +101,31 @@ static int sc_set_config(int mode)
 		return 1;
 	}
 
+	argv_array_pushl(&cone_argv, "config", "--worktree",
+			 "core.sparseCheckoutCone", NULL);
+
+	if (mode == SPARSE_CHECKOUT_CONE)
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
@@ -105,8 +133,21 @@ static int sparse_checkout_init(int argc, const char **argv)
 	FILE *fp;
 	int res;
 	struct object_id oid;
+	int mode;
+
+	static struct option builtin_sparse_checkout_init_options[] = {
+		OPT_BOOL(0, "cone", &init_opts.cone_mode,
+			 N_("initialize the sparse-checkout in cone mode")),
+		OPT_END(),
+	};
 
-	if (sc_set_config(1))
+	argc = parse_options(argc, argv, NULL,
+			     builtin_sparse_checkout_init_options,
+			     builtin_sparse_checkout_init_usage, 0);
+
+	mode = init_opts.cone_mode ? SPARSE_CHECKOUT_CONE : SPARSE_CHECKOUT_FULL;
+
+	if (sc_set_config(mode))
 		return 1;
 
 	memset(&pl, 0, sizeof(pl));
@@ -135,6 +176,72 @@ static int sparse_checkout_init(int argc, const char **argv)
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
+		if (!slash)
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
+			fprintf(fp, "/%s/\n!/%s/*/\n", pattern, pattern);
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
+		fprintf(fp, "/%s/\n", pattern);
+	}
+}
+
 static int write_patterns_and_update(struct pattern_list *pl)
 {
 	char *sparse_filename;
@@ -142,7 +249,12 @@ static int write_patterns_and_update(struct pattern_list *pl)
 
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
 
@@ -150,6 +262,24 @@ static int write_patterns_and_update(struct pattern_list *pl)
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
+	if (line->buf[0] == '/')
+		strbuf_remove(line, 0, 1);
+
+	if (!line->len)
+		return;
+
+	insert_recursive_pattern(pl, line);
+}
+
 static char const * const builtin_sparse_checkout_set_usage[] = {
 	N_("git sparse-checkout set [--stdin|<patterns>]"),
 	NULL
@@ -177,17 +307,34 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 			     builtin_sparse_checkout_set_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
-	if (set_opts.use_stdin) {
+	if (core_sparse_checkout_cone) {
 		struct strbuf line = STRBUF_INIT;
-
-		while (!strbuf_getline(&line, stdin)) {
-			size_t len;
-			char *buf = strbuf_detach(&line, &len);
-			add_pattern(buf, buf, len, &pl, 0);
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
-			add_pattern(argv[i], argv[i], strlen(argv[i]), &pl, 0);
+		if (set_opts.use_stdin) {
+			struct strbuf line = STRBUF_INIT;
+
+			while (!strbuf_getline(&line, stdin)) {
+				size_t len;
+				char *buf = strbuf_detach(&line, &len);
+				add_pattern(buf, buf, len, &pl, 0);
+			}
+		} else {
+			for (i = 0; i < argc; i++)
+				add_pattern(argv[i], argv[i], strlen(argv[i]), &pl, 0);
+		}
 	}
 
 	return write_patterns_and_update(&pl);
@@ -198,7 +345,7 @@ static int sparse_checkout_disable(int argc, const char **argv)
 	char *sparse_filename;
 	FILE *fp;
 
-	if (sc_set_config(1))
+	if (sc_set_config(SPARSE_CHECKOUT_FULL))
 		die(_("failed to change config"));
 
 	sparse_filename = get_sparse_checkout_filename();
@@ -212,7 +359,7 @@ static int sparse_checkout_disable(int argc, const char **argv)
 	unlink(sparse_filename);
 	free(sparse_filename);
 
-	return sc_set_config(0);
+	return sc_set_config(SPARSE_CHECKOUT_NONE);
 }
 
 int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
diff --git a/dir.c b/dir.c
index 4fc57187e9..298a4539ec 100644
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
index bbd5bd1cc9..7c76a2d55e 100644
--- a/dir.h
+++ b/dir.h
@@ -296,6 +296,9 @@ int is_excluded(struct dir_struct *dir,
 		struct index_state *istate,
 		const char *name, int *dtype);
 
+int pl_hashmap_cmp(const void *unused_cmp_data,
+		   const void *a, const void *b, const void *key);
+
 struct pattern_list *add_pattern_list(struct dir_struct *dir,
 				      int group_type, const char *src);
 int add_patterns_from_file_to_list(const char *fname, const char *base, int baselen,
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index f726205d21..b6eb02c69a 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -178,5 +178,54 @@ test_expect_success 'sparse-checkout disable' '
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

