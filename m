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
	by dcvr.yhbt.net (Postfix) with ESMTP id 122191F4B7
	for <e@80x24.org>; Tue, 27 Aug 2019 12:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbfH0M6C (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 08:58:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40301 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729901AbfH0M6B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 08:58:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id c3so18687853wrd.7
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 05:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Z9ZC6ebRefB3vGsu5gtP8HC6qsK2bvviQz2Ah4aJVyY=;
        b=sEH31cd6gte4dnncsceD7IFLJyZsVsV5Pvdz3MpUP/dFhp8c/+UovTmfWHGmg6BnGa
         7tuqj4RakkR0Uy1TfLX2PKQ3dJLzgQtKFLuMBtQVEujrnpc5rq6a/HkB8Nz3MS1hrjwt
         FrMPjiAkB1Z4l3nppNasjoJM9egDwAhG8iKeov9GQr7u/7BiZm7VtCmhi/XH7k/UTlvn
         3/HM2wBW4qJLajo3JvpB+AfSmF36fevPmzqf87Ds1M/pnn3rdxNJJyhcJhFNGPFbnF3P
         mNJtUvNZefmNNrQ1R0fcm9G09U6XNb+B+aZMEMFmvqXcSArhxXTH0oCEgGk6c19i+8/z
         dbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Z9ZC6ebRefB3vGsu5gtP8HC6qsK2bvviQz2Ah4aJVyY=;
        b=lgsQR36AG+iJDX3ELJNUFI23ITEJNXWtjYJJu1mvrg5sSuQAxlywLOq7awKEh0O5Ri
         DXQkQRU1InfrMx05WrbrKqOr8ae1Wv/8cwqbcHjmz18azYOwMFNcgls0Pez9maYyMHot
         z9/DNm+xMVbPdiEtINKGjWx6RiwgvTa+IjagNUJZHUvx4Rc+eygtfdpfP/D3fjMVqkzs
         +eiE96br18U7PDsNPN4YbCBnDkl/B6gteBOc2VdK8fgTrfBEw+VAXbAj46PyzFe4oSUv
         5ZknOTuI9BtMQiQhPCHQoH2PiagAFPXF1SzgXwgM9g0JVYXUXBbwvOEPS3hcL15SE6Un
         uIUA==
X-Gm-Message-State: APjAAAXKWonUF1oPySzEcdb2Ob0SixbSyeTZiZekIyKh3cLGeIW/b3ne
        BxI8VTQ5T98YWb04fbaLpqkVtFP6JWY=
X-Google-Smtp-Source: APXvYqzPk7zW2fZFHds4S1EZboKLtI/st1ooaRcMfl/S+TDqyU0UP8NlINN/q/a8MPgfnSib7Ant/A==
X-Received: by 2002:adf:f1cc:: with SMTP id z12mr28674496wro.125.1566910680107;
        Tue, 27 Aug 2019 05:58:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w13sm40217521wre.44.2019.08.27.05.57.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 05:57:59 -0700 (PDT)
Date:   Tue, 27 Aug 2019 05:57:59 -0700 (PDT)
X-Google-Original-Date: Tue, 27 Aug 2019 12:57:49 GMT
Message-Id: <bc7a74f697741c723ca670b543392b3f8fc0e35b.1566910672.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v4.git.gitgitgadget@gmail.com>
References: <pull.170.v3.git.gitgitgadget@gmail.com>
        <pull.170.v4.git.gitgitgadget@gmail.com>
From:   "Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 08/11] built-in add -i: show unique prefixes of the
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
index bbab69d4bc..12a4c2adb8 100644
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
@@ -338,12 +358,29 @@ static void populate_wi_changes(struct strbuf *buf,
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
@@ -370,20 +407,26 @@ static int run_status(struct add_i_state *s, const struct pathspec *ps,
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
@@ -425,7 +468,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 		res = -1;
 
 	for (;;) {
-		i = list_and_choose((struct item **)commands,
+		i = list_and_choose((struct prefix_item **)commands,
 				    ARRAY_SIZE(commands), &s, &main_loop_opts);
 		if (i == LIST_AND_CHOOSE_QUIT) {
 			printf(_("Bye.\n"));
-- 
gitgitgadget

