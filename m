Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 384BA1F461
	for <e@80x24.org>; Mon, 13 May 2019 17:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731732AbfEMR2E (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 13:28:04 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35750 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730677AbfEMR2C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 13:28:02 -0400
Received: by mail-ed1-f66.google.com with SMTP id p26so18701227edr.2
        for <git@vger.kernel.org>; Mon, 13 May 2019 10:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=maXgbBZIfSjyQDIgjTn7ji0VBOqIZyKDH4hVyNWT1Xs=;
        b=cFQG11BuqBPFecQ30q/sBXyH5s12SAUTkymrRkA1DsfouAUerlSzURKt28l/7Brdi1
         +uGgGA804ZCo1wubSW5JunhjCNlM8QKw2VvLLc5VQMITLYLR0f9zJdTztye1UfVBdtJX
         XXDo5zBDmDtB6Ctg+DJ1PE9cymGjjjVHkhOtQf/Hmb4z81lUuI9e2LkbwgH3X6FZfYEP
         g70LXqqPXQp5lcrZPSqkkR79vRbJVONXLgrSnI/PxBTsfFKqpgle2CjGgBSWi8jAJHc8
         zjx2NKmQjvewfJcSMm5xwVI3awgUrHpACgWG/fiBh7LsOqbIWIKt8mE7DvxdW3HeeRtb
         j/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=maXgbBZIfSjyQDIgjTn7ji0VBOqIZyKDH4hVyNWT1Xs=;
        b=MgtjSZPiEH/IF3/X034quyFLuvxRtJEP5LVxlNB/9efqDWZ3TW94LAGOka0FCe4YRH
         SLfghpDipQru0wln1swz2bwsRDAZC9wNDYpxb6D7R/lOCoCxeRDVqnASH+NbncXVFe2f
         Rd2O00rbBHmsmA8l5i48fzyilf2BDUvt/E29rZx2hwv5Jzsfw5zj/xJlMBBhcoAFlzWx
         LMJKBo8/P1j6mF02SxtENu3Zb1RnFGVKiJlFiQa2WonHgAlwD0RJfzVg6gSdTejfFrS+
         uBEHS//UnR9E0yinwrDOo53YIeRyfT7h5HjxnIi/GCd9zEP3eA6y8aSsFXUvODeVblRU
         D13A==
X-Gm-Message-State: APjAAAXVe+5pnEOuHx5O6XWlQljBE8II5IAVHHF5NE2FvbgKrP/YS5eU
        At+G0ZXCRaqsC07Wrr6HZ3WK0hRt
X-Google-Smtp-Source: APXvYqx5NeZQpce7MvZqqPVPCclu6vurCwTK4WAGn+diEkcA3m15p3PvKG2RaO+9McFPx1xf6f6THQ==
X-Received: by 2002:a50:a51c:: with SMTP id y28mr24502940edb.280.1557768480265;
        Mon, 13 May 2019 10:28:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e43sm3911718edb.38.2019.05.13.10.27.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 10:27:59 -0700 (PDT)
Date:   Mon, 13 May 2019 10:27:59 -0700 (PDT)
X-Google-Original-Date: Mon, 13 May 2019 17:27:48 GMT
Message-Id: <ced9b6acedf0450555488c0cbda55716d6bc636e.1557768472.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v2.git.gitgitgadget@gmail.com>
References: <pull.170.git.gitgitgadget@gmail.com>
        <pull.170.v2.git.gitgitgadget@gmail.com>
From:   "Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 08/11] built-in add -i: show unique prefixes of the
 commands
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
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
 add-interactive.c | 69 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 56 insertions(+), 13 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 0ea4f3edb8..7ff87bae1b 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -5,6 +5,7 @@
 #include "diffcore.h"
 #include "revision.h"
 #include "refs.h"
+#include "prefix-map.h"
 
 struct add_i_state {
 	struct repository *r;
@@ -46,18 +47,32 @@ static int init_add_i_state(struct repository *r, struct add_i_state *s)
 	return 0;
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
 
-static void list(struct item **list, size_t nr,
+static void list(struct prefix_item **list, size_t nr,
 		 struct add_i_state *s, struct list_options *opts)
 {
 	int i, last_lf = 0;
@@ -100,13 +115,15 @@ struct list_and_choose_options {
  * If an error occurred, returns `LIST_AND_CHOOSE_ERROR`. Upon EOF,
  * `LIST_AND_CHOOSE_QUIT` is returned.
  */
-static ssize_t list_and_choose(struct item **items, size_t nr,
+static ssize_t list_and_choose(struct prefix_item **items, size_t nr,
 			       struct add_i_state *s,
 			       struct list_and_choose_options *opts)
 {
 	struct strbuf input = STRBUF_INIT;
 	ssize_t res = LIST_AND_CHOOSE_ERROR;
 
+	find_unique_prefixes(items, nr, 1, 4);
+
 	for (;;) {
 		char *p, *endp;
 
@@ -146,6 +163,9 @@ static ssize_t list_and_choose(struct item **items, size_t nr,
 			}
 
 			p[sep] = '\0';
+			if (index < 0)
+				index = find_unique(p, items, nr);
+
 			if (index < 0 || index >= nr)
 				printf(_("Huh (%s)?\n"), p);
 			else {
@@ -171,7 +191,7 @@ struct adddel {
 
 struct file_list {
 	struct file_item {
-		struct item item;
+		struct prefix_item item;
 		struct adddel index, worktree;
 	} **file;
 	size_t nr, alloc;
@@ -337,12 +357,29 @@ static void populate_wi_changes(struct strbuf *buf,
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
@@ -369,20 +406,26 @@ static int run_status(struct add_i_state *s, const struct pathspec *ps,
 		return -1;
 
 	if (files->nr)
-		list((struct item **)files->file, files->nr, s, opts);
+		list((struct prefix_item **)files->file, files->nr, s, opts);
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
 	int (*command)(struct add_i_state *s, const struct pathspec *ps,
 		       struct file_list *files, struct list_options *opts);
 };
@@ -424,7 +467,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 		res = -1;
 
 	for (;;) {
-		i = list_and_choose((struct item **)commands,
+		i = list_and_choose((struct prefix_item **)commands,
 				    ARRAY_SIZE(commands), &s, &main_loop_opts);
 		if (i == LIST_AND_CHOOSE_QUIT) {
 			printf(_("Bye.\n"));
-- 
gitgitgadget

