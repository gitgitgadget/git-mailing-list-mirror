Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE1562036D
	for <e@80x24.org>; Fri, 24 Nov 2017 17:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753998AbdKXRdd (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 12:33:33 -0500
Received: from avasout01.plus.net ([84.93.230.227]:38834 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754004AbdKXRdV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 12:33:21 -0500
Received: from [10.0.2.15] ([80.189.70.158])
        by smtp with ESMTPA
        id IHqoewZA32zbeIHqpej3Wc; Fri, 24 Nov 2017 17:33:20 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=QuQu5R6d c=1 sm=1 tr=0
 a=bpDj9VLvXCYHU65eeb/Fiw==:117 a=bpDj9VLvXCYHU65eeb/Fiw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=rIi2gjRoXplu1E669lkA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] checkout: include the checkout.h header file
Message-ID: <60a2f330-8113-6389-ba2d-574d6af94a83@ramsayjones.plus.com>
Date:   Fri, 24 Nov 2017 17:33:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGvdOiIWoI5jOxGythrtoYeZ7PrjXRQq+rIdeRNLq9Yx27FhEVgj78TXbDCVI20kIBSuAUbhkBTA0pN7ki95N616Jz3GD+Xc7Sn4ehOH6O+Z5YHc8Wfp
 ErQhPQEkByxbhFsMNxI1XexyFsEUuygjwzgnL6A33hgAfmMtcJZ4cEGDg7g36OeYxoKAJRRy7jPcGw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Thomas,

If you need to re-roll your 'tg/worktree-create-tracking' branch, could
you please squash this into the relevant patch (commit 6736ae9593,
"checkout: factor out functions to new lib file", 2017-11-22).

[noticed by sparse]

Thanks!

ATB,
Ramsay Jones

 checkout.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/checkout.c b/checkout.c
index b0c744d37..ac42630f7 100644
--- a/checkout.c
+++ b/checkout.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "remote.h"
+#include "checkout.h"
 
 struct tracking_name_data {
 	/* const */ char *src_ref;
-- 
2.15.0
