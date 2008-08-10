From: Anand Kumria <wildfire@progsoc.org>
Subject: [PATCH 11/12] Put some documentation in about the parameters that have been added
Date: Sun, 10 Aug 2008 19:26:34 +0100
Message-ID: <1218392795-4084-12-git-send-email-wildfire@progsoc.org>
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
 <1218392795-4084-11-git-send-email-wildfire@progsoc.org>
Cc: simon@lst.de, Anand Kumria <wildfire@progsoc.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 20:38:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSFo9-0003k8-VD
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 20:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753230AbYHJShX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 14:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753211AbYHJShX
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 14:37:23 -0400
Received: from 133.105.233.220.exetel.com.au ([220.233.105.133]:47922 "EHLO
	giskard.kumria.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215AbYHJShU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 14:37:20 -0400
Received: from caliban.kumria.com ([203.7.227.146] helo=eve.kumria.com)
	by giskard.kumria.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <anand@eve.kumria.com>)
	id 1KSFn2-00023a-Gx; Mon, 11 Aug 2008 04:37:18 +1000
Received: from anand by eve.kumria.com with local (Exim 4.69)
	(envelope-from <anand@eve.kumria.com>)
	id 1KSFch-00015M-T8; Sun, 10 Aug 2008 19:26:35 +0100
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1218392795-4084-11-git-send-email-wildfire@progsoc.org>
X-Spam-Score: -2.3
X-Spam-Score-Int: -22
X-Spam-Bar: --
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91869>

Signed-off-by: Anand Kumria <wildfire@progsoc.org>
---
 contrib/fast-import/git-p4.txt |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/contrib/fast-import/git-p4.txt b/contrib/fast-import/git-p4.txt
index 0896abb..79a22e9 100644
--- a/contrib/fast-import/git-p4.txt
+++ b/contrib/fast-import/git-p4.txt
@@ -131,6 +131,38 @@ Example
 Configuration parameters
 ========================
 
+git-p4.user ($P4USER)
+
+Allows you to specify the username to use to connect to the Perforce repository.
+
+  git config [--global] git-p4.user public
+
+git-p4.password ($P4PASS)
+
+Allows you to specify the password to use to connect to the Perforce repository.
+Warning this password will be visible on the command-line invocation of the p4 binary.
+
+  git config [--global] git-p4.password public1234
+
+git-p4.port ($P4PORT)
+
+Specify the port to be used to contact the Perforce server. As this will be passed
+directly to the p4 binary, it may be in the format host:port as well.
+
+  git config [--global] git-p4.port codes.zimbra.com:2666
+
+git-p4.host ($P4HOST)
+
+Specify the host to contact for a Perforce repository.
+
+  git config [--global] git-p4.host perforce.example.com
+
+git-p4.client ($P4CLIENT)
+
+Specify the client name to use
+
+  git config [--global] git-p4.client public-view
+
 git-p4.syncFromOrigin
 
 A useful setup may be that you have a periodically updated git repository
-- 
1.5.6.3
