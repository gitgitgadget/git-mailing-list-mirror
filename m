Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52BDF1F404
	for <e@80x24.org>; Tue, 18 Sep 2018 04:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbeIRJjY (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 05:39:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42771 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbeIRJjY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 05:39:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id l9-v6so325165pff.9
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 21:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zhzyC86jamcIAKUp1vhGlOa+f9+2z11kBeOkNS8kz2Q=;
        b=uW8M+kFZncwBQ6PpY/sihv1KwQ8RE2LkfFkYV3r5Pwur0a1ieM67jQRZFmUiYOJORX
         kMN8PycqkbBdbSE2bA37J3IOqJDin9W4IbhNutN0Xsq5UBVHL2CNQYmI8/wiX89zCVW/
         MfzjV8apAhxsOTQq5A7fMHGVfHHUPu3CI4IlQ2Ufl3coPixPNy7nkFhh7sSHWlFwNOhV
         mmCxMEbCOyIvqXpBzFuzE5g+Clc2kp9362VI/cdPpcrCAvmNzP7saQbRsaqytbcKY5/9
         JTxR7boEr/kfbMBwEs/5lQU2QOhaU7q9kaYeyR9XL7jQd3W0jvHpnM7RkPNNL0p6ElZJ
         6bNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zhzyC86jamcIAKUp1vhGlOa+f9+2z11kBeOkNS8kz2Q=;
        b=Wfpq0/OV3yu3iw/rfmp2Ps/v5KpwEJ7uviUhJ6b4h2R8tjfF0XYK5yiOgHJ/FWWRtO
         fo3NPmKpuLBX6C14/j9kN3GuziN8MzMXpugu/1FiNpRYy9Tv/yewzfzVLWnoO/G4Ltn1
         sypGThItcj+XYMGZusKDavEnIVL1jsnmiOTpbw+14gU0CtVw7u6p+iP0qvRJcD7EQo0p
         eBgF2Z9EnJUGygiuoMG74SqoPIoNSjyuuA1uM0POIn4YCnEoW1VxhvJw5Bd2RCmrNPoH
         y+U4bpq1ydmmml4OpNAEanIzaRcjvX0EztOfrPa6VWnpbB6W1e4ZuZVqkohNIMIEldBI
         IJ/g==
X-Gm-Message-State: APzg51A4i4joxs5NUsZ2SAbYue3pUCZTCY9DZWmggK5VBvhl1slsjGV8
        xD0j0Z/JBFeoFmd+/rdehnfX6kLu
X-Google-Smtp-Source: ANB0VdbMQMRkQB0uv5TzNqcM7iHqGOhPJuvESmBC2JAEJdeRnq9VTeOufA6O1QqryqDDjtcYH5Q4UQ==
X-Received: by 2002:a63:91:: with SMTP id 139-v6mr25979167pga.389.1537243724160;
        Mon, 17 Sep 2018 21:08:44 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id s27-v6sm35491271pfk.133.2018.09.17.21.08.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 21:08:43 -0700 (PDT)
Date:   Mon, 17 Sep 2018 21:08:43 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Sep 2018 04:08:34 GMT
Message-Id: <cc1ec4c2702d8ba35873600d321015bb0430d92e.1537243720.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.25.v2.git.gitgitgadget@gmail.com>
References: <pull.25.git.gitgitgadget@gmail.com>
        <pull.25.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/6] prio-queue: add 'peek' operation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When consuming a priority queue, it can be convenient to inspect
the next object that will be dequeued without actually dequeueing
it. Our existing library did not have such a 'peek' operation, so
add it as prio_queue_peek().

Add a reference-level comparison in t/helper/test-prio-queue.c
so this method is exercised by t0009-prio-queue.sh.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 prio-queue.c               |  9 +++++++++
 prio-queue.h               |  6 ++++++
 t/helper/test-prio-queue.c | 10 +++++++---
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/prio-queue.c b/prio-queue.c
index a078451872..d3f488cb05 100644
--- a/prio-queue.c
+++ b/prio-queue.c
@@ -85,3 +85,12 @@ void *prio_queue_get(struct prio_queue *queue)
 	}
 	return result;
 }
+
+void *prio_queue_peek(struct prio_queue *queue)
+{
+	if (!queue->nr)
+		return NULL;
+	if (!queue->compare)
+		return queue->array[queue->nr - 1].data;
+	return queue->array[0].data;
+}
diff --git a/prio-queue.h b/prio-queue.h
index d030ec9dd6..682e51867a 100644
--- a/prio-queue.h
+++ b/prio-queue.h
@@ -46,6 +46,12 @@ extern void prio_queue_put(struct prio_queue *, void *thing);
  */
 extern void *prio_queue_get(struct prio_queue *);
 
+/*
+ * Gain access to the "thing" that would be returned by
+ * prio_queue_get, but do not remove it from the queue.
+ */
+extern void *prio_queue_peek(struct prio_queue *);
+
 extern void clear_prio_queue(struct prio_queue *);
 
 /* Reverse the LIFO elements */
diff --git a/t/helper/test-prio-queue.c b/t/helper/test-prio-queue.c
index 9807b649b1..e817bbf464 100644
--- a/t/helper/test-prio-queue.c
+++ b/t/helper/test-prio-queue.c
@@ -22,9 +22,13 @@ int cmd__prio_queue(int argc, const char **argv)
 	struct prio_queue pq = { intcmp };
 
 	while (*++argv) {
-		if (!strcmp(*argv, "get"))
-			show(prio_queue_get(&pq));
-		else if (!strcmp(*argv, "dump")) {
+		if (!strcmp(*argv, "get")) {
+			void *peek = prio_queue_peek(&pq);
+			void *get = prio_queue_get(&pq);
+			if (peek != get)
+				BUG("peek and get results do not match");
+			show(get);
+		} else if (!strcmp(*argv, "dump")) {
 			int *v;
 			while ((v = prio_queue_get(&pq)))
 			       show(v);
-- 
gitgitgadget

