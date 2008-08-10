From: Anand Kumria <wildfire@progsoc.org>
Subject: [PATCH 12/12]  Put in the two other configuration elements found in the source
Date: Sun, 10 Aug 2008 19:26:35 +0100
Message-ID: <1218392795-4084-13-git-send-email-wildfire@progsoc.org>
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
 <1218392795-4084-12-git-send-email-wildfire@progsoc.org>
Cc: simon@lst.de, Anand Kumria <wildfire@progsoc.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 20:38:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSFoP-0003rN-1a
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 20:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248AbYHJShb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 14:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753242AbYHJShb
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 14:37:31 -0400
Received: from 133.105.233.220.exetel.com.au ([220.233.105.133]:47937 "EHLO
	giskard.kumria.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138AbYHJSha (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 14:37:30 -0400
Received: from caliban.kumria.com ([203.7.227.146] helo=eve.kumria.com)
	by giskard.kumria.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <anand@eve.kumria.com>)
	id 1KSFnC-00023p-I2; Mon, 11 Aug 2008 04:37:29 +1000
Received: from anand by eve.kumria.com with local (Exim 4.69)
	(envelope-from <anand@eve.kumria.com>)
	id 1KSFch-00015O-U9; Sun, 10 Aug 2008 19:26:35 +0100
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1218392795-4084-12-git-send-email-wildfire@progsoc.org>
X-Spam-Score: -2.3
X-Spam-Score-Int: -22
X-Spam-Bar: --
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91870>

 I am not entirely clear what these parameters do but felt it
 useful to call them out in the documentation.

Signed-off-by: Anand Kumria <wildfire@progsoc.org>
---
 contrib/fast-import/git-p4.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/contrib/fast-import/git-p4.txt b/contrib/fast-import/git-p4.txt
index 79a22e9..ac551d4 100644
--- a/contrib/fast-import/git-p4.txt
+++ b/contrib/fast-import/git-p4.txt
@@ -163,6 +163,10 @@ Specify the client name to use
 
   git config [--global] git-p4.client public-view
 
+git-p4.allowSubmit
+
+  git config [--global] git-p4.allowSubmit false
+
 git-p4.syncFromOrigin
 
 A useful setup may be that you have a periodically updated git repository
@@ -176,6 +180,10 @@ by default if there is an origin branch. You can disable this using:
 
   git config [--global] git-p4.syncFromOrigin false
 
+git-p4.useclientspec
+
+  git config [--global] git-p4.useclientspec false
+
 Implementation Details...
 =========================
 
-- 
1.5.6.3
