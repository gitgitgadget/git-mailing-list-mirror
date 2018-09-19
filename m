Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42FD61F453
	for <e@80x24.org>; Wed, 19 Sep 2018 00:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbeISFzy (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 01:55:54 -0400
Received: from avasout06.plus.net ([212.159.14.18]:57198 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbeISFzx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 01:55:53 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id 2QEXgDzhyWLW22QEYgvGTn; Wed, 19 Sep 2018 01:20:47 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=Db8nuJGPN5_Jf1WHHBEA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] userdiff.h: add missing declaration (hdr-check)
Message-ID: <c46ca4a9-6822-436c-8e84-95b977527912@ramsayjones.plus.com>
Date:   Wed, 19 Sep 2018 01:20:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLCjc7Vzf87c6Ztg4u9pUwdzgAXYwny5sLiEGfEz/LWGAwHKTwMD2a84Zec1l+hDqg2kioSWwhdLjjFTswgK2OLHdF8K7QlyeVOx4UvLT83Xuvtz+Mx/
 kpNqV3NAgYvd+WUl/upN7pKAzWyd4YiH5069mj1gGI1ZAipyp1xekl3PWw83dIFMyITZ4t/Ck1D/9A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

... and this is the patch I needed for the current 'pu' branch.

ATB,
Ramsay Jones

 userdiff.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/userdiff.h b/userdiff.h
index dad3fc03c1..b072bfe89a 100644
--- a/userdiff.h
+++ b/userdiff.h
@@ -3,6 +3,8 @@
 
 #include "notes-cache.h"
 
+struct index_state;
+
 struct userdiff_funcname {
 	const char *pattern;
 	int cflags;
-- 
2.19.0
