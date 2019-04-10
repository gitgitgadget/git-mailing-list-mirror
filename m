Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6717C20248
	for <e@80x24.org>; Wed, 10 Apr 2019 17:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbfDJRiD (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 13:38:03 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44899 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729655AbfDJRh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 13:37:59 -0400
Received: by mail-ed1-f67.google.com with SMTP id d11so2763329edp.11
        for <git@vger.kernel.org>; Wed, 10 Apr 2019 10:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pRNh/ztFrKB40bwoePW1Bf5Lnj9AMgB3ybTo5lQDG3k=;
        b=EZgyrUfr/x3vvRnr8V78N4BGlJ9r/WXABmdcPKcRL9EuSEib5PzO3C/NeFS83ZuI+G
         QLgeAQU/LwPBWbhA3JCsWlCKRHpvOFQgQGTijk16MV3uwdNVM95O2as6/AmBOrdMeA+W
         Zs+y8EnSufnbbyme3gqp7Qo5EOfUlvZz/quXTAvkyHgDA7qb6EdvIM7bHmTsAAakwh+f
         KdIs8jX+rxBB3HR9J0VBRPLBR18u3kmcII4mz0XJ2OCpuAATI4OqKLJyXn5d0j26L5qU
         VbOfP+bOF8cp0KnZXOURH3QgnOFbZmcRkonBR7wqTjkXnX64KkDvGcz+BgBaDVfV0OLj
         TbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pRNh/ztFrKB40bwoePW1Bf5Lnj9AMgB3ybTo5lQDG3k=;
        b=R0zVtBxd0VJcf4YBZ4fXlN92SZPSdPNSZhu8WbBmafTfQ4mRo8IUzG/Wl9D17VftPs
         V3EiKwS2AElDwFqbJTumZSY3freh1qRIy7epkplfHxDldDsIrC1CZdO6ohRQHUaP8YJe
         loWHaHdlo2heBijzDeLha4VtJeyILugJrGcu1XmdxQlQFvXmcA/z3hLW7W9F9quBW9uE
         fyfoBE1JBXEEEz4XvDcxFLdUHUxt8Jdh1+Eb2GnpGy5Kfd7pra7QIcz1AHGO60haN41Q
         KYT2y0eE3S54xT9TyGofEJgM/BdbZQDTuFytKrulJ2qpRK9W8mczm1xhI+f6dhCsRKjn
         0vSw==
X-Gm-Message-State: APjAAAVMh5d5FaM/B1I2H63CfxrUyk5XcgCaETv5moIuFfRiCKlF+EXh
        gYA6/GEo67v3uTy8nC3n1bZW7pUe
X-Google-Smtp-Source: APXvYqxbpWgXpm1SnxDNqylp9GUn8M5T3Mwo4HdvyV6QPRSHLJjMwwaSlJg2sUkwcIiyzK9ZQI2DhA==
X-Received: by 2002:a17:906:aece:: with SMTP id me14mr25301781ejb.0.1554917877318;
        Wed, 10 Apr 2019 10:37:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r1sm1338490edx.12.2019.04.10.10.37.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 10:37:56 -0700 (PDT)
Date:   Wed, 10 Apr 2019 10:37:56 -0700 (PDT)
X-Google-Original-Date: Wed, 10 Apr 2019 17:37:45 GMT
Message-Id: <56acc31e962e5985c7ad2119b7e6d86f7647e786.1554917868.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.git.gitgitgadget@gmail.com>
References: <pull.170.git.gitgitgadget@gmail.com>
From:   "Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 08/11] built-in add -i: show unique prefixes of the commands
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Slavica Djukic <slawica92@hotmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Slavica Djukic <slawica92@hotmail.com>

Just like in the Perl script `git-add--interactive.perl`, for each
command a unique prefix is determined (if there exists any within the
given parameters), and shown in the list, and accepted as a shortcut for
the command.

We use the prefix map implementation that we just added in the previous
commit for that purpose.

Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 add-interactive.c | 70 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 57 insertions(+), 13 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index c8bd62369e..62ce446dd9 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -6,6 +6,7 @@
 #include "diffcore.h"
 #include "revision.h"
 #include "refs.h"
+#include "prefix-map.h"
 
 static int use_color = -1;
 
@@ -53,18 +54,33 @@ int add_i_config(const char *var, const char *value, void *cb)
 	return git_color_default_config(var, value, cb);
 }
 
-struct item {
-	const char *name;
-};
+static ssize_t find_unique(const char *string,
+			   struct prefix_item **list, size_t nr)
+{
+	ssize_t found = -1, i;
+
+	for (i = 0; i < nr; i++) {
+		struct prefix_item *item = list[i];
+		if (!starts_with(item->name, string))
+			continue;
+		if (found >= 0)
+			return -1;
+		found = i;
+	}
+
+	return found;
+}
 
 struct list_options {
 	int columns;
 	const char *header;
-	void (*print_item)(int i, struct item *item, void *print_item_data);
+	void (*print_item)(int i, struct prefix_item *item,
+			   void *print_item_data);
 	void *print_item_data;
 };
 
-static void list(struct item **list, size_t nr, struct list_options *opts)
+static void list(struct prefix_item **list, size_t nr,
+		 struct list_options *opts)
 {
 	int i, last_lf = 0;
 
@@ -101,12 +117,14 @@ struct list_and_choose_options {
 /*
  * Returns the selected index.
  */
-static ssize_t list_and_choose(struct item **items, size_t nr,
+static ssize_t list_and_choose(struct prefix_item **items, size_t nr,
 			       struct list_and_choose_options *opts)
 {
 	struct strbuf input = STRBUF_INIT;
 	ssize_t res = -1;
 
+	find_unique_prefixes(items, nr, 1, 4);
+
 	for (;;) {
 		char *p, *endp;
 
@@ -146,6 +164,9 @@ static ssize_t list_and_choose(struct item **items, size_t nr,
 			}
 
 			p[sep] = '\0';
+			if (index < 0)
+				index = find_unique(p, items, nr);
+
 			if (index < 0 || index >= nr)
 				printf(_("Huh (%s)?\n"), p);
 			else {
@@ -171,7 +192,7 @@ struct adddel {
 
 struct file_list {
 	struct file_item {
-		struct item item;
+		struct prefix_item item;
 		struct adddel index, worktree;
 	} **file;
 	size_t nr, alloc;
@@ -337,12 +358,29 @@ static void populate_wi_changes(struct strbuf *buf,
 		strbuf_addstr(buf, no_changes);
 }
 
+/* filters out prefixes which have special meaning to list_and_choose() */
+static int is_valid_prefix(const char *prefix, size_t prefix_len)
+{
+	return prefix_len && prefix &&
+		/*
+		 * We expect `prefix` to be NUL terminated, therefore this
+		 * `strcspn()` call is okay, even if it might do much more
+		 * work than strictly necessary.
+		 */
+		strcspn(prefix, " \t\r\n,") >= prefix_len &&	/* separators */
+		*prefix != '-' &&				/* deselection */
+		!isdigit(*prefix) &&				/* selection */
+		(prefix_len != 1 ||
+		 (*prefix != '*' &&				/* "all" wildcard */
+		  *prefix != '?'));				/* prompt help */
+}
+
 struct print_file_item_data {
 	const char *modified_fmt;
 	struct strbuf buf, index, worktree;
 };
 
-static void print_file_item(int i, struct item *item,
+static void print_file_item(int i, struct prefix_item *item,
 			    void *print_file_item_data)
 {
 	struct file_item *c = (struct file_item *)item;
@@ -369,20 +407,26 @@ static int run_status(struct repository *r, const struct pathspec *ps,
 		return -1;
 
 	if (files->nr)
-		list((struct item **)files->file, files->nr, opts);
+		list((struct prefix_item **)files->file, files->nr, opts);
 	putchar('\n');
 
 	return 0;
 }
 
-static void print_command_item(int i, struct item *item,
+static void print_command_item(int i, struct prefix_item *item,
 			       void *print_command_item_data)
 {
-	printf(" %2d: %s", i + 1, item->name);
+	if (!item->prefix_length ||
+	    !is_valid_prefix(item->name, item->prefix_length))
+		printf(" %2d: %s", i + 1, item->name);
+	else
+		printf(" %3d: [%.*s]%s", i + 1,
+		       (int)item->prefix_length, item->name,
+		       item->name + item->prefix_length);
 }
 
 struct command_item {
-	struct item item;
+	struct prefix_item item;
 	int (*command)(struct repository *r, const struct pathspec *ps,
 		       struct file_list *files, struct list_options *opts);
 };
@@ -420,7 +464,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 		res = -1;
 
 	for (;;) {
-		i = list_and_choose((struct item **)commands,
+		i = list_and_choose((struct prefix_item **)commands,
 				    ARRAY_SIZE(commands), &main_loop_opts);
 		if (i < -1) {
 			printf(_("Bye.\n"));
-- 
gitgitgadget

