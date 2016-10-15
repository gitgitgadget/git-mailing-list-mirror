Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FAC320988
	for <e@80x24.org>; Sat, 15 Oct 2016 20:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755835AbcJOU54 (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Oct 2016 16:57:56 -0400
Received: from avasout03.plus.net ([84.93.230.244]:53737 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756079AbcJOU5y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2016 16:57:54 -0400
Received: from [10.0.2.15] ([194.75.29.46])
        by avasout03 with smtp
        id vwxU1t0040zhorE01wxVdE; Sat, 15 Oct 2016 21:57:32 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=YLLd8lOx c=1 sm=1 tr=0
 a=g54qAj+LxVGqXy9pVcJ+0w==:117 a=g54qAj+LxVGqXy9pVcJ+0w==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=7Ygwl5IdgeDh5Glfmq8A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] trailer: mark file-local symbol 'conf_head' static
Message-ID: <0e3265cd-8d9b-1c0b-5637-f815c9a70243@ramsayjones.plus.com>
Date:   Sat, 15 Oct 2016 21:57:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Jonathan,

If you need to re-roll your 'jt/trailer-with-cruft' branch, could you
please squash this into the relevant patch. [commit 3fb120de ("trailer:
use list.h for doubly-linked list", 14-10-2016)]

Thanks!

ATB,
Ramsay Jones

 trailer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/trailer.c b/trailer.c
index 1be6ec8..2862a48 100644
--- a/trailer.c
+++ b/trailer.c
@@ -42,7 +42,7 @@ struct arg_item {
 	struct conf_info conf;
 };
 
-LIST_HEAD(conf_head);
+static LIST_HEAD(conf_head);
 
 static char *separators = ":";
 
-- 
2.10.0
