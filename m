From: Anand Kumria <wildfire@progsoc.org>
Subject: [PATCH 10/12]  Move git-p4.syncFromOrigin into a configuration parameters section
Date: Sun, 10 Aug 2008 19:26:33 +0100
Message-ID: <1218392795-4084-11-git-send-email-wildfire@progsoc.org>
References: <1218392795-4084-1-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-2-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-3-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-4-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-5-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-6-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-7-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-8-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-9-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-10-git-send-email-wildfire@progsoc.org>
Cc: simon@lst.de, Anand Kumria <wildfire@progsoc.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 20:38:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSFoA-0003k8-K6
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 20:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753241AbYHJSh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 14:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753211AbYHJSh0
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 14:37:26 -0400
Received: from 133.105.233.220.exetel.com.au ([220.233.105.133]:47931 "EHLO
	giskard.kumria.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235AbYHJShY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 14:37:24 -0400
Received: from caliban.kumria.com ([203.7.227.146] helo=eve.kumria.com)
	by giskard.kumria.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <anand@eve.kumria.com>)
	id 1KSFn5-00023e-R0; Mon, 11 Aug 2008 04:37:23 +1000
Received: from anand by eve.kumria.com with local (Exim 4.69)
	(envelope-from <anand@eve.kumria.com>)
	id 1KSFch-00015I-Ra; Sun, 10 Aug 2008 19:26:35 +0100
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1218392795-4084-10-git-send-email-wildfire@progsoc.org>
X-Spam-Score: -2.3
X-Spam-Score-Int: -22
X-Spam-Bar: --
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91868>

Signed-off-by: Anand Kumria <wildfire@progsoc.org>
---
 contrib/fast-import/git-p4.txt |   28 ++++++++++++++++------------
 1 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/contrib/fast-import/git-p4.txt b/contrib/fast-import/git-p4.txt
index b16a838..0896abb 100644
--- a/contrib/fast-import/git-p4.txt
+++ b/contrib/fast-import/git-p4.txt
@@ -63,18 +63,6 @@ It is recommended to run 'git repack -a -d -f' from time to time when using
 incremental imports to optimally combine the individual git packs that each
 incremental import creates through the use of git-fast-import.
 
-
-A useful setup may be that you have a periodically updated git repository
-somewhere that contains a complete import of a Perforce project. That git
-repository can be used to clone the working repository from and one would
-import from Perforce directly after cloning using git-p4. If the connection to
-the Perforce server is slow and the working repository hasn't been synced for a
-while it may be desirable to fetch changes from the origin git repository using
-the efficient git protocol. git-p4 supports this setup by calling "git fetch origin"
-by default if there is an origin branch. You can disable this using
-
-  git config git-p4.syncFromOrigin false
-
 Updating
 ========
 
@@ -140,6 +128,22 @@ Example
   git-p4 rebase
 
 
+Configuration parameters
+========================
+
+git-p4.syncFromOrigin
+
+A useful setup may be that you have a periodically updated git repository
+somewhere that contains a complete import of a Perforce project. That git
+repository can be used to clone the working repository from and one would
+import from Perforce directly after cloning using git-p4. If the connection to
+the Perforce server is slow and the working repository hasn't been synced for a
+while it may be desirable to fetch changes from the origin git repository using
+the efficient git protocol. git-p4 supports this setup by calling "git fetch origin"
+by default if there is an origin branch. You can disable this using:
+
+  git config [--global] git-p4.syncFromOrigin false
+
 Implementation Details...
 =========================
 
-- 
1.5.6.3
