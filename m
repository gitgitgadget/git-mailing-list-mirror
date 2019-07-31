Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B1FA1F731
	for <e@80x24.org>; Wed, 31 Jul 2019 20:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbfGaUEe (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 16:04:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39508 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfGaUEb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 16:04:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id u25so50584466wmc.4
        for <git@vger.kernel.org>; Wed, 31 Jul 2019 13:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QvRbnWf/C+Bh/eFmk5hfokHipZpa8Htx7tzaKSp4u3A=;
        b=seAHlvGli6UvNUvlIuZhx+7HxTKsoOngUOzVuNm4R97t9k+0JXUiuIJxFD7H77SAqf
         n69dFq8y1gB9ZoK9r9JjeCvMqmDXx3rz+PjbFOiMT4cIKazBw6elakVI6Gj3TfkKt6ZM
         P4IF3L+Pushfu8fFxbRuK5v2/28eXPaj8KZ09s3ReIZeSze689isZGnRcRJdJwXDWf6L
         AK44mErAHFA9MbsNK52irzI/tGLQ/rqM/IVeyCaMsACk+wnMJ9JRsbVNM8tI52GyndRT
         WPPhqJyBRnJtjGhZ5oTwSseiG9AGC4Qp7OUaBXnUUWCS3VwKlxcbS8y8luaIOfEBtbwl
         zahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QvRbnWf/C+Bh/eFmk5hfokHipZpa8Htx7tzaKSp4u3A=;
        b=LDV4Z6/LP5/DuvWomdo7AfBDz2Ool/uQRihZcIOo/euF+CfT1YQRfmp1JN30l2l12o
         Unu2uJrZd7MKk1EEJNwko5sWil9kmsESN0QwmER5IF2AQQd3hShMt5gtUpcTUw0hOU8h
         QNjmZr7rxKcep0H9ALtmoe013jmM2GY/TEEYfmM8RX9vO7vIbp0ZZ1YEDNL4ZcP6SWca
         G7FPfitOuey+34zb3e4YbMeYApLQdKocKur/nW5dX5OLZ/p+CDriK7T+rzucdTGMurdR
         jL2Pm0WcNHItBWjBKs2WEQdH01l63mTMpMzdFViCPz7Rj1aq5ytmr6i6q3mL70nmC09K
         zjvA==
X-Gm-Message-State: APjAAAWCAN4/A4E3KfqNfmskxc78HtxSfG5HSC1SrPcQK2/XHpCfKU+f
        BWLhBuejXIt1D5rfTZw8XqDtp3Pv
X-Google-Smtp-Source: APXvYqzALS2VsQO1twZgXLOxaXYzTIBWjESUIaRQM0kSnP/gOyku9/1dmAxs1HcxJJIob3+IX21e6A==
X-Received: by 2002:a1c:b707:: with SMTP id h7mr110498259wmf.45.1564603469255;
        Wed, 31 Jul 2019 13:04:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t63sm63357771wmt.6.2019.07.31.13.04.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 13:04:28 -0700 (PDT)
Date:   Wed, 31 Jul 2019 13:04:28 -0700 (PDT)
X-Google-Original-Date: Wed, 31 Jul 2019 20:04:25 GMT
Message-Id: <38b53da31f174892b564564e0a380c0a154c8f88.1564603467.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.298.git.gitgitgadget@gmail.com>
References: <pull.298.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/3] trace2: cleanup column alignment in perf target format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Truncate/elide very long "filename:linenumber" field.
Truncate region and data "category" field if necessary.
Adjust overall column widths.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 trace2/tr2_tgt_perf.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index ea0cbbe13e..4a9d99218b 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -21,10 +21,10 @@ static struct tr2_dst tr2dst_perf = { TR2_SYSENV_PERF, 0, 0, 0 };
  */
 static int tr2env_perf_be_brief;
 
-#define TR2FMT_PERF_FL_WIDTH (50)
+#define TR2FMT_PERF_FL_WIDTH (28)
 #define TR2FMT_PERF_MAX_EVENT_NAME (12)
-#define TR2FMT_PERF_REPO_WIDTH (4)
-#define TR2FMT_PERF_CATEGORY_WIDTH (10)
+#define TR2FMT_PERF_REPO_WIDTH (3)
+#define TR2FMT_PERF_CATEGORY_WIDTH (12)
 
 #define TR2_DOTS_BUFFER_SIZE (100)
 #define TR2_INDENT (2)
@@ -79,17 +79,36 @@ static void perf_fmt_prepare(const char *event_name,
 
 	if (!tr2env_perf_be_brief) {
 		struct tr2_tbuf tb_now;
+		size_t fl_end_col;
 
 		tr2_tbuf_local_time(&tb_now);
 		strbuf_addstr(buf, tb_now.buf);
 		strbuf_addch(buf, ' ');
 
-		if (file && *file)
-			strbuf_addf(buf, "%s:%d ", file, line);
-		while (buf->len < TR2FMT_PERF_FL_WIDTH)
+		fl_end_col = buf->len + TR2FMT_PERF_FL_WIDTH;
+
+		if (file && *file) {
+			struct strbuf buf_fl = STRBUF_INIT;
+
+			strbuf_addf(&buf_fl, "%s:%d", file, line);
+
+			if (buf_fl.len <= TR2FMT_PERF_FL_WIDTH)
+				strbuf_addbuf(buf, &buf_fl);
+			else {
+				size_t avail = TR2FMT_PERF_FL_WIDTH - 3;
+				strbuf_addstr(buf, "...");
+				strbuf_add(buf,
+					   &buf_fl.buf[buf_fl.len - avail],
+					   avail);
+			}
+
+			strbuf_release(&buf_fl);
+		}
+
+		while (buf->len < fl_end_col)
 			strbuf_addch(buf, ' ');
 
-		strbuf_addstr(buf, "| ");
+		strbuf_addstr(buf, " | ");
 	}
 
 	strbuf_addf(buf, "d%d | ", tr2_sid_depth());
@@ -102,7 +121,7 @@ static void perf_fmt_prepare(const char *event_name,
 		strbuf_addf(buf, "r%d ", repo->trace2_repo_id);
 	while (buf->len < len)
 		strbuf_addch(buf, ' ');
-	strbuf_addstr(buf, "| ");
+	strbuf_addstr(buf, " | ");
 
 	if (p_us_elapsed_absolute)
 		strbuf_addf(buf, "%9.6f | ",
@@ -116,8 +135,8 @@ static void perf_fmt_prepare(const char *event_name,
 	else
 		strbuf_addf(buf, "%9s | ", " ");
 
-	strbuf_addf(buf, "%-*s | ", TR2FMT_PERF_CATEGORY_WIDTH,
-		    (category ? category : ""));
+	strbuf_addf(buf, "%-*.*s | ", TR2FMT_PERF_CATEGORY_WIDTH,
+		    TR2FMT_PERF_CATEGORY_WIDTH, (category ? category : ""));
 
 	if (ctx->nr_open_regions > 0) {
 		int len_indent = TR2_INDENT_LENGTH(ctx);
-- 
gitgitgadget

