Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F5731F453
	for <e@80x24.org>; Fri, 25 Jan 2019 12:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbfAYMXe (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 07:23:34 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:33443 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfAYMXe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 07:23:34 -0500
Received: by mail-ed1-f48.google.com with SMTP id p6so7272066eds.0
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 04:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jWQp+OnjGGR/qjsHpDv/5/slcc6yYLWT9gs2Yk2rhoo=;
        b=pS6Ho2AX4H7m3Az41l7t9fc8jmBtA2IkU/7QdwF4CfPd7atR7xwHm3k/258bJqSRrB
         8RX2JljA2+zm2+lXtMAklAY2AYDYns9gmphsBXgiAXDntYL8eax894aZIhbbojk5d0vJ
         9cPGvmSdObKVDdJC94dPh8u34tytraXvVCa+ngHjcuVt6DZ7JDxQ7OCanA6ZMOb8Wb2b
         yYnyfsh0cVnmdUvoYrgyrrB/SGyTi8S+yN6IIYx9AAfNXpHScmYKgMyqlSqQIGzkADa2
         HpB+JlkPU0d8HFbljbmHnqVDR/81wGuDC4CxDZt1Dn95W6T/5g6SF/jbj3BIR0cpAyn6
         qTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jWQp+OnjGGR/qjsHpDv/5/slcc6yYLWT9gs2Yk2rhoo=;
        b=uEhwgI7W0tUiG5UaHdZLCazX49SBo6vrMdLJQ0Q5BZKKTe4BzUt5kY63ChqtAGDc+d
         KqCwH6xADDOEbnoC2gTyPNC0+SkNEuYOsEJwdzWChR6nDCJX0z3f3UtSuwZjqw4Rll6F
         8RxhTrmI/NZNzvpNLeCQRWSQZWEpRvK6022D4e0h4/o7BRJlhHFK8Q1CjviecV31dAdF
         JPo0l74CRBJFZd+m9b6psmanWD7pWMzfkDtEYqG6RY1PiAJdEdFFH9Rq5yYPn47YIrgr
         fPUYont/PrKU8wc4dXS0zSoXP9qWFJK6kdJ9W6RTr7opVOXnYTybdq+1yg9pd0/5THaS
         VCpA==
X-Gm-Message-State: AJcUukdTSLXhnl8wxU81jA/BmnBn2FwJdELuwn2maGq08yQI/IdprjoW
        tXAXe++LReJ7gYrNzm5UehSsJHV4
X-Google-Smtp-Source: ALg8bN7QH9ZP18BGbFRu4N+Hio7O47hqDzLB/t3lOXFOzHxMba0FyX/6ba+7Sh/CEEMUnj97rrQ75g==
X-Received: by 2002:a50:f61e:: with SMTP id c30mr10260058edn.197.1548419012240;
        Fri, 25 Jan 2019 04:23:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b46sm12067092edc.57.2019.01.25.04.23.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 04:23:31 -0800 (PST)
Date:   Fri, 25 Jan 2019 04:23:31 -0800 (PST)
X-Google-Original-Date: Fri, 25 Jan 2019 12:23:23 GMT
Message-Id: <737767b6f4e0367a7797020bd07a6b4357a47413.1548419009.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.v4.git.gitgitgadget@gmail.com>
References: <pull.103.v3.git.gitgitgadget@gmail.com>
        <pull.103.v4.git.gitgitgadget@gmail.com>
From:   "Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 1/7] diff: export diffstat interface
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
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

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
---
 diff.c | 36 ++++++++++++++----------------------
 diff.h | 18 ++++++++++++++++++
 2 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/diff.c b/diff.c
index dc9965e836..46a7d8cf29 100644
--- a/diff.c
+++ b/diff.c
@@ -2421,22 +2421,6 @@ static void pprint_rename(struct strbuf *name, const char *a, const char *b)
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
@@ -5922,12 +5906,7 @@ void diff_flush(struct diff_options *options)
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
@@ -6227,6 +6206,19 @@ static int is_submodule_ignored(const char *path, struct diff_options *options)
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
index ce5e8a8183..7809db3039 100644
--- a/diff.h
+++ b/diff.h
@@ -239,6 +239,22 @@ void diff_emit_submodule_error(struct diff_options *o, const char *err);
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
@@ -327,6 +343,8 @@ void diff_change(struct diff_options *,
 
 struct diff_filepair *diff_unmerge(struct diff_options *, const char *path);
 
+void compute_diffstat(struct diff_options *options, struct diffstat_t *diffstat);
+
 #define DIFF_SETUP_REVERSE      	1
 #define DIFF_SETUP_USE_SIZE_CACHE	4
 
-- 
gitgitgadget

