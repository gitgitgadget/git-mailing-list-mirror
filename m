From: Anand Kumria <wildfire@progsoc.org>
Subject: [PATCH 09/12]  Consistently use 'git-p4' for the configuration entries
Date: Sun, 10 Aug 2008 19:26:32 +0100
Message-ID: <1218392795-4084-10-git-send-email-wildfire@progsoc.org>
References: <1218392795-4084-1-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-2-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-3-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-4-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-5-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-6-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-7-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-8-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-9-git-send-email-wildfire@progsoc.org>
Cc: simon@lst.de, Anand Kumria <wildfire@progsoc.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 20:38:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSFo9-0003k8-9S
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 20:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbYHJShU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 14:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753211AbYHJShU
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 14:37:20 -0400
Received: from 133.105.233.220.exetel.com.au ([220.233.105.133]:47916 "EHLO
	giskard.kumria.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753199AbYHJShS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 14:37:18 -0400
Received: from caliban.kumria.com ([203.7.227.146] helo=eve.kumria.com)
	by giskard.kumria.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <anand@eve.kumria.com>)
	id 1KSFmy-00023U-8w; Mon, 11 Aug 2008 04:37:16 +1000
Received: from anand by eve.kumria.com with local (Exim 4.69)
	(envelope-from <anand@eve.kumria.com>)
	id 1KSFch-00015H-Ql; Sun, 10 Aug 2008 19:26:35 +0100
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1218392795-4084-9-git-send-email-wildfire@progsoc.org>
X-Spam-Score: -2.3
X-Spam-Score-Int: -22
X-Spam-Bar: --
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91867>

Signed-off-by: Anand Kumria <wildfire@progsoc.org>
---
 contrib/fast-import/git-p4 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index a927e50..6c64224 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1444,7 +1444,7 @@ class P4Sync(Command):
             if not gitBranchExists(self.refPrefix + "HEAD") and self.importIntoRemotes and gitBranchExists(self.branch):
                 system("git symbolic-ref %sHEAD %s" % (self.refPrefix, self.branch))
 
-        if self.useClientSpec or gitConfig("p4.useclientspec") == "true":
+        if self.useClientSpec or gitConfig("git-p4.useclientspec") == "true":
             self.getClientSpec()
 
         # TODO: should always look at previous commits,
-- 
1.5.6.3
