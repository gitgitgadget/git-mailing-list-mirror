Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8587E2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 20:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423635AbcHEUzl (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 16:55:41 -0400
Received: from avasout07.plus.net ([84.93.230.235]:44526 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2998567AbcHEUzh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 16:55:37 -0400
Received: from [10.0.2.15] ([209.93.82.95])
	by avasout07 with smtp
	id TYvX1t00523PrXV01YvYPv; Fri, 05 Aug 2016 21:55:33 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=UYYTc+aN c=1 sm=1 tr=0
 a=MrGUH+yfTxdMEvUZuMmDjA==:117 a=MrGUH+yfTxdMEvUZuMmDjA==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=m2DuujDMaJsxSaSzbL4A:9
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH:	ramsayjones@:2500
To:	jeffhost@microsoft.com
Cc:	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
From:	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] wt-status.c: mark a file-local symbol as static
Message-ID: <ff4862e4-da97-deef-b2dc-5201df184484@ramsayjones.plus.com>
Date:	Fri, 5 Aug 2016 21:55:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
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

If you need to re-roll your 'jh/status-v2-porcelain' branch, could
you please squash this into the relevant patch (37f7104f, "status:
print per-file porcelain v2 status data", 02-08-2016).

Thanks!

ATB,
Ramsay Jones

 wt-status.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wt-status.c b/wt-status.c
index 3396bf5..a80400e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2152,7 +2152,7 @@ static void wt_porcelain_v2_print_other(
  * [<v2_ignored_items>]*
  *
  */
-void wt_porcelain_v2_print(struct wt_status *s)
+static void wt_porcelain_v2_print(struct wt_status *s)
 {
 	struct wt_status_change_data *d;
 	struct string_list_item *it;
-- 
2.9.0
