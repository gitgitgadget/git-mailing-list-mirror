Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B2CC1F453
	for <e@80x24.org>; Wed, 17 Oct 2018 05:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbeJQNjW (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 09:39:22 -0400
Received: from ms90.vtex.lt ([82.135.219.78]:53015 "EHLO ms90.vtex.lt"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbeJQNjW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 09:39:22 -0400
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Oct 2018 09:39:21 EDT
Received: (qmail 8248 invoked by uid 210); 17 Oct 2018 05:38:03 -0000
Received: from boole.vtex.vmt by ms90 (envelope-from <s4uliu5@gmail.com>, uid 201) with qmail-scanner-2.08st 
 (clamdscan: 0.99.3/25043. spamassassin: 3.3.2. perlscan: 2.08st.  
 Clear:RC:1(10.0.0.8):. 
 Processed in 0.053757 secs); 17 Oct 2018 05:38:03 -0000
Received: from boole.vtex.vmt (10.0.0.8)
  by lili.vtex.vmt with ESMTPS (DHE-RSA-AES256-GCM-SHA384 encrypted); 17 Oct 2018 05:38:03 -0000
Received: (qmail 2947 invoked from network); 17 Oct 2018 05:38:03 -0000
Received: from s2u.vtex.vmt (10.5.0.15)
  by boole.vtex.vmt with SMTP; 17 Oct 2018 05:38:03 -0000
From:   Saulius Gurklys <s4uliu5@gmail.com>
To:     git@vger.kernel.org
Cc:     Saulius Gurklys <s4uliu5@gmail.com>
Subject: [PATCH] doc: fix small typo in git show-branch
Date:   Wed, 17 Oct 2018 08:37:41 +0300
Message-Id: <20181017053741.25875-1-s4uliu5@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
X-Qmail-Scanner-2.08st: added fake Content-Type header
Content-Type:   text/plain; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix small typo as in document <glob> is used not <globs>.

Signed-off-by: Saulius Gurklys <s4uliu5@gmail.com>
---
 Documentation/git-show-branch.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index 262db049d..4a0137122 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -19,7 +19,7 @@ DESCRIPTION
 -----------
 
 Shows the commit ancestry graph starting from the commits named
-with <rev>s or <globs>s (or all refs under refs/heads
+with <rev>s or <glob>s (or all refs under refs/heads
 and/or refs/tags) semi-visually.
 
 It cannot show more than 29 branches and commits at a time.
-- 
2.19.1

