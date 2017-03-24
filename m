Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E402F1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 17:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752167AbdCXR1p (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 13:27:45 -0400
Received: from avasout04.plus.net ([212.159.14.19]:58884 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbdCXR1g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 13:27:36 -0400
Received: from [10.0.2.15] ([146.90.175.94])
        by avasout04 with smtp
        id ztSq1u00522aPyA01tSrdL; Fri, 24 Mar 2017 17:26:52 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Groywg9C c=1 sm=1 tr=0
 a=c4JbszTospdBBUsinAk+iw==:117 a=c4JbszTospdBBUsinAk+iw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=Gz7UVnXG6Al1THnuOnwA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Jeff Hostetler <jeffhost@microsoft.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] name-hash: add test-lazy-init-name-hash to .gitignore
Message-ID: <fd5e41aa-27a7-e209-71c0-059605ea06d6@ramsayjones.plus.com>
Date:   Fri, 24 Mar 2017 17:26:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Jeff,

If you need to re-roll your 'jh/memihash-opt' branch, could you please
squash this into the relevant patch (commit f25dde4fbf, "name-hash: add
test-lazy-init-name-hash", 23-03-2017).

Thanks!

ATB,
Ramsay Jones

 t/helper/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/helper/.gitignore b/t/helper/.gitignore
index 5f68aa8f8..57bdd4b8e 100644
--- a/t/helper/.gitignore
+++ b/t/helper/.gitignore
@@ -12,6 +12,7 @@
 /test-hashmap
 /test-index-version
 /test-line-buffer
+/test-lazy-init-name-hash
 /test-match-trees
 /test-mergesort
 /test-mktemp
-- 
2.12.0
