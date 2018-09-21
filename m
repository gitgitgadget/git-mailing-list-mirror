Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEACB1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 17:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391030AbeIUX3b (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 19:29:31 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:39221 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391025AbeIUX3b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 19:29:31 -0400
Received: by mail-pf1-f175.google.com with SMTP id j8-v6so6284839pff.6
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 10:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BZOhhE9AML81OMes14sxjPPAo+VYQQgTwCbQcYv1DFI=;
        b=OJD4MUc7VVdNxYEAdsDU3IBjVWK36TFUu6OqXMVNugiTvcT/uaEdGLfd9aZLhQBIlN
         9aPKnDJ/7tRpnomSzO9RGgX9WJRJwGQmVGYi+5FYogAkq8qjlGWdyVorGJvYa9E2ra0B
         kRVqnMbW3dJJq4QoiiA4xFfhDw+hPzUMDjzgA49nqr+Qoxv0xUQKCW5mTGuGF0U0Tfma
         WrfeSfh0NWHBKjhL2j0CKtJP4PETICmRzAm03c9qGddwXEuFGz/SXzKOUJeRUwYRvulU
         eqcIZiIz0J2GD64bw466jQci0bDabBbGwcx055GkUU/qGrHc0J67TO2oOoB3+sSzsLoV
         Eb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BZOhhE9AML81OMes14sxjPPAo+VYQQgTwCbQcYv1DFI=;
        b=GhPZgGZFsM/RgqvS5Y5Mej1DLp92kKbRBt21bwbS+IRfmATSqswe/o7nbZ1qxyV2NP
         Ch1dDnfoYlpmr4sooLN8TiDZh1C6DNIemDUEKmySp9otaijKDnUsHp8xUjvNM87EqlK4
         KtsCnXRjqpw6mCgJtamW6tQ9KejIMm6rd6hHVorBdb0x2QfTyPnhAGq2LM4KD7M+EuC5
         dcBD7b+Ih73Vd7vMom/7EPIPVt9Y1DDkMb7jC6XIwgIxEhtuZmSsSLg2tn8NBdLz2WPB
         Bm0w5WqY9fWBfLfH/0118dG3N0WZgAWAthhc5GGnmfqyHQ8DMTPfVjPNXMIlUmKloCts
         dOCA==
X-Gm-Message-State: APzg51D6HbRr9gQwuMjRqqSEnlCkDFtTTFfAbVnIJ7l5eyyYahs3h2yj
        tArB5jYJimoshobFTtQU6JjEYXgX
X-Google-Smtp-Source: ANB0VdZPWjWOE1c/8D8GjxzqGWUnkFk+XlZv7h834Vi5RQ64Kvp5v2FzMah03nns8eepu9hIkFZUOw==
X-Received: by 2002:a62:1544:: with SMTP id 65-v6mr47162672pfv.178.1537551575981;
        Fri, 21 Sep 2018 10:39:35 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id p4-v6sm38384838pfb.180.2018.09.21.10.39.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 10:39:35 -0700 (PDT)
Date:   Fri, 21 Sep 2018 10:39:35 -0700 (PDT)
X-Google-Original-Date: Fri, 21 Sep 2018 17:39:22 GMT
Message-Id: <fa6d5ef1523676694a04b2d17c4d2ce043ccf5b7.1537551564.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.25.v3.git.gitgitgadget@gmail.com>
References: <pull.25.v2.git.gitgitgadget@gmail.com>
        <pull.25.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 6/7] revision.h: add whitespace in flag definitions
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

In anticipation of adding longer flag names in the next change, add
an extra tab to each flag definition in revision.h.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 revision.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/revision.h b/revision.h
index fd4154ff75..e7bd059d80 100644
--- a/revision.h
+++ b/revision.h
@@ -10,20 +10,20 @@
 #include "commit-slab-decl.h"
 
 /* Remember to update object flag allocation in object.h */
-#define SEEN		(1u<<0)
-#define UNINTERESTING   (1u<<1)
-#define TREESAME	(1u<<2)
-#define SHOWN		(1u<<3)
-#define TMP_MARK	(1u<<4) /* for isolated cases; clean after use */
-#define BOUNDARY	(1u<<5)
-#define CHILD_SHOWN	(1u<<6)
-#define ADDED		(1u<<7)	/* Parents already parsed and added? */
-#define SYMMETRIC_LEFT	(1u<<8)
-#define PATCHSAME	(1u<<9)
-#define BOTTOM		(1u<<10)
-#define USER_GIVEN	(1u<<25) /* given directly by the user */
-#define TRACK_LINEAR	(1u<<26)
-#define ALL_REV_FLAGS	(((1u<<11)-1) | USER_GIVEN | TRACK_LINEAR)
+#define SEEN			(1u<<0)
+#define UNINTERESTING		(1u<<1)
+#define TREESAME		(1u<<2)
+#define SHOWN			(1u<<3)
+#define TMP_MARK		(1u<<4) /* for isolated cases; clean after use */
+#define BOUNDARY		(1u<<5)
+#define CHILD_SHOWN		(1u<<6)
+#define ADDED			(1u<<7)	/* Parents already parsed and added? */
+#define SYMMETRIC_LEFT		(1u<<8)
+#define PATCHSAME		(1u<<9)
+#define BOTTOM			(1u<<10)
+#define USER_GIVEN		(1u<<25) /* given directly by the user */
+#define TRACK_LINEAR		(1u<<26)
+#define ALL_REV_FLAGS		(((1u<<11)-1) | USER_GIVEN | TRACK_LINEAR)
 
 #define DECORATE_SHORT_REFS	1
 #define DECORATE_FULL_REFS	2
-- 
gitgitgadget

