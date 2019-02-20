Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B02B1F453
	for <e@80x24.org>; Wed, 20 Feb 2019 11:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfBTLlo (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 06:41:44 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43673 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbfBTLlh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 06:41:37 -0500
Received: by mail-ed1-f66.google.com with SMTP id m35so15610754ede.10
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 03:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nczJPIas/3pbNcntoe1Br8TbUEn1nzvP/oLdJIb7WxE=;
        b=WKzXN/b8RkiAjs6oyHv//ylWBArV6nAkOwUNtbVac+GYlpDBAu1szcXIXmpHGocLWh
         Bb9ugw9pqPjz69uGEDkBcAgFCyCq07FewYxP4fz/JsNfgHFvDWtYjS8sazeF2ZySrz51
         fwI/8+YcHoU8OhC46ewhe7MlmWjsB0DIDlq/4TTFjxad0rkoSKmxMIvcdJ5RlPpfK+nR
         0vOXYPzn4C0E2kdeVlR3GElrG7XX3O7zQDc8K/e0EUQ0mJ7HhdbyEWNg3UAO1uqBz2Nv
         aj2TxVMTzeZGaS8J+HBDsGyA4uZ19GgPHIggIw7F1OJ1ibifhocFtEBKouo+si2Zhiec
         Bduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nczJPIas/3pbNcntoe1Br8TbUEn1nzvP/oLdJIb7WxE=;
        b=sJHgAoQWXG9VPo9hd1abcvF5YvXB0wugtuhg+jhjI2oTQ7T0L5kgZkXHoDfzXeo8ee
         Cvc8Lv/dgl9JEmTTpkVqXTH8gO+PIDDLscraRCfhzEO88LlGkeerzy+SgbeeGoGB3P8t
         sxgR168Bu8ZJUrhESO9eWIU7E6tvLynPGi9Sco1ysRPFJuQyYt+WhgKBORKjiEyC5o3u
         R9RUUY6VwD5+8molppM+wPckX7+/IevWreZ17so0qKwTYHy+AwG5Th3N9y5Kg61xeQMy
         6J4GdrqmyTDtI15uWn5AO0MO8vqlHwBtUq8G+9eNlD+AdwfaOdJVhcdRWb2iLysAV311
         E0SQ==
X-Gm-Message-State: AHQUAuZF2Gl4OejxG8+20eCb67s5wpc82oujkdvl72Eq+RTAhdhvLGEq
        b8leydG2iJln6zfoYn6bpIqjfumD
X-Google-Smtp-Source: AHgI3IY5kIyxNxTKHLnclGb70PIjCnOJEnz4YD0NIIJiCpQtrDy3hiesq6mYNIXvk14FN0bgbqC45w==
X-Received: by 2002:a50:d9c1:: with SMTP id x1mr27044983edj.276.1550662894141;
        Wed, 20 Feb 2019 03:41:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay21sm2758519ejb.0.2019.02.20.03.41.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 03:41:33 -0800 (PST)
Date:   Wed, 20 Feb 2019 03:41:33 -0800 (PST)
X-Google-Original-Date: Wed, 20 Feb 2019 11:41:24 GMT
Message-Id: <7912f375170ca266a4ce0f9f755f8d8fecdf3d37.1550662887.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.v5.git.gitgitgadget@gmail.com>
References: <pull.103.v4.git.gitgitgadget@gmail.com>
        <pull.103.v5.git.gitgitgadget@gmail.com>
From:   "Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 07/10] add-interactive.c: add support for list_only option
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

If list_only option is not set, (i.e. we want to pick elements
from the list, not just display them), highlight unique prefixes
of list elements and let user make a choice as shown in
prompt_help_cmd and singleton_prompt_help_cmd.

Input that is expected from user is full line.
Although that's also the case with Perl script in this
particular situation, there is also sub prompt_single_character,
which deals with single keystroke.

Ever since f7a4cea25e3ee1c8f27777bc4293dca0210fa573,
we did not use _getch() in our code base's C code, and this would
be the first user. There are portability issues with _getch()
(or getch()) that we would like to avoid.
That said, from now on, every other input will also be expected
to be full line, rather than single keystroke.

Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
---
 add-interactive.c | 378 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 373 insertions(+), 5 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 6bf8a90d9d..3c2e972413 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -70,18 +70,27 @@ struct choices {
 };
 #define CHOICES_INIT { NULL, 0, 0 }
 
+struct prefix_entry {
+	struct hashmap_entry e;
+	const char *name;
+	size_t prefix_length;
+	struct choice *item;
+};
+
 static int use_color = -1;
 enum color_add_i {
 	COLOR_PROMPT,
 	COLOR_HEADER,
 	COLOR_HELP,
-	COLOR_ERROR
+	COLOR_ERROR,
+	COLOR_RESET
 };
 
 static char colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_BOLD_BLUE, /* Prompt */
 	GIT_COLOR_BOLD,      /* Header */
 	GIT_COLOR_BOLD_RED,  /* Help */
+	GIT_COLOR_BOLD_RED,  /* Error */
 	GIT_COLOR_RESET      /* Reset */
 };
 
@@ -102,6 +111,8 @@ static int parse_color_slot(const char *slot)
 		return COLOR_HELP;
 	if (!strcasecmp(slot, "error"))
 		return COLOR_ERROR;
+	if (!strcasecmp(slot, "reset"))
+		return COLOR_RESET;
 
 	return -1;
 }
@@ -288,14 +299,248 @@ static struct collection_status *list_modified(struct repository *r, const char
 	return s;
 }
 
+static int map_cmp(const void *unused_cmp_data,
+		   const void *entry,
+		   const void *entry_or_key,
+		   const void *unused_keydata)
+{
+	const struct choice *a = entry;
+	const struct choice *b = entry_or_key;
+	if((a->prefix_length == b->prefix_length) &&
+	  (strncmp(a->name, b->name, a->prefix_length) == 0))
+		return 0;
+	return 1;
+}
+
+static struct prefix_entry *new_prefix_entry(const char *name,
+					     size_t prefix_length,
+					     struct choice *item)
+{
+	struct prefix_entry *result = xcalloc(1, sizeof(*result));
+	result->name = name;
+	result->prefix_length = prefix_length;
+	result->item = item;
+	hashmap_entry_init(result, memhash(name, prefix_length));
+	return result;
+}
+
+static void find_unique_prefixes(struct choices *data)
+{
+	int soft_limit = 0;
+	int hard_limit = 4;
+	struct hashmap map;
+
+	hashmap_init(&map, map_cmp, NULL, 0);
+
+	for (int i = 0; i < data->nr; i++) {
+		struct prefix_entry *e = xcalloc(1, sizeof(*e));
+		struct prefix_entry *e2;
+		e->name = data->choices[i]->name;
+		e->item = data->choices[i];
+
+		for (int j = soft_limit + 1; j <= hard_limit; j++) {
+			if (!isascii(e->name[j]))
+				break;
+
+			e->prefix_length = j;
+			hashmap_entry_init(e, memhash(e->name, j));
+			e2 = hashmap_get(&map, e, NULL);
+			if (!e2) {
+				e->item->prefix_length = j;
+				hashmap_add(&map, e);
+				e = NULL;
+				break;
+			}
+
+			if (!e2->item) {
+				continue; /* non-unique prefix */
+			}
+
+			if (j != e2->item->prefix_length)
+				BUG("Hashmap entry has unexpected prefix length (%"PRIuMAX"/ != %"PRIuMAX"/)",
+				   (uintmax_t)j, (uintmax_t)e2->item->prefix_length);
+
+			/* skip common prefix */
+			for (j++; j <= hard_limit && e->name[j - 1]; j++) {
+				if (e->item->name[j - 1] != e2->item->name[j - 1])
+					break;
+				hashmap_add(&map, new_prefix_entry(e->name, j, NULL));
+			}
+			if (j <= hard_limit && e2->name[j - 1]) {
+				e2->item->prefix_length = j;
+				hashmap_add(&map, new_prefix_entry(e2->name, j, e2->item));
+			}
+			else {
+				e2->item->prefix_length = 0;
+			}
+			e2->item = NULL;
+
+			if (j <= hard_limit && e->name[j - 1]) {
+				e->item->prefix_length = j;
+				hashmap_add(&map, new_prefix_entry(e->name,
+								   e->item->prefix_length, e->item));
+				e = NULL;
+			}
+			else
+				e->item->prefix_length = 0;
+			break;
+		}
+
+		free(e);
+	}
+}
+
+static int find_unique(char *string, struct choices *data)
+{
+	int found = 0;
+	int i = 0;
+	int hit = 0;
+
+	for (i = 0; i < data->nr; i++) {
+		struct choice *item = data->choices[i];
+		hit = 0;
+		if (!strcmp(item->name, string))
+			hit = 1;
+		if (hit && found)
+			return 0;
+		if (hit)
+			found = i + 1;
+	}
+
+	return found;
+}
+
+/* filters out prefixes which have special meaning to list_and_choose() */
+static int is_valid_prefix(const char *prefix)
+{
+	regex_t *regex;
+	const char *pattern = "(\\s,)|(^-)|(^[0-9]+)";
+	int is_valid = 0;
+
+	regex = xmalloc(sizeof(*regex));
+	if (regcomp(regex, pattern, REG_EXTENDED))
+		return 0;
+
+	is_valid = prefix &&
+		   regexec(regex, prefix, 0, NULL, 0) &&
+		   strcmp(prefix, "*") &&
+		   strcmp(prefix, "?");
+	free(regex);
+	return is_valid;
+}
+
+/* return a string with the prefix highlighted */
+/* for now use square brackets; later might use ANSI colors (underline, bold) */
+static char *highlight_prefix(struct choice *item)
+{
+	struct strbuf buf;
+	struct strbuf prefix;
+	struct strbuf remainder;
+	const char *prompt_color = get_color(COLOR_PROMPT);
+	const char *reset_color = get_color(COLOR_RESET);
+	int remainder_size = strlen(item->name) - item->prefix_length;
+
+	strbuf_init(&buf, 0);
+
+	strbuf_init(&prefix, 0);
+	strbuf_add(&prefix, item->name, item->prefix_length);
+
+	strbuf_init(&remainder, 0);
+	strbuf_add(&remainder, item->name + item->prefix_length,
+		   remainder_size + 1);
+
+	if(!prefix.buf) {
+		strbuf_release(&buf);
+		strbuf_release(&prefix);
+		return remainder.buf;
+	}
+	
+	if (!is_valid_prefix(prefix.buf)) {
+		strbuf_addstr(&buf, prefix.buf);
+		strbuf_addstr(&buf, remainder.buf);
+	}
+	else if (!use_color) {
+		strbuf_addstr(&buf, "[");
+		strbuf_addstr(&buf, prefix.buf);
+		strbuf_addstr(&buf, "]");
+		strbuf_addstr(&buf, remainder.buf);
+	}
+	else {
+		strbuf_addstr(&buf, prompt_color);
+		strbuf_addstr(&buf, prefix.buf);
+		strbuf_addstr(&buf, reset_color);
+		strbuf_addstr(&buf, remainder.buf);
+	}
+
+	strbuf_release(&prefix);
+	strbuf_release(&remainder);
+
+	return buf.buf;
+}
+
+static void singleton_prompt_help_cmd(void)
+{
+	const char *help_color = get_color(COLOR_HELP);
+	color_fprintf_ln(stdout, help_color, "%s", _("Prompt help:"));
+	color_fprintf_ln(stdout, help_color, "1          - %s",
+			 _("select a numbered item"));
+	color_fprintf_ln(stdout, help_color, "foo        - %s",
+			 _("select item based on unique prefix"));
+	color_fprintf_ln(stdout, help_color, "           - %s",
+			 _("(empty) select nothing"));
+}
+
+static void prompt_help_cmd(void)
+{
+	const char *help_color = get_color(COLOR_HELP);
+	color_fprintf_ln(stdout, help_color, "%s",
+			 _("Prompt help:"));
+	color_fprintf_ln(stdout, help_color, "1          - %s",
+			 _("select a single item"));
+	color_fprintf_ln(stdout, help_color, "3-5        - %s",
+			 _("select a range of items"));
+	color_fprintf_ln(stdout, help_color, "2-3,6-9    - %s",
+			 _("select multiple ranges"));
+	color_fprintf_ln(stdout, help_color, "foo        - %s",
+			 _("select item based on unique prefix"));
+	color_fprintf_ln(stdout, help_color, "-...       - %s",
+			 _("unselect specified items"));
+	color_fprintf_ln(stdout, help_color, "*          - %s",
+			 _("choose all items"));
+	color_fprintf_ln(stdout, help_color, "           - %s",
+			 _("(empty) finish selecting"));
+}
+
 static struct choices *list_and_choose(struct choices *data,
 				       struct list_and_choose_options *opts)
 {
-	if (!data)
+	char *chosen_choices = xcalloc(data->nr, sizeof(char *));
+	struct choices *results = xcalloc(1, sizeof(*results));
+	int chosen_size = 0;
+
+	if (!data) {
+		free(chosen_choices);
+		free(results);
 		return NULL;
+	}
+	
+	if (!opts->list_only)
+		find_unique_prefixes(data);
 
+top:
 	while (1) {
 		int last_lf = 0;
+		const char *prompt_color = get_color(COLOR_PROMPT);
+		const char *error_color = get_color(COLOR_ERROR);
+		struct strbuf input = STRBUF_INIT;
+		struct strbuf choice;
+		struct strbuf token;
+		char *token_tmp;
+		regex_t *regex_dash_range;
+		regex_t *regex_number;
+		const char *pattern_dash_range;
+		const char *pattern_number;
+		const char delim[] = " ,";
 
 		if (opts->header) {
 			const char *header_color = get_color(COLOR_HEADER);
@@ -306,13 +551,17 @@ static struct choices *list_and_choose(struct choices *data,
 
 		for (int i = 0; i < data->nr; i++) {
 			struct choice *c = data->choices[i];
+			char chosen = chosen_choices[i]? '*' : ' ';
 			char *print;
 			const char *modified_fmt = _("%12s %12s %s");
 			char worktree_changes[50];
 			char index_changes[50];
 			char print_buf[100];
 
-			print = (char *)c->name;
+			if (!opts->list_only)
+				print = highlight_prefix(data->choices[i]);
+			else
+				print = (char *)c->name;
 			
 			if ((data->choices[i]->type == 'f') && (!opts->list_only_file_names)) {
 				uintmax_t worktree_added = c->u.file.worktree.added;
@@ -338,7 +587,7 @@ static struct choices *list_and_choose(struct choices *data,
 				snprintf(print, 100, "%s", print_buf);
 			}
 
-			printf(" %2d: %s", i + 1, print);
+			printf("%c%2d: %s", chosen, i + 1, print);
 
 			if ((opts->list_flat) && ((i + 1) % (opts->column_n))) {
 				printf("\t");
@@ -354,8 +603,126 @@ static struct choices *list_and_choose(struct choices *data,
 		if (!last_lf)
 			printf("\n");
 
-		return NULL;
+		if (opts->list_only)
+			return NULL;
+
+		color_fprintf(stdout, prompt_color, "%s", opts->prompt);
+		if(opts->singleton)
+			printf("> ");
+		else
+			printf(">> ");
+
+		fflush(stdout);
+		strbuf_getline(&input, stdin);
+		strbuf_trim(&input);
+
+		if (!input.buf)
+			break;
+		
+		if (!input.buf[0]) {
+			printf("\n");
+			if (opts->on_eof_fn)
+				opts->on_eof_fn();
+			break;
+		}
+
+		if (!strcmp(input.buf, "?")) {
+			opts->singleton? singleton_prompt_help_cmd() : prompt_help_cmd();
+			goto top;
+		}
+
+		token_tmp = strtok(input.buf, delim);
+		strbuf_init(&token, 0);
+		strbuf_add(&token, token_tmp, strlen(token_tmp));
+
+		while (1) {
+			int choose = 1;
+			int bottom = 0, top = 0;
+			strbuf_init(&choice, 0);
+			strbuf_addbuf(&choice, &token);
+
+			/* Input that begins with '-'; unchoose */
+			pattern_dash_range = "^-";
+			regex_dash_range = xmalloc(sizeof(*regex_dash_range));
+
+			if (regcomp(regex_dash_range, pattern_dash_range, REG_EXTENDED))
+				BUG("regex compilation for pattern %s failed",
+				   pattern_dash_range);
+			if (!regexec(regex_dash_range, choice.buf, 0, NULL, 0)) {
+				choose = 0;
+				/* remove dash from input */
+				strbuf_remove(&choice, 0, 1);
+			}
+
+			/* A range can be specified like 5-7 or 5-. */
+			pattern_dash_range = "^([0-9]+)-([0-9]*)$";
+			pattern_number = "^[0-9]+$";
+			regex_number = xmalloc(sizeof(*regex_number));
+
+			if (regcomp(regex_dash_range, pattern_dash_range, REG_EXTENDED))
+				BUG("regex compilation for pattern %s failed",
+				   pattern_dash_range);
+			if (regcomp(regex_number, pattern_number, REG_EXTENDED))
+				BUG("regex compilation for pattern %s failed", pattern_number);
+
+			if (!regexec(regex_dash_range, choice.buf, 0, NULL, 0)) {
+				const char delim_dash[] = "-";
+				char *num = NULL;
+				num = strtok(choice.buf, delim_dash);
+				bottom = atoi(num);
+				num = strtok(NULL, delim_dash);
+				top = num? atoi(num) : (1 + data->nr);
+			}
+			else if (!regexec(regex_number, choice.buf, 0, NULL, 0))
+				bottom = top = atoi(choice.buf);
+			else if (!strcmp(choice.buf, "*")) {
+				bottom = 1;
+				top = 1 + data->nr;
+			}
+			else {
+				bottom = top = find_unique(choice.buf, data);
+				if (!bottom) {
+					color_fprintf_ln(stdout, error_color, _("Huh (%s)?"), choice.buf);
+					goto top;
+				}
+			}
+
+			if (opts->singleton && bottom != top) {
+				color_fprintf_ln(stdout, error_color, _("Huh (%s)?"), choice.buf);
+				goto top;
+			}
+
+			for (int i = bottom - 1; i <= top - 1; i++) {
+				if (data->nr <= i || i < 0)
+					continue;
+				chosen_choices[i] = choose;
+				if (choose == 1)
+					chosen_size++;
+			}
+
+			strbuf_release(&token);
+			strbuf_release(&choice);
+
+			token_tmp = strtok(NULL, delim);
+			if (!token_tmp)
+				break;
+			strbuf_init(&token, 0);
+			strbuf_add(&token, token_tmp, strlen(token_tmp));
+		}
+
+		if ((opts->immediate) || !(strcmp(choice.buf, "*")))
+			break;
 	}
+
+	for (int i = 0; i < data->nr; i++) {
+		if (chosen_choices[i]) {
+			ALLOC_GROW(results->choices, results->nr + 1, results->alloc);
+			results->choices[results->nr++] = data->choices[i];
+		}
+	}
+
+	free(chosen_choices);
+	return results;
 }
 
 static struct choice *make_choice(const char *name )
@@ -412,6 +779,7 @@ void add_i_status(void)
 	const char *modified_fmt = _("%12s %12s %s");
 	const char type = 'f';
 
+	opts.list_only = 1;
 	opts.header = xmalloc(sizeof(char) * (HEADER_MAXLEN + 1));
 	snprintf(opts.header, HEADER_MAXLEN + 1, modified_fmt,
 		 _("staged"), _("unstaged"), _("path"));
-- 
gitgitgadget

