Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 776AC20135
	for <e@80x24.org>; Thu,  9 Mar 2017 01:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752874AbdCIBsp (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 20:48:45 -0500
Received: from avasout01.plus.net ([84.93.230.227]:34397 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754695AbdCIBso (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 20:48:44 -0500
Received: from [10.0.2.15] ([146.90.175.94])
        by avasout01 with smtp
        id tdnG1u00422aPyA01dnH06; Thu, 09 Mar 2017 01:47:18 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=BZKo6vl2 c=1 sm=1 tr=0
 a=c4JbszTospdBBUsinAk+iw==:117 a=c4JbszTospdBBUsinAk+iw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=25N7l54CqsoWSSQ2S4cA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] read-tree: mark a file-local symbol as static
Message-ID: <5a67328d-bbea-4dda-b9bc-32c15d960bcf@ramsayjones.plus.com>
Date:   Thu, 9 Mar 2017 01:47:16 +0000
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

Hi Stefan,

If you need to re-roll your 'sb/checkout-recurse-submodules' branch,
could you please squash this into the relevant patch (commit 97aadb19f1,
"builtin/read-tree: add --recurse-submodules switch", 06-03-2017).

ATB,
Ramsay Jones

 builtin/read-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 2dc5cc06d..23e212ee8 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -21,7 +21,7 @@
 static int nr_trees;
 static int read_empty;
 static struct tree *trees[MAX_UNPACK_TREES];
-int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
+static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 
 static int list_tree(unsigned char *sha1)
 {
-- 
2.12.0
