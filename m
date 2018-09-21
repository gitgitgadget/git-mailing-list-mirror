Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 903FF1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 17:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390951AbeIUX3Y (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 19:29:24 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42866 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389545AbeIUX3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 19:29:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id l9-v6so6279835pff.9
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 10:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zhzyC86jamcIAKUp1vhGlOa+f9+2z11kBeOkNS8kz2Q=;
        b=fffD5Qzw0WxT3iO60Dd0heV4oNYmEuOHYETqwtREmTcGZSSs4QypkoDynMqhstUNvV
         qERWgDhUWtW7nHx3wRYx1karMNmAfFMB7u+Cf7ekI8JdSU2TiMp1apmU9TFO2pKJ6fnm
         w8VQU8vzoW0XNY8xcEv5utxqeDBnmopfKPEknvus8P+EdiyydTimmd0Xn5/rvxFI9GgC
         ioZ15fC6xyVgdyuzWEpz5qF5f2tMUUjF5VqaGgFexYVVK6onxxDaehORx6UnAgzfCI1Q
         6E2ce5FtbYi/PW8JHPoZuOHQN4icTm/JCTZZz4COPAf4qcAFp65/dZlBf41FD6YoSzj7
         EhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zhzyC86jamcIAKUp1vhGlOa+f9+2z11kBeOkNS8kz2Q=;
        b=knwgQ3OiDYVYhCiPxYhU6MTtCTktfNmIXWhTCqPCHjPVD0HmzDsvJYL7MEfCBlmg2L
         y0QykueCYPo+s0l2lE6wnvUKtgGfqy+SnlcBUOOtsbQEfaIp4IMUfnMDuSLu2pF+XjJ2
         pwEwJqNYFj2Ys2q5niWflu8Gc70BpL//55X+EN7IerSxYksu+CsqWOjv78RwWABzUU6X
         1XlaTn5KiOGASfYEpX7r7ykirbJwNXPR2fziMvm05us45cBim8/nBnKFvmAzlXVpi21u
         2/N3ft6kAimxp89XEgVVbqXkqT9vL2rAM2JKf21FyOMNW/MkIo/E41n+IjppuBhUadUH
         h3WQ==
X-Gm-Message-State: APzg51AGe+2ApUpGctnfuzwTqjNvCgVkmRY1lFE8/hNwB8dDOJd2/Tm0
        f3Own9/4BwkAfc6nvRAGYwOenl/j
X-Google-Smtp-Source: ANB0VdaYA8+sczhnNalFT8klLNMaxe4/QOtqEEWKVfMt7gFy5xqIRlXax3Ld5l9ZLAP2/qADHOTJpg==
X-Received: by 2002:a63:ef4f:: with SMTP id c15-v6mr41828645pgk.368.1537551568667;
        Fri, 21 Sep 2018 10:39:28 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id h85-v6sm43338668pfk.71.2018.09.21.10.39.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 10:39:27 -0700 (PDT)
Date:   Fri, 21 Sep 2018 10:39:27 -0700 (PDT)
X-Google-Original-Date: Fri, 21 Sep 2018 17:39:17 GMT
Message-Id: <cc1ec4c2702d8ba35873600d321015bb0430d92e.1537551564.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.25.v3.git.gitgitgadget@gmail.com>
References: <pull.25.v2.git.gitgitgadget@gmail.com>
        <pull.25.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 1/7] prio-queue: add 'peek' operation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, Junio C Hamano <gitster@pobox.com>,
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

