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
	by dcvr.yhbt.net (Postfix) with ESMTP id 588AA1F731
	for <e@80x24.org>; Fri,  9 Aug 2019 15:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407240AbfHIPAz (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 11:00:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36642 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfHIPAz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 11:00:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id g67so5909970wme.1
        for <git@vger.kernel.org>; Fri, 09 Aug 2019 08:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QvRbnWf/C+Bh/eFmk5hfokHipZpa8Htx7tzaKSp4u3A=;
        b=QwSAe5Oo5LOWbXvxs27jGCMHnyDlfzkAsEjeIMDiOS1MsNz4E6plV67GrYE8/pOIBI
         +rUwu9ZMW9lAMaVDAujoQTLj7EY4AROqU5Drx+UGsQjDMJzsm3GGjtHvVUQL0K44rXk+
         IxISQUUlILJsnBLsz4BWouNo7kfKcbnBZUeSCkp+4K2vGBir5bER4eYvWeLMJlG8tnlZ
         LjvCoCSf4L3dkcYYt7C+2Qb0SODHPKtRJ2IO0JXRfxjl4RfLmHEj5nnnoXKcjdTusIEw
         fBmEdP2ZmQOTo02AOoUm+M0LWALrqj4cQoYjMUpCHmLcJi3FudrHP2fJIEMopK8XZO9/
         /6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QvRbnWf/C+Bh/eFmk5hfokHipZpa8Htx7tzaKSp4u3A=;
        b=lKXKQo9IMwrkgIZl2E+8a5m+emZYMoMuza3EDyZwSIp/HoAMIFsbRUrYCERMpe79rh
         IA5zuPIfDcKya/pgqde9xHyQgeVUkiw6AXEeJ6oGqG50XBwqk9Ah8JfMvBJja2lOqomB
         N/qNfRub3MNJRnVrnUG3yQI5fpI+jhZe61Qw4wqaKbyablmhndmpqp4lXxYUhV60BUw+
         d0Qq36Isl/ha/2hmM4DIm8ySdyWnwcod/BJ2RnPjjU8N6X/b3JAhtdZ7MLwc+BOOAve3
         g/9B6E8EW+DbuOBWzrcl5atm+U0l1C6BWNjZO23O5TIoSMjWIgBamZDxT3+Sy3qRo7Wb
         2/uQ==
X-Gm-Message-State: APjAAAUpNKdYn1sTnxtFel2kj7Tu58qb1Xlx2jXjveCL/0E+/kqxDPnt
        6YbqJXuQ0jtVYWt15Ji3LE5azE/S
X-Google-Smtp-Source: APXvYqxjlfnR1ClF12K+VMT9nuBzyi/3P90oJriyTXY5VzjQF7nG37GQW52n0tOdsPrGj7YltrxPzg==
X-Received: by 2002:a1c:be11:: with SMTP id o17mr11328209wmf.115.1565362853600;
        Fri, 09 Aug 2019 08:00:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n12sm5399351wmc.24.2019.08.09.08.00.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 08:00:53 -0700 (PDT)
Date:   Fri, 09 Aug 2019 08:00:53 -0700 (PDT)
X-Google-Original-Date: Fri, 09 Aug 2019 15:00:45 GMT
Message-Id: <38b53da31f174892b564564e0a380c0a154c8f88.1565362851.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.298.v3.git.gitgitgadget@gmail.com>
References: <pull.298.v2.git.gitgitgadget@gmail.com>
        <pull.298.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 1/7] trace2: cleanup column alignment in perf target format
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

