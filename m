Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49B121F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 18:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbfJKSgK (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 14:36:10 -0400
Received: from mail-gateway-shared13.cyon.net ([194.126.200.66]:56370 "EHLO
        mail-gateway-shared13.cyon.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728689AbfJKSgK (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 11 Oct 2019 14:36:10 -0400
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared13.cyon.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <bb@drbeat.li>)
        id 1iIzb0-0005ZL-8o
        for git@vger.kernel.org; Fri, 11 Oct 2019 20:25:00 +0200
Received: from [10.20.10.230] (port=35630 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.92)
        (envelope-from <bb@drbeat.li>)
        id 1iIzaz-0007DL-2Y; Fri, 11 Oct 2019 20:24:57 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id CF32618003C; Fri, 11 Oct 2019 20:24:56 +0200 (CEST)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH] git-compat-util: fix documentation syntax
Date:   Fri, 11 Oct 2019 20:24:54 +0200
Message-Id: <20191011182454.11495-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-OutGoing-Spam-Status: No, score=-1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The parameter marker for x was garbled in its introduction in 89c855ed3c
("git-compat-util.h: implement a different ARRAY_SIZE macro for for
safely deriving the size of array", 2015-04-30).

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 git-compat-util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 8b8b29a867..607dca7534 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -77,7 +77,7 @@
 #endif
 /*
  * ARRAY_SIZE - get the number of elements in a visible array
- *  <at> x: the array whose size you want.
+ * @x: the array whose size you want.
  *
  * This does not work on pointers, or arrays declared as [], or
  * function parameters.  With correct compiler support, such usage
-- 
2.21.0.1020.gf2820cf01a

