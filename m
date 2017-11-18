Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22B4E201C8
	for <e@80x24.org>; Sat, 18 Nov 2017 18:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030806AbdKRSEM (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 13:04:12 -0500
Received: from mout.web.de ([212.227.17.11]:49230 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936280AbdKRSEK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 13:04:10 -0500
Received: from [192.168.178.36] ([91.20.49.242]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MVLWc-1efqlY3wmE-00YhAL; Sat, 18
 Nov 2017 19:04:03 +0100
Subject: [PATCH 1/6] t4051: add test for comments preceding function lines
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <790c2344-a71e-7089-9000-f9b37a4a5cd9@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b5815f62-3ed4-58ea-6d32-b156e44cbe3f@web.de>
Date:   Sat, 18 Nov 2017 19:04:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <790c2344-a71e-7089-9000-f9b37a4a5cd9@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:2wcZyj6LdtawFXmlmmTpnGGmQArxbEewSFQCB0lu6EzEXymZD+3
 q89JCBNsQ3QXfZmZIou4JIvv5kFbwSbWGx1A7CX1yJ3yA6WTSj7ml6x+aOXKOvo7cY5T1OW
 yQ7KhccROoxcJGkGd3f2MMBb55AIXDLtPj3af6xksvlU6lT0z4qSDnpyt+CujKvKfVA37/Z
 ITn8ReTSjHOeocmOdcvpA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bDu/tkRcTO4=:I9GuhJ7Utmh/b0SQ6eKI3j
 E6wielTk8+yLyr9Dj0Yb4yKSiz8nBMRmj6la3vK2HjQlEGsIqlN39DPujbuw3OaImqhMy/fDz
 5WHTrOkWChjga/xWp2GsdeV1c5Uhx//dgDScWXG/UPNUqvQZZ/oBL1ML08NwQs7VlhNpY4gBm
 wQz3OuSZlTB1GmeCh4qBDYLEoZg0FLAEprGbmlQ8RRJ9FlksyCbveRxNrgU0Ev/VAGkpok81g
 EaX3SLaGddr2wYLlDeCBvSNAT4GQV/XGAyTX2Qf0HulsTNal9HUVEfJE6cySVayt6Jok55pLd
 7OYhk07+fc0xzEm4OvCzSfHU4xKU3qGM/fTq7QUcG9blhi/c4eJnf4eb0AZD4Vq8QWbOiOeUc
 /fZ6GWa6/IFZziygo8cWgsbSXZqDdKpaRIwxH/UlUv9HCqkR8mrGf+bvJKQJQCL4dfxgvFzGP
 N1Zvrh9/hKd+5t0p4U3hcRhCS/mzRrNJH3EplYzA6HaY3jwB1QmV7MngV3h/P3TWbwwfB1YHh
 mQn9QfC1ln5MXlnMvSIK1oT6hliZNwLGQoHjInZLOiMPUUZMVsbysIa145QA/+t4peMTb5Ab5
 g1oH/WujAXFeq5r/JUQo+n2zGHuukvutXNqOx8ZhqQbdWYCGYMXssIUXOuy4/X+dY3+RQxZoB
 ArPsPvlNn4xTbnglpVu1/D/RSZ6KaqMgqaeJ74+rTveDpVU9hiXY3JrHI4XUaF8YXxA3OM7R+
 sSfsel4+OXk/sbs72uIgLONCwoUmDvC/1pesLqXlOji6qSSBjf+9GZsC+bplvx1/C7NXNW9YA
 Fp8j2Bou7Dj9IGnxox1pkNnsTLKftEi4jd2dVZrJitlskuQ4T0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When showing function context it would be helpful to show comments
immediately before declarations, as they are most likely relevant.  Add
a test for that.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/t4051-diff-function-context.sh | 4 ++++
 t/t4051/hello.c                  | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/t/t4051-diff-function-context.sh b/t/t4051-diff-function-context.sh
index 3e6b485ecb..30fc5bf2b3 100755
--- a/t/t4051-diff-function-context.sh
+++ b/t/t4051-diff-function-context.sh
@@ -85,6 +85,10 @@ test_expect_success 'setup' '
 
 check_diff changed_hello 'changed function'
 
+test_expect_failure ' context includes comment' '
+	grep "^ .*Hello comment" changed_hello.diff
+'
+
 test_expect_success ' context includes begin' '
 	grep "^ .*Begin of hello" changed_hello.diff
 '
diff --git a/t/t4051/hello.c b/t/t4051/hello.c
index 63b1a1e4ef..73e767e178 100644
--- a/t/t4051/hello.c
+++ b/t/t4051/hello.c
@@ -1,4 +1,7 @@
 
+/*
+ * Hello comment.
+ */
 static void hello(void)	// Begin of hello
 {
 	/*
-- 
2.15.0
