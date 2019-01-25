Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AD381F453
	for <e@80x24.org>; Fri, 25 Jan 2019 12:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfAYMXk (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 07:23:40 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46644 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfAYMXh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 07:23:37 -0500
Received: by mail-ed1-f66.google.com with SMTP id o10so7189388edt.13
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 04:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gJ9EZ6s2ppCMotQCwIgSQOgE/iuUG1zHvEyrNQD0AEU=;
        b=MBHrwxpSwBmEiYJR+Lb8UpZAunGPiaPgwtaADCbnqS/1Y5hlivwAO+t/jtms7VXgFw
         hS9TwUGyNsfs3Qo0gpO7Bexjgl3q6b2A2JgIId/rMJU6CJ4alGRCGZOcM3TnafEQ/3ZE
         KTlsuO9n0xs0/D8lPVMJfBMniCjzV9gb8fHOvKt9dYkhdCb5WvAWvJaht7Wm1beQtnga
         Oe/MQfzNLEi9psdhqHXAI1BbOfnkJHjD5hjVBf77JLwUcHid6Q2oTCkQxG6m+sFqUjma
         7WdAgO9P/k1y46XHRxQ4pkKyn1fRgMfgs9jVQEYnRA6VG+Kcms8Ck+Tb5Yg4GmJE0xOE
         NMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gJ9EZ6s2ppCMotQCwIgSQOgE/iuUG1zHvEyrNQD0AEU=;
        b=ixEr6rRHzxd1qFLp7/rcJoFE+9OR041UOni/R8qJRJkx/edVQIOgVpvIlU44H5/yFv
         qlIHf20VJsHb/8XZfBA8wkeNGGO+Ufpm30dY3pOwWcljBRKDpAOuDjy4fwB12B4KlaIn
         YUKqdOWIoaW+bMjrFTOA/vpI7HRcfjrVU8hz8QEbSCaYTtDUZWCyM+DQ/FdYgDKW99as
         Tzp+zpFymIk42HHanFI8dRqOqWPkEtf0XGkpDn2uMaTFOwGmhAbewifo32KFec2MT719
         uUimG+wzJkHdnixj10Mdd9OH+QyPc/HmJ3LbYg5L8czYZ4B6QSo8ptJFqg5QYHPfOppg
         8Znw==
X-Gm-Message-State: AJcUukcAXq82Cz8wS4pRgy7auuAXjKxGGb4WcpGVC1SpVKcTY6SSbZbu
        gaXhM42UotVy/629Wx6/XrKvZTIE
X-Google-Smtp-Source: ALg8bN5FQ73Ik/mAWtX4JG0JkydpaELp8dcWnlSfm72oeuopod1hmw85qXtg+meTlknIh9Jz9eRgrA==
X-Received: by 2002:a17:906:515:: with SMTP id j21-v6mr9595493eja.39.1548419014159;
        Fri, 25 Jan 2019 04:23:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r1sm11439551eds.1.2019.01.25.04.23.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 04:23:33 -0800 (PST)
Date:   Fri, 25 Jan 2019 04:23:33 -0800 (PST)
X-Google-Original-Date: Fri, 25 Jan 2019 12:23:25 GMT
Message-Id: <d247ef69fe2c9d017b8d363de554a52269c0d281.1548419009.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.v4.git.gitgitgadget@gmail.com>
References: <pull.103.v3.git.gitgitgadget@gmail.com>
        <pull.103.v4.git.gitgitgadget@gmail.com>
From:   "Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 3/7] add-interactive.c: implement status command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Daniel Ferreira <bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Daniel Ferreira <bnmvco@gmail.com>

Add new files: add-interactive.c and add-interactive.h, which
will be used for implementing "application logic" of git add -i,
whereas add--helper.c will be used mostly for parsing the command line.
We're a bit lax with the command-line parsing, as the command is
intended to be called only by one internal user: the add--interactive script.

Implement add --interactive's status command in add-interactive.c and
use it in builtin add--helper.c.

It prints a numstat comparing changed files between a) the worktree and
the index; b) the index and the HEAD.

To do so, we use run_diff_index() and run_diff_files() to get changed
files, use the diffstat API on them to get the numstat and use a
combination of a hashmap and qsort() to print the result in
O(n) + O(n lg n) complexity.

This is the first interactive add command implemented in C of those
anticipated by the previous commit, which introduced
the add--helper built-in.

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
---
 Makefile              |   1 +
 add-interactive.c     | 246 ++++++++++++++++++++++++++++++++++++++++++
 add-interactive.h     |   8 ++
 builtin/add--helper.c |  32 ++++++
 4 files changed, 287 insertions(+)
 create mode 100644 add-interactive.c
 create mode 100644 add-interactive.h

diff --git a/Makefile b/Makefile
index 9c84b80739..2a4a5cc37b 100644
--- a/Makefile
+++ b/Makefile
@@ -827,6 +827,7 @@ LIB_H = $(shell $(FIND) . \
 	-name '*.h' -print)
 
 LIB_OBJS += abspath.o
+LIB_OBJS += add-interactive.o
 LIB_OBJS += advice.o
 LIB_OBJS += alias.o
 LIB_OBJS += alloc.o
diff --git a/add-interactive.c b/add-interactive.c
new file mode 100644
index 0000000000..c55d934186
--- /dev/null
+++ b/add-interactive.c
@@ -0,0 +1,246 @@
+#include "add-interactive.h"
+#include "cache.h"
+#include "commit.h"
+#include "color.h"
+#include "config.h"
+#include "diffcore.h"
+#include "revision.h"
+
+#define HEADER_INDENT "      "
+
+enum collection_phase {
+	WORKTREE,
+	INDEX
+};
+
+struct file_stat {
+	struct hashmap_entry ent;
+	struct {
+		uintmax_t added, deleted;
+	} index, worktree;
+	char name[FLEX_ARRAY];
+};
+
+struct collection_status {
+	enum collection_phase phase;
+
+	const char *reference;
+	struct pathspec pathspec;
+
+	struct hashmap file_map;
+};
+
+static int use_color = -1;
+enum color_add_i {
+	COLOR_PROMPT,
+	COLOR_HEADER,
+	COLOR_HELP,
+	COLOR_ERROR
+};
+
+static char colors[][COLOR_MAXLEN] = {
+	GIT_COLOR_BOLD_BLUE, /* Prompt */
+	GIT_COLOR_BOLD,      /* Header */
+	GIT_COLOR_BOLD_RED,  /* Help */
+	GIT_COLOR_BOLD_RED   /* Error */
+};
+
+static const char *get_color(enum color_add_i ix)
+{
+	if (want_color(use_color))
+		return colors[ix];
+	return "";
+}
+
+static int parse_color_slot(const char *slot)
+{
+	if (!strcasecmp(slot, "prompt"))
+		return COLOR_PROMPT;
+	if (!strcasecmp(slot, "header"))
+		return COLOR_HEADER;
+	if (!strcasecmp(slot, "help"))
+		return COLOR_HELP;
+	if (!strcasecmp(slot, "error"))
+		return COLOR_ERROR;
+
+	return -1;
+}
+
+int add_i_config(const char *var,
+		const char *value, void *cbdata)
+{
+	const char *name;
+
+	if (!strcmp(var, "color.interactive")) {
+		use_color = git_config_colorbool(var, value);
+		return 0;
+	}
+
+	if (skip_prefix(var, "color.interactive.", &name)) {
+		int slot = parse_color_slot(name);
+		if (slot < 0)
+			return 0;
+		if (!value)
+			return config_error_nonbool(var);
+		return color_parse(value, colors[slot]);
+	}
+
+	return git_default_config(var, value, cbdata);
+}
+
+static int hash_cmp(const void *unused_cmp_data, const void *entry,
+			const void *entry_or_key, const void *keydata)
+{
+	const struct file_stat *e1 = entry, *e2 = entry_or_key;
+	const char *name = keydata ? keydata : e2->name;
+
+	return strcmp(e1->name, name);
+}
+
+static int alphabetical_cmp(const void *a, const void *b)
+{
+	struct file_stat *f1 = *((struct file_stat **)a);
+	struct file_stat *f2 = *((struct file_stat **)b);
+
+	return strcmp(f1->name, f2->name);
+}
+
+static void collect_changes_cb(struct diff_queue_struct *q,
+					 struct diff_options *options,
+					 void *data)
+{
+	struct collection_status *s = data;
+	struct diffstat_t stat = { 0 };
+	int i;
+
+	if (!q->nr)
+		return;
+
+	compute_diffstat(options, &stat);
+
+	for (i = 0; i < stat.nr; i++) {
+		struct file_stat *entry;
+		const char *name = stat.files[i]->name;
+		unsigned int hash = strhash(name);
+
+		entry = hashmap_get_from_hash(&s->file_map, hash, name);
+		if (!entry) {
+			FLEX_ALLOC_STR(entry, name, name);
+			hashmap_entry_init(entry, hash);
+			hashmap_add(&s->file_map, entry);
+		}
+
+		if (s->phase == WORKTREE) {
+			entry->worktree.added = stat.files[i]->added;
+			entry->worktree.deleted = stat.files[i]->deleted;
+		} else if (s->phase == INDEX) {
+			entry->index.added = stat.files[i]->added;
+			entry->index.deleted = stat.files[i]->deleted;
+		}
+	}
+}
+
+static void collect_changes_worktree(struct collection_status *s)
+{
+	struct rev_info rev;
+
+	s->phase = WORKTREE;
+
+	init_revisions(&rev, NULL);
+	setup_revisions(0, NULL, &rev, NULL);
+
+	rev.max_count = 0;
+
+	rev.diffopt.flags.ignore_dirty_submodules = 1;
+	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback = collect_changes_cb;
+	rev.diffopt.format_callback_data = s;
+
+	run_diff_files(&rev, 0);
+}
+
+static void collect_changes_index(struct collection_status *s)
+{
+	struct rev_info rev;
+	struct setup_revision_opt opt = { 0 };
+
+	s->phase = INDEX;
+
+	init_revisions(&rev, NULL);
+	opt.def = s->reference;
+	setup_revisions(0, NULL, &rev, &opt);
+
+	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback = collect_changes_cb;
+	rev.diffopt.format_callback_data = s;
+
+	run_diff_index(&rev, 1);
+}
+
+void add_i_print_modified(void)
+{
+	int i = 0;
+	struct collection_status s;
+	/* TRANSLATORS: you can adjust this to align "git add -i" status menu */
+	const char *modified_fmt = _("%12s %12s %s");
+	const char *header_color = get_color(COLOR_HEADER);
+	struct object_id sha1;
+
+	struct hashmap_iter iter;
+	struct file_stat **files;
+	struct file_stat *entry;
+
+	if (read_cache() < 0)
+		return;
+
+	s.reference = !get_oid("HEAD", &sha1) ? "HEAD": empty_tree_oid_hex();
+	hashmap_init(&s.file_map, hash_cmp, NULL, 0);
+
+	collect_changes_worktree(&s);
+	collect_changes_index(&s);
+
+	if (hashmap_get_size(&s.file_map) < 1) {
+		printf("\n");
+		return;
+	}
+
+	printf(HEADER_INDENT);
+	color_fprintf(stdout, header_color, modified_fmt, _("staged"),
+			_("unstaged"), _("path"));
+	printf("\n");
+
+	hashmap_iter_init(&s.file_map, &iter);
+
+	files = xcalloc(hashmap_get_size(&s.file_map), sizeof(struct file_stat *));
+	while ((entry = hashmap_iter_next(&iter))) {
+		files[i++] = entry;
+	}
+	QSORT(files, hashmap_get_size(&s.file_map), alphabetical_cmp);
+
+	for (i = 0; i < hashmap_get_size(&s.file_map); i++) {
+		struct file_stat *f = files[i];
+
+		char worktree_changes[50];
+		char index_changes[50];
+
+		if (f->worktree.added || f->worktree.deleted)
+			snprintf(worktree_changes, 50, "+%"PRIuMAX"/-%"PRIuMAX, f->worktree.added,
+					f->worktree.deleted);
+		else
+			snprintf(worktree_changes, 50, "%s", _("nothing"));
+
+		if (f->index.added || f->index.deleted)
+			snprintf(index_changes, 50, "+%"PRIuMAX"/-%"PRIuMAX, f->index.added,
+					f->index.deleted);
+		else
+			snprintf(index_changes, 50, "%s", _("unchanged"));
+
+		printf(" %2d: ", i + 1);
+		printf(modified_fmt, index_changes, worktree_changes, f->name);
+		printf("\n");
+	}
+	printf("\n");
+
+	free(files);
+	hashmap_free(&s.file_map, 1);
+}
diff --git a/add-interactive.h b/add-interactive.h
new file mode 100644
index 0000000000..1f4747553c
--- /dev/null
+++ b/add-interactive.h
@@ -0,0 +1,8 @@
+#ifndef ADD_INTERACTIVE_H
+#define ADD_INTERACTIVE_H
+
+int add_i_config(const char *var, const char *value, void *cbdata);
+
+void add_i_print_modified(void);
+
+#endif
\ No newline at end of file
diff --git a/builtin/add--helper.c b/builtin/add--helper.c
index 6a97f0e191..43545d9af5 100644
--- a/builtin/add--helper.c
+++ b/builtin/add--helper.c
@@ -1,6 +1,38 @@
+#include "add-interactive.h"
 #include "builtin.h"
+#include "config.h"
+#include "revision.h"
+
+static const char * const builtin_add_helper_usage[] = {
+	N_("git add-interactive--helper <command>"),
+	NULL
+};
+
+enum cmd_mode {
+	DEFAULT = 0,
+	STATUS
+};
 
 int cmd_add__helper(int argc, const char **argv, const char *prefix)
 {
+	enum cmd_mode mode = DEFAULT;
+
+	struct option options[] = {
+		OPT_CMDMODE(0, "status", &mode,
+			 N_("print status information with diffstat"), STATUS),
+		OPT_END()
+	};
+
+	git_config(add_i_config, NULL);
+	argc = parse_options(argc, argv, NULL, options,
+			     builtin_add_helper_usage,
+			     PARSE_OPT_KEEP_ARGV0);
+
+	if (mode == STATUS)
+		add_i_print_modified();
+	else
+		usage_with_options(builtin_add_helper_usage,
+				   options);
+
 	return 0;
 }
-- 
gitgitgadget

