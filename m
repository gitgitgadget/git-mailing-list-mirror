Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E280620248
	for <e@80x24.org>; Tue, 26 Feb 2019 11:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbfBZLFt (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 06:05:49 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42228 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfBZLFt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 06:05:49 -0500
Received: from localhost (2a02-ab04-03b9-5e00-0000-0000-0000-0003.dynamic.v6.chello.sk [IPv6:2a02:ab04:3b9:5e00::3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: andrewsh)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C1FE227FB9E;
        Tue, 26 Feb 2019 11:05:47 +0000 (GMT)
From:   Andrej Shadura <andrew.shadura@collabora.co.uk>
To:     git@vger.kernel.org
Cc:     Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH 1/2] gitk: refresh the colour scheme
Date:   Tue, 26 Feb 2019 12:05:34 +0100
Message-Id: <20190226110535.29172-1-andrew.shadura@collabora.co.uk>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The colours gitk is currently using are from the basic 16 colour
palette, and are a bit too intensive to be comfortable or pleasant
to work with.

Adjust the main colours (commit nodes, remotes, tags and one branch
colour) to be slightly softer.

Signed-off-by: Andrej Shadura <andrew.shadura@collabora.co.uk>
---
 gitk-git/gitk | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index a14d7a16b2..5766754ab6 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -12302,7 +12302,7 @@ if {[tk windowingsystem] eq "aqua"} {
     set extdifftool "meld"
 }
 
-set colors {"#00ff00" red blue magenta darkgrey brown orange}
+set colors {"#00ff00" red blue #f282f2 darkgrey brown orange}
 if {[tk windowingsystem] eq "win32"} {
     set uicolor SystemButtonFace
     set uifgcolor SystemButtonText
@@ -12325,11 +12325,11 @@ set ignorespace 0
 set worddiff ""
 set markbgcolor "#e0e0ff"
 
-set headbgcolor "#00ff00"
+set headbgcolor #98ff5e
 set headfgcolor black
 set headoutlinecolor black
-set remotebgcolor #ffddaa
-set tagbgcolor yellow
+set remotebgcolor #bae2ff
+set tagbgcolor #f3fb57
 set tagfgcolor black
 set tagoutlinecolor black
 set reflinecolor black
@@ -12338,10 +12338,10 @@ set filesepfgcolor black
 set linehoverbgcolor #ffff80
 set linehoverfgcolor black
 set linehoveroutlinecolor black
-set mainheadcirclecolor yellow
+set mainheadcirclecolor #ffeb74
 set workingfilescirclecolor red
 set indexcirclecolor "#00ff00"
-set circlecolors {white blue gray blue blue}
+set circlecolors {white #08b5ed gray blue blue}
 set linkfgcolor blue
 set circleoutlinecolor $fgcolor
 set foundbgcolor yellow
-- 
2.19.1

