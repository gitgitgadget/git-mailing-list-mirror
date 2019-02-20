Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC59C1F453
	for <e@80x24.org>; Wed, 20 Feb 2019 11:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfBTLlg (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 06:41:36 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41301 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbfBTLlf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 06:41:35 -0500
Received: by mail-ed1-f65.google.com with SMTP id x7so19575618eds.8
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 03:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0Rcb6ln1StKe8v7QuBEjzmyR+1dgsbFgspac//KqD00=;
        b=PWjN4YsBT+bWgolfH42p5qKo34jcgWhrwjIPS1gch39DBBA0ZTR/6/Ncm+Jt9kxLj7
         UzlwGbwY63kRGJrTKi1i4ebQmNsWUUtAsLzEQrDSAU7JDo92t+5diSqvdDe4XN3kn29c
         VDBZWWYupbUDqy31Z/bNkf5fyJlG+k0hDbvsouNVcG2CQsYNUag5n9f1laSQzfIXpwDl
         jEwS1A4CMGh3A+z9yGIqeoeeEiuJ7NPLAdNNnUfJZX44u0n/Jcv4A5GArQ8KukA0bgS0
         1UOfbh1NVNd9iwqBhd004NR6nWYV5+9dWTWVgFmesxKNaY1Beiw4h4Mpd63vhzZdXpc7
         lTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0Rcb6ln1StKe8v7QuBEjzmyR+1dgsbFgspac//KqD00=;
        b=p3m4ImqvwF3Thls/So4iLmjel/qhJZQHsxmaWMsd29l3W9blXaA1TapNWsgYVIJbAb
         TK11ZSDnppV5M0gqwYbHtcp9nREc8Dv0mGIuiijIckc5MxVO2yhGzh4rwZc6TygKR7SW
         ql3CQp653dvLS1llqM/5LHY3e+ttQaiCTH9bSIKy9PraGkOTASMcL/4sdtMSajvrGmq/
         cosk65WOOFRWDtMbCX4Qx0fjm9IM+lnCVdY25sP8LTrqR1ZUr+BL8KtFfDEer/Mcem60
         kaozMfwNSRnK0a8IFukmP1ThFfAzkZ+UViZbXivdmkDk2UINY2x6c9ahHe4OcvnD+Ace
         caJQ==
X-Gm-Message-State: AHQUAub1qtvJ7bVj/QcHx207duWfIcLO1I1N8KUt5VHpxLfK99PXRfSi
        1UNCXDovwzDAZZ4jrs7pPOtRmdN6
X-Google-Smtp-Source: AHgI3IYUJeIfOcdK75YxNJiliLefwUH3YAp7466N9Mc3cvAofmOM/bNUjqqUAhScgYjQxIH6ZGrqfg==
X-Received: by 2002:a50:98a6:: with SMTP id j35mr27090355edb.141.1550662892609;
        Wed, 20 Feb 2019 03:41:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y45sm3576639edd.33.2019.02.20.03.41.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 03:41:32 -0800 (PST)
Date:   Wed, 20 Feb 2019 03:41:32 -0800 (PST)
X-Google-Original-Date: Wed, 20 Feb 2019 11:41:22 GMT
Message-Id: <9a72aabe6cf1001d373c933086a79ace29b98806.1550662887.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.v5.git.gitgitgadget@gmail.com>
References: <pull.103.v4.git.gitgitgadget@gmail.com>
        <pull.103.v5.git.gitgitgadget@gmail.com>
From:   "Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 05/10] add-interactive.c: implement status command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Slavica Djukic <slawica92@hotmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Slavica Djukic <slawica92@hotmail.com>

Implement add --interactive's status command in add-interactive.c and
use it in builtin add--helper.c.
This is the first interactive add command implemented in C of those
anticipated by the previous commit, which introduced
the add--helper built-in.

Implement additional helper functions dealing with struct choice and
colors.

Use list_modified to get the data, and then pass it to list_and_choose
to show it in appropriate format.

We're a bit lax with the command-line parsing, as the command is
intended to be called only by one internal user: the add--interactive script.

Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Original-patch-by: Daniel Ferreira <bnmvco@gmail.com>
Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
---
 add-interactive.c     | 119 ++++++++++++++++++++++++++++++++++++++++++
 add-interactive.h     |   8 +++
 builtin/add--helper.c |  32 ++++++++++++
 3 files changed, 159 insertions(+)
 create mode 100644 add-interactive.h

diff --git a/add-interactive.c b/add-interactive.c
index 9a475a5d48..6bf8a90d9d 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -1,3 +1,4 @@
+#include "add-interactive.h"
 #include "cache.h"
 #include "commit.h"
 #include "color.h"
@@ -7,6 +8,8 @@
 
 #define HEADER_INDENT "      "
 
+#define HEADER_MAXLEN 30
+
 enum collection_phase {
 	WORKTREE,
 	INDEX
@@ -29,6 +32,11 @@ struct collection_status {
 	struct hashmap file_map;
 };
 
+struct command {
+	char *name;
+	void (*command_fn)(void);
+};
+
 struct list_and_choose_options {
 	int column_n;
 	unsigned singleton:1;
@@ -84,6 +92,42 @@ static const char *get_color(enum color_add_i ix)
 	return "";
 }
 
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
+		 const char *value, void *cbdata)
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
 static int hash_cmp(const void *unused_cmp_data, const void *entry,
 		    const void *entry_or_key, const void *keydata)
 {
@@ -313,3 +357,78 @@ static struct choices *list_and_choose(struct choices *data,
 		return NULL;
 	}
 }
+
+static struct choice *make_choice(const char *name )
+{
+	struct choice *choice;
+	FLEXPTR_ALLOC_STR(choice, name, name);
+	return choice;
+}
+
+static struct choice *add_choice(struct choices *choices, const char type,
+				 struct file_stat *file, struct command *command)
+{
+	struct choice *choice;
+	switch (type) {
+		case 'f':
+			choice = make_choice(file->name);
+			choice->u.file.index.added = file->index.added;
+			choice->u.file.index.deleted = file->index.deleted;
+			choice->u.file.worktree.added = file->worktree.added;
+			choice->u.file.worktree.deleted = file->worktree.deleted;
+			break;
+		case 'c':
+			choice = make_choice(command->name);
+			choice->u.command_fn = command->command_fn;
+			break;
+	}
+	choice->type = type;
+
+	ALLOC_GROW(choices->choices, choices->nr + 1, choices->alloc);
+	choices->choices[choices->nr++] = choice;
+
+	return choice;
+}
+
+static void free_choices(struct choices *choices)
+{
+	int i;
+
+	for (i = 0; i < choices->nr; i++)
+		free(choices->choices[i]);
+	free(choices->choices);
+	choices->choices = NULL;
+	choices->nr = choices->alloc = 0;
+}
+
+void add_i_status(void)
+{
+	struct collection_status *s;
+	struct list_and_choose_options opts = { 0 };
+	struct hashmap *map;
+	struct hashmap_iter iter;
+	struct choices choices = CHOICES_INIT;
+	struct file_stat *entry;
+	const char *modified_fmt = _("%12s %12s %s");
+	const char type = 'f';
+
+	opts.header = xmalloc(sizeof(char) * (HEADER_MAXLEN + 1));
+	snprintf(opts.header, HEADER_MAXLEN + 1, modified_fmt,
+		 _("staged"), _("unstaged"), _("path"));
+
+	s = list_modified(the_repository, NULL);
+	if (s == NULL)
+		return;
+
+	map = &s->file_map;
+	hashmap_iter_init(map, &iter);
+	while ((entry = hashmap_iter_next(&iter))) {
+		add_choice(&choices, type, entry, NULL);
+	}
+
+	list_and_choose(&choices, &opts);
+
+	hashmap_free(&s->file_map, 1);
+	free(s);
+	free_choices(&choices);
+}
diff --git a/add-interactive.h b/add-interactive.h
new file mode 100644
index 0000000000..8ef3d2e82b
--- /dev/null
+++ b/add-interactive.h
@@ -0,0 +1,8 @@
+#ifndef ADD_INTERACTIVE_H
+#define ADD_INTERACTIVE_H
+
+int add_i_config(const char *var, const char *value, void *cbdata);
+
+void add_i_status(void);
+
+#endif
diff --git a/builtin/add--helper.c b/builtin/add--helper.c
index 6a97f0e191..464d2245f3 100644
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
+			    N_("print status information with diffstat"), STATUS),
+		OPT_END()
+	};
+
+	git_config(add_i_config, NULL);
+	argc = parse_options(argc, argv, NULL, options,
+			     builtin_add_helper_usage,
+			     PARSE_OPT_KEEP_ARGV0);
+
+	if (mode == STATUS)
+		add_i_status();
+	else
+		usage_with_options(builtin_add_helper_usage,
+				   options);
+
 	return 0;
 }
-- 
gitgitgadget

