Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 453E41F453
	for <e@80x24.org>; Wed, 20 Feb 2019 11:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfBTLlc (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 06:41:32 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:39396 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfBTLlb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 06:41:31 -0500
Received: by mail-ed1-f53.google.com with SMTP id p27so12033092edc.6
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 03:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+9eD0YtFGoh1BM612J1vEUvognradigDRhsqHPidzjE=;
        b=aVHTw5TmSorYi9pqGD5oEpj2LmyKV7LAGNsXZN/pXKEVk2LiQAd32bfp7FHmEO5T4+
         U8WHsVz2z+DJ8baf7ghID+XHfaQ7gWbImzgIW+alL2q7y3DhIrfo1cnpxx2WGBJfqmo9
         QGvodx6MWvQ7e0uM6BntueAU3j/ncFNgnSSSq7xWRBsGB3x3+voFnoGZbAch6jxMt2Js
         T+7PO8jXfYxDb60MeGBmWYVRKvDF50iorQghnWGCvQAvsX8hAkEB1pdqG8P5DvhPttmD
         GQCeNi+qk3FFzv8c4Jz7OV3mL41Cm3jWVlhjGaDNDd0XJqwtos1nE49GlwdFley0GlFy
         276g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+9eD0YtFGoh1BM612J1vEUvognradigDRhsqHPidzjE=;
        b=NdH+JUQ9VQXHMwb4M5sQzBOLpWEBIz8WaqCzoH1MVSKaGkAyHGRVXxWgEH/dRpzCbQ
         7JLFegxOFDBAEN8tfwfFrWxhKEQ6WNhlpeXH2Yn7RtI3qKY0u6Ozi7YW30hz/fGOZASf
         HKIqE8ZE7dbG5R98ZDaPfkg6JiPA7AVS69a8Ij+wTOmUJSTI7i8//YzEfzLV0NLSHW7s
         S97XPTN0BCYQb+tjwqo7B2cHKN2w35EwLXb+oi1JJeoJAchiImGajgpTGigPbsEDtLYR
         y1X5Fk/ujAKnTA53H133J7zRWhNu0fOKPHzn9OartEc5j5mx3IEe5YmDr+Fhiurj1TII
         4jgg==
X-Gm-Message-State: AHQUAuaR9D+NYKGIjz5HptM1MeoquvGj8j3W6CF37y4ywafyzyjimLL7
        SWUcJVd6Flg+MSNgczS6wkWuaLDm
X-Google-Smtp-Source: AHgI3IbSa19MMOkvlZ6qtPNVCSGqx9EjamSRmblk3hUsBzjGsVttNJO/3brOC/OcYaK/73dxF1/gzg==
X-Received: by 2002:aa7:db04:: with SMTP id t4mr10054599eds.173.1550662889440;
        Wed, 20 Feb 2019 03:41:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i1-v6sm4001553eja.43.2019.02.20.03.41.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 03:41:29 -0800 (PST)
Date:   Wed, 20 Feb 2019 03:41:29 -0800 (PST)
X-Google-Original-Date: Wed, 20 Feb 2019 11:41:18 GMT
Message-Id: <d839f0c082ece5298647f8dfbfd0566d59c58172.1550662887.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.v5.git.gitgitgadget@gmail.com>
References: <pull.103.v4.git.gitgitgadget@gmail.com>
        <pull.103.v5.git.gitgitgadget@gmail.com>
From:   "Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 01/10] diff: export diffstat interface
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
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

Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
---
 diff.c | 36 ++++++++++++++----------------------
 diff.h | 18 ++++++++++++++++++
 2 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/diff.c b/diff.c
index 5306c48652..e290a95f4b 100644
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
@@ -6001,12 +5985,7 @@ void diff_flush(struct diff_options *options)
 	    dirstat_by_line) {
 		struct diffstat_t diffstat;
 
-		memset(&diffstat, 0, sizeof(struct diffstat_t));
-		for (i = 0; i < q->nr; i++) {
-			struct diff_filepair *p = q->queue[i];
-			if (check_pair_status(p))
-				diff_flush_stat(p, options, &diffstat);
-		}
+		compute_diffstat(options, &diffstat);
 		if (output_format & DIFF_FORMAT_NUMSTAT)
 			show_numstat(&diffstat, options);
 		if (output_format & DIFF_FORMAT_DIFFSTAT)
@@ -6306,6 +6285,19 @@ static int is_submodule_ignored(const char *path, struct diff_options *options)
 	return ignored;
 }
 
+void compute_diffstat(struct diff_options *options, struct diffstat_t *diffstat)
+{
+	int i;
+	struct diff_queue_struct *q = &diff_queued_diff;
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
index b512d0477a..a4a986ad6e 100644
--- a/diff.h
+++ b/diff.h
@@ -240,6 +240,22 @@ void diff_emit_submodule_error(struct diff_options *o, const char *err);
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
@@ -328,6 +344,8 @@ void diff_change(struct diff_options *,
 
 struct diff_filepair *diff_unmerge(struct diff_options *, const char *path);
 
+void compute_diffstat(struct diff_options *options, struct diffstat_t *diffstat);
+
 #define DIFF_SETUP_REVERSE      	1
 #define DIFF_SETUP_USE_SIZE_CACHE	4
 
-- 
gitgitgadget

