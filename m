Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7260F20FCF
	for <e@80x24.org>; Thu, 30 Jun 2016 01:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938AbcF3BsG (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 21:48:06 -0400
Received: from avasout08.plus.net ([212.159.14.20]:60672 "EHLO
	avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839AbcF3BsE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 21:48:04 -0400
Received: from [10.0.2.15] ([209.93.82.95])
	by avasout08 with smtp
	id Cpo01t00723PrXV01po1vt; Thu, 30 Jun 2016 02:48:02 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=M8UPEG4s c=1 sm=1 tr=0
 a=MrGUH+yfTxdMEvUZuMmDjA==:117 a=MrGUH+yfTxdMEvUZuMmDjA==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=29RLd0HPKNcHI2Ky2cIA:9
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH:	ramsayjones@:2500
To:	Christian Couder <chriscool@tuxfamily.org>
Cc:	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
From:	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] builtin/apply: include declaration of cmd_apply()
Message-ID: <57747A4D.9040701@ramsayjones.plus.com>
Date:	Thu, 30 Jun 2016 02:47:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Christian,

If you need to re-roll your 'cc/apply-am' branch, could you please
squash this into the relevant patch. Commit 95a3b0ba ("apply: move
libified code from builtin/apply.c to apply.{c,h}", 22-04-2016)
removed this '#include "builtin.h"' line, which causes sparse to
issue a warning.

Thanks!

ATB,
Ramsay Jones

 builtin/apply.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/apply.c b/builtin/apply.c
index 066cb29..9c66474 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "builtin.h"
 #include "parse-options.h"
 #include "lockfile.h"
 #include "apply.h"
-- 
2.9.0
