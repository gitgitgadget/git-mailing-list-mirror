Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CBD81FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 21:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753485AbcFQVGT (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 17:06:19 -0400
Received: from avasout04.plus.net ([212.159.14.19]:52550 "EHLO
	avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753475AbcFQVGS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 17:06:18 -0400
Received: from [10.0.2.15] ([84.92.139.254])
	by avasout04 with smtp
	id 7x6F1t0025VX2mk01x6GNb; Fri, 17 Jun 2016 22:06:17 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=K//fZHiI c=1 sm=1 tr=0
 a=RCQFcU9wfaUQolwYLdiqXg==:117 a=RCQFcU9wfaUQolwYLdiqXg==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=EBOSESyhAAAA:8 a=kcLwNhGqQqfSFHWZ8jIA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH:	ramsayjones@:2500
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
From:	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] archive-tar: add UL type suffix to unsigned long constant
Message-ID: <57646646.9060407@ramsayjones.plus.com>
Date:	Fri, 17 Jun 2016 22:06:14 +0100
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

Hi Jeff,

If you need to re-roll your 'jk/big-and-old-archive-tar' branch, could
you please squash this into the relevant patch (commit 8035a1e3,
"archive-tar: write extended headers for far-future mtime", 16-06-2016).

Thanks!

ATB,
Ramsay Jones

 archive-tar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/archive-tar.c b/archive-tar.c
index 749722f..c7b85fd 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -187,7 +187,7 @@ static inline unsigned long ustar_size(uintmax_t size)
 
 static inline unsigned long ustar_mtime(time_t mtime)
 {
-	if (mtime < 077777777777)
+	if (mtime < 077777777777UL)
 		return mtime;
 	else
 		return 0;
-- 
2.9.0
