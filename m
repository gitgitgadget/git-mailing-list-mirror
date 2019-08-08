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
	by dcvr.yhbt.net (Postfix) with ESMTP id A16E31F731
	for <e@80x24.org>; Thu,  8 Aug 2019 14:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403813AbfHHOTD (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 10:19:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32889 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389561AbfHHOTD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 10:19:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so95235154wru.0
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 07:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QvRbnWf/C+Bh/eFmk5hfokHipZpa8Htx7tzaKSp4u3A=;
        b=rrSo1UeVAmSDYJ0Vx+Uv7nTikTosvE1DtpdiOhQmTjOZaFZPm9ArzjYnPF8BZ63CqX
         NFpGxal9fDQbCnHtw07IuR19RwIUL4K5rOiRX3hYFIRKrHZjfZPo7ZLeToBi+XKor1Dz
         GGDH7RodzYYF9Dff+N3U2z6ekeNBTMkkQX3IvSfFLjOV3syaIxRAkCdm4ZxXrLP+pLvZ
         ae0sRhmGnlaWs5Lz/yrVrsFPdGedyxcvkOawCeRajgk0hz+cPLSmqkJ0HJRUmx1g2sEv
         MM1QziQoCOinCSaHR9lyQ7vp3vmzmiUov7N5WtZW9Pu2aeywsmYqH2iQN1Lzvztjnulh
         /BhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QvRbnWf/C+Bh/eFmk5hfokHipZpa8Htx7tzaKSp4u3A=;
        b=KWWztxHjkavFATguF6tTKuWqVFaDaGVExIWn+7xaeu3A6gYqSIx6QKqYwyLj/GEGej
         mvhFLE3pTPpL+f1ayx3HNtg5c1LpLrjKRmtH5Divo4yOlfu7OxCc5cq7x7hAHkCDqXeb
         Thq5x0fV0OC0KI+vt6+Sq/VO5RZjEqkKcl0i3xeAXqh7L1TC4WDHiyrE/89Sj4Somdnx
         8+gezQBS7NMb9RpI2owfZkMWbOQqU26quTmEm2TpuU++dGtp3nkkZGzbUvgqkhBvM1pD
         CqbShsp2BqRqXEYf5v+dyPeXW77Np4prwUwJPYhKZ9SNR2X9t/YECA51df+x7MGXzUxG
         zWOg==
X-Gm-Message-State: APjAAAXzK6TaGUcU4aL+wGjxUH3F4XG568kHMOQ9bWqWCvT6Tly7ytrW
        jinIc638boY2Qnk4udps8YDW/ZYd
X-Google-Smtp-Source: APXvYqwO2+4YR9bk01BitvaXjHgEzXnQqkpFtnVppcbzcpvr6yIGujg/wA6WqrAND1wciG7pkMoSVQ==
X-Received: by 2002:adf:d4cc:: with SMTP id w12mr17834763wrk.121.1565273940490;
        Thu, 08 Aug 2019 07:19:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a81sm3383902wmh.3.2019.08.08.07.18.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 07:18:59 -0700 (PDT)
Date:   Thu, 08 Aug 2019 07:18:59 -0700 (PDT)
X-Google-Original-Date: Thu, 08 Aug 2019 14:18:52 GMT
Message-Id: <38b53da31f174892b564564e0a380c0a154c8f88.1565273938.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.298.v2.git.gitgitgadget@gmail.com>
References: <pull.298.git.gitgitgadget@gmail.com>
        <pull.298.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/7] trace2: cleanup column alignment in perf target format
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

