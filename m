Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 161D41F453
	for <e@80x24.org>; Wed, 19 Sep 2018 00:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeISFnl (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 01:43:41 -0400
Received: from avasout06.plus.net ([212.159.14.18]:56100 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbeISFnl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 01:43:41 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id 2Q2lgDytfWLW22Q2ngvGII; Wed, 19 Sep 2018 01:08:37 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=IbSAnmDksFdLW6BTFawA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 2/9] json-writer.h: add missing include (hdr-check)
Message-ID: <c6a715e5-cc06-e1e1-3728-6f3e04e102d0@ramsayjones.plus.com>
Date:   Wed, 19 Sep 2018 01:08:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJSCQlm+cZOmYbUhfnuOvzlkuNYX57miNMsgCl61pEew3V4yI/Qja4735n7+dsOFwi5LpF8B/zJxmI2rau0uhuUICq4FddIBKc4T8GWC01hXnCz4MaLF
 OnxG+are0h8bWawMwMOXPWeVPgacYN1ziH3vsmv+Hw8G5RQWQ/MYczPUDWXJdVdJiCUg+LSEhjA+OQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 json-writer.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/json-writer.h b/json-writer.h
index fc18acc7d9..83906b09c1 100644
--- a/json-writer.h
+++ b/json-writer.h
@@ -42,6 +42,8 @@
  * of the given strings.
  */
 
+#include "strbuf.h"
+
 struct json_writer
 {
 	/*
-- 
2.19.0
