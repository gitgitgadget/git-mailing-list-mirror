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
	by dcvr.yhbt.net (Postfix) with ESMTP id 43D351F454
	for <e@80x24.org>; Mon,  4 Nov 2019 12:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfKDMPi (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 07:15:38 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38159 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfKDMPh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 07:15:37 -0500
Received: by mail-wm1-f67.google.com with SMTP id z19so11648450wmk.3
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 04:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=rFMaUJqcvtNZv6SXcUG484Xgjg/pJ3HxwuEagPqFxzA=;
        b=B/TZTORip39O3Y1L6Cad+a/Ro28AAl31Q/Ee5xPmZ6TPQLxACSuYueQ1JNs2x6KwLn
         jfigja131stGxKkPWfDG5Uio5r46Q0Iu6FnEetRmLkokeo48LQaxnEk9IB3s3Q204sxC
         AElwlBwJtVmm70oItyedA9nzKHRjyWKCcOHeeB/X0VG7wroSdJGLiYTu1NyU6uzlVEZF
         rPvgcxfxMepKBuyZnhVsBMqpf0cpK1W9Mqmu0cuJ9PazhNVMCp6oMN96oGG9jGyQ9Ae1
         x8LuKviuLNbo80oMa8NWof9VeHt96n+SoK3yx9pleqv3xDLCaJod/qJV5WLUbUlnqArx
         CA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=rFMaUJqcvtNZv6SXcUG484Xgjg/pJ3HxwuEagPqFxzA=;
        b=W8Fc9LPDowUToTluaNbljX/E6QGVQYCtLXMhkdhp6X0w9MH0buhPNAxHGQD1tWjd3R
         Er54g+EqTolcP0P6Vdn7dQaPQQCra6QdQaGi3/P+5bXLxBfKlVli2vrV0r4faLO+NLpf
         RxPWuCKk9JC9e3gvtvDjk/RxqrQL4H4nRU2v17scAvvNO5IAgrxvlnh/mwkiBDZoPtb2
         lRTMqwv8mdALoTLubIDXvsnqu11NP68m7N+4aIs/NxRFrFIpbi4wuK03fQ3MJWnvkk+2
         4vEmnQ0EAZSrVlg+CyoQQA57D1KXazFHCdZ6Z686jOg8k42oWtSq24N4SXDFh6Ml1rQ0
         dY6w==
X-Gm-Message-State: APjAAAXNTnXfasgFlWv10HdoVwEsENT/tVr1oPg+GgLdkL5XmJ4s0Z9x
        FLTosg9LPeH+szp9eUiFyB+UAeyo
X-Google-Smtp-Source: APXvYqw0y0uoujxtH1mFNROehe/waLC8CsCwfyv0hm43bZKt/RuEU8GjHZIE1tOKBM/PvVKXM8PnWQ==
X-Received: by 2002:a05:600c:c5:: with SMTP id u5mr6146169wmm.35.1572869733718;
        Mon, 04 Nov 2019 04:15:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s12sm18655649wme.20.2019.11.04.04.15.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 04:15:33 -0800 (PST)
Message-Id: <2fc8cc354690841cd8496d9a7660faf572580aef.1572869730.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v5.git.1572869729.gitgitgadget@gmail.com>
References: <pull.170.v4.git.gitgitgadget@gmail.com>
        <pull.170.v5.git.1572869729.gitgitgadget@gmail.com>
From:   "Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Nov 2019 12:15:22 +0000
Subject: [PATCH v5 2/9] diff: export diffstat interface
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Daniel Ferreira <bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Daniel Ferreira <bnmvco@gmail.com>

Make the diffstat interface (namely, the diffstat_t struct and
compute_diffstat) no longer be internal to diff.c and allow it to be used
by other parts of git.

This is helpful for code that may want to easily extract information
from files using the diff machinery, while flushing it differently from
how the show_* functions used by diff_flush() do it. One example is the
builtin implementation of git-add--interactive's status.

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
Signed-off-by: Slavica Đukić <slawica92@hotmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff.c | 39 ++++++++++++++++-----------------------
 diff.h | 20 ++++++++++++++++++++
 2 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/diff.c b/diff.c
index afe4400a60..5703a9b78f 100644
--- a/diff.c
+++ b/diff.c
@@ -2495,22 +2495,6 @@ static void pprint_rename(struct strbuf *name, const char *a, const char *b)
 	}
 }
 
-struct diffstat_t {
-	int nr;
-	int alloc;
-	struct diffstat_file {
-		char *from_name;
-		char *name;
-		char *print_name;
-		const char *comments;
-		unsigned is_unmerged:1;
-		unsigned is_binary:1;
-		unsigned is_renamed:1;
-		unsigned is_interesting:1;
-		uintmax_t added, deleted;
-	} **files;
-};
-
 static struct diffstat_file *diffstat_add(struct diffstat_t *diffstat,
 					  const char *name_a,
 					  const char *name_b)
@@ -3157,7 +3141,7 @@ static void show_dirstat_by_line(struct diffstat_t *data, struct diff_options *o
 	gather_dirstat(options, &dir, changed, "", 0);
 }
 
-static void free_diffstat_info(struct diffstat_t *diffstat)
+void free_diffstat_info(struct diffstat_t *diffstat)
 {
 	int i;
 	for (i = 0; i < diffstat->nr; i++) {
@@ -6283,12 +6267,7 @@ void diff_flush(struct diff_options *options)
 	    dirstat_by_line) {
 		struct diffstat_t diffstat;
 
-		memset(&diffstat, 0, sizeof(struct diffstat_t));
-		for (i = 0; i < q->nr; i++) {
-			struct diff_filepair *p = q->queue[i];
-			if (check_pair_status(p))
-				diff_flush_stat(p, options, &diffstat);
-		}
+		compute_diffstat(options, &diffstat, q);
 		if (output_format & DIFF_FORMAT_NUMSTAT)
 			show_numstat(&diffstat, options);
 		if (output_format & DIFF_FORMAT_DIFFSTAT)
@@ -6621,6 +6600,20 @@ static int is_submodule_ignored(const char *path, struct diff_options *options)
 	return ignored;
 }
 
+void compute_diffstat(struct diff_options *options,
+		      struct diffstat_t *diffstat,
+		      struct diff_queue_struct *q)
+{
+	int i;
+
+	memset(diffstat, 0, sizeof(struct diffstat_t));
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		if (check_pair_status(p))
+			diff_flush_stat(p, options, diffstat);
+	}
+}
+
 void diff_addremove(struct diff_options *options,
 		    int addremove, unsigned mode,
 		    const struct object_id *oid,
diff --git a/diff.h b/diff.h
index 7f8f024feb..d986ddc3b5 100644
--- a/diff.h
+++ b/diff.h
@@ -245,6 +245,22 @@ void diff_emit_submodule_error(struct diff_options *o, const char *err);
 void diff_emit_submodule_pipethrough(struct diff_options *o,
 				     const char *line, int len);
 
+struct diffstat_t {
+	int nr;
+	int alloc;
+	struct diffstat_file {
+		char *from_name;
+		char *name;
+		char *print_name;
+		const char *comments;
+		unsigned is_unmerged:1;
+		unsigned is_binary:1;
+		unsigned is_renamed:1;
+		unsigned is_interesting:1;
+		uintmax_t added, deleted;
+	} **files;
+};
+
 enum color_diff {
 	DIFF_RESET = 0,
 	DIFF_CONTEXT = 1,
@@ -334,6 +350,10 @@ void diff_change(struct diff_options *,
 
 struct diff_filepair *diff_unmerge(struct diff_options *, const char *path);
 
+void compute_diffstat(struct diff_options *options, struct diffstat_t *diffstat,
+		      struct diff_queue_struct *q);
+void free_diffstat_info(struct diffstat_t *diffstat);
+
 #define DIFF_SETUP_REVERSE      	1
 #define DIFF_SETUP_USE_SIZE_CACHE	4
 
-- 
gitgitgadget

