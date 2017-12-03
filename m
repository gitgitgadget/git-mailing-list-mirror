Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5065B20C11
	for <e@80x24.org>; Sun,  3 Dec 2017 13:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751349AbdLCNET (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 08:04:19 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37561 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbdLCNES (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 08:04:18 -0500
Received: by mail-wm0-f67.google.com with SMTP id f140so9964573wmd.2
        for <git@vger.kernel.org>; Sun, 03 Dec 2017 05:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=A1+VOP7JgyFShkwDLziqjI7pkXjez5RgAUCgIuzesXw=;
        b=P67ERuCwKr5V1gJfbDoGL8pEAigCQPASy0I7cMmuZ8R3P2x7HjTQKbZGmY/4tyL5S1
         24wLjm9Eip93CPqS2N9HxooRnslPnOaysnqg+zoU4Y72jZbHeHxjnHa/JlGt14NhBAcK
         gvAIbC4220vRvvhduNfJr0IrB5FSKsfBKvyJpmRwT9aWA2S9974GY2giAx8bgQ85Pfnx
         PHmGm5+juPxgLk2Ta83epA1clM/PAi/H2Xiwd4pxXSH+cPqzebNpDCSMuH/r9leqMvMQ
         PdlKk166TWczXXohHlpnaCk/boRxJGmXBtBOtq3Vx39VqRsz7Ow1qW2chljdteZ3oyat
         +eVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A1+VOP7JgyFShkwDLziqjI7pkXjez5RgAUCgIuzesXw=;
        b=HjBA2yxdFVE7Dho3k1+2mudyEwLLckr9a1JE0RAWMjbBo+D5hiqhgedX0kcyTbvacY
         jYQFeyElgJyW3xa8EGjpha82Zi6vHvpfGkdSgExQdfSFbJQctrkjG0PgnwWM7sGcLpQE
         epwK8t2xH+pdNxWsO2Fyuatm77XWfIJOHOBO3zflYl4tydMMcG8LXG5tlsXrODamNrQ/
         RsTlWcaU4o++EVmJbqR/TCc3kny0mvmNQJJapkrj7FoLpC7w4CHbItIVXwxnzNTn0cgK
         YrmJYZ2+GUNMEdy7A/SXy4QFbX34LWmV0X5CG2DbKPQMZteF9UODM4FsBWVd6dlDYkSc
         m3vQ==
X-Gm-Message-State: AKGB3mLBM6OJ5zFpGybxK50MS5swnrZH6AJbwAw4ZAPaAkPkbqVj28rH
        hUGxrjhwzpKYTzdEYlt9yfUMlhh7
X-Google-Smtp-Source: AGs4zMZAklVjCNi6l/pLFlpUWWWhNESEpqOghsZj7vAjFyJyx0GrXcbqUQDbcZMssd3D3xCY49K0eA==
X-Received: by 10.28.135.135 with SMTP id j129mr890402wmd.144.1512306257305;
        Sun, 03 Dec 2017 05:04:17 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id q2sm707914wma.19.2017.12.03.05.04.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Dec 2017 05:04:16 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christian Couder <christian.couder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] list-objects-filter-options: fix 'keword' typo in comment
Date:   Sun,  3 Dec 2017 14:03:51 +0100
Message-Id: <20171203130351.12062-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.1.271.g1a4e40aa5d.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

---
 list-objects-filter-options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 50b98109eb..6729a57dee 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -8,7 +8,7 @@
 #include "list-objects-filter-options.h"
 
 /*
- * Parse value of the argument to the "filter" keword.
+ * Parse value of the argument to the "filter" keyword.
  * On the command line this looks like:
  *       --filter=<arg>
  * and in the pack protocol as:
-- 
2.15.0.16.g80a053294d

