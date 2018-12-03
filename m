Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16767211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 20:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbeLCUWM (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 15:22:12 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36629 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeLCUWM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 15:22:12 -0500
Received: by mail-lj1-f196.google.com with SMTP id g11-v6so12676466ljk.3
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 12:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gBkPCAVO6bMRrH7WQrBICMkh+ouuvD96s+Nc+haBufY=;
        b=p7J1lw2zwe/KoqZ42Yp9YmSvs3BVhELR7al5rsCd6JirXoWMcTxwHECjuyd0aIzQnA
         xlC6tVMOm1WC330uoRZdt8zVa6Q3wtEYQIZA0Qr7VJZseqRWj7K2UXJsHu8NlWRszLz5
         8OMeL/gImyflXoBpuMgY4B+wArwYMsD1QRddNYbGOq5hY1QaM6I+7ktI9f5XrCQJW1Pq
         eQTWH9se9xdi51XWTvF6veGQULHxBloX683NWWZRXYhKkL+r5gfkzYLePOLMmjAW3FQs
         OaAEy/2j+KY0F2uedMX+eb2ztxEVZSbhzE1AdXdhvAK37Eb88NIm5N2ZMw8qoNU/MuHF
         R2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gBkPCAVO6bMRrH7WQrBICMkh+ouuvD96s+Nc+haBufY=;
        b=tpmbsuysmJNrEvnMWcly1Bgmts9+D3r5il8ukIe3sXNoNscYsB0Ka1W9Vylh3ULd/n
         uX4CnTJqbKk1I+mw5hnelH9Ou7P4kmHiUSksAJbjkeedjS6JzbkltIAj1NBDvWi9vUAo
         RBiPmfcMb7HKd9FiJ6bf1Z/q3x07MY2mZckHTTpFl1GKSIOVZz3WSHcsBikA1hbDa8sR
         ZFUgGD/RQi9r9/GZlpGsm+fUpUYFZi2GjN5ZiJYpJm+7X5ETzsIg8Mjy6fn4OHFLmfRb
         HCo3DhIMSwKJOz6OzpydOaKftLNfL7kojU2pVMvLUauOsGsaWOlGQLa2tV043YZwmBcm
         hcEw==
X-Gm-Message-State: AA+aEWZAvF0A8JYqyRB3gF900Y2Sen/3Cm0c47oj2I0tF+KrIydxQp4B
        NjYPljqeHozeiPoiWBwYE+o=
X-Google-Smtp-Source: AFSGD/UgqgT+LGA+6HEYWfXRJkFBuLZffm4rKDqXsJP4LY8HhNsrnBfbMJc/T43cRHdgiAx/go/5eQ==
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr10947676ljj.9.1543868529345;
        Mon, 03 Dec 2018 12:22:09 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id j12-v6sm2705104ljh.66.2018.12.03.12.22.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 12:22:08 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 3/3] RelNotes 2.20: drop spurious double quote
Date:   Mon,  3 Dec 2018 21:21:51 +0100
Message-Id: <78f3043b6589f7e3b1872d940ae2ee1315553373.1543868120.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.1.gfcc5f94f1e
In-Reply-To: <cover.1543868120.git.martin.agren@gmail.com>
References: <xmqq36rhjnts.fsf@gitster-ct.c.googlers.com> <cover.1543868120.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have three double-quote characters, which is one too many or too few.
Dropping the last one seems to match the original intention best.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/RelNotes/2.20.0.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/2.20.0.txt b/Documentation/RelNotes/2.20.0.txt
index 201135d80c..e71fe3dee1 100644
--- a/Documentation/RelNotes/2.20.0.txt
+++ b/Documentation/RelNotes/2.20.0.txt
@@ -578,7 +578,7 @@ Fixes since v2.19
 
  * "git rev-parse --exclude=* --branches --branches"  (i.e. first
    saying "add only things that do not match '*' out of all branches"
-   and then adding all branches, without any exclusion this time")
+   and then adding all branches, without any exclusion this time)
    worked as expected, but "--exclude=* --all --all" did not work the
    same way, which has been fixed.
    (merge 5221048092 ag/rev-parse-all-exclude-fix later to maint).
-- 
2.20.0.rc2.1.gfcc5f94f1e

