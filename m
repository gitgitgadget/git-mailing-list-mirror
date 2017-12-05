Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DDC120C3E
	for <e@80x24.org>; Tue,  5 Dec 2017 16:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbdLEQug (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 11:50:36 -0500
Received: from siwi.pair.com ([209.68.5.199]:43570 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752294AbdLEQud (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 11:50:33 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 3ADBE844E6;
        Tue,  5 Dec 2017 11:50:33 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 85829844E4;
        Tue,  5 Dec 2017 11:50:32 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        christian.couder@gmail.com,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v6 1/3] list-objects-filter-options: fix 'keword' typo in comment
Date:   Tue,  5 Dec 2017 16:50:12 +0000
Message-Id: <20171205165014.64488-2-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171205165014.64488-1-git@jeffhostetler.com>
References: <20171205165014.64488-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 list-objects-filter-options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 9b28322..52bdec7 100644
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
2.9.3

