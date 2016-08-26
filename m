Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 865201FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 17:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753902AbcHZRFs (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 13:05:48 -0400
Received: from mx1.2b3w.ch ([92.42.186.250]:51135 "EHLO mx1.2b3w.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753419AbcHZRFr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 13:05:47 -0400
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
        by mx1.2b3w.ch (Postfix) with ESMTP id E48BFC3444;
        Fri, 26 Aug 2016 18:59:25 +0200 (CEST)
Received: from drbeat.li (215-243-153-5.dyn.cable.fcom.ch [5.153.243.215])
        by mx1.2b3w.ch (Postfix) with ESMTPSA id C8E37C343E;
        Fri, 26 Aug 2016 18:59:25 +0200 (CEST)
Received: by drbeat.li (Postfix, from userid 1000)
        id A6FF4200F9; Fri, 26 Aug 2016 18:59:25 +0200 (CEST)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 2/2] SubmittingPatches: hint at gitk's "Copy commit summary" command
Date:   Fri, 26 Aug 2016 18:59:01 +0200
Message-Id: <1472230741-5161-2-git-send-email-dev+git@drbeat.li>
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1472230741-5161-1-git-send-email-dev+git@drbeat.li>
References: <1472230741-5161-1-git-send-email-dev+git@drbeat.li>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the section on referencing previous commits with a hint to the
gitk command that was added exactly for this purpose.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 Documentation/SubmittingPatches | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 500230c..94a1661 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -124,7 +124,8 @@ archive, summarize the relevant points of the discussion.
 If you want to reference a previous commit in the history of a stable
 branch use the format "abbreviated sha1 (subject, date)". So for example
 like this: "Commit f86a374 (pack-bitmap.c: fix a memleak, 2015-03-30)
-noticed [...]".
+noticed [...]". The "Copy commit summary" command of gitk generates this
+format.
 
 
 (3) Generate your patch using Git tools out of your commits.
-- 
2.7.2
