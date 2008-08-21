From: <bpeeluk@yahoo.co.uk>
Subject: (unknown)
Date: Thu, 21 Aug 2008 15:15:38 -0400
Message-ID: <70vbht$lcjdb@smtpout.karoo.kcom.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Thu Aug 21 21:16:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWFeF-0003Ae-BC
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 21:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175AbYHUTPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 15:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753609AbYHUTPj
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 15:15:39 -0400
Received: from smtpout.karoo.kcom.com ([212.50.160.34]:38805 "EHLO
	smtpout.karoo.kcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716AbYHUTPi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 15:15:38 -0400
X-Greylist: delayed 593 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Aug 2008 15:15:38 EDT
X-IronPort-AV: E=Sophos;i="4.32,246,1217804400"; 
   d="scan'208";a="22433195"
Received: from unknown (HELO localhost) ([91.84.60.59])
  by smtpout.karoo.kcom.com with ESMTP; 21 Aug 2008 20:01:53 +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93187>

>From e2b0f6749bca6f6bc7a5397fe2bd28de25db07c1 Mon Sep 17 00:00:00 2001
From: Neil Roberts <bpeeluk@yahoo.co.uk>
Date: Thu, 21 Aug 2008 19:49:58 +0100
Subject: [PATCH] config.mak.in: Pass on LDFLAGS from configure

The configure script allows you to specify flags to pass to the linker
step in the LDFLAGS environment variable but this was being ignored in
the Makefile. Now a make variable gets set to the value passed down
from the configure script.

Signed-off-by: Neil Roberts <bpeeluk@yahoo.co.uk>
---
 config.mak.in |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index b776149..f67d673 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -3,6 +3,7 @@
 
 CC = @CC@
 CFLAGS = @CFLAGS@
+LDFLAGS = @LDFLAGS@
 AR = @AR@
 TAR = @TAR@
 #INSTALL = @INSTALL@		# needs install-sh or install.sh in sources
-- 
1.5.4.3
