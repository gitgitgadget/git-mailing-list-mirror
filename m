Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 922231F576
	for <e@80x24.org>; Mon, 22 Jan 2018 00:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750948AbeAVAay (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Jan 2018 19:30:54 -0500
Received: from avasout03.plus.net ([84.93.230.244]:52384 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750878AbeAVAax (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jan 2018 19:30:53 -0500
Received: from [10.0.2.15] ([80.189.70.206])
        by smtp with ESMTPA
        id dQ0heWmXSPaKHdQ0iegkcm; Mon, 22 Jan 2018 00:30:52 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=DYU5VMlW c=1 sm=1 tr=0
 a=BecK+r/lr4XRfISlKBaA+g==:117 a=BecK+r/lr4XRfISlKBaA+g==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=z6QcS41qXs8ybomwwL0A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] sequencer: mark a file local symbol as static
Message-ID: <43b60294-0e8f-0f6e-1b9a-8a2779777513@ramsayjones.plus.com>
Date:   Mon, 22 Jan 2018 00:30:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJtgdlLQfJbUAT8t7KCprGuR30wPaFPT8hbwPVk903dUH5FPr1cnKipq5w145RxuglFgXL0vZrPh49j4dLJfSqSZbrjfefkOcRTDqgMb9zF7IqzEqsV8
 tY4WJOnLC6/NWuxajNdV8Hc4CxK/yR4631BK3CLvB37gUoPdklmQcMCh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Phillip,

If you need to re-roll your 'pw/sequencer-in-process-commit' branch, could
you please squash this into the relevant patch (commit da96adcf5a,
"sequencer: run 'prepare-commit-msg' hook", 2018-01-19).

Thanks.

ATB,
Ramsay Jones

 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 79579ba11..5bfdc4044 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -893,7 +893,7 @@ void commit_post_rewrite(const struct commit *old_head,
 	run_rewrite_hook(&old_head->object.oid, new_head);
 }
 
-int run_prepare_commit_msg_hook(struct strbuf *msg, const char *commit)
+static int run_prepare_commit_msg_hook(struct strbuf *msg, const char *commit)
 {
 	struct argv_array hook_env = ARGV_ARRAY_INIT;
 	int ret;
-- 
2.16.0
