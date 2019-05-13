Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CC911F461
	for <e@80x24.org>; Mon, 13 May 2019 17:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731726AbfEMR2D (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 13:28:03 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37977 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731668AbfEMR2A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 13:28:00 -0400
Received: by mail-ed1-f67.google.com with SMTP id w11so18667247edl.5
        for <git@vger.kernel.org>; Mon, 13 May 2019 10:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Fq8JyL/8QrjGUewxn4JGjB/dR3S9hr5kcLA1dQyWxH0=;
        b=Fz26riSLPOa336mbs7ieIQErDlljItcwkQGeb2FEe69x12NqfK395gmWf1OxmLlgx0
         5vTKzxvEAKkfN599ODwjoBI6FvYfPcu7kuEbNNQtFToUMj2O1bB9eGfBWsYf+drhQJ1h
         BMEK+RgWjr3cFZUzEQGBoAliD96A7vc/bA0P5WyYN9wsWXcXdekDV8QRo0Bebjf2P92Y
         H6IElkGELwqb3rLS0wxf25zSKrapbxJX6ajh8RDa1fonoCp6K/BKZhm5L11iUUboe6fD
         9tz3Cxuup3Qba+EbRSWG086mswS+xWIsH5H3UvTlYu1julYs75ZTOzkAu9PdkwevtWNJ
         PT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Fq8JyL/8QrjGUewxn4JGjB/dR3S9hr5kcLA1dQyWxH0=;
        b=J4cKmpI38NdExmf2eNTwJOGYmp0EmdjGNNTTJ5Lptnl7DzGf2AtU3MgfHZtpaQGDYT
         5QT1DbcIETPW57vYZ0YGdCZufcJGukV1+HN3nOPSQYonULi03CFctvhXWpWLsUHa/VPi
         z0Ey8I9txWXg7EwR8jBoGuYmZYqZ9RyuOKXnrfn5KOiyWNofBKCZvtTKqGmYqVOR4SJl
         4KO3ffzFAQ72aHK3K58xDTVmNkGpozeXfK4DMPiGnGBdY1hbsQbRYaNOjR4VqHpdbt70
         KGuIpkQ/7D6v/MQ+XPxVfY92rPkXqFCRhLrPIzfM0UyXxrL7E41xqgS1+Ajq7Oi+4svP
         DnkQ==
X-Gm-Message-State: APjAAAWbgbeebrX6aLHJNh+iTKLy6I2gtCzY9DL2gC5JMZcbb28DcSmU
        iSzH+Cz6YY/Y3url59pVMMTt03zq
X-Google-Smtp-Source: APXvYqxI5TdF/hJUWoFPe2YsNn5q+kGq6IbqsuJ7FHuVbeaXs2pTEY2URw3Onb0K8KlKeK6cIUEreQ==
X-Received: by 2002:a50:9b10:: with SMTP id o16mr30395681edi.229.1557768477657;
        Mon, 13 May 2019 10:27:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y42sm2884947edb.95.2019.05.13.10.27.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 10:27:57 -0700 (PDT)
Date:   Mon, 13 May 2019 10:27:57 -0700 (PDT)
X-Google-Original-Date: Mon, 13 May 2019 17:27:45 GMT
Message-Id: <83d92a9762b4c10d74d804a6104b5ae76330ca17.1557768471.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v2.git.gitgitgadget@gmail.com>
References: <pull.170.git.gitgitgadget@gmail.com>
        <pull.170.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 05/11] built-in add -i: color the header in the `status`
 command
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

For simplicity, we only implemented the `status` command without colors.
This patch starts adding color, matching what the Perl script
`git-add--interactive.perl` does.

Original-Patch-By: Daniel Ferreira <bnmvco@gmail.com>
Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 60 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 6 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 2dbf29dee2..6c2fca12c1 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -1,9 +1,51 @@
 #include "cache.h"
 #include "add-interactive.h"
+#include "color.h"
+#include "config.h"
 #include "diffcore.h"
 #include "revision.h"
 #include "refs.h"
 
+struct add_i_state {
+	struct repository *r;
+	int use_color;
+	char header_color[COLOR_MAXLEN];
+};
+
+static void init_color(struct repository *r, struct add_i_state *s,
+		       const char *slot_name, char *dst,
+		       const char *default_color)
+{
+	char *key = xstrfmt("color.interactive.%s", slot_name);
+	const char *value;
+
+	if (!s->use_color)
+		dst[0] = '\0';
+	else if (repo_config_get_value(r, key, &value) ||
+		 color_parse(value, dst))
+		strlcpy(dst, default_color, COLOR_MAXLEN);
+
+	free(key);
+}
+
+static int init_add_i_state(struct repository *r, struct add_i_state *s)
+{
+	const char *value;
+
+	s->r = r;
+
+	if (repo_config_get_value(r, "color.interactive", &value))
+		s->use_color = -1;
+	else
+		s->use_color =
+			git_config_colorbool("color.interactive", value);
+	s->use_color = want_color(s->use_color);
+
+	init_color(r, s, "header", s->header_color, GIT_COLOR_BOLD);
+
+	return 0;
+}
+
 struct item {
 	const char *name;
 };
@@ -14,7 +56,8 @@ struct list_options {
 	void *print_item_data;
 };
 
-static void list(struct item **list, size_t nr, struct list_options *opts)
+static void list(struct item **list, size_t nr,
+		 struct add_i_state *s, struct list_options *opts)
 {
 	int i;
 
@@ -22,7 +65,8 @@ static void list(struct item **list, size_t nr, struct list_options *opts)
 		return;
 
 	if (opts->header)
-		printf("%s\n", opts->header);
+		color_fprintf_ln(stdout, s->header_color,
+				 "%s", opts->header);
 
 	for (i = 0; i < nr; i++) {
 		opts->print_item(i, list[i], opts->print_item_data);
@@ -226,16 +270,16 @@ static void print_file_item(int i, struct item *item,
 	printf(" %2d: %s", i + 1, d->buf.buf);
 }
 
-static int run_status(struct repository *r, const struct pathspec *ps,
+static int run_status(struct add_i_state *s, const struct pathspec *ps,
 		      struct file_list *files, struct list_options *opts)
 {
 	reset_file_list(files);
 
-	if (get_modified_files(r, files, ps) < 0)
+	if (get_modified_files(s->r, files, ps) < 0)
 		return -1;
 
 	if (files->nr)
-		list((struct item **)files->file, files->nr, opts);
+		list((struct item **)files->file, files->nr, s, opts);
 	putchar('\n');
 
 	return 0;
@@ -243,6 +287,7 @@ static int run_status(struct repository *r, const struct pathspec *ps,
 
 int run_add_i(struct repository *r, const struct pathspec *ps)
 {
+	struct add_i_state s = { NULL };
 	struct print_file_item_data print_file_item_data = {
 		"%12s %12s %s", STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
 	};
@@ -253,13 +298,16 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 	struct file_list files = { NULL };
 	int res = 0;
 
+	if (init_add_i_state(r, &s))
+		return error("could not parse `add -i` config");
+
 	strbuf_addstr(&header, "      ");
 	strbuf_addf(&header, print_file_item_data.modified_fmt,
 		    _("staged"), _("unstaged"), _("path"));
 	opts.header = header.buf;
 
 	repo_refresh_and_write_index(r, REFRESH_QUIET, 1);
-	if (run_status(r, ps, &files, &opts) < 0)
+	if (run_status(&s, ps, &files, &opts) < 0)
 		res = -1;
 
 	release_file_list(&files);
-- 
gitgitgadget

