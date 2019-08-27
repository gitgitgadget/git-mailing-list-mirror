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
	by dcvr.yhbt.net (Postfix) with ESMTP id 181201F461
	for <e@80x24.org>; Tue, 27 Aug 2019 12:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbfH0M6F (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 08:58:05 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:35846 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbfH0M56 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 08:57:58 -0400
Received: by mail-wr1-f54.google.com with SMTP id y19so851110wrd.3
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 05:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=l25ies6dv1TGwp/ChEvj6ryxriJQU9OfmiV2WryrGnE=;
        b=q+BrlX1yGjauO442Nuyy6Zv6TPT8PuK9mk3+KBQDqHisdSRWMnGhI4Uc1yDBTnjd4c
         zlLne3bPknee8b+E4R2j62cwgVxvDUppwtBWq18NJiLTH5qeIGq5hBci4WcU95GMHhSz
         Uc3GQoAas6Wi3GhCKi+b8bxz2gvXhsSg647iLlBUMswHB62njyHX2FVGY9a2DgJQA/bC
         G7sJ6Y9RewR8zbJUPCLyIOjho7Irqg7TmH4O5tgiMlg1mxY7qP39/z+oQygYbrYvZJiB
         XLuT7VQwz0JsXDEyhhG++K0crpUVbjK9bdztPrDbqfucRqyF0ABAbbVkJGeLDt3sqO/w
         7B7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=l25ies6dv1TGwp/ChEvj6ryxriJQU9OfmiV2WryrGnE=;
        b=l5hiu+ElTcEPI6suo3A4kbYjJBD9qhimCd6Fd5uMiwtU2adIle0vVr4/aTxW0v+Mbu
         I3Y7KleeQRH6ei3GGw92RS06lpohjcMLKb2xPW3rm1fKDhiMTdb3o+P79C3oMcWjiyNn
         /TqszO1F8MYbqhOKrXtwAuNRyG1YOFnYXMyI7Z9bRa01gNio9NBXoeNbJ435HKmTpbob
         cSgQ5Y+84u1aj5hjAyyEWb/7UCLNF7x2TcGis+MbncQQqiyrYE3xUbB+fpbhCvxnwOvZ
         Iu3TKpPkQbWNkdcfsA8IsS2LJIOguBeJn4Kpk3JusAwYJEKUZD7mqsCzqlPLrdYm9h0p
         m4yg==
X-Gm-Message-State: APjAAAWX5NK/Earh5mXw0p/64LiDGhZ39hNxOaUf9oGzDWrI/mv7vdPE
        unlKom+UKVm5I7v17m/qQWTzxwxxGjM=
X-Google-Smtp-Source: APXvYqzV74N4+rWgXczF62tvW0gXjDcSajQyFzCrZAGiGRzmfo6n+ZmOVHVjLAyWBdrCuIltfMD3jg==
X-Received: by 2002:a5d:6606:: with SMTP id n6mr3829903wru.346.1566910675804;
        Tue, 27 Aug 2019 05:57:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f10sm12821459wrs.22.2019.08.27.05.57.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 05:57:55 -0700 (PDT)
Date:   Tue, 27 Aug 2019 05:57:55 -0700 (PDT)
X-Google-Original-Date: Tue, 27 Aug 2019 12:57:43 GMT
Message-Id: <38cc04c1d9816bc3bad960df0d5edea3020a9173.1566910672.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v4.git.gitgitgadget@gmail.com>
References: <pull.170.v3.git.gitgitgadget@gmail.com>
        <pull.170.v4.git.gitgitgadget@gmail.com>
From:   "Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 02/11] diff: export diffstat interface
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
 diff.c | 39 ++++++++++++++++-----------------------
 diff.h | 20 ++++++++++++++++++++
 2 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/diff.c b/diff.c
index efe42b341a..6829a74065 100644
--- a/diff.c
+++ b/diff.c
@@ -2492,22 +2492,6 @@ static void pprint_rename(struct strbuf *name, const char *a, const char *b)
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
@@ -3154,7 +3138,7 @@ static void show_dirstat_by_line(struct diffstat_t *data, struct diff_options *o
 	gather_dirstat(options, &dir, changed, "", 0);
 }
 
-static void free_diffstat_info(struct diffstat_t *diffstat)
+void free_diffstat_info(struct diffstat_t *diffstat)
 {
 	int i;
 	for (i = 0; i < diffstat->nr; i++) {
@@ -6278,12 +6262,7 @@ void diff_flush(struct diff_options *options)
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
@@ -6616,6 +6595,20 @@ static int is_submodule_ignored(const char *path, struct diff_options *options)
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
index c2c3056810..c791ecc972 100644
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

