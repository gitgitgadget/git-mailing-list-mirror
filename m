Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA7B11F461
	for <e@80x24.org>; Mon, 13 May 2019 17:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731717AbfEMR15 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 13:27:57 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44671 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731668AbfEMR15 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 13:27:57 -0400
Received: by mail-ed1-f67.google.com with SMTP id b8so18670903edm.11
        for <git@vger.kernel.org>; Mon, 13 May 2019 10:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NmPrKBH95W/J/xZgv+G4CsKw6zBPtFdY24F+BBhsbJU=;
        b=YuCrYniw3DtHH+anCYTpqneUMVnkIkQNp6OA40X1sI0P1y0EKkgMrrT7OS4AEsaQ7E
         g0zq5BseS6pm4x0K1uNXTnpiX3pYsNZLnjjoZrhdxXkT7gb8+7oc3RP6EW39YG7S6B+W
         qYiPbVSSgSDcZaZzTyewlceVJmHGfg/aJvrkpem0otHHPMWe9yogIOFtS6I2aGEtvwl6
         YaYWw7pp2yzso4jfcGZlPvbgxXDo5VVitEVEvgVI5sJq3rAB8XO2MOVFfaEI282LXIdm
         rC7yJD+xXGsN4uHghYs34l8fOLGFo6fu2uBxOCHKpx5z7fR+apPfInWnPoba6CiHPZ4h
         Zzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NmPrKBH95W/J/xZgv+G4CsKw6zBPtFdY24F+BBhsbJU=;
        b=AghuyMapfcOYByxqAnRdGULh6poUIcMGJaA0dZ4oJWqLxfFXvadqV6+LJlTcKLXYTo
         zRGuIKYHylA7i5PeYc5LzJjcmmC3gt0P7KyT6PKzXnC0LAbWXPhLrndzYADJIPI9l+Aw
         GAzMFQYwjKyGGU7JOYb6xQr82hO5MEpAIBHcxLoru/3/4E+zxxxjFSjreAbZ64xthFCH
         43hEVIo25hwMzsJ5jXuzULGbvGpZ56knPLoIr9PcQbao2xH7hf9bDYiZ833RUkAsST0s
         mHJ9VW+lrjtup3DBS46gv3XjwJJTDZ5z0mPerzEIV/rktmLZI0F/OAC65l9ErOCgQAwR
         SAJw==
X-Gm-Message-State: APjAAAWhVihjyhPOmrtMpAGemhlB0HuAI0whfwkXibsffmJM0ElcR5op
        Pk56ZJ+GS8wmEDZ9g4mfXE9D41mx
X-Google-Smtp-Source: APXvYqz5XPJUGC9UmEHqprDHuXuQgbxk6s5iqhlt2dDydJ40QICejid5xEMCTLEqjKiHVW0rpcVCsg==
X-Received: by 2002:a50:9490:: with SMTP id s16mr31151625eda.260.1557768475315;
        Mon, 13 May 2019 10:27:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f13sm1777163eja.17.2019.05.13.10.27.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 10:27:54 -0700 (PDT)
Date:   Mon, 13 May 2019 10:27:54 -0700 (PDT)
X-Google-Original-Date: Mon, 13 May 2019 17:27:42 GMT
Message-Id: <bc99009fbf0e01e9bbe77aa6410489beadf454dc.1557768471.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v2.git.gitgitgadget@gmail.com>
References: <pull.170.git.gitgitgadget@gmail.com>
        <pull.170.v2.git.gitgitgadget@gmail.com>
From:   "Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 02/11] diff: export diffstat interface
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
index 5306c48652..daa5f3a736 100644
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
+		compute_diffstat(options, &diffstat, q);
 		if (output_format & DIFF_FORMAT_NUMSTAT)
 			show_numstat(&diffstat, options);
 		if (output_format & DIFF_FORMAT_DIFFSTAT)
@@ -6306,6 +6285,20 @@ static int is_submodule_ignored(const char *path, struct diff_options *options)
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
index b512d0477a..ae9bedfab8 100644
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
@@ -328,6 +344,9 @@ void diff_change(struct diff_options *,
 
 struct diff_filepair *diff_unmerge(struct diff_options *, const char *path);
 
+void compute_diffstat(struct diff_options *options, struct diffstat_t *diffstat,
+		      struct diff_queue_struct *q);
+
 #define DIFF_SETUP_REVERSE      	1
 #define DIFF_SETUP_USE_SIZE_CACHE	4
 
-- 
gitgitgadget

