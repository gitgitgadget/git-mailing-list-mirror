Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 533781F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 12:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKMMlQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 07:41:16 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34583 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfKMMlP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 07:41:15 -0500
Received: by mail-wr1-f66.google.com with SMTP id e6so2219036wrw.1
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 04:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Ohz6fmiu9hEZGsQRibqeyYnFTlpDhDaHpZdPRVAZXJU=;
        b=ZCiGgmj3GXrCGdypucEJQhG+rPxWvFvm81wWLLTVRqeF88mJPs+YCPykXSYX5yOTWP
         qp+zlq4ECsZzv/nmx8rJp5WrgYSedqdmQFRNMCQHtOWXsJ4vV8iXxd+h9w/v2XellNoZ
         Y6rYG5ESHFbaJTRt71qwpI5TgE7YIPlNyd1sZtLOe7Ek/nqEJIOb72aAQGk4wKWu7zJk
         Sp8EiKHzt4UZgNt4yRgFL3Aa5410T54YPdpdu2+y8B8B/J1Y/uSEkCfuGAraTb6kBw5n
         OqWTJQNK94bFHvpTA0oFPxyYT553B/cxVMjlBcwq+YLO5WwMsLm36hLG1hjd/B5D15eP
         LYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Ohz6fmiu9hEZGsQRibqeyYnFTlpDhDaHpZdPRVAZXJU=;
        b=evFkOrb1b9OES6mW+NO3qbU67rZmywvKC/eY6mTWzmHThL79VeEwOUJdXsqFuKc3x7
         MYmIIgrEwYkxFqzQ4vpT17OSjQEZ4puc6BFzk9iSprKH5nbtKOzq26hnHEuXbHRlXBw7
         xZzbT3wcRsPkt/FjxMC9hr6IWDkP6iZt9WLkxAT1wcuQlnno2Rwa5zLpA3gsGrAAOPeY
         NWqrtCI0e5XembVrqAF4uWXp558TzhJui6yk8Ze14cboSwy/KpDlq69H17f5tRaO8/mQ
         5aG6wdg3DuliIC8wgUBWZvYUEOmtGCKa38a41eu4kxatH74fHMl1Nf09NOTtGsREkT8J
         zzEg==
X-Gm-Message-State: APjAAAWLgu7RzN8CcLhnYKpJXHH/DrvzouC/95wdgmuSrIYu9oL9xKnw
        QMh4vVOGLLjZhHLiR7FNeEddj03u
X-Google-Smtp-Source: APXvYqxXtpDh6GNPe5+TALnGoR37EkFPpv25pBGjRZvT7RwF8dJxs8T3CIn8NioSEAVOPn9nQ9dJvA==
X-Received: by 2002:a05:6000:14a:: with SMTP id r10mr2589563wrx.310.1573648872620;
        Wed, 13 Nov 2019 04:41:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c15sm2627551wrx.78.2019.11.13.04.41.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 04:41:12 -0800 (PST)
Message-Id: <b6459be5eb249a6d19615eb9d1cd8cb526eebc83.1573648866.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v6.git.1573648866.gitgitgadget@gmail.com>
References: <pull.170.v5.git.1572869729.gitgitgadget@gmail.com>
        <pull.170.v6.git.1573648866.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 13 Nov 2019 12:41:02 +0000
Subject: [PATCH v6 6/9] built-in add -i: show unique prefixes of the commands
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Just like in the Perl script `git-add--interactive.perl`, for each
command a unique prefix is determined (if there exists any within the
given parameters), and shown in the list, and accepted as a shortcut for
the command.

To determine the unique prefixes, as well as to look up the command in
question, we use a copy of the list and sort it.

While this might seem like overkill for a single command, it will make
much more sense when all the commands are implemented, and when we reuse
the same logic to present a list of files to edit, with convenient
unique prefixes.

At the start of the development of this patch series, a dedicated data
structure was introduced that imitated the Trie that the Perl version
implements. However, this was deemed overkill, and we now simply sort
the list before determining the length of the unique prefixes by looking
at each item's neighbor. As a bonus, we now use the same sorted list to
perform a binary search using the user-provided prefix as search key.

Original-patch-by: Slavica Đukić <slawica92@hotmail.com>
Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 add-interactive.c | 188 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 177 insertions(+), 11 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 0f99a52a72..7b6bcf6f8a 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -45,6 +45,132 @@ static void init_add_i_state(struct add_i_state *s, struct repository *r)
 	init_color(r, s, "header", s->header_color, GIT_COLOR_BOLD);
 }
 
+/*
+ * A "prefix item list" is a list of items that are identified by a string, and
+ * a unique prefix (if any) is determined for each item.
+ *
+ * It is implemented in the form of a pair of `string_list`s, the first one
+ * duplicating the strings, with the `util` field pointing at a structure whose
+ * first field must be `size_t prefix_length`.
+ *
+ * That `prefix_length` field will be computed by `find_unique_prefixes()`; It
+ * will be set to zero if no valid, unique prefix could be found.
+ *
+ * The second `string_list` is called `sorted` and does _not_ duplicate the
+ * strings but simply reuses the first one's, with the `util` field pointing at
+ * the `string_item_list` of the first `string_list`. It  will be populated and
+ * sorted by `find_unique_prefixes()`.
+ */
+struct prefix_item_list {
+	struct string_list items;
+	struct string_list sorted;
+	size_t min_length, max_length;
+};
+#define PREFIX_ITEM_LIST_INIT \
+	{ STRING_LIST_INIT_DUP, STRING_LIST_INIT_NODUP, 1, 4 }
+
+static void prefix_item_list_clear(struct prefix_item_list *list)
+{
+	string_list_clear(&list->items, 1);
+	string_list_clear(&list->sorted, 0);
+}
+
+static void extend_prefix_length(struct string_list_item *p,
+				 const char *other_string, size_t max_length)
+{
+	size_t *len = p->util;
+
+	if (!*len || memcmp(p->string, other_string, *len))
+		return;
+
+	for (;;) {
+		char c = p->string[*len];
+
+		/*
+		 * Is `p` a strict prefix of `other`? Or have we exhausted the
+		 * maximal length of the prefix? Or is the current character a
+		 * multi-byte UTF-8 one? If so, there is no valid, unique
+		 * prefix.
+		 */
+		if (!c || ++*len > max_length || !isascii(c)) {
+			*len = 0;
+			break;
+		}
+
+		if (c != other_string[*len - 1])
+			break;
+	}
+}
+
+static void find_unique_prefixes(struct prefix_item_list *list)
+{
+	size_t i;
+
+	if (list->sorted.nr == list->items.nr)
+		return;
+
+	string_list_clear(&list->sorted, 0);
+	/* Avoid reallocating incrementally */
+	list->sorted.items = xmalloc(st_mult(sizeof(*list->sorted.items),
+					     list->items.nr));
+	list->sorted.nr = list->sorted.alloc = list->items.nr;
+
+	for (i = 0; i < list->items.nr; i++) {
+		list->sorted.items[i].string = list->items.items[i].string;
+		list->sorted.items[i].util = list->items.items + i;
+	}
+
+	string_list_sort(&list->sorted);
+
+	for (i = 0; i < list->sorted.nr; i++) {
+		struct string_list_item *sorted_item = list->sorted.items + i;
+		struct string_list_item *item = sorted_item->util;
+		size_t *len = item->util;
+
+		*len = 0;
+		while (*len < list->min_length) {
+			char c = item->string[(*len)++];
+
+			if (!c || !isascii(c)) {
+				*len = 0;
+				break;
+			}
+		}
+
+		if (i > 0)
+			extend_prefix_length(item, sorted_item[-1].string,
+					     list->max_length);
+		if (i + 1 < list->sorted.nr)
+			extend_prefix_length(item, sorted_item[1].string,
+					     list->max_length);
+	}
+}
+
+static ssize_t find_unique(const char *string, struct prefix_item_list *list)
+{
+	int index = string_list_find_insert_index(&list->sorted, string, 1);
+	struct string_list_item *item;
+
+	if (list->items.nr != list->sorted.nr)
+		BUG("prefix_item_list in inconsistent state (%"PRIuMAX
+		    " vs %"PRIuMAX")",
+		    (uintmax_t)list->items.nr, (uintmax_t)list->sorted.nr);
+
+	if (index < 0)
+		item = list->sorted.items[-1 - index].util;
+	else if (index > 0 &&
+		 starts_with(list->sorted.items[index - 1].string, string))
+		return -1;
+	else if (index + 1 < list->sorted.nr &&
+		 starts_with(list->sorted.items[index + 1].string, string))
+		return -1;
+	else if (index < list->sorted.nr)
+		item = list->sorted.items[index].util;
+	else
+		return -1;
+	return item - list->items.items;
+}
+
 struct list_options {
 	int columns;
 	const char *header;
@@ -95,18 +221,21 @@ struct list_and_choose_options {
  * If an error occurred, returns `LIST_AND_CHOOSE_ERROR`. Upon EOF,
  * `LIST_AND_CHOOSE_QUIT` is returned.
  */
-static ssize_t list_and_choose(struct add_i_state *s, struct string_list *items,
+static ssize_t list_and_choose(struct add_i_state *s,
+			       struct prefix_item_list *items,
 			       struct list_and_choose_options *opts)
 {
 	struct strbuf input = STRBUF_INIT;
 	ssize_t res = LIST_AND_CHOOSE_ERROR;
 
+	find_unique_prefixes(items);
+
 	for (;;) {
 		char *p;
 
 		strbuf_reset(&input);
 
-		list(s, items, &opts->list_opts);
+		list(s, &items->items, &opts->list_opts);
 
 		printf("%s%s", opts->prompt, "> ");
 		fflush(stdout);
@@ -141,7 +270,10 @@ static ssize_t list_and_choose(struct add_i_state *s, struct string_list *items,
 			}
 
 			p[sep] = '\0';
-			if (index < 0 || index >= items->nr)
+			if (index < 0)
+				index = find_unique(p, items);
+
+			if (index < 0 || index >= items->items.nr)
 				printf(_("Huh (%s)?\n"), p);
 			else {
 				res = index;
@@ -307,6 +439,23 @@ static void render_adddel(struct strbuf *buf,
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
@@ -346,10 +495,23 @@ typedef int (*command_t)(struct add_i_state *s, const struct pathspec *ps,
 			 struct string_list *files,
 			 struct list_options *opts);
 
+struct command_item {
+	size_t prefix_length;
+	command_t command;
+};
+
 static void print_command_item(int i, struct string_list_item *item,
 			       void *print_command_item_data)
 {
-	printf(" %2d: %s", i + 1, item->string);
+	struct command_item *util = item->util;
+
+	if (!util->prefix_length ||
+	    !is_valid_prefix(item->string, util->prefix_length))
+		printf(" %2d: %s", i + 1, item->string);
+	else
+		printf(" %2d: [%.*s]%s", i + 1,
+		       (int)util->prefix_length, item->string,
+		       item->string + util->prefix_length);
 }
 
 int run_add_i(struct repository *r, const struct pathspec *ps)
@@ -365,7 +527,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 	} command_list[] = {
 		{ "status", run_status },
 	};
-	struct string_list commands = STRING_LIST_INIT_NODUP;
+	struct prefix_item_list commands = PREFIX_ITEM_LIST_INIT;
 
 	struct print_file_item_data print_file_item_data = {
 		"%12s %12s %s", STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
@@ -378,9 +540,12 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 	ssize_t i;
 	int res = 0;
 
-	for (i = 0; i < ARRAY_SIZE(command_list); i++)
-		string_list_append(&commands, command_list[i].string)
-			->util = command_list[i].command;
+	for (i = 0; i < ARRAY_SIZE(command_list); i++) {
+		struct command_item *util = xcalloc(sizeof(*util), 1);
+		util->command = command_list[i].command;
+		string_list_append(&commands.items, command_list[i].string)
+			->util = util;
+	}
 
 	init_add_i_state(&s, r);
 
@@ -405,8 +570,9 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 			break;
 		}
 		if (i != LIST_AND_CHOOSE_ERROR) {
-			command_t command = commands.items[i].util;
-			res = command(&s, ps, &files, &opts);
+			struct command_item *util =
+				commands.items.items[i].util;
+			res = util->command(&s, ps, &files, &opts);
 		}
 	}
 
@@ -415,7 +581,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 	strbuf_release(&print_file_item_data.index);
 	strbuf_release(&print_file_item_data.worktree);
 	strbuf_release(&header);
-	string_list_clear(&commands, 0);
+	prefix_item_list_clear(&commands);
 
 	return res;
 }
-- 
gitgitgadget

