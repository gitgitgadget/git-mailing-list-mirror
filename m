Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 777D21F404
	for <e@80x24.org>; Wed, 27 Dec 2017 22:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752640AbdL0W5Q (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 17:57:16 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:36699 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752540AbdL0W5P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 17:57:15 -0500
Received: by mail-io0-f193.google.com with SMTP id i143so16575943ioa.3
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 14:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+ZRZdPETG3ekF+KypkLsJRq/T/bpHyUZ39aRFkE3hI0=;
        b=u3ZyvDi7atjpV8Ka21KDTnK+Zd5BiRPexGFnBG0sOIEfToV79RRKEFaKybkDlNIYp8
         R+bFJOt6v6bDBgdhxdUVXfpX3qYJpggU4OApZ9aXgAbwf6kcEVQ1ANCkOj6RFh4Q9n97
         IyIc6srsldjUqKw/sYGoEXDYJVzK7kyXsTkOqpOGFEpZNVsgTrQhmn3odyJMby1paDIF
         YS6+/SyyOCVb64YP4INt0rgITpWI+hnp9MMNk1v1aKI6IH0wJkc0qVU1IZJKuZbtCILQ
         ny6klI9YtyyMLmFB921GzsuGe+3b2eOQepEhIYBq9k3HCcdmu8DduNqNs+KNmoqRSxIU
         kAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+ZRZdPETG3ekF+KypkLsJRq/T/bpHyUZ39aRFkE3hI0=;
        b=HsjeI1Gr+CpkdzSIzFb9jvzXkEg2/nm6MQTRzCF4fSTxdbQBwkoSVcWT7xj6Tsa9Yi
         tfJTq9rdPVA0Ioa4wqvuuqM4GZPglLlljXVQHyIbqYCGZwLDrjhOtgzXuJixpagmpYbw
         9qIYqFOZYDS3Fa1FN2uVceRtozf7awcBEvTJer9tZhbqCa7H1h15MYGkD4F7536+ReFb
         Mfp+4txtiJu1Z8ZniXEK3YGT4AtKsYmYhRXIIe7GeBWF7gVD+SdzSlpCArkaLWW+RCBy
         Uu2m24D0120UeJE3vp6vq2ppOFJf1bzfxo6KBqMOpWRtLsXTBfeOKRUa2inYYGntPRzB
         RvqA==
X-Gm-Message-State: AKGB3mLcwgIBTXHetpfzm4CCfLF/+jfeqOSWcXKSLdPmoxQ19NU4gjqB
        WjGaB5wiTumdM3vo9Fh9zi0lZA==
X-Google-Smtp-Source: ACJfBovChVJ0EtBIcoIPiWqHClXWDCMEqNt0l+cXZWWetagqHkuE4sV/Ou20KsicGOjAvgcBu4tG8Q==
X-Received: by 10.107.53.67 with SMTP id c64mr29011515ioa.113.1514415434329;
        Wed, 27 Dec 2017 14:57:14 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id h187sm18211437ioe.17.2017.12.27.14.57.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 14:57:13 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: [PATCHv2 2/5] t/lib-submodule-update.sh: clarify test
Date:   Wed, 27 Dec 2017 14:57:02 -0800
Message-Id: <20171227225705.73235-3-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20171227225705.73235-1-sbeller@google.com>
References: <20171219222636.216001-1-sbeller@google.com>
 <20171227225705.73235-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Keep the local branch name as the upstream branch name to avoid confusion.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/lib-submodule-update.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 38dadd2c29..d7699046f6 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -664,8 +664,8 @@ test_submodule_recursing_with_args_common() {
 			cd submodule_update &&
 			git -C sub1 checkout -b keep_branch &&
 			git -C sub1 rev-parse HEAD >expect &&
-			git branch -t check-keep origin/modify_sub1 &&
-			$command check-keep &&
+			git branch -t modify_sub1 origin/modify_sub1 &&
+			$command modify_sub1 &&
 			test_superproject_content origin/modify_sub1 &&
 			test_submodule_content sub1 origin/modify_sub1 &&
 			git -C sub1 rev-parse keep_branch >actual &&
-- 
2.15.1.620.gb9897f4670-goog

