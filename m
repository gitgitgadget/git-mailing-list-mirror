Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AB9D1F453
	for <e@80x24.org>; Wed, 19 Sep 2018 00:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbeISFuf (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 01:50:35 -0400
Received: from avasout06.plus.net ([212.159.14.18]:56470 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbeISFuf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 01:50:35 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id 2Q9QgDzMPWLW22Q9RgvGPW; Wed, 19 Sep 2018 01:15:29 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=pzq_ecxqI29eS9NEZesA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 9/9] commit-reach.h: add missing declarations (hdr-check)
Message-ID: <089b2111-b7e9-6795-b04a-ed259f78796a@ramsayjones.plus.com>
Date:   Wed, 19 Sep 2018 01:15:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIjgnc9HVjOJ3CMFnUmK1R5pXsUyLINGj1vbTPZIvsTFuqUo5zSwIC2oarRYQg3mExDk/lZkZHUsjKl+RZeukV5gGqIpARBUiyrfiOJTwy3qy4VSMIkd
 zQORV4B1XAzNpFUQeet8fDU3Edxo+R2YiV11S29ODmpzJzZ48muFYWwisZP531PdphZUVp7YoWH79w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 commit-reach.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/commit-reach.h b/commit-reach.h
index 7d313e2975..f41d8f6ba3 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -1,12 +1,13 @@
 #ifndef __COMMIT_REACH_H__
 #define __COMMIT_REACH_H__
 
+#include "commit.h"
 #include "commit-slab.h"
 
-struct commit;
 struct commit_list;
-struct contains_cache;
 struct ref_filter;
+struct object_id;
+struct object_array;
 
 struct commit_list *get_merge_bases_many(struct commit *one,
 					 int n,
-- 
2.19.0
