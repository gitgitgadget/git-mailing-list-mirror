Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B8D81F404
	for <e@80x24.org>; Fri, 14 Sep 2018 23:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbeIOEnR (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Sep 2018 00:43:17 -0400
Received: from avasout06.plus.net ([212.159.14.18]:43050 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725724AbeIOEnR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Sep 2018 00:43:17 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id 0xTxg6R4nWLW20xTygsioN; Sat, 15 Sep 2018 00:26:39 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=3j6fI3gwtbhRmM_KvNMA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] midx.c: mark a file-local symbol as static
Message-ID: <63d480c7-0312-3b1d-59bc-7b9996facea0@ramsayjones.plus.com>
Date:   Sat, 15 Sep 2018 00:26:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfI0H8zNZMeZmk/Gfspa5uXJe2HSXeXO0vyYiZo19bFviWEDPh5OZBNDygo+Ip0DbDJT3BbOcbQ671JgPJEGcBUHSSE0rxT1MITZtCrHowVn/RuOUq1oJ
 HoMbA+5HVYBEzeM3wrk0EHz7utH0gzf9bElExw6WIJ7Cu9jzoWv3pLY8/kv5cYkHgETYGaXn3fSjTA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Derrick,

If you need to re-roll your 'ds/multi-pack-verify' branch, could you
please squash this into the relevant patch (commit 64cbf3df21,
"multi-pack-index: add 'verify' verb", 2018-09-13).

[noticed by sparse].

Thanks.

ATB,
Ramsay Jones

 midx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 4d4c930522..713d6f9dde 100644
--- a/midx.c
+++ b/midx.c
@@ -926,7 +926,7 @@ void clear_midx_file(const char *object_dir)
 	free(midx);
 }
 
-int verify_midx_error;
+static int verify_midx_error;
 
 static void midx_report(const char *fmt, ...)
 {
-- 
2.19.0
