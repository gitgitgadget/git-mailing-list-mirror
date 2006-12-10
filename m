X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Doug Maxey <dwm@enoyolf.org>
Subject: [RFC/PATCH] gitk: add current directory to main window title
Date: Sun, 10 Dec 2006 14:31:46 -0600
Message-ID: <24010.1165782706@bebe.enoyolf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 10 Dec 2006 20:32:19 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: exmh enoyolf.org version 2.7.2.1 01/17/2005 with nmh-1.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33925>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtVLM-0007pm-HU for gcvg-git@gmane.org; Sun, 10 Dec
 2006 21:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762517AbWLJUcM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 15:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762501AbWLJUcM
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 15:32:12 -0500
Received: from falcon30.maxeymade.com ([24.173.215.190]:53457 "EHLO
 bebe.enoyolf.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1762500AbWLJUcL (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006
 15:32:11 -0500
Received: from bebe.enoyolf.org (bebe.enoyolf.org [127.0.0.1]) by
 bebe.enoyolf.org (8.13.8/8.13.8) with ESMTP id kBAKVkoM024011; Sun, 10 Dec
 2006 14:31:46 -0600
To: Paul Mackerras <paulus@samba.org>
Sender: git-owner@vger.kernel.org

From fe613c56b0079871e6b862077a9d673ca064cc16 Mon Sep 17 00:00:00 2001
From: Doug Maxey <dwm@bebe.enoyolf.org>
Date: Sun, 10 Dec 2006 14:02:50 -0600

Signed-off-by: Doug Maxey <dwm@enoyolf.org>
---
Based off gitk#master.

It helps me, being greyware challenged, keep track of which gitk is active 
for a given directory. 
---
 gitk |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index 3dabc69..b8fd6ca 100755
--- a/gitk
+++ b/gitk
@@ -6293,6 +6293,7 @@ set stuffsaved 0
 set patchnum 0
 setcoords
 makewindow
+wm title . "[file tail $argv0] [file tail [pwd]]"
 readrefs
 
 if {$cmdline_files ne {} || $revtreeargs ne {}} {
-- 
1.4.4.2


