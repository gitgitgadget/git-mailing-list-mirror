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
	by dcvr.yhbt.net (Postfix) with ESMTP id DE3901F461
	for <e@80x24.org>; Tue, 16 Jul 2019 14:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387960AbfGPO6l (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 10:58:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37134 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387944AbfGPO6l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 10:58:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so21324563wrr.4
        for <git@vger.kernel.org>; Tue, 16 Jul 2019 07:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mpkeVPikkrkZ341eok9WN8D60Cbru9upeIgIoTv35/M=;
        b=gaV3QjEDuJvZ/qndJeW0NKWqATawtU617tBllzFPMko4Hs+Qrscf0gbPF6bWtIrI+F
         33657zqsJa4jdJR2yNoUd/d/LP1SzWYukFNWa1MdQDU/PoMIyBhJH8L/DK8guLUVnyfU
         4NMZtJI95SU4Q/4lsdDV9/8EHyaYdaHxDsqC3xWSZy2FbbxHeHSWcjRlWI6QeOjVnF4Z
         FLXDHAaJvRG8rl5OGlxqSNciaddqwh9CoRTYoA84XOIwTFAmYLJfb+Cg9zGFAtke9SMJ
         lsT+VN89lM1wsZZkYqCAW2LAmWBWcnuhhShFqo/AbJNyvaGkFInv7aUb3D29iqAfoRhH
         ICuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mpkeVPikkrkZ341eok9WN8D60Cbru9upeIgIoTv35/M=;
        b=ti/6OrQGEVdelTlwhuymUiEARVme8R+Nry/hoJ88o73bG/SCXpIEWPTdZ61sGCexN4
         aimMEGgeD6YRL327F5PmsL8u20/uiabxhVY8UqQkaN9d88Q6nC9fkXwp9bT/MrRbcGAc
         1mPnjajyfURAJpndEWSO+CWw+J2YtkmGFwqzjgX10Nl23EXpc1gp9zTBpivoBxdfVdGU
         Buu7H2JBz6KQDANbwxJeVtATZLEdVkaz7unhLvAPin6Qi3rgXa5ZuPOrjs5oytBE0HEV
         LUgolHJasv8pPqi7hTRHrhcdqTMv+46e/7PviiSp6mS9OgIjUPh7FUVTsxNNX3xwJnOg
         NW2Q==
X-Gm-Message-State: APjAAAXA06BA0wXRhRXiQIqFkHCRmhElSeDGXaa0G6uuUAPbRDZhRewD
        Tb0ldlKdRugJBp/6XHgtu5mDPrER
X-Google-Smtp-Source: APXvYqwcB78pWDkiHBU+gvfxkS/dAo0v8oZ+fkx7Tk3hvHMFhOSWqFS8tpToWfl6duNHYdcmPhVxug==
X-Received: by 2002:adf:cf0d:: with SMTP id o13mr23731012wrj.291.1563289118611;
        Tue, 16 Jul 2019 07:58:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c1sm39253359wrh.1.2019.07.16.07.58.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 07:58:38 -0700 (PDT)
Date:   Tue, 16 Jul 2019 07:58:38 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Jul 2019 14:58:26 GMT
Message-Id: <c7a377890d84849ea2f63099cfc081420a4de15d.1563289115.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v3.git.gitgitgadget@gmail.com>
References: <pull.170.v2.git.gitgitgadget@gmail.com>
        <pull.170.v3.git.gitgitgadget@gmail.com>
From:   "Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 02/11] diff: export diffstat interface
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>, Jeff King <peff@peff.net>,
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
Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff.c | 37 +++++++++++++++----------------------
 diff.h | 19 +++++++++++++++++++
 2 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/diff.c b/diff.c
index 1ee04e321b..03d6f00d97 100644
--- a/diff.c
+++ b/diff.c
@@ -2489,22 +2489,6 @@ static void pprint_rename(struct strbuf *name, const char *a, const char *b)
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
@@ -6273,12 +6257,7 @@ void diff_flush(struct diff_options *options)
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
@@ -6611,6 +6590,20 @@ static int is_submodule_ignored(const char *path, struct diff_options *options)
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
index b680b377b2..34fc658946 100644
--- a/diff.h
+++ b/diff.h
@@ -244,6 +244,22 @@ void diff_emit_submodule_error(struct diff_options *o, const char *err);
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
@@ -333,6 +349,9 @@ void diff_change(struct diff_options *,
 
 struct diff_filepair *diff_unmerge(struct diff_options *, const char *path);
 
+void compute_diffstat(struct diff_options *options, struct diffstat_t *diffstat,
+		      struct diff_queue_struct *q);
+
 #define DIFF_SETUP_REVERSE      	1
 #define DIFF_SETUP_USE_SIZE_CACHE	4
 
-- 
gitgitgadget

