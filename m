Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FF5D1F829
	for <e@80x24.org>; Sun, 30 Apr 2017 14:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425051AbdD3O6X (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 10:58:23 -0400
Received: from mout3.freenet.de ([195.4.92.93]:32949 "EHLO mout3.freenet.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423419AbdD3O6W (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 10:58:22 -0400
Received: from [195.4.92.141] (helo=mjail1.freenet.de)
        by mout3.freenet.de with esmtpa (ID liebundartig@freenet.de) (port 25) (Exim 4.85 #1)
        id 1d4qIl-0001qx-R4; Sun, 30 Apr 2017 16:58:19 +0200
Received: from localhost ([::1]:37000 helo=mjail1.freenet.de)
        by mjail1.freenet.de with esmtpa (ID liebundartig@freenet.de) (Exim 4.85 #1)
        id 1d4qIl-0004Fv-N3; Sun, 30 Apr 2017 16:58:19 +0200
Received: from mx10.freenet.de ([195.4.92.20]:40767)
        by mjail1.freenet.de with esmtpa (ID liebundartig@freenet.de) (Exim 4.85 #1)
        id 1d4qFO-00014B-1G; Sun, 30 Apr 2017 16:54:50 +0200
Received: from p200300454467fa13e06c29e09bd4ce99.dip0.t-ipconnect.de ([2003:45:4467:fa13:e06c:29e0:9bd4:ce99]:46062 helo=p200300454467fa4464be414ec96be51f.dip0.t-ipconnect.de)
        by mx10.freenet.de with esmtpsa (ID liebundartig@freenet.de) (TLSv1.2:AES128-SHA256:128) (port 465) (Exim 4.85 #1)
        id 1d4qFN-0004o5-RP; Sun, 30 Apr 2017 16:54:49 +0200
From:   =?UTF-8?q?Ren=C3=A9=20Genz?= <liebundartig@freenet.de>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org,
        =?UTF-8?q?Ren=C3=A9=20Genz?= <liebundartig@freenet.de>
Subject: [PATCH v2] doc: git-pull.txt use US spelling, fix minor typo
Date:   Sun, 30 Apr 2017 16:54:25 +0200
Message-Id: <1493564065-3844-1-git-send-email-liebundartig@freenet.de>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originated-At: 2003:45:4467:fa13:e06c:29e0:9bd4:ce99!46062
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: René Genz <liebundartig@freenet.de>
---
 Documentation/git-pull.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 4470e4b..942af8e 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -67,7 +67,7 @@ with uncommitted changes is discouraged: while possible, it leaves you
 in a state that may be hard to back out of in the case of a conflict.
 
 If any of the remote changes overlap with local uncommitted changes,
-the merge will be automatically cancelled and the work tree untouched.
+the merge will be automatically canceled and the work tree untouched.
 It is generally best to get any local changes in working order before
 pulling or stash them away with linkgit:git-stash[1].
 
@@ -210,7 +210,8 @@ EXAMPLES
   current branch:
 +
 ------------------------------------------------
-$ git pull, git pull origin
+$ git pull
+$ git pull origin
 ------------------------------------------------
 +
 Normally the branch merged in is the HEAD of the remote repository,
-- 
1.9.1

