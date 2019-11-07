Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE6591F454
	for <e@80x24.org>; Thu,  7 Nov 2019 08:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfKGIKM (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 03:10:12 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:51246 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbfKGIKG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 03:10:06 -0500
Received: by mail-wm1-f54.google.com with SMTP id q70so1397727wme.1
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 00:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hO/u8rxEfCnmR4bxofuAqbFClYIl3NY94pGXQutTt6g=;
        b=d13Pc0etDCqWbfKppPZMwzE/Ou13uu6qw6lNTwU6SPMR6NniDSozybtMVUGjnco7ys
         BT08ebLUuyck7M7f5Q4QmeEn/C5IylvEKtFTKeK7dHRHU2ZBYC1aB0g+vPsPTr0WPict
         9U5w4wGJjEvaYUJWTeZD/DwyI+8835esCWrHdxJ8vArUWicR3fpqLQmE1eDsKVQZUniF
         lTZhmMzMJpqG4WfkrxvYm4H76XnApLB4taIkn2r+2H0U8e1UlLN8ntzDrksIwql5JrZ/
         duqmZ5/zPlgk3LmdiDwoOQq7ZPWdo5L4cxhDRSDf+b8m3EGQDb2jfp3iPOCLxLPSmfz2
         gj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hO/u8rxEfCnmR4bxofuAqbFClYIl3NY94pGXQutTt6g=;
        b=dFXH0Wlub6V/wAkqT6NNJd/mb6W8T7CS5qd82z+VNfohFDYoW2vEVl1GC0EG163n4L
         iA33hqPqJRV3tCfmBdvoBSCo+GIOGkc5Nk+ARL3Pl5CoyvwriYuHmUSv7mIjjfAPCe9X
         EBa0pxHX5BiQT85SRTuCCIP4BtWG6PSFanI6U3PlqRqdZa9dnrbAAXg9Hx7xHRvv4L2t
         Kh2mBA6P9JNw6KbudYQa7jVhQtq4STF/JaxfBq1UiYslz0aUdIhqSpFhJT7TWQYRHxsv
         BtXRFnm6q2MMM6pRDCdzAoL8UKSAgsRun+6dLzdd+zupJ1sE8wtiXgc9IVGCYON+9bU9
         9FhA==
X-Gm-Message-State: APjAAAWNHVpnTlhl0b6+saotxPaqgOx90jeTrrtmVpzcpuJSDeOHtc0f
        d21chyYUntjRrhHhDm9jryN6BD+s
X-Google-Smtp-Source: APXvYqziL7AaTPCSt4449tI4jBGUXDDM7AmbBRXPEGO5k+ehTzG+kjgD/brAY2EiUzNkaId/IYY8hQ==
X-Received: by 2002:a1c:9646:: with SMTP id y67mr1526363wmd.79.1573114204154;
        Thu, 07 Nov 2019 00:10:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o1sm1526214wrs.50.2019.11.07.00.10.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 00:10:03 -0800 (PST)
Message-Id: <078a19e86af6fcf1348d8988dc10cfac2e689ba4.1573114201.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.449.git.1573114201.gitgitgadget@gmail.com>
References: <pull.449.git.1573114201.gitgitgadget@gmail.com>
From:   "george espinoza via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Nov 2019 08:09:57 +0000
Subject: [PATCH 3/6] This file wasn't supposed to change during my git push
 for check-ref-format :(
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     George Espinoza <gespinoz2019@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        george espinoza <gespinoz2019@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: george espinoza <gespinoz2019@gmail.com>

Signed-off-by: george espinoza <gespinoz2019@gmail.com>
---
 builtin/merge-ours.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
index 3980f4899a..4594507420 100644
--- a/builtin/merge-ours.c
+++ b/builtin/merge-ours.c
@@ -11,11 +11,6 @@
 #include "git-compat-util.h"
 #include "builtin.h"
 #include "diff.h"
-#include "parse-options.h"
-
-/* parse-options.h added to initiate replacement of manual option parsing
- * with parse-options. 
- */
 
 static const char builtin_merge_ours_usage[] =
 	"git merge-ours <base>... -- HEAD <remote>...";
-- 
gitgitgadget

