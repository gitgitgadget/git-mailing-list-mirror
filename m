Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66A321F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 21:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbeJKFC7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 01:02:59 -0400
Received: from mail.weplayciv.com ([162.221.200.53]:37070 "EHLO
        mail.weplayciv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbeJKFC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 01:02:59 -0400
Received: from localhost.localdomain (c-3985e555.02-149-6c6b7013.bbcust.telenor.se [85.229.133.57])
        by mail.weplayciv.com (Postfix) with ESMTPSA id CBFA09446E6;
        Wed, 10 Oct 2018 14:38:54 -0700 (PDT)
From:   Daniels Umanovskis <daniels@umanovskis.se>
To:     git@vger.kernel.org
Cc:     Daniels Umanovskis <daniels@umanovskis.se>
Subject: [PATCH] doc: move git-rev-parse from porcelain to plumbing
Date:   Wed, 10 Oct 2018 23:37:26 +0200
Message-Id: <20181010213726.26111-1-daniels@umanovskis.se>
X-Mailer: git-send-email 2.19.1.330.g93276587c.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-rev-parse mostly seems like plumbing, and is more usd in
scripts than in regular use. Online it's often mentioned as
a plumbing command. Nonetheless it's listed under porcelain
interrogators in `man git`. It seems appropriate to formally
move git-rev-parse to plumbing interrogators.

Signed-off-by: Daniels Umanovskis <daniels@umanovskis.se>
---
 command-list.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/command-list.txt b/command-list.txt
index c36ea3c18..e6364e167 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -153,7 +153,7 @@ git-rerere                              ancillaryinterrogators
 git-reset                               mainporcelain           worktree
 git-revert                              mainporcelain
 git-rev-list                            plumbinginterrogators
-git-rev-parse                           ancillaryinterrogators
+git-rev-parse                           plumbinginterrogators
 git-rm                                  mainporcelain           worktree
 git-send-email                          foreignscminterface             complete
 git-send-pack                           synchingrepositories
-- 
2.19.1.330.g93276587c.dirty

