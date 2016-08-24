Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADB322018E
	for <e@80x24.org>; Wed, 24 Aug 2016 15:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932712AbcHXP1a (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 11:27:30 -0400
Received: from avasout07.plus.net ([84.93.230.235]:46537 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932184AbcHXP1a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 11:27:30 -0400
Received: from [10.0.2.15] ([209.93.82.95])
        by avasout07 with smtp
        id b3TS1t00323PrXV013TTF2; Wed, 24 Aug 2016 16:27:28 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=UYYTc+aN c=1 sm=1 tr=0
 a=MrGUH+yfTxdMEvUZuMmDjA==:117 a=MrGUH+yfTxdMEvUZuMmDjA==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=XGE7h83pQQLc7NAhYqIA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] diff: mark a file-local symbol static
Message-ID: <a27aa17e-f602-fc49-92b3-2198e4772e47@ramsayjones.plus.com>
Date:   Wed, 24 Aug 2016 16:27:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Michael,

If you need to re-roll your 'mh/diff-indent-heuristic' branch, could
you please squash this into the relevant patch (commit 8f5cc189,
"diff: improve positioning of add/delete blocks in diffs", 22-08-2016).

Thanks!

ATB,
Ramsay Jones

 xdiff/xdiffi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index dc79628..67c1ccc 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -684,7 +684,7 @@ static void score_add_split(const struct split_measurement *m, struct split_scor
 	}
 }
 
-int score_cmp(struct split_score *s1, struct split_score *s2)
+static int score_cmp(struct split_score *s1, struct split_score *s2)
 {
 	/* -1 if s1.effective_indent < s2->effective_indent, etc. */
 	int cmp_indents = ((s1->effective_indent > s2->effective_indent) -
-- 
2.9.0
