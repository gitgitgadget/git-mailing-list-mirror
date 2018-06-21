Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 753031F403
	for <e@80x24.org>; Thu, 21 Jun 2018 00:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932401AbeFUA4j (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 20:56:39 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:39428 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932241AbeFUA4j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 20:56:39 -0400
Received: from vapier.lan (localhost [127.0.0.1])
        by smtp.gentoo.org (Postfix) with ESMTP id 3D2C7335C8E
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 00:56:38 +0000 (UTC)
From:   Mike Frysinger <vapier@gentoo.org>
To:     git@vger.kernel.org
Subject: [PATCH] git-stash.txt: document show options
Date:   Wed, 20 Jun 2018 20:56:33 -0400
Message-Id: <20180621005633.31440-1-vapier@gentoo.org>
X-Mailer: git-send-email 2.17.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 Documentation/git-stash.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 7ef8c4791177..76e4ca788102 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -106,7 +106,7 @@ stash@{1}: On master: 9cc0589... Add git-stash
 The command takes options applicable to the 'git log'
 command to control what is shown and how. See linkgit:git-log[1].
 
-show [<stash>]::
+show [<options>] [<stash>]::
 
 	Show the changes recorded in the stash entry as a diff between the
 	stashed contents and the commit back when the stash entry was first
@@ -116,6 +116,9 @@ show [<stash>]::
 	to view the second most recent entry in patch form).
 	You can use stash.showStat and/or stash.showPatch config variables
 	to change the default behavior.
++
+The command takes options applicable to the 'git diff'
+command to control what is shown and how. See linkgit:git-diff[1].
 
 pop [--index] [-q|--quiet] [<stash>]::
 
-- 
2.17.1

