Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B472D1F453
	for <e@80x24.org>; Wed, 19 Sep 2018 00:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbeISFqv (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 01:46:51 -0400
Received: from avasout06.plus.net ([212.159.14.18]:56380 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbeISFqv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 01:46:51 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id 2Q5pgDz7MWLW22Q5qgvGMo; Wed, 19 Sep 2018 01:11:46 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=rUJLPd6_RAPUv1su_JsA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 5/9] refs/packed-backend.h: add missing declaration
 (hdr-check)
Message-ID: <e0e42ac7-2f7e-a989-446b-d5f5e2a780f0@ramsayjones.plus.com>
Date:   Wed, 19 Sep 2018 01:11:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNmouAG2PxGD5gSQpYwzI5MpdS89jZWrYmtZn6NrI3s2VFoazWaNRRjsWES/wrg5UBMSmeDAqVUUknJvXJX6PLzdMp28qNvIu2UHzMML7jAWVkg/iUIU
 //cCd12zAQT+mvFQMGz6hrl9CDys2aH6kChy90gXJYYH6RdYhG+KObEbM+6KMWs1pVFxBx19KX5m3Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 refs/packed-backend.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/refs/packed-backend.h b/refs/packed-backend.h
index 640245d3b9..a01a0aff9c 100644
--- a/refs/packed-backend.h
+++ b/refs/packed-backend.h
@@ -1,6 +1,8 @@
 #ifndef REFS_PACKED_BACKEND_H
 #define REFS_PACKED_BACKEND_H
 
+struct ref_transaction;
+
 /*
  * Support for storing references in a `packed-refs` file.
  *
-- 
2.19.0
