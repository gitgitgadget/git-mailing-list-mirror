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
	by dcvr.yhbt.net (Postfix) with ESMTP id 387561F4B7
	for <e@80x24.org>; Tue, 27 Aug 2019 12:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbfH0M6D (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 08:58:03 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55492 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729861AbfH0M6B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 08:58:01 -0400
Received: by mail-wm1-f68.google.com with SMTP id f72so2974847wmf.5
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 05:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Y4lT1wnaCIJK9Gipd3pEAc/YaEpdH/veIOQxmPJjBGM=;
        b=CZKDDdDPJ3QmNHFV7JJPMs0ONOCMacS2PX/95QjrgloGxACibTt9RURToxrNVdx6t6
         xywvDTTCGTe+66x5/89IfdgKnhAi2fO/EmvxTsDgkquPZZOig2hXoobUMvEp1RBwRlKQ
         08cGEC1iEVteqAUwxJTuc0Z5s7GGSLFTbgGi5fIkfMObmGJObQejUxHg4blHXtmgvHuv
         t4RofcXEJi9rxIfmGwR75W7w9WJko3EfcYIYuAvuD0nf4VQtwMAKvi6wjc6vZhQXdEt+
         0/TFexenSgYyCb1i6VqmL5+HFJNK726t+I3mU/34BOrX36p4MiAkBcvpdeG/i/8Z7Iea
         uAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Y4lT1wnaCIJK9Gipd3pEAc/YaEpdH/veIOQxmPJjBGM=;
        b=dNgCNU8txODbp6S2epDxJYLz2oxCzA0iZ2oB3mYs0FKr6NNYJLz0mN27hgQHKx9gib
         d7213Y8e22a8MIPTQDhlHUdFr/BeXMKOSKvc6oO+UPWh8Mzt8G6DdFE6jgwKkT4d8RFC
         PiXZJVvJHibyO1m9CRRRfWqHYM2gaY24SwtrF7LtS7vVQ2tKtE7rk8a6w0+nzBKaZLZ9
         1/q3Kf8WTZsiBXMBbXAG+xBnkJt84uZGoap/GKTWRloKatvxdk/Q2KgkWfk74j11VHXA
         tlEZ7p5ZRgL5JQuinLwKm05wCdgaegEGSCswu1NWCR2WSTyrEkyXrCVfwxCewP8U4bZU
         x9LQ==
X-Gm-Message-State: APjAAAW5EDEURa2IsM9YKJRlIqazpEPZYaTJOc6xK+FA/NaiSDSWNWL+
        xDrSu1pJcZ69rK1ahiP8/Sg/LGIV91s=
X-Google-Smtp-Source: APXvYqzydwZSkjIKK/FxaHpxTBxKF3bsk1IafnwkfWLFPXDlbGJGjQnOhmDT0izsGKGF70YEzQpSzw==
X-Received: by 2002:a1c:f518:: with SMTP id t24mr26962396wmh.98.1566910678537;
        Tue, 27 Aug 2019 05:57:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d16sm11079940wrv.55.2019.08.27.05.57.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 05:57:58 -0700 (PDT)
Date:   Tue, 27 Aug 2019 05:57:58 -0700 (PDT)
X-Google-Original-Date: Tue, 27 Aug 2019 12:57:47 GMT
Message-Id: <ac67731cf11810e24de13ec3312ec71d2115b5f7.1566910672.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v4.git.gitgitgadget@gmail.com>
References: <pull.170.v3.git.gitgitgadget@gmail.com>
        <pull.170.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 06/11] built-in add -i: implement the main loop
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>, Jeff King <peff@peff.net>,
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
 add-interactive.c | 129 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 127 insertions(+), 2 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index f5577a80d3..bbab69d4bc 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -51,6 +51,7 @@ struct item {
 };
 
 struct list_options {
+	int columns;
 	const char *header;
 	void (*print_item)(int i, struct item *item, void *print_item_data);
 	void *print_item_data;
@@ -59,7 +60,7 @@ struct list_options {
 static void list(struct item **list, size_t nr,
 		 struct add_i_state *s, struct list_options *opts)
 {
-	int i;
+	int i, last_lf = 0;
 
 	if (!nr)
 		return;
@@ -70,8 +71,97 @@ static void list(struct item **list, size_t nr,
 
 	for (i = 0; i < nr; i++) {
 		opts->print_item(i, list[i], opts->print_item_data);
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
+static ssize_t list_and_choose(struct item **items, size_t nr,
+			       struct add_i_state *s,
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
+		list(items, nr, s, &opts->list_opts);
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
+			if (index < 0 || index >= nr)
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
@@ -286,17 +376,40 @@ static int run_status(struct add_i_state *s, const struct pathspec *ps,
 	return 0;
 }
 
+static void print_command_item(int i, struct item *item,
+			       void *print_command_item_data)
+{
+	printf(" %2d: %s", i + 1, item->name);
+}
+
+struct command_item {
+	struct item item;
+	int (*command)(struct add_i_state *s, const struct pathspec *ps,
+		       struct file_list *files, struct list_options *opts);
+};
+
 int run_add_i(struct repository *r, const struct pathspec *ps)
 {
 	struct add_i_state s = { NULL };
+	struct list_and_choose_options main_loop_opts = {
+		{ 4, N_("*** Commands ***"), print_command_item, NULL },
+		N_("What now")
+	};
+	struct command_item
+		status = { { "status" }, run_status };
+	struct command_item *commands[] = {
+		&status
+	};
+
 	struct print_file_item_data print_file_item_data = {
 		"%12s %12s %s", STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
 	};
 	struct list_options opts = {
-		NULL, print_file_item, &print_file_item_data
+		0, NULL, print_file_item, &print_file_item_data
 	};
 	struct strbuf header = STRBUF_INIT;
 	struct file_list files = { NULL };
+	ssize_t i;
 	int res = 0;
 
 	if (init_add_i_state(r, &s))
@@ -311,6 +424,18 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 	if (run_status(&s, ps, &files, &opts) < 0)
 		res = -1;
 
+	for (;;) {
+		i = list_and_choose((struct item **)commands,
+				    ARRAY_SIZE(commands), &s, &main_loop_opts);
+		if (i == LIST_AND_CHOOSE_QUIT) {
+			printf(_("Bye.\n"));
+			res = 0;
+			break;
+		}
+		if (i != LIST_AND_CHOOSE_ERROR)
+			res = commands[i]->command(&s, ps, &files, &opts);
+	}
+
 	release_file_list(&files);
 	strbuf_release(&print_file_item_data.buf);
 	strbuf_release(&print_file_item_data.index);
-- 
gitgitgadget

