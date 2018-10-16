Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 496601F453
	for <e@80x24.org>; Tue, 16 Oct 2018 22:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbeJQG3O (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 02:29:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42745 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeJQG3M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 02:29:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id f26-v6so12144371pfn.9
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 15:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SJ+lmcE+SHOiaT/fYfkqaXMRwOhfW/HXswdUqQ9heU4=;
        b=Wcud3eGpYhhNRMnGjvMP348dedvLSubESDbTXa3No4qXriflzszpnJgiPRt/FidzOj
         LHUHPzTmpXsogxWM8CW1NJuZjAada4jxvjVgphY/m2oPigaSOup6AG0LKxM5LrRjTiPZ
         mj8fArpB1AV0AiduWOLUxn8FY5p6ZL6lpQ6SUV34OHXJRa8imKmy+OD4qK9Mi3TSooUk
         EGcgv2sSPtiK/OFt6tV2n7nO6pOZwWn04id9DUgVhAlunxfTyhpyF+Q6Em8/4Yu3RSVL
         z7Trl+3XJy33YSrnf+tfpW60DgrTfNKvrJnbI/1nP1/RD1O83QX0TsEYV7QB+eDWzpRb
         Y5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SJ+lmcE+SHOiaT/fYfkqaXMRwOhfW/HXswdUqQ9heU4=;
        b=GWzei/ofUkbNE6h2oVd8XdpxchiFmrUiFpks121IVCLyknvVB0n3+SOoeiI4/GVVYo
         luLQLrJlfRmuTfa1Jjwu7yX6mFCkEcILK548NzhORiRCXB9yYd7x4Bc/1AMiP4aHjTR4
         gl1EwBhmTvECCU7YzKHiqk6v1+R0XbbNPgbb/x9wgWPGj6vHizKQVKl8WwkfA8+VLU0N
         Oig/WgJ/d8hMouQcOkabi36xgBB7oMPejH+1rJsElXk+ZVFEQsMWoVQQbpVxJE4lAaPG
         eZzdtmwUtGGcIeDiZ5Ln/sGI3UINuD5Tj0U8sWCEEKg9DW96ygyVxRX6g2BSk9UJM7Lu
         Ps4w==
X-Gm-Message-State: ABuFfogJ5fIdTdRt0tpabVaWSdxevwMBVgScJOzrMnAk8PYRswN5a22M
        kYhIeumpgzgL445JLvIkTVr8JNf7
X-Google-Smtp-Source: ACcGV60ciWKdNPyNhnGAdiuF5yBtYd6qkIaL5LaJY9r3jLbm++Tu2PTMb2w2qxyKHIyalfxxiWHZhQ==
X-Received: by 2002:a62:c252:: with SMTP id l79-v6mr23759939pfg.141.1539729399028;
        Tue, 16 Oct 2018 15:36:39 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id h32-v6sm7017961pgb.94.2018.10.16.15.36.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 15:36:37 -0700 (PDT)
Date:   Tue, 16 Oct 2018 15:36:37 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Oct 2018 22:36:26 GMT
Message-Id: <2358cfd5edde4f749ee237f6b9f643444c62b900.1539729393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.25.v4.git.gitgitgadget@gmail.com>
References: <pull.25.v3.git.gitgitgadget@gmail.com>
        <pull.25.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 1/7] prio-queue: add 'peek' operation
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
so this method is exercised by t0009-prio-queue.sh. Further, add
a test that checks the behavior when the compare function is NULL
(i.e. the queue becomes a stack).

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 prio-queue.c               |  9 +++++++++
 prio-queue.h               |  6 ++++++
 t/helper/test-prio-queue.c | 26 ++++++++++++++++++--------
 t/t0009-prio-queue.sh      | 14 ++++++++++++++
 4 files changed, 47 insertions(+), 8 deletions(-)

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
index 9807b649b1..5bc9c46ea5 100644
--- a/t/helper/test-prio-queue.c
+++ b/t/helper/test-prio-queue.c
@@ -22,14 +22,24 @@ int cmd__prio_queue(int argc, const char **argv)
 	struct prio_queue pq = { intcmp };
 
 	while (*++argv) {
-		if (!strcmp(*argv, "get"))
-			show(prio_queue_get(&pq));
-		else if (!strcmp(*argv, "dump")) {
-			int *v;
-			while ((v = prio_queue_get(&pq)))
-			       show(v);
-		}
-		else {
+		if (!strcmp(*argv, "get")) {
+			void *peek = prio_queue_peek(&pq);
+			void *get = prio_queue_get(&pq);
+			if (peek != get)
+				BUG("peek and get results do not match");
+			show(get);
+		} else if (!strcmp(*argv, "dump")) {
+			void *peek;
+			void *get;
+			while ((peek = prio_queue_peek(&pq))) {
+				get = prio_queue_get(&pq);
+				if (peek != get)
+					BUG("peek and get results do not match");
+				show(get);
+			}
+		} else if (!strcmp(*argv, "stack")) {
+			pq.compare = NULL;
+		} else {
 			int *v = malloc(sizeof(*v));
 			*v = atoi(*argv);
 			prio_queue_put(&pq, v);
diff --git a/t/t0009-prio-queue.sh b/t/t0009-prio-queue.sh
index e56dfce668..3941ad2528 100755
--- a/t/t0009-prio-queue.sh
+++ b/t/t0009-prio-queue.sh
@@ -47,4 +47,18 @@ test_expect_success 'notice empty queue' '
 	test_cmp expect actual
 '
 
+cat >expect <<'EOF'
+3
+2
+6
+4
+5
+1
+8
+EOF
+test_expect_success 'stack order' '
+	test-tool prio-queue stack 8 1 5 4 6 2 3 dump >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

