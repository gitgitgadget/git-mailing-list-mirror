Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F2CC001B0
	for <git@archiver.kernel.org>; Wed, 19 Jul 2023 23:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjGSXfq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 19:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGSXfp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 19:35:45 -0400
X-Greylist: delayed 644 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Jul 2023 16:35:43 PDT
Received: from mail-gateway-shared13.cyon.net (mail-gateway-shared13.cyon.net [194.126.200.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A3DC6
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 16:35:43 -0700 (PDT)
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared13.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <bb@drbeat.li>)
        id 1qMGXR-0007Pk-2X
        for git@vger.kernel.org;
        Thu, 20 Jul 2023 01:24:58 +0200
Received: from [10.20.10.230] (port=3738 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.96)
        (envelope-from <bb@drbeat.li>)
        id 1qMGXQ-00HN1V-25;
        Thu, 20 Jul 2023 01:24:56 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id 05BFA1800FD; Thu, 20 Jul 2023 01:24:55 +0200 (CEST)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     Beat Bolli <dev+git@drbeat.li>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 1/2] trace2: fix a comment
Date:   Thu, 20 Jul 2023 01:24:43 +0200
Message-Id: <20230719232444.555838-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.35.1.720.g215f5dbbfb
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the trace2 counter mechanism was added in 81071626ba (trace2: add
global counter mechanism, 2022-10-24), the name of the file where new
counters are added was misspelled in a comment.

Use the correct file name.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 trace2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/trace2.h b/trace2.h
index f5c5a9e6bac5..64c747c1df1b 100644
--- a/trace2.h
+++ b/trace2.h
@@ -541,7 +541,7 @@ void trace2_timer_stop(enum trace2_timer_id tid);
  * elsewhere as array indexes).
  *
  * Any values added to this enum be also be added to the
- * `tr2_counter_metadata[]` in `trace2/tr2_tr2_ctr.c`.
+ * `tr2_counter_metadata[]` in `trace2/tr2_ctr.c`.
  */
 enum trace2_counter_id {
 	/*
-- 
2.41.0

