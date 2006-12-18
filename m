X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: [PATCH] vim syntax: follow recent changes to commit template
Date: Mon, 18 Dec 2006 02:26:42 -0500
Message-ID: <20061218072642.GA13858@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 18 Dec 2006 07:33:33 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Dec 2006 02:33:25 EST
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34721>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwD05-0006gt-3Y for gcvg-git@gmane.org; Mon, 18 Dec
 2006 08:33:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753451AbWLRHd0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 02:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753419AbWLRHd0
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 02:33:26 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:40662
 "HELO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id
 S1753451AbWLRHdZ (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 02:33:25 -0500
Received: (qmail 24316 invoked from network); 18 Dec 2006 02:26:43 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 18 Dec 2006 02:26:43 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Dec
 2006 02:26:42 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

This patch changes the syntax highlighting to correctly match the new
text of the commit message introduced by
  82dca84871637ac9812c0dec27f56d07cfba524c

Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/vim/syntax/gitcommit.vim |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/vim/syntax/gitcommit.vim b/contrib/vim/syntax/gitcommit.vim
index a9de09f..d911efb 100644
--- a/contrib/vim/syntax/gitcommit.vim
+++ b/contrib/vim/syntax/gitcommit.vim
@@ -1,7 +1,7 @@
 syn region gitLine start=/^#/ end=/$/
-syn region gitCommit start=/^# Updated but not checked in:$/ end=/^#$/ contains=gitHead,gitCommitFile
+syn region gitCommit start=/^# Added but not yet committed:$/ end=/^#$/ contains=gitHead,gitCommitFile
 syn region gitHead contained start=/^#   (.*)/ end=/^#$/
-syn region gitChanged start=/^# Changed but not updated:/ end=/^#$/ contains=gitHead,gitChangedFile
+syn region gitChanged start=/^# Changed but not added:/ end=/^#$/ contains=gitHead,gitChangedFile
 syn region gitUntracked start=/^# Untracked files:/ end=/^#$/ contains=gitHead,gitUntrackedFile
 
 syn match gitCommitFile contained /^#\t.*/hs=s+2
-- 
