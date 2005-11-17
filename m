From: Martin Atukunda <matlads@dsmagic.com>
Subject: [PATCH 1/2] Build GIT_VERSION from VERSION, PATCHLEVEL, and SUBLEVEL variables.
Date: Thu, 17 Nov 2005 16:25:37 +0300
Message-ID: <11322339373013-git-send-email-matlads@dsmagic.com>
References: <11322339372137-git-send-email-matlads@dsmagic.com>
Reply-To: Martin Atukunda <matlads@dsmagic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Atukunda <matlads@dsmagic.com>
X-From: git-owner@vger.kernel.org Thu Nov 17 14:29:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ecjmd-0003uO-5U
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 14:26:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbVKQN0X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 08:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbVKQN0W
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 08:26:22 -0500
Received: from metronet39.infocom.co.ug ([217.113.73.39]:58373 "EHLO
	entandikwa.ds.co.ug") by vger.kernel.org with ESMTP
	id S1750801AbVKQN0S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 08:26:18 -0500
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP
	id 142FD517A; Thu, 17 Nov 2005 16:27:44 +0300 (EAT)
Received: from localhost ([127.0.0.1] helo=igloo)
	by igloo.ds.co.ug with smtp (Exim 4.54)
	id 1Ecjlh-0000Lz-GG; Thu, 17 Nov 2005 16:25:37 +0300
In-Reply-To: <11322339372137-git-send-email-matlads@dsmagic.com>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12110>

This will allow scripts to be able to determine which git release they
target (or require).

Signed-Off-By: Martin Atukunda <matlads@dsmagic.com>

---

 Makefile |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

applies-to: 1e3fcf60526c196a46433e6947c9104ca236f230
968e5b59fba66a1b146c643e5161978c787d4273
diff --git a/Makefile b/Makefile
index ebff990..74c6b9e 100644
--- a/Makefile
+++ b/Makefile
@@ -50,7 +50,11 @@
 # Define USE_STDEV below if you want git to care about the underlying device
 # change being considered an inode change from the update-cache perspective.
 
-GIT_VERSION = 0.99.9.GIT
+VERSION = 0
+PATCHLEVEL = 99
+SUBLEVEL = 9
+EXTRAVERSION = GIT
+GIT_VERSION=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL).$(EXTRAVERSION)
 
 # CFLAGS and LDFLAGS are for the users to override from the command line.
 
---
0.99.9.GIT
