Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B57EB20248
	for <e@80x24.org>; Tue, 19 Mar 2019 14:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfCSOhx (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 10:37:53 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45047 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfCSOhw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 10:37:52 -0400
Received: by mail-ed1-f66.google.com with SMTP id x10so13634708edh.11
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 07:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7Ttuzw6L3lhXQ6nI6ALN2Oi6by0eWbALROZxX6/U3UE=;
        b=vAHxmKGEXxEof6psh12WkLkvWU2OSXOrA/8mWdw3uEuXxbdZ/IgAGkQYMhG1rFyPcL
         4NfYy54v00hXXL2jp3pvwscY6kkFqqSyqXAOUsoUJT3cQzoP3lOo5ML9sxFnjnDVwLA9
         BP2pLkk73HQucFjA47bxdxnig1VimWCiZSxFW71nMI3Xv1EjdbIJp2N+nWaSMnN+H3Dj
         GxJGrR5egR3S5gugyFrw3eSyaUgldOQN8GZfN4OfY7/tlIuHr+cwcSRjoFTdXlEbn3+N
         TKme1gP8Z3ZVAyfc+30w9oFzbwbhbwLvImzCmFZSsQhx6TmaMDImH2WuEl5mF6eMxt1K
         4gqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7Ttuzw6L3lhXQ6nI6ALN2Oi6by0eWbALROZxX6/U3UE=;
        b=qdQC1MBadUcbUWXO9ynZRDk5XLS7CrSe8bn+LIsc8wqGEx9aV0N8E9CdRfd9ZG0Qvl
         +Ohnl8VGfLH/gbp54PwqWaks5799Y9CWEPzMSNOekZDD+1R90hsBy59owcEh42zjZmYh
         /s6P1ZYRmpEfiPEXp1LgHOKGrccKPSNjzewaH9P40yokoukwIBhf5V1io+Krf3fSXrpB
         T32mA0awt4vQ0+XXeG2qWhKwWFJBKw9QSML2JEEi8teHODDaKT3eYTa1zJWXxH53hZDJ
         yoY31aCLZDWKwmArhgvoxJXuVHoQCGITbXedV1s96ck/VwmRBw+WlFL+oqmmslXeFokl
         Mo4Q==
X-Gm-Message-State: APjAAAWWho3ahXanhltuJ7fBhc58o1zDQfFYJORhPV7fOV631F5xj8Hf
        IOqooUcvJw28kZjfujDcrjryyf0V
X-Google-Smtp-Source: APXvYqx97nfdaoD12BmRQ1aIu72IY8U4X3TfZdAO5Kb1aqKjl17awyOhLuyNPdjAEUNTe5ehRbrLVg==
X-Received: by 2002:a50:d94f:: with SMTP id u15mr16256163edj.256.1553006270299;
        Tue, 19 Mar 2019 07:37:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h27sm3078419eja.73.2019.03.19.07.37.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 07:37:49 -0700 (PDT)
Date:   Tue, 19 Mar 2019 07:37:49 -0700 (PDT)
X-Google-Original-Date: Tue, 19 Mar 2019 14:37:44 GMT
Message-Id: <e1da1f84a85165703e3b6be4a240bd36d62b4b01.1553006268.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.166.v2.git.gitgitgadget@gmail.com>
References: <pull.166.git.gitgitgadget@gmail.com>
        <pull.166.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/4] progress: add sparse mode to force 100% complete
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
 progress.c | 40 +++++++++++++++++++++++++++++++++++++---
 progress.h |  3 +++
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/progress.c b/progress.c
index 5a99c9fbf0..3d75376c96 100644
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
@@ -216,16 +218,48 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
 
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
+static void finish_if_sparse(struct progress **p_progress)
+{
+	struct progress *progress = *p_progress;
+
+	if (progress &&
+	    progress->sparse &&
+	    progress->last_value != progress->total)
+		display_progress(progress, progress->total);
 }
 
 void stop_progress(struct progress **p_progress)
 {
+	finish_if_sparse(p_progress);
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

