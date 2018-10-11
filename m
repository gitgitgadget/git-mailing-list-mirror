Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58E861F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 18:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbeJLCIG (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 22:08:06 -0400
Received: from mail.weplayciv.com ([162.221.200.53]:55536 "EHLO
        mail.weplayciv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbeJLCIG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 22:08:06 -0400
Received: from localhost.localdomain (c-3985e555.02-149-6c6b7013.bbcust.telenor.se [85.229.133.57])
        by mail.weplayciv.com (Postfix) with ESMTPSA id A425394EC03;
        Thu, 11 Oct 2018 11:39:39 -0700 (PDT)
From:   Daniels Umanovskis <daniels@umanovskis.se>
To:     git@vger.kernel.org
Cc:     Daniels Umanovskis <daniels@umanovskis.se>
Subject: [PATCH] doc: move git-get-tar-commit-id to plumbing
Date:   Thu, 11 Oct 2018 20:39:32 +0200
Message-Id: <20181011183932.15530-1-daniels@umanovskis.se>
X-Mailer: git-send-email 2.19.1.330.g93276587c.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is definitely a low-level command, it's hard to argue
against it belonging in plumbing.

Signed-off-by: Daniels Umanovskis <daniels@umanovskis.se>
---
 command-list.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/command-list.txt b/command-list.txt
index c36ea3c18..966705358 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -96,7 +96,7 @@ git-for-each-ref                        plumbinginterrogators
 git-format-patch                        mainporcelain
 git-fsck                                ancillaryinterrogators          complete
 git-gc                                  mainporcelain
-git-get-tar-commit-id                   ancillaryinterrogators
+git-get-tar-commit-id                   plumbinginterrogators
 git-grep                                mainporcelain           info
 git-gui                                 mainporcelain
 git-hash-object                         plumbingmanipulators
-- 
2.19.1.330.g93276587c.dirty

