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
	by dcvr.yhbt.net (Postfix) with ESMTP id AABA51F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 12:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfKOMg3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 07:36:29 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37322 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbfKOMg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 07:36:28 -0500
Received: by mail-wr1-f65.google.com with SMTP id t1so10826925wrv.4
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 04:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XPb3MLdgwnEvsfcxAQOGY8ntP8rXuAYYjibPqJjc+u0=;
        b=GCH5qui2Qrrvtx8fJCmMfbWcijmnuv7dWjnN0ZMIMRgtGgLyH1c/dm5PYctZ5p4tSt
         6l3J1QpUup3TUsxeI+53t+UN/QPxdrIyJ0nJ6ivRbyVKIAss1D4FIgztDgeUG7u3qDsh
         scdsGHKqbRfQuIdoWkCBk8BoLmXkXFeyb3tvzgPqYvqY6Jd5Hp4VPSt26ZdLC7PefsoL
         OUnP+dVh4yXU4fyQ83qzxWbhTuwFUuYXpdLZwvPA4QKhB2/2UM/CTjUcAK1zKQSCuNv0
         3DY1/LEucX+qXMT+VAAFotd6B9XlfEv6D1qClQRjxxXmW4F0RIXKPmlNWeRgoc/lNzxN
         U5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XPb3MLdgwnEvsfcxAQOGY8ntP8rXuAYYjibPqJjc+u0=;
        b=ddsLPg8JxQaI3jluo7Q+V6uO8+PMUC1NOBXmJGTaBS8kD2xLVadxxzN7B0/MEOBn7O
         KqNA3mS6oFikUFOoMmwK1DEMoP5sRmHMEBSwb+bOiu0VLJQoUuSeA/c3CPFWsnCezpIu
         JOHYxPduodZb3YVoIwi3wpMXhpkbeGNqEpRi1elI3MEg2LBgTGu0T1akAAmY/0weZVUa
         Z+Up9z++y1Sk/IIdZCQ4BcQ0ozSkQFfqW3u4ucdtcdXTvU0pzkG7lPxbayyj5U0MZp2g
         lVftVk/6rcnRwOe2pQOp5sQd4+wTZjlTrApv5CcQT0I2KcXPZ3bNRN4MhUWfdE207N86
         Q4IA==
X-Gm-Message-State: APjAAAWMyw3KMkvtm3qd3weAh7uuRfOySMkGgcQIYCO2WgDkvGFYfAPf
        PNnqU3yYDG/12w1b8o3+0FVJgng+
X-Google-Smtp-Source: APXvYqxFhqFHs99dDDxBPqqiYrMnmnhAuCtF3rnbe8opQNY4o27/cPfEoc14PyXH9OjkHRTcLLL9YA==
X-Received: by 2002:a5d:5411:: with SMTP id g17mr14634887wrv.360.1573821384946;
        Fri, 15 Nov 2019 04:36:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z14sm10959630wrl.60.2019.11.15.04.36.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 04:36:24 -0800 (PST)
Message-Id: <c324b47592dca2cd4967d62d2520a35bfcf04bae.1573821382.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.171.git.1573821382.gitgitgadget@gmail.com>
References: <pull.171.git.1573821382.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Nov 2019 12:36:16 +0000
Subject: [PATCH 2/8] built-in add -i: prepare for multi-selection commands
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `upgrade`, `revert` and `add-untracked` commands allow selecting
multiple entries. Let's extend the `list_and_choose()` function to
accommodate those use cases.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 114 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 89 insertions(+), 25 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 8ec930ac15..33a751150a 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -72,15 +72,17 @@ static void init_add_i_state(struct add_i_state *s, struct repository *r)
 struct prefix_item_list {
 	struct string_list items;
 	struct string_list sorted;
+	int *selected; /* for multi-selections */
 	size_t min_length, max_length;
 };
 #define PREFIX_ITEM_LIST_INIT \
-	{ STRING_LIST_INIT_DUP, STRING_LIST_INIT_NODUP, 1, 4 }
+	{ STRING_LIST_INIT_DUP, STRING_LIST_INIT_NODUP, NULL, 1, 4 }
 
 static void prefix_item_list_clear(struct prefix_item_list *list)
 {
 	string_list_clear(&list->items, 1);
 	string_list_clear(&list->sorted, 0);
+	FREE_AND_NULL(list->selected);
 }
 
 static void extend_prefix_length(struct string_list_item *p,
@@ -182,11 +184,12 @@ static ssize_t find_unique(const char *string, struct prefix_item_list *list)
 struct list_options {
 	int columns;
 	const char *header;
-	void (*print_item)(int i, struct string_list_item *item, void *print_item_data);
+	void (*print_item)(int i, int selected, struct string_list_item *item,
+			   void *print_item_data);
 	void *print_item_data;
 };
 
-static void list(struct add_i_state *s, struct string_list *list,
+static void list(struct add_i_state *s, struct string_list *list, int *selected,
 		 struct list_options *opts)
 {
 	int i, last_lf = 0;
@@ -199,7 +202,8 @@ static void list(struct add_i_state *s, struct string_list *list,
 				 "%s", opts->header);
 
 	for (i = 0; i < list->nr; i++) {
-		opts->print_item(i, list->items + i, opts->print_item_data);
+		opts->print_item(i, selected ? selected[i] : 0, list->items + i,
+				 opts->print_item_data);
 
 		if ((opts->columns) && ((i + 1) % (opts->columns))) {
 			putchar('\t');
@@ -218,6 +222,10 @@ struct list_and_choose_options {
 	struct list_options list_opts;
 
 	const char *prompt;
+	enum {
+		SINGLETON = (1<<0),
+		IMMEDIATE = (1<<1),
+	} flags;
 	void (*print_help)(struct add_i_state *s);
 };
 
@@ -225,7 +233,8 @@ struct list_and_choose_options {
 #define LIST_AND_CHOOSE_QUIT  (-2)
 
 /*
- * Returns the selected index.
+ * Returns the selected index in singleton mode, the number of selected items
+ * otherwise.
  *
  * If an error occurred, returns `LIST_AND_CHOOSE_ERROR`. Upon EOF,
  * `LIST_AND_CHOOSE_QUIT` is returned.
@@ -234,8 +243,19 @@ static ssize_t list_and_choose(struct add_i_state *s,
 			       struct prefix_item_list *items,
 			       struct list_and_choose_options *opts)
 {
+	int singleton = opts->flags & SINGLETON;
+	int immediate = opts->flags & IMMEDIATE;
+
 	struct strbuf input = STRBUF_INIT;
-	ssize_t res = LIST_AND_CHOOSE_ERROR;
+	ssize_t res = singleton ? LIST_AND_CHOOSE_ERROR : 0;
+
+	if (!singleton) {
+		free(items->selected);
+		CALLOC_ARRAY(items->selected, items->items.nr);
+	}
+
+	if (singleton && !immediate)
+		BUG("singleton requires immediate");
 
 	find_unique_prefixes(items);
 
@@ -244,15 +264,16 @@ static ssize_t list_and_choose(struct add_i_state *s,
 
 		strbuf_reset(&input);
 
-		list(s, &items->items, &opts->list_opts);
+		list(s, &items->items, items->selected, &opts->list_opts);
 
 		color_fprintf(stdout, s->prompt_color, "%s", opts->prompt);
-		fputs("> ", stdout);
+		fputs(singleton ? "> " : ">> ", stdout);
 		fflush(stdout);
 
 		if (strbuf_getline(&input, stdin) == EOF) {
 			putchar('\n');
-			res = LIST_AND_CHOOSE_QUIT;
+			if (immediate)
+				res = LIST_AND_CHOOSE_QUIT;
 			break;
 		}
 		strbuf_trim(&input);
@@ -268,7 +289,9 @@ static ssize_t list_and_choose(struct add_i_state *s,
 		p = input.buf;
 		for (;;) {
 			size_t sep = strcspn(p, " \t\r\n,");
-			ssize_t index = -1;
+			int choose = 1;
+			/* `from` is inclusive, `to` is exclusive */
+			ssize_t from = -1, to = -1;
 
 			if (!sep) {
 				if (!*p)
@@ -277,29 +300,69 @@ static ssize_t list_and_choose(struct add_i_state *s,
 				continue;
 			}
 
-			if (isdigit(*p)) {
+			/* Input that begins with '-'; de-select */
+			if (*p == '-') {
+				choose = 0;
+				p++;
+				sep--;
+			}
+
+			if (sep == 1 && *p == '*') {
+				from = 0;
+				to = items->items.nr;
+			} else if (isdigit(*p)) {
 				char *endp;
-				index = strtoul(p, &endp, 10) - 1;
-				if (endp != p + sep)
-					index = -1;
+				/*
+				 * A range can be specified like 5-7 or 5-.
+				 *
+				 * Note: `from` is 0-based while the user input
+				 * is 1-based, hence we have to decrement by
+				 * one. We do not have to decrement `to` even
+				 * if it is 0-based because it is an exclusive
+				 * boundary.
+				 */
+				from = strtoul(p, &endp, 10) - 1;
+				if (endp == p + sep)
+					to = from + 1;
+				else if (*endp == '-') {
+					to = strtoul(++endp, &endp, 10);
+					/* extra characters after the range? */
+					if (endp != p + sep)
+						from = -1;
+				}
 			}
 
 			p[sep] = '\0';
-			if (index < 0)
-				index = find_unique(p, items);
+			if (from < 0) {
+				from = find_unique(p, items);
+				if (from >= 0)
+					to = from + 1;
+			}
 
-			if (index < 0 || index >= items->items.nr)
+			if (from < 0 || from >= items->items.nr ||
+			    (singleton && from + 1 != to)) {
 				color_fprintf_ln(stdout, s->error_color,
 						 _("Huh (%s)?"), p);
-			else {
-				res = index;
+				break;
+			} else if (singleton) {
+				res = from;
 				break;
 			}
 
+			if (to > items->items.nr)
+				to = items->items.nr;
+
+			for (; from < to; from++)
+				if (items->selected[from] != choose) {
+					items->selected[from] = choose;
+					res += choose ? +1 : -1;
+				}
+
 			p += sep + 1;
 		}
 
-		if (res != LIST_AND_CHOOSE_ERROR)
+		if ((immediate && res != LIST_AND_CHOOSE_ERROR) ||
+		    !strcmp(input.buf, "*"))
 			break;
 	}
 
@@ -496,7 +559,7 @@ struct print_file_item_data {
 	struct strbuf buf, index, worktree;
 };
 
-static void print_file_item(int i, struct string_list_item *item,
+static void print_file_item(int i, int selected, struct string_list_item *item,
 			    void *print_file_item_data)
 {
 	struct file_item *c = item->util;
@@ -511,7 +574,7 @@ static void print_file_item(int i, struct string_list_item *item,
 	strbuf_addf(&d->buf, d->modified_fmt,
 		    d->index.buf, d->worktree.buf, item->string);
 
-	printf(" %2d: %s", i + 1, d->buf.buf);
+	printf("%c%2d: %s", selected ? '*' : ' ', i + 1, d->buf.buf);
 }
 
 static int run_status(struct add_i_state *s, const struct pathspec *ps,
@@ -520,7 +583,7 @@ static int run_status(struct add_i_state *s, const struct pathspec *ps,
 	if (get_modified_files(s->r, NO_FILTER, files, ps) < 0)
 		return -1;
 
-	list(s, files, opts);
+	list(s, files, NULL, opts);
 	putchar('\n');
 
 	return 0;
@@ -559,7 +622,8 @@ struct print_command_item_data {
 	const char *color, *reset;
 };
 
-static void print_command_item(int i, struct string_list_item *item,
+static void print_command_item(int i, int selected,
+			       struct string_list_item *item,
 			       void *print_command_item_data)
 {
 	struct print_command_item_data *d = print_command_item_data;
@@ -592,7 +656,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 	struct print_command_item_data data = { "[", "]" };
 	struct list_and_choose_options main_loop_opts = {
 		{ 4, N_("*** Commands ***"), print_command_item, &data },
-		N_("What now"), command_prompt_help
+		N_("What now"), SINGLETON | IMMEDIATE, command_prompt_help
 	};
 	struct {
 		const char *string;
-- 
gitgitgadget

