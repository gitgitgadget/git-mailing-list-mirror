X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] INSTALL: no need to have GNU diff installed
Date: Thu, 14 Dec 2006 11:40:21 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612141139540.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 14 Dec 2006 10:40:29 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34305>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Guo0o-0007go-PT for gcvg-git@gmane.org; Thu, 14 Dec
 2006 11:40:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751922AbWLNKkY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 05:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbWLNKkY
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 05:40:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:60700 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1751922AbWLNKkX
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 05:40:23 -0500
Received: (qmail invoked by alias); 14 Dec 2006 10:40:22 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp024) with SMTP; 14 Dec 2006 11:40:22 +0100
To: git@vger.kernel.org, junkio@cox.net
Sender: git-owner@vger.kernel.org


Since a long time, we have inbuilt diff generation.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 INSTALL |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/INSTALL b/INSTALL
index b5dd9f0..e7aea60 100644
--- a/INSTALL
+++ b/INSTALL
@@ -72,16 +72,6 @@ Issues of note:
 	- expat library; git-http-push uses it for remote lock
 	  management over DAV.  Similar to "curl" above, this is optional.
 
-	- "GNU diff" to generate patches.  Of course, you don't _have_ to
-	  generate patches if you don't want to, but let's face it, you'll
-	  be wanting to. Or why did you get git in the first place?
-
-	  Non-GNU versions of the diff/patch programs don't generally support
-	  the unified patch format (which is the one git uses), so you
-	  really do want to get the GNU one.  Trust me, you will want to
-	  do that even if it wasn't for git.  There's no point in living
-	  in the dark ages any more. 
-
         - "wish", the Tcl/Tk windowing shell is used in gitk to show the
           history graphically
 
-- 
1.4.4.2.ga1b439-dirty
