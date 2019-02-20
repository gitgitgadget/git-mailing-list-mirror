Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A07D71F453
	for <e@80x24.org>; Wed, 20 Feb 2019 11:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfBTLlh (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 06:41:37 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38158 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbfBTLlf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 06:41:35 -0500
Received: by mail-ed1-f66.google.com with SMTP id h58so19572571edb.5
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 03:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WcmJxNEZPXYa1fUGXO5klyKYdJllAn3hqOLW5VnHHEg=;
        b=MHw3IPKm3y5gNBiuADPHqiv/AnU0valXtGN4P+hqfdYPXqcd8OILW/2k41nAVYtx1z
         nRJxarmkv+4N6ULJuYiz5T3TUY1S2xqMfOoGybmJ9sMk08nwRleBDfxWl4ePgfJtO3Ot
         yU77Rpqrba50XeUcsCvSQJqXoRikgansMNf6xK+p80qMZqUSyGlSOsS6UB6A3RykOUxE
         2Mqmia9Phr8lHDAwrHXlfu3897CXyglIODYz8ZdMujjt1F0mGVjZzcl3XHphgdHVITv7
         pO50ltVauspuani7ZIPuz+HfRo94LSZwtgt/BLCe69Ab82T6jN4TLXSxkMaLivJYmfmt
         CuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WcmJxNEZPXYa1fUGXO5klyKYdJllAn3hqOLW5VnHHEg=;
        b=R085UK19yIr7VVPUtHj7lwXTK6fQ2Hm5GLCOCXjNbH4m6/G5ewWIkMdKjzMgRQm/fh
         Ahh9DYKiXd92Iypluf4QUU/ncsTXbfD+EhrUvDgNHrgHa2RuqFuzOEPixTwfqUgb0ET8
         MiwuOk7znn2uwGQbLTVx0XwIznryoWRUiBFuoeoriqvBJroLazB0eydxeraspouq4S3R
         TdmSHaH4vJVZ15s+VjfMttOvRkwMuPgt2DtFoYhx+g2MsbmDGK0mxsAtKNuRH2NYqLvG
         XFZg/Y04QFeiQKY7oLOBHxr5w6trpKaXkcDZ8xPyXBiXh7Oc7yx8ytR6LXFU3JaVQIlL
         URbA==
X-Gm-Message-State: AHQUAubwDWsTi/6kfUNRtubKpTwC9rqVMhy6MDnQCw3GHqWekLGnMfiF
        Hwv0lwZTUEoTAUh+Deu7biOz2/IB
X-Google-Smtp-Source: AHgI3Iap7SGo+V8c/8hAFaj6ieEnLHyTn+I3jS/wEGIFlTBSnC7X2cXcgeBCAejOFtMBgOgry82vjQ==
X-Received: by 2002:a50:b1cd:: with SMTP id n13mr8014355edd.224.1550662891877;
        Wed, 20 Feb 2019 03:41:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b22sm1095973edb.5.2019.02.20.03.41.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 03:41:31 -0800 (PST)
Date:   Wed, 20 Feb 2019 03:41:31 -0800 (PST)
X-Google-Original-Date: Wed, 20 Feb 2019 11:41:21 GMT
Message-Id: <a97b29d2741e0e5ae8cf45b1c7cafc56afaa66ef.1550662887.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.v5.git.gitgitgadget@gmail.com>
References: <pull.103.v4.git.gitgitgadget@gmail.com>
        <pull.103.v5.git.gitgitgadget@gmail.com>
From:   "Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 04/10] add-interactive.c: implement list_and_choose
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

This is one of the two functions translated from Perl script, besides
list_modified that will be used by *_cmd functions (including status)
to collect index/worktree changes, list those changes and let user
make a choice.

At this point, it only prints worktree and index changes, but later on
in this patch series there will be upgraded to highlighting unique
prefixes of list items and let user pick those items.

Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
---
 add-interactive.c | 127 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/add-interactive.c b/add-interactive.c
index 7d096207d4..9a475a5d48 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -5,6 +5,8 @@
 #include "diffcore.h"
 #include "revision.h"
 
+#define HEADER_INDENT "      "
+
 enum collection_phase {
 	WORKTREE,
 	INDEX
@@ -27,6 +29,61 @@ struct collection_status {
 	struct hashmap file_map;
 };
 
+struct list_and_choose_options {
+	int column_n;
+	unsigned singleton:1;
+	unsigned list_flat:1;
+	unsigned list_only:1;
+	unsigned list_only_file_names:1;
+	unsigned immediate:1;
+	char *header;
+	const char *prompt;
+	void (*on_eof_fn)(void);
+};
+
+struct choice {
+	struct hashmap_entry e;
+	char type;
+	union {
+		void (*command_fn)(void);
+		struct {
+			struct {
+				uintmax_t added, deleted;
+			} index, worktree;
+		} file;
+	} u;
+	size_t prefix_length;
+	const char *name;
+};
+
+struct choices {
+	struct choice **choices;
+	size_t alloc, nr;
+};
+#define CHOICES_INIT { NULL, 0, 0 }
+
+static int use_color = -1;
+enum color_add_i {
+	COLOR_PROMPT,
+	COLOR_HEADER,
+	COLOR_HELP,
+	COLOR_ERROR
+};
+
+static char colors[][COLOR_MAXLEN] = {
+	GIT_COLOR_BOLD_BLUE, /* Prompt */
+	GIT_COLOR_BOLD,      /* Header */
+	GIT_COLOR_BOLD_RED,  /* Help */
+	GIT_COLOR_RESET      /* Reset */
+};
+
+static const char *get_color(enum color_add_i ix)
+{
+	if (want_color(use_color))
+		return colors[ix];
+	return "";
+}
+
 static int hash_cmp(const void *unused_cmp_data, const void *entry,
 		    const void *entry_or_key, const void *keydata)
 {
@@ -186,3 +243,73 @@ static struct collection_status *list_modified(struct repository *r, const char
 	free(files);
 	return s;
 }
+
+static struct choices *list_and_choose(struct choices *data,
+				       struct list_and_choose_options *opts)
+{
+	if (!data)
+		return NULL;
+
+	while (1) {
+		int last_lf = 0;
+
+		if (opts->header) {
+			const char *header_color = get_color(COLOR_HEADER);
+			if (!opts->list_flat)
+				printf(HEADER_INDENT);
+			color_fprintf_ln(stdout, header_color, "%s", opts->header);
+		}
+
+		for (int i = 0; i < data->nr; i++) {
+			struct choice *c = data->choices[i];
+			char *print;
+			const char *modified_fmt = _("%12s %12s %s");
+			char worktree_changes[50];
+			char index_changes[50];
+			char print_buf[100];
+
+			print = (char *)c->name;
+			
+			if ((data->choices[i]->type == 'f') && (!opts->list_only_file_names)) {
+				uintmax_t worktree_added = c->u.file.worktree.added;
+				uintmax_t worktree_deleted = c->u.file.worktree.deleted;
+				uintmax_t index_added = c->u.file.index.added;
+				uintmax_t index_deleted = c->u.file.index.deleted;
+
+				if (worktree_added || worktree_deleted)
+					snprintf(worktree_changes, 50, "+%"PRIuMAX"/-%"PRIuMAX,
+						 worktree_added, worktree_deleted);
+				else
+					snprintf(worktree_changes, 50, "%s", _("nothing"));
+
+				if (index_added || index_deleted)
+					snprintf(index_changes, 50, "+%"PRIuMAX"/-%"PRIuMAX,
+						 index_added, index_deleted);
+				else
+					snprintf(index_changes, 50, "%s", _("unchanged"));
+
+				snprintf(print_buf, 100, modified_fmt, index_changes,
+					 worktree_changes, print);
+				print = xmalloc(strlen(print_buf) + 1);
+				snprintf(print, 100, "%s", print_buf);
+			}
+
+			printf(" %2d: %s", i + 1, print);
+
+			if ((opts->list_flat) && ((i + 1) % (opts->column_n))) {
+				printf("\t");
+				last_lf = 0;
+			}
+			else {
+				printf("\n");
+				last_lf = 1;
+			}
+
+		}
+
+		if (!last_lf)
+			printf("\n");
+
+		return NULL;
+	}
+}
-- 
gitgitgadget

