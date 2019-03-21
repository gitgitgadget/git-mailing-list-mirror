Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AB5120248
	for <e@80x24.org>; Thu, 21 Mar 2019 19:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbfCUTgP (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 15:36:15 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34729 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbfCUTgP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 15:36:15 -0400
Received: by mail-ed1-f65.google.com with SMTP id a16so6026211edn.1
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 12:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dMAOd/T+ToPGGUmA0Er7hLd5R4YI5lTMR3RGutX3LQY=;
        b=RPIW8byz5tHbA7fZaUMM0Lf7FUQNr5veZniLApGolfwJNy+j/zJ7mR0U6qQx7jUTF/
         4+C/E+NHpYhwMTcFj/wGCS37oc8ckc0B9fvE6Ihl4NiznUA8r4j/eexdF75OkH+iuTfW
         RuLoXmYlQjgOKzDvRxdrKf6GnOeXR7q7CqptO5Ni2egldLNVE4LVBqHxyfy37YQum8e0
         xl9UYDfB+G0pMHH8v08pGc9KsEjs5QXE8KPyiWzEH73qYnIiBojKLKmXDbwRVAVvfGqs
         nubaSmB7EARbiFGhck1PzrDy8gjvanUUjajVPqWwSbhukA6MVukZgGy4sVmd8tnKkEIO
         F6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dMAOd/T+ToPGGUmA0Er7hLd5R4YI5lTMR3RGutX3LQY=;
        b=tInrhtTvzYBaXjcY9PlYYzZ1CrDD/oaFo03/eyBvX/SeNbQ3vwRZivXCkWy3ynW/XI
         1wYkQ0MoHMqIkTYcRMBDCDWWH5fuyLW81cEMbTfMm69FqVppR5AZ+qLUFXqkC5eIi9d8
         n7QLpFPTYR5bGr2B2LklODPyiq5UuYY6BaLgVs6hjzMwTv77BOHTFU7aUneNjHVzfobZ
         oj802+YicfhE5QzQPlDyDSiLEEgLdPKZfivEORJNU1D83ZbocGNlGAnQVmVKbFUDOiiU
         TFD5ANDWIC/aZXmM7341Qfwh4dUbjZpuXKV4BPpXglLopMTgOPYHIgTta5W0aIKJAguT
         HbnQ==
X-Gm-Message-State: APjAAAVxtSuauGYH5MjKufAKOt6TXlky62NAjUuk0m6ltxXvjzaViN7e
        0TG0mjfBUTXeWunc0nqsHobGxvKI
X-Google-Smtp-Source: APXvYqxkPivlY6GbLs01cFYX2nq6hIYt0LDFl4d/LvkL0tgP5PQdhx7PpNvWwdk5r70er2L2//dRRw==
X-Received: by 2002:a50:b2c2:: with SMTP id p60mr3501530edd.183.1553196972859;
        Thu, 21 Mar 2019 12:36:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v54sm1943448edm.7.2019.03.21.12.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 12:36:11 -0700 (PDT)
Date:   Thu, 21 Mar 2019 12:36:11 -0700 (PDT)
X-Google-Original-Date: Thu, 21 Mar 2019 19:36:07 GMT
Message-Id: <5595e019c82b0aa67c2c738dbb9b9ec8287ec363.1553196970.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.166.v3.git.gitgitgadget@gmail.com>
References: <pull.166.v2.git.gitgitgadget@gmail.com>
        <pull.166.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 1/4] progress: add sparse mode to force 100% complete
 message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add new start_sparse_progress() and start_delayed_sparse_progress()
constructors and "sparse" flag to struct progress.

Teach stop_progress() to force a 100% complete progress message before
printing the final "done" message when "sparse" is set.

Calling display_progress() for every item in a large set can
be expensive.  If callers try to filter this for performance
reasons, such as emitting every k-th item, progress would
not reach 100% unless they made a final call to display_progress()
with the item count before calling stop_progress().

Now this is automatic when "sparse" is set.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 progress.c | 38 +++++++++++++++++++++++++++++++++++---
 progress.h |  3 +++
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/progress.c b/progress.c
index 5a99c9fbf0..212d00e524 100644
--- a/progress.c
+++ b/progress.c
@@ -34,6 +34,7 @@ struct progress {
 	uint64_t total;
 	unsigned last_percent;
 	unsigned delay;
+	unsigned sparse;
 	struct throughput *throughput;
 	uint64_t start_ns;
 };
@@ -194,7 +195,7 @@ int display_progress(struct progress *progress, uint64_t n)
 }
 
 static struct progress *start_progress_delay(const char *title, uint64_t total,
-					     unsigned delay)
+					     unsigned delay, unsigned sparse)
 {
 	struct progress *progress = malloc(sizeof(*progress));
 	if (!progress) {
@@ -208,6 +209,7 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
 	progress->last_value = -1;
 	progress->last_percent = -1;
 	progress->delay = delay;
+	progress->sparse = sparse;
 	progress->throughput = NULL;
 	progress->start_ns = getnanotime();
 	set_progress_signal();
@@ -216,16 +218,46 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
 
 struct progress *start_delayed_progress(const char *title, uint64_t total)
 {
-	return start_progress_delay(title, total, 2);
+	return start_progress_delay(title, total, 2, 0);
 }
 
 struct progress *start_progress(const char *title, uint64_t total)
 {
-	return start_progress_delay(title, total, 0);
+	return start_progress_delay(title, total, 0, 0);
+}
+
+/*
+ * Here "sparse" means that the caller might use some sampling criteria to
+ * decide when to call display_progress() rather than calling it for every
+ * integer value in[0 .. total).  In particular, the caller might not call
+ * display_progress() for the last value in the range.
+ *
+ * When "sparse" is set, stop_progress() will automatically force the done
+ * message to show 100%.
+ */
+struct progress *start_sparse_progress(const char *title, uint64_t total)
+{
+	return start_progress_delay(title, total, 0, 1);
+}
+
+struct progress *start_delayed_sparse_progress(const char *title,
+					       uint64_t total)
+{
+	return start_progress_delay(title, total, 2, 1);
+}
+
+static void finish_if_sparse(struct progress *progress)
+{
+	if (progress &&
+	    progress->sparse &&
+	    progress->last_value != progress->total)
+		display_progress(progress, progress->total);
 }
 
 void stop_progress(struct progress **p_progress)
 {
+	finish_if_sparse(*p_progress);
+
 	stop_progress_msg(p_progress, _("done"));
 }
 
diff --git a/progress.h b/progress.h
index 70a4d4a0d6..7b725acc8d 100644
--- a/progress.h
+++ b/progress.h
@@ -6,7 +6,10 @@ struct progress;
 void display_throughput(struct progress *progress, uint64_t total);
 int display_progress(struct progress *progress, uint64_t n);
 struct progress *start_progress(const char *title, uint64_t total);
+struct progress *start_sparse_progress(const char *title, uint64_t total);
 struct progress *start_delayed_progress(const char *title, uint64_t total);
+struct progress *start_delayed_sparse_progress(const char *title,
+					       uint64_t total);
 void stop_progress(struct progress **progress);
 void stop_progress_msg(struct progress **progress, const char *msg);
 
-- 
gitgitgadget

