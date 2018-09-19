Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 452071F453
	for <e@80x24.org>; Wed, 19 Sep 2018 00:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbeISFpl (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 01:45:41 -0400
Received: from avasout06.plus.net ([212.159.14.18]:56193 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbeISFpk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 01:45:40 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id 2Q4hgDz2lWLW22Q4igvGM6; Wed, 19 Sep 2018 01:10:36 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=EYqcgdh2XKQegAF-mAgA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 4/9] refs/ref-cache.h: add missing declarations (hdr-check)
Message-ID: <2a1a0a73-71e4-32ee-5fd8-5b7209624932@ramsayjones.plus.com>
Date:   Wed, 19 Sep 2018 01:10:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfK4jhzL2//DwVIB3Ckzx5UJdmQvR/aOWklMG+VWS70DTDc1TWZ57M6xZtH/VI4QlGZcZjKjVqMj8XMtaKisJL2z7nJ6BkPnSrY5o/NTyxk0UDjKflbs8
 OjEbFu/3F5t6WuKnk6AiD+KcEM3Vvl5LEotP0mgqgTewEN03bS7WZUQsNSzMUcbbb1+UGH0DG3IH3Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 refs/ref-cache.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/refs/ref-cache.h b/refs/ref-cache.h
index eda65e73ed..3bfb89d2b3 100644
--- a/refs/ref-cache.h
+++ b/refs/ref-cache.h
@@ -1,7 +1,10 @@
 #ifndef REFS_REF_CACHE_H
 #define REFS_REF_CACHE_H
 
+#include "cache.h"
+
 struct ref_dir;
+struct ref_store;
 
 /*
  * If this ref_cache is filled lazily, this function is used to load
-- 
2.19.0
