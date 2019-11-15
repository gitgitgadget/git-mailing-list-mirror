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
	by dcvr.yhbt.net (Postfix) with ESMTP id DFD3E1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 11:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfKOLL1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 06:11:27 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42711 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbfKOLL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 06:11:26 -0500
Received: by mail-wr1-f65.google.com with SMTP id a15so10516440wrf.9
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 03:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=rFMaUJqcvtNZv6SXcUG484Xgjg/pJ3HxwuEagPqFxzA=;
        b=riifydFD28Ncxdjz2gYimWPhIVhVsT4xV8O7bD57tZ+CP7YJeAThSPnvlJuNd8aGnw
         FMiwmquZbv3H2aijcz5hOaXqsIqgaATqrPIHlBB63S/TFA5gQV7Ws22rEPynxEcOkg6S
         dxOqfsl4MgogPyybWh3B5v2epuNTbg9FWRb5EPauoRmf+noH/ktpDIwiaoX05bVCPCIh
         dAe/uY/xtQQP4spL77rncfQSQ6lxwB7d9V52dpXbkJeyFK4ESUyQXxUlDWHhNqbxBUIZ
         5EjqRqvLYcB7wUK3R8h5q5NiRTJv6MrZ1IgftfiTSA9PMTua7lH7brJDgjZnnxA+aej5
         kvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=rFMaUJqcvtNZv6SXcUG484Xgjg/pJ3HxwuEagPqFxzA=;
        b=aOmLqvEMKUn6VAHOlcXdgcfVHL86hevK3zBrKPOcazda0Dn+KmTjVSy/B3q/6go7TP
         99yeU47l/EX9aUG42dmPz+IzypIi2YR8sAbvQ8M2ttXPMnLLWJu5ru6599tFiYn+dMIq
         K5mGoG/UKw+vHBepqnBfUS7S4yU1UCqEdAoK2Hmj4gf2ittuN/OV1bkrDCnMn9o4PsoO
         +cAwZmKJ5GrpBhaSWriL/gk5FxDCnWAv6e3XD0UaAL7/bTEzueK9jftBtkiWLWWZIkv1
         fjO+x+UMP6yTF+AiNKgioXWAWGLAPDaUE6kJyM7P5mfPEiiEu7PHIcYTMEkJ8asGcjsL
         pKUA==
X-Gm-Message-State: APjAAAX+FlGk5WEOP190ZtLamy/hrKiehdLi7Ckqy5W0axP5jTGEuNJs
        q20bPH6ntCKPyhJkI4T6u1tKBRVC
X-Google-Smtp-Source: APXvYqwlcMXCAq8BAj5SW2ny5oTTrWt/XgtUpphElyIAwbTLRJ5R43V+AjAR3whFv/ZmTRj5dCaFVg==
X-Received: by 2002:adf:e911:: with SMTP id f17mr11509265wrm.300.1573816283553;
        Fri, 15 Nov 2019 03:11:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m16sm9500432wml.47.2019.11.15.03.11.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 03:11:23 -0800 (PST)
Message-Id: <f42d7b13107743fc1aa9cc42ee188fdeb10c702b.1573816280.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v7.git.1573816280.gitgitgadget@gmail.com>
References: <pull.170.v6.git.1573648866.gitgitgadget@gmail.com>
        <pull.170.v7.git.1573816280.gitgitgadget@gmail.com>
From:   "Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Nov 2019 11:11:13 +0000
Subject: [PATCH v7 2/9] diff: export diffstat interface
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     "Jeff Hostetler <git@jeffhostetler.com>, Jeff King" <peff@peff.net>,
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

