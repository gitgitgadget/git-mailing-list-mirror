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
	by dcvr.yhbt.net (Postfix) with ESMTP id A03941F454
	for <e@80x24.org>; Mon,  4 Nov 2019 12:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbfKDMPl (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 07:15:41 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46184 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbfKDMPj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 07:15:39 -0500
Received: by mail-wr1-f66.google.com with SMTP id b3so11022010wrs.13
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 04:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3bJKMOutT6c3VZ5WmS7+2ODb4vvEEnvB3DXZ+5+HhFI=;
        b=kWwTJHEixNNPnj3IbUI7LAjaFCBhJh8T1tzjdVHIBpLZBFN5dindGs06uaavvqpECV
         LzyxrmFwn/ILikThyOavbofJy/tQ6kzZXcVHSBSzxQWGjGCNrXx5pxtN7OfnVctlP0a+
         1gKwPZdf0XWpeEfkzo28uQQGATgTA2Z1CcAtCekwFSWbGiD5yVkiY13L69CUVQBnF8C2
         r9Fg9wimOg64XGdaI8T0j+M4HD8ZwkPVxGpqgT8S88uefMlPWvCtFTPMGXuQSt3B4GSQ
         erhNXWcNe7vN+MIuAtdr/6OaywpTuosZV49e3/x6tbJmoOi7WW+7QlHIUpDd4bfCFCmy
         QZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3bJKMOutT6c3VZ5WmS7+2ODb4vvEEnvB3DXZ+5+HhFI=;
        b=uBQYLWmkuiyNDtiVJAzKhlE4SCa9+ak7h3uksE53UABQ6a9/907b7J6eFfWmWOnUPZ
         cWE7OUlsvJXaLGYym2VqjhDcida87/S0Wn/zDGlsf8nv/skGF1Y/Cpa7jmb/Ew9eebmN
         Al1dXTDnCM4iVQO5kBDMrHxp3/N8GFlqk0qRoU1cQJaU0SS/z1jBKEytCLTH4jx6Cjde
         NmM1udnNqIbdqQZmO4mok0ilQuEW7nIdSrZb9Va1kXdYN+ZbuzJlNu/M0y2EcunOlX5q
         8rLsZaze0JqPjaskguperYiTmLCF01L8WbE7hljv3Q3F1NG4EZdxrihuNivXtk4kovUZ
         0keQ==
X-Gm-Message-State: APjAAAWWOCcfuWxCRNmJdFY+3nJ1RKwNZe46VE6n4WPoIswoPspL/CC4
        lqA2xm7wtFi3Qm4o195EOOxOr5Pp
X-Google-Smtp-Source: APXvYqxTwlK9n785DOupn1xLXioveZGkt8Q55RwCS8y0jUzOoWpbmqjh09RhlvgBYU6vv+6aJGkoFw==
X-Received: by 2002:a5d:49c9:: with SMTP id t9mr23668020wrs.146.1572869736254;
        Mon, 04 Nov 2019 04:15:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i3sm16610073wrw.69.2019.11.04.04.15.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 04:15:35 -0800 (PST)
Message-Id: <25590fbbbee7efc34477bfea233684e93ee7fe60.1572869730.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v5.git.1572869729.gitgitgadget@gmail.com>
References: <pull.170.v4.git.gitgitgadget@gmail.com>
        <pull.170.v5.git.1572869729.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Nov 2019 12:15:25 +0000
Subject: [PATCH v5 5/9] built-in add -i: implement the main loop
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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

The reason why we did not start with the main loop to begin with is that
it is the first user of `list_and_choose()`, which uses the `list()`
function that we conveniently introduced for use by the `status`
command.

Apart from the "and choose" part, there are more differences between the
way the `status` command calls the `list_and_choose()` function in the
Perl version of `git add -i` compared to the other callers of said
function. The most important ones:

- The list is not only shown, but the user is also asked to make a
  choice, possibly selecting multiple entries.

- The list of items is prefixed with a marker indicating what items have
  been selected, if multi-selection is allowed.

- Initially, for each item a unique prefix (if there exists any within
  the given parameters) is determined, and shown in the list, and
  accepted as a shortcut for the selection.

These features will be implemented later, except the part where the user
can choose a command. At this stage, though, the built-in `git add -i`
still only supports the `status` command, with the remaining commands to
follow over the course of the next commits.

In addition, we also modify `list()` to support displaying the commands
in columns, even if there is currently only one.

The Perl script `git-add--interactive.perl` mixed the purposes of the
"list" and the "and choose" part into the same function. In the C
version, we will keep them separate instead, calling the `list()`
function from the `list_and_choose()` function.

Note that we only have a prompt ending in a single ">" at this stage;
later commits will add commands that display a double ">>" to indicate
that the user is in a different loop than the main one.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 135 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 133 insertions(+), 2 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 174e07ce83..c6f7fbad36 100644
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
@@ -65,8 +66,96 @@ static void list(struct add_i_state *s, struct string_list *list,
 
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
+		char *p, *endp;
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
+				index = strtoul(p, &endp, 10) - 1;
+				if (endp != p + sep)
+					index = -1;
+			}
+
+			p[sep] = '\0';
+			if (index < 0 || index >= items->nr)
+				printf(_("Huh (%s)?\n"), p);
+			else {
+				res = index;
+				break;
+			}
+
+			p += sep + 1;
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
@@ -252,20 +341,48 @@ static int run_status(struct add_i_state *s, const struct pathspec *ps,
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
@@ -279,11 +396,25 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 
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

