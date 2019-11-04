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
	by dcvr.yhbt.net (Postfix) with ESMTP id B6E6E1F454
	for <e@80x24.org>; Mon,  4 Nov 2019 12:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfKDMPo (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 07:15:44 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50384 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfKDMPk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 07:15:40 -0500
Received: by mail-wm1-f67.google.com with SMTP id 11so16435708wmk.0
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 04:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=kSYfCLCAHtsmzDNlIaADdzszo1MkBEkH9vO4RVbgBCE=;
        b=oSly33u8wdG13+LXS6ijRy8sFJ0l9nuofZtWw7vhJn5a81SDMha3AbyIOUrw1svX53
         tPWa+UagNszrz2Q/8TM9fe1A1NPz0P8Ef1PCVf4q3YBP+XntJCiS0lvH3nlhzfFOV4H3
         dyAIMLaDm2shD8FycG5as6xWsy8ey6JQ5YoWKyHPL/6WBgJxB4w9McK7mIN6lH1PIVUX
         xHLURdYUS4n2qB0/EtzmLrGI6R3wA5lCT3EDFetO9Sqt7/wxjWUrnHUamADJATpV3weF
         8i49V6WgNHSQJoin1jbu4BdeL6CxwZk9z6D65UI1rZbwX2zjrpI39CmoPUfpvYgzwglV
         NUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=kSYfCLCAHtsmzDNlIaADdzszo1MkBEkH9vO4RVbgBCE=;
        b=V2GI2Qv6TiAvcPxirAylHCO7NA0SOc81hDprGK8xnSYkkN6mL/ugFv4MN5y2ZlpN7u
         wUahVcX0nofsqTs4qyljT1Nn9ZaS8vp96oie2yGQXjVdRyPn7LV6M1t9MbdHDxsVPuqx
         jtssHrtW+x+VduZf5XOqbyPgDQmLvtrQBY4/hF/3PoInaqiBQnaKfTERCoaACNPvTqIn
         sFqDCLCa9KsHBQcYXeoAPIQO93MlB6vMKJFiHsODuwrWeM+WoU5fReBRDeE/w4/DUP9H
         QQBB8rMl9SiUpQF0S30N0geKLJpH4FcKGnhry47qYJbfflOF6YKlJTrIZ16kvWUUVHGA
         gkoA==
X-Gm-Message-State: APjAAAVkhPMgeJ0wdTs9CXDbSObBnhYCH9T+BLXe9+i+Q7+9vQZ7MH18
        rRv5stXqe+ay/ZUaqZn5YUoCDgH2
X-Google-Smtp-Source: APXvYqweKhsER+DzsCOm78YChdVx7uXyhD5lPT4LFfZ6pSoR40ztng+N6sQPiZfkImAKIJBCKte5TQ==
X-Received: by 2002:a1c:2e09:: with SMTP id u9mr21546269wmu.108.1572869737017;
        Mon, 04 Nov 2019 04:15:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n13sm9426180wmi.25.2019.11.04.04.15.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 04:15:36 -0800 (PST)
Message-Id: <57fdc01463b5fe1637dcfa4b027bde8e99f7fe86.1572869730.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v5.git.1572869729.gitgitgadget@gmail.com>
References: <pull.170.v4.git.gitgitgadget@gmail.com>
        <pull.170.v5.git.1572869729.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Nov 2019 12:15:26 +0000
Subject: [PATCH v5 6/9] built-in add -i: show unique prefixes of the commands
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
index c6f7fbad36..eb559555ad 100644
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
 		char *p, *endp;
 
 		strbuf_reset(&input);
 
-		list(s, items, &opts->list_opts);
+		list(s, &items->items, &opts->list_opts);
 
 		printf("%s%s", opts->prompt, "> ");
 		fflush(stdout);
@@ -140,7 +269,10 @@ static ssize_t list_and_choose(struct add_i_state *s, struct string_list *items,
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
@@ -306,6 +438,23 @@ static void render_adddel(struct strbuf *buf,
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
@@ -345,10 +494,23 @@ typedef int (*command_t)(struct add_i_state *s, const struct pathspec *ps,
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
@@ -364,7 +526,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 	} command_list[] = {
 		{ "status", run_status },
 	};
-	struct string_list commands = STRING_LIST_INIT_NODUP;
+	struct prefix_item_list commands = PREFIX_ITEM_LIST_INIT;
 
 	struct print_file_item_data print_file_item_data = {
 		"%12s %12s %s", STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
@@ -377,9 +539,12 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
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
 
@@ -404,8 +569,9 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
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
 
@@ -414,7 +580,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 	strbuf_release(&print_file_item_data.index);
 	strbuf_release(&print_file_item_data.worktree);
 	strbuf_release(&header);
-	string_list_clear(&commands, 0);
+	prefix_item_list_clear(&commands);
 
 	return res;
 }
-- 
gitgitgadget

