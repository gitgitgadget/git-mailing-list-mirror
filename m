Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 604E21F454
	for <e@80x24.org>; Wed, 19 Sep 2018 00:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeISFoq (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 01:44:46 -0400
Received: from avasout06.plus.net ([212.159.14.18]:56193 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbeISFop (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 01:44:45 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id 2Q3ngDyyhWLW22Q3ogvGKc; Wed, 19 Sep 2018 01:09:40 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=6666aDbLxHxIAnJYuSoA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 3/9] ewah/ewok_rlw.h: add missing include (hdr-check)
Message-ID: <48c92f46-746a-f532-1e8c-3d5cd993c41b@ramsayjones.plus.com>
Date:   Wed, 19 Sep 2018 01:09:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfA4pYi4uvsq1DDNKIzNSc9Ec1ytI+fe059UkYve0dUz5FiJU1kiSN3QOfogJtSiK2fQnvI1dbGk3A875gM9uLHuC6cMnfPbVJk+pjWhOk2RYa1HmbdPa
 97tcufHjbVoDaRbMPQQ9hEwZHzFy43/dENBaxfr81rhNIkz3T2jsucld+kcA2/S17S/hIqlEvC1Qig==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 ewah/ewok_rlw.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ewah/ewok_rlw.h b/ewah/ewok_rlw.h
index 7cdfdd0c02..d487966935 100644
--- a/ewah/ewok_rlw.h
+++ b/ewah/ewok_rlw.h
@@ -19,6 +19,8 @@
 #ifndef __EWOK_RLW_H__
 #define __EWOK_RLW_H__
 
+#include "ewok.h"
+
 #define RLW_RUNNING_BITS (sizeof(eword_t) * 4)
 #define RLW_LITERAL_BITS (sizeof(eword_t) * 8 - 1 - RLW_RUNNING_BITS)
 
-- 
2.19.0
