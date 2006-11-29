X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] hooks/pre-commit: add example to add Signed-off-by line to
 message
Date: Wed, 29 Nov 2006 12:20:08 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611291219190.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 29 Nov 2006 11:21:54 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32634>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpNU8-00071x-4G for gcvg-git@gmane.org; Wed, 29 Nov
 2006 12:20:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967140AbWK2LUM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 06:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967145AbWK2LUL
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 06:20:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:37866 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S967140AbWK2LUK (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 06:20:10 -0500
Received: (qmail invoked by alias); 29 Nov 2006 11:20:08 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp034) with SMTP; 29 Nov 2006 12:20:08 +0100
To: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org, junkio@cox.net
Sender: git-owner@vger.kernel.org


It is good to have an example of how to supply a template for the
commit message anyway.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 templates/hooks--pre-commit |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/templates/hooks--pre-commit b/templates/hooks--pre-commit
index 723a9ef..931f127 100644
--- a/templates/hooks--pre-commit
+++ b/templates/hooks--pre-commit
@@ -7,6 +7,13 @@
 #
 # To enable this hook, make this file executable.
 
+# Uncomment this to add a Signed-off-by line to the message.
+
+# . git-sh-setup
+# git var GIT_AUTHOR_IDENT | \
+# sed -n "s/^\(.*\) [0-9]\+ [-+][0-9]\+$/Signed-off-by: \1/p" \
+# > $GIT_DIR/SQUASH_MSG
+
 # This is slightly modified from Andrew Morton's Perfect Patch.
 # Lines you introduce should not have trailing whitespace.
 # Also check for an indentation that has SP before a TAB.
-- 
1.4.4.1.gb475
