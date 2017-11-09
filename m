Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 624AC1F442
	for <e@80x24.org>; Thu,  9 Nov 2017 15:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751213AbdKIPy3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 10:54:29 -0500
Received: from avasout04.plus.net ([212.159.14.19]:43538 "EHLO
        avasout04.plus.net.plus.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750777AbdKIPy3 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Nov 2017 10:54:29 -0500
Received: from [10.0.2.15] ([80.189.70.158])
        by smtp with ESMTPA
        id Cp9ue7ikIzbmWCp9ve3tDP; Thu, 09 Nov 2017 15:54:28 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=P6pKvmIu c=1 sm=1 tr=0
 a=bpDj9VLvXCYHU65eeb/Fiw==:117 a=bpDj9VLvXCYHU65eeb/Fiw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=D_9AcKLrjr7tixRO5cAA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Jeff Hostetler <jeffhost@microsoft.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] fetch-object: include the fetch-object.h header file
Message-ID: <0c97f9a3-2d66-a1f7-9453-36a4cfbafdf1@ramsayjones.plus.com>
Date:   Thu, 9 Nov 2017 15:54:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfN+fSfK4j7QcQ7eMi3AnYvAUkY4WncUvomj015izUdUetNYihXWGIDd7iArn8bOzj3hFQ9b/b4LdBgW9GfqIJ9G7xQ1MmlLwIwRX2HARWR6yDvO531fe
 sf0PJZhmxG9wOQsxCOn4iL5yCh43NSu0vpfzyKZtqXJEirGMzsh4EUqfdG5GFlpmeMYDgRG918jVnw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Jeff,

If you need to re-roll your 'jh/fsck-promisors' branch, could you
please squash this into the relevant patch (commit 1a4b4ca4e9,
"introduce fetch-object: fetch one promisor object", 02-11-2017).

[This silences a sparse warning].

Also, I notice that partial_clone_utils_register() does not have
any callers - I assume this will be 'fixed' in an upcoming series.

Thanks!

ATB,
Ramsay Jones

 fetch-object.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fetch-object.c b/fetch-object.c
index 369b61c0e..fc086fce2 100644
--- a/fetch-object.c
+++ b/fetch-object.c
@@ -3,6 +3,7 @@
 #include "pkt-line.h"
 #include "strbuf.h"
 #include "transport.h"
+#include "fetch-object.h"
 
 void fetch_object(const char *remote_name, const unsigned char *sha1)
 {
-- 
2.15.0
