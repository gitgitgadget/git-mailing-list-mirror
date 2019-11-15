Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,UNWANTED_LANGUAGE_BODY shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 361651F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 12:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfKOMga (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 07:36:30 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44976 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbfKOMg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 07:36:28 -0500
Received: by mail-wr1-f67.google.com with SMTP id f2so10812634wrs.11
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 04:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J1l9QLkhOQh4CM7g9oRmHlHkJ4wZCjYjwkmuadOnwQQ=;
        b=F/dr83prdLfkaXRZEB6qyNySJaYW5kHtUmEQqQsdYv1vggwu2WFTfPPZfPX707bA7f
         yW6jLgCnNlKL0zjzF4ckXHcqg5PT11BzMaBqmPffusF5ioSlEoHqdVw/z9QnUxmYKwE2
         ayNGNoRF3ZyCFfLzjbtYuw6A0d2w2FyApYrIrXDdS5sXH2lnIU9Pno7I0cyezdGc+IZn
         EDEN6vXqXZ+OcAv65krXXtSdkJTsQr6PgKS6f8lzdj/4/qexioEx8GYG5WEZPGajpSlF
         RXWi2IgoWv9gZ49QVoq+PyblnBlDuDADzIV2fIjczPDz9SlWX2yyztFQ7f/LjJEOoY0z
         640A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=J1l9QLkhOQh4CM7g9oRmHlHkJ4wZCjYjwkmuadOnwQQ=;
        b=PVxEWgASWesTF8UAAybpppqDgxOSYjNCP4Ec3hoaPOh6no/kXclq8LNozXNxj5mcs1
         1Zr0f+2uI/e00/8AS3Z7qJ6Tdr/6RbV1fCm9Avz8dBCcMoklWr545+weAsKe1/kBTEXF
         qEpTwkUfaUxC5VvGD6X+cnUcDwSP6bKtD6uZfoJk+MHS4huTRXibi+z5g1YZ9qn9mL1C
         Q1ybuGFZnRD1b1ux9IVu+HzJCQCERNgcgaVZQUhqgPGJGHSQKU6IY+yHk90+5II2yt2x
         snB5Z4VtLhmIUnFkoUvKCR2yZTyxX3onpod2ObwTx1vX05pofLn01LjbZm8EQqYHswOy
         ZqaQ==
X-Gm-Message-State: APjAAAVQb8FjiY+eHX+OrpbHkJrYwxe1lo+6/t/0jcXygVdyzqHu4my3
        fhpOLcit9FEv9Q5pHDkkzs8kp7lL
X-Google-Smtp-Source: APXvYqy43e59cGUOzlxiEuVnQqAdIyg9iDUAq4uSH4AyIQSTFBksFH0Tj0/RELPsLeBpSZLa8PIG/g==
X-Received: by 2002:adf:fe0c:: with SMTP id n12mr14802847wrr.174.1573821386976;
        Fri, 15 Nov 2019 04:36:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v81sm10293941wmg.4.2019.11.15.04.36.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 04:36:26 -0800 (PST)
Message-Id: <5c498795b354c8483f9344662085a8f8cca4580f.1573821382.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.171.git.1573821382.gitgitgadget@gmail.com>
References: <pull.171.git.1573821382.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Nov 2019 12:36:19 +0000
Subject: [PATCH 5/8] built-in add -i: re-implement `add-untracked` in C
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

This is yet another command, ported to C. It builds nicely on the
support functions introduced for other commands, with the notable
difference that only names are displayed for untracked files, no
file type or diff summary.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/add-interactive.c b/add-interactive.c
index 191a10b97d..9ed4455a86 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -7,6 +7,7 @@
 #include "refs.h"
 #include "string-list.h"
 #include "lockfile.h"
+#include "dir.h"
 
 struct add_i_state {
 	struct repository *r;
@@ -559,6 +560,7 @@ static int is_valid_prefix(const char *prefix, size_t prefix_len)
 struct print_file_item_data {
 	const char *modified_fmt, *color, *reset;
 	struct strbuf buf, name, index, worktree;
+	unsigned only_names:1;
 };
 
 static void print_file_item(int i, int selected, struct string_list_item *item,
@@ -582,6 +584,12 @@ static void print_file_item(int i, int selected, struct string_list_item *item,
 		highlighted = d->name.buf;
 	}
 
+	if (d->only_names) {
+		printf("%c%2d: %s", selected ? '*' : ' ', i + 1,
+		       highlighted ? highlighted : item->string);
+		return;
+	}
+
 	render_adddel(&d->worktree, &c->worktree, _("nothing"));
 	render_adddel(&d->index, &c->index, _("unchanged"));
 
@@ -761,6 +769,88 @@ static int run_revert(struct add_i_state *s, const struct pathspec *ps,
 	return res;
 }
 
+static int get_untracked_files(struct repository *r,
+			       struct prefix_item_list *files,
+			       const struct pathspec *ps)
+{
+	struct dir_struct dir = { 0 };
+	size_t i;
+	struct strbuf buf = STRBUF_INIT;
+
+	if (repo_read_index(r) < 0)
+		return error(_("could not read index"));
+
+	prefix_item_list_clear(files);
+	setup_standard_excludes(&dir);
+	add_pattern_list(&dir, EXC_CMDL, "--exclude option");
+	fill_directory(&dir, r->index, ps);
+
+	for (i = 0; i < dir.nr; i++) {
+		struct dir_entry *ent = dir.entries[i];
+
+		if (index_name_is_other(r->index, ent->name, ent->len)) {
+			strbuf_reset(&buf);
+			strbuf_add(&buf, ent->name, ent->len);
+			add_file_item(&files->items, buf.buf);
+		}
+	}
+
+	strbuf_release(&buf);
+	return 0;
+}
+
+static int run_add_untracked(struct add_i_state *s, const struct pathspec *ps,
+		      struct prefix_item_list *files,
+		      struct list_and_choose_options *opts)
+{
+	struct print_file_item_data *d = opts->list_opts.print_item_data;
+	int res = 0, fd;
+	size_t count, i;
+	struct lock_file index_lock;
+
+	if (get_untracked_files(s->r, files, ps) < 0)
+		return -1;
+
+	if (!files->items.nr) {
+		printf(_("No untracked files.\n"));
+		goto finish_add_untracked;
+	}
+
+	opts->prompt = N_("Add untracked");
+	d->only_names = 1;
+	count = list_and_choose(s, files, opts);
+	d->only_names = 0;
+	if (count <= 0)
+		goto finish_add_untracked;
+
+	fd = repo_hold_locked_index(s->r, &index_lock, LOCK_REPORT_ON_ERROR);
+	if (fd < 0) {
+		res = -1;
+		goto finish_add_untracked;
+	}
+
+	for (i = 0; i < files->items.nr; i++) {
+		const char *name = files->items.items[i].string;
+		if (files->selected[i] &&
+		    add_file_to_index(s->r->index, name, 0) < 0) {
+			res = error(_("could not stage '%s'"), name);
+			break;
+		}
+	}
+
+	if (!res &&
+	    write_locked_index(s->r->index, &index_lock, COMMIT_LOCK) < 0)
+		res = error(_("could not write index"));
+
+	if (!res)
+		printf(Q_("added %d path\n",
+			  "added %d paths\n", count), (int)count);
+
+finish_add_untracked:
+	putchar('\n');
+	return res;
+}
+
 static int run_help(struct add_i_state *s, const struct pathspec *unused_ps,
 		    struct prefix_item_list *unused_files,
 		    struct list_and_choose_options *unused_opts)
@@ -857,6 +947,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 		{ "status", run_status },
 		{ "update", run_update },
 		{ "revert", run_revert },
+		{ "add untracked", run_add_untracked },
 		{ "help", run_help },
 	};
 	struct prefix_item_list commands = PREFIX_ITEM_LIST_INIT;
-- 
gitgitgadget

