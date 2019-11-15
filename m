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
	by dcvr.yhbt.net (Postfix) with ESMTP id D0F5F1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 11:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfKOLLa (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 06:11:30 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45903 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfKOLL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 06:11:29 -0500
Received: by mail-wr1-f65.google.com with SMTP id z10so10508282wrs.12
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 03:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9vhLL38fN5NhY5cSdFlnqGT7ywXcpNhkfvqXuW2GOfQ=;
        b=okC0Cf0Umcm0hQrqPqLl5Jmbbtmf4vjw4k+cfSMCSiVnyRlj7LitiC+o7BH/RV1gIg
         rBhGj1aadBkyqaQgHspqYrcykAc68y2QqhJhc+KRl9EJIlwrQMhdwryXEL7M6JdVzMbv
         QVPl4Ydy5gL+KZxtMxzFP5MEWpPtot8DI0ceqHUv+T6005ETqby0K4VbFrPz0ltik5MV
         pLzieF83jxYlmX4ZH11w16KRvEOtgS+6+c+KgCQuXO6Uy+wFSz20mHaOqpk3bxSPOhzv
         5/afM/95/8kO4L5/UnkWlTZFGEBmhRwiGy/+Qp5dcwcEd4cQxJNoOrtp9OeSj1uVhVFa
         VA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9vhLL38fN5NhY5cSdFlnqGT7ywXcpNhkfvqXuW2GOfQ=;
        b=Y+tHaAS+ft59e2eQUMZzpJ/kIqTnHZGFrniHRVhskHudLuyVYY3AehiLN8q5YUT6+J
         VchzIH+iwvGyyjGYHsqWFANw36qpWzSQbfL6F13RfM0qRv17X8k5GKODT/ndJflwxQdK
         /LFnPim/Cn7eK46/dE1WkHHZY0bVLQtGHWHbSBtsU0jZWSrHcf5HESBQO6qn2OL1DhBb
         j9Mcha2/mnfDEsvltJsVwjgP4Qi2Xp2UfLbtYf4VC8ouGn80+9v4nR1MmD+PmJ8HfDwA
         0dvDlKRIGWOk5ADrDu7HcvqN0FzrWSGvEsKy021yraLgMkz9oSq4HbPFgqx0InNLwWCq
         bZqw==
X-Gm-Message-State: APjAAAW+cRc0hlHsHU3jzPNbyxk3eoNVadjelMBiV3FLCRtVk6+RXzUp
        3BXvYC0EOG0ZSHP37QwDNle2PorQ
X-Google-Smtp-Source: APXvYqxeHRVN2Z+k6d5yA8qqSXTiJsx74/ETJTiWZOwcio2bnTbrCYAbleq08AF/39zURx//DJWl0g==
X-Received: by 2002:adf:97dd:: with SMTP id t29mr622809wrb.283.1573816285969;
        Fri, 15 Nov 2019 03:11:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w13sm10540642wrm.8.2019.11.15.03.11.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 03:11:25 -0800 (PST)
Message-Id: <601c37108930afe48e25290f6e54b660a25faaf1.1573816280.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v7.git.1573816280.gitgitgadget@gmail.com>
References: <pull.170.v6.git.1573648866.gitgitgadget@gmail.com>
        <pull.170.v7.git.1573816280.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Nov 2019 11:11:16 +0000
Subject: [PATCH v7 5/9] built-in add -i: implement the main loop
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Jeff Hostetler <git@jeffhostetler.com>, Jeff King" <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The reason why we did not start with the main loop to begin with is that
it is the first user of `list_and_choose()`, which uses the `list()`
function that we conveniently introduced for use by the `status`
command.

In contrast to the Perl version, in the built-in interactive `add`, we
will keep the `list()` function (which only displays items) and the
`list_and_choose()` function (which uses `list()` to display the items,
and only takes care of the "and choose" part) separate.

The `list_and_choose()` function, as implemented in
`git-add--interactive.perl` knows a few more tricks than the function we
introduce in this patch:

- There is a flag to let the user select multiple items.

- In multi-select mode, the list of items is prefixed with a marker
  indicating what items have been selected.

- Initially, for each item a unique prefix is determined (if there
  exists any within the given parameters), and shown in the list, and
  accepted as a shortcut for the selection.

These features will be implemented in the C version later.

This patch does not add any new main loop command, of course, the
built-in `git add -i` still only supports the `status` command. The
remaining commands to follow over the course of the next commits.

To accommodate for listing the commands in columns, preparing for the
commands that will be implemented over the course of the next
patches/patch series, we teach the `list()` function to do precisely
that.

Note that we only have a prompt ending in a single ">" at this stage;
later commits will add commands that display a double ">>" to indicate
that the user is in a different loop than the main one.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 137 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 135 insertions(+), 2 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 174e07ce83..76d9824de0 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -46,6 +46,7 @@ static void init_add_i_state(struct add_i_state *s, struct repository *r)
 }
 
 struct list_options {
+	int columns;
 	const char *header;
 	void (*print_item)(int i, struct string_list_item *item, void *print_item_data);
 	void *print_item_data;
@@ -54,7 +55,7 @@ struct list_options {
 static void list(struct add_i_state *s, struct string_list *list,
 		 struct list_options *opts)
 {
-	int i;
+	int i, last_lf = 0;
 
 	if (!list->nr)
 		return;
@@ -65,8 +66,98 @@ static void list(struct add_i_state *s, struct string_list *list,
 
 	for (i = 0; i < list->nr; i++) {
 		opts->print_item(i, list->items + i, opts->print_item_data);
+
+		if ((opts->columns) && ((i + 1) % (opts->columns))) {
+			putchar('\t');
+			last_lf = 0;
+		}
+		else {
+			putchar('\n');
+			last_lf = 1;
+		}
+	}
+
+	if (!last_lf)
 		putchar('\n');
+}
+struct list_and_choose_options {
+	struct list_options list_opts;
+
+	const char *prompt;
+};
+
+#define LIST_AND_CHOOSE_ERROR (-1)
+#define LIST_AND_CHOOSE_QUIT  (-2)
+
+/*
+ * Returns the selected index.
+ *
+ * If an error occurred, returns `LIST_AND_CHOOSE_ERROR`. Upon EOF,
+ * `LIST_AND_CHOOSE_QUIT` is returned.
+ */
+static ssize_t list_and_choose(struct add_i_state *s, struct string_list *items,
+			       struct list_and_choose_options *opts)
+{
+	struct strbuf input = STRBUF_INIT;
+	ssize_t res = LIST_AND_CHOOSE_ERROR;
+
+	for (;;) {
+		char *p;
+
+		strbuf_reset(&input);
+
+		list(s, items, &opts->list_opts);
+
+		printf("%s%s", opts->prompt, "> ");
+		fflush(stdout);
+
+		if (strbuf_getline(&input, stdin) == EOF) {
+			putchar('\n');
+			res = LIST_AND_CHOOSE_QUIT;
+			break;
+		}
+		strbuf_trim(&input);
+
+		if (!input.len)
+			break;
+
+		p = input.buf;
+		for (;;) {
+			size_t sep = strcspn(p, " \t\r\n,");
+			ssize_t index = -1;
+
+			if (!sep) {
+				if (!*p)
+					break;
+				p++;
+				continue;
+			}
+
+			if (isdigit(*p)) {
+				char *endp;
+				index = strtoul(p, &endp, 10) - 1;
+				if (endp != p + sep)
+					index = -1;
+			}
+
+			if (p[sep])
+				p[sep++] = '\0';
+			if (index < 0 || index >= items->nr)
+				printf(_("Huh (%s)?\n"), p);
+			else {
+				res = index;
+				break;
+			}
+
+			p += sep;
+		}
+
+		if (res != LIST_AND_CHOOSE_ERROR)
+			break;
 	}
+
+	strbuf_release(&input);
+	return res;
 }
 
 struct adddel {
@@ -252,20 +343,48 @@ static int run_status(struct add_i_state *s, const struct pathspec *ps,
 	return 0;
 }
 
+typedef int (*command_t)(struct add_i_state *s, const struct pathspec *ps,
+			 struct string_list *files,
+			 struct list_options *opts);
+
+static void print_command_item(int i, struct string_list_item *item,
+			       void *print_command_item_data)
+{
+	printf(" %2d: %s", i + 1, item->string);
+}
+
 int run_add_i(struct repository *r, const struct pathspec *ps)
 {
 	struct add_i_state s = { NULL };
+	struct list_and_choose_options main_loop_opts = {
+		{ 4, N_("*** Commands ***"), print_command_item, NULL },
+		N_("What now")
+	};
+	struct {
+		const char *string;
+		command_t command;
+	} command_list[] = {
+		{ "status", run_status },
+	};
+	struct string_list commands = STRING_LIST_INIT_NODUP;
+
 	struct print_file_item_data print_file_item_data = {
 		"%12s %12s %s", STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
 	};
 	struct list_options opts = {
-		NULL, print_file_item, &print_file_item_data
+		0, NULL, print_file_item, &print_file_item_data
 	};
 	struct strbuf header = STRBUF_INIT;
 	struct string_list files = STRING_LIST_INIT_DUP;
+	ssize_t i;
 	int res = 0;
 
+	for (i = 0; i < ARRAY_SIZE(command_list); i++)
+		string_list_append(&commands, command_list[i].string)
+			->util = command_list[i].command;
+
 	init_add_i_state(&s, r);
+
 	strbuf_addstr(&header, "      ");
 	strbuf_addf(&header, print_file_item_data.modified_fmt,
 		    _("staged"), _("unstaged"), _("path"));
@@ -279,11 +398,25 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 
 	res = run_status(&s, ps, &files, &opts);
 
+	for (;;) {
+		i = list_and_choose(&s, &commands, &main_loop_opts);
+		if (i == LIST_AND_CHOOSE_QUIT) {
+			printf(_("Bye.\n"));
+			res = 0;
+			break;
+		}
+		if (i != LIST_AND_CHOOSE_ERROR) {
+			command_t command = commands.items[i].util;
+			res = command(&s, ps, &files, &opts);
+		}
+	}
+
 	string_list_clear(&files, 1);
 	strbuf_release(&print_file_item_data.buf);
 	strbuf_release(&print_file_item_data.index);
 	strbuf_release(&print_file_item_data.worktree);
 	strbuf_release(&header);
+	string_list_clear(&commands, 0);
 
 	return res;
 }
-- 
gitgitgadget

