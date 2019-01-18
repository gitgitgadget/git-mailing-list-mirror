Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5662A1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 07:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfARHrG (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 02:47:06 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:35265 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbfARHrF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 02:47:05 -0500
Received: by mail-ed1-f44.google.com with SMTP id x30so10434226edx.2
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 23:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jWQp+OnjGGR/qjsHpDv/5/slcc6yYLWT9gs2Yk2rhoo=;
        b=K1b2Jk3fP4Y16b1Lt2WKjB2pqagKrg5mp+eEqM4p8GjhPejFf0JHhi6OZ29ICIertD
         7px58X/x2WiTFM8ztM+Z8+BGGrwZbvyXSmbF/WAD0/btlZ5JhxOZ75rl9vhlYgXMMEjh
         CcFqfYLzuZA+gK+v14VDGa70kqoOAWuMWagKlbvhnMBsNi0ECuAe+dPS/G4GU0uCWsX8
         K4ShcEg5dZpv5hP7bttG7rvQMoLaBgP3P/XeTz7t0b0UvNFeMrzSU3VgPKf0X4Na7GBW
         zjLvbZX5f/VGDEulYMGyelEzT7WQm+7FYjgKfJpGc65vUSapiLH8q9cIrlSnwduyovNc
         IY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jWQp+OnjGGR/qjsHpDv/5/slcc6yYLWT9gs2Yk2rhoo=;
        b=I0ph7zRUfYHMs35BhZ4xacUkcEy1x12eciwZehDXfdPBAO3Yl7FbmrkWoc5Ykuhp7E
         oS4HtARsIir1sf2ayovrw364PPd6LhEXyNQqS1d/Hb8bjVP3czzo2lkWGnNrd9cs8V4j
         dpdZHjQAtRSjPg4TYI6G0vuVDoupTdlrm6doaCYo9w4uGb3Y5uxOZ1KPWyxs9p4t+Skb
         sNED+WBvXFp/eLXeM+eiHd1++yYm9WzldSxjEYmcDhdr9++dfU5o2v970c515GTtJ7Pg
         gBVI2/gVhlemRviNfJzoOzGn89OD9TCsprGvOOUoQrQsLvgqlMTMQ0W/yR7vj3bKqVDD
         AEew==
X-Gm-Message-State: AJcUukf5r8TQZkFFjYL250kTm3yqNGhAIVztdoRDD7unDxmYahLXXvqw
        d1HggK/8Y0yN4wFSXQXcLYLkIpmC
X-Google-Smtp-Source: ALg8bN5oeQca+PgqpSlhOgYCxGCYc9Cwcu9mQo9nbpfye0yfpVD4rPRwx07unirOgOeX+W4KjxWVNQ==
X-Received: by 2002:a50:8bc9:: with SMTP id n9mr14963193edn.41.1547797623276;
        Thu, 17 Jan 2019 23:47:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e51sm6893258edd.35.2019.01.17.23.47.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 23:47:02 -0800 (PST)
Date:   Thu, 17 Jan 2019 23:47:02 -0800 (PST)
X-Google-Original-Date: Fri, 18 Jan 2019 07:46:54 GMT
Message-Id: <737767b6f4e0367a7797020bd07a6b4357a47413.1547797620.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.v2.git.gitgitgadget@gmail.com>
References: <pull.103.git.gitgitgadget@gmail.com>
        <pull.103.v2.git.gitgitgadget@gmail.com>
From:   "Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/7] diff: export diffstat interface
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
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

