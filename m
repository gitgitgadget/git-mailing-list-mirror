Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 745BD1F461
	for <e@80x24.org>; Wed, 26 Jun 2019 22:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfFZWOt (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 18:14:49 -0400
Received: from avasout04.plus.net ([212.159.14.19]:47602 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfFZWOt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 18:14:49 -0400
Received: from [10.0.2.15] ([87.115.253.20])
        by smtp with ESMTPA
        id gGBjhW9WDaslVgGBkhoPYW; Wed, 26 Jun 2019 23:14:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1561587288; bh=0JYQyGnWiK4pfb1bJyLRvWQemjSbDyD+QgUtFPEWnJA=;
        h=To:Cc:From:Subject:Date;
        b=PWcymE5UM5a72IfZUuyq9HbTqX7uU1U6V1NLa23k3tAUygG4/sgDxZFW/Zrud59Q9
         t51TDL491EG4ys12wJE5ElI5tz7gHxbCkbjaCg49C0AUvGBgZHkJbtvd+rCwOKkodS
         vWuesLeDTGfTqtX7ReW/+WQBBafPsaTekPTBBGLjcmRhnAPyQ00GPcJdFuCwFKQZZL
         p3gXzgmsJEPQlGnL6raMHYN0MAhJ8PgdV34CCMOQwdpab8v4YB90jUVxR90t5WIdNv
         /O5s9ymT29g+RKtwH+KU8SCRl50krxBKPSiqIjL4YpJhSqpOMpO1HDfMstIRtO9xF+
         4gvIq3d82nTyg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=bfsVr9HB c=1 sm=1 tr=0
 a=ceBz2RPxfYaxgFK6o8vNfQ==:117 a=ceBz2RPxfYaxgFK6o8vNfQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=woT-RcFGbLPOwidZL20A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] promisor-remote.h: fix an 'hdr-check' warning
Message-ID: <204ceee5-9a79-150c-df62-e2f522cf15e0@ramsayjones.plus.com>
Date:   Wed, 26 Jun 2019 23:14:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKt1FWKfMbnBMtjbj6+j8ysh0Hvm1bteeYeVXDrUVXYFe3wIGO6Hm2ekJUj7f9HuM+TuVros5E5Fs11J4BIt7FVod6TRgwLtg/l1icoSW5anFN/66qmQ
 hHc+E+HqTx7THf8mbZpE4VDyCp74vZE/GsocnhFkJDLsMSyMw5xbIoKdaLuXFvG9aJbCOCyQwvquoQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Christian,

If you need to re-roll your 'cc/multi-promisor' branch, could you please
squash this into the relevant patch (commit 9e27beaa23, "promisor-remote:
implement promisor_remote_get_direct()", 2019-06-25).

[No, this is not the same as the April patch! :-D ]

Thanks!

ATB,
Ramsay Jones

 promisor-remote.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/promisor-remote.h b/promisor-remote.h
index 8200dfc940..a9a9c77b7c 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -2,6 +2,7 @@
 #define PROMISOR_REMOTE_H
 
 struct object_id;
+struct repository;
 
 /*
  * Promisor remote linked list
-- 
2.22.0
