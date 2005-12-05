From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: [PATCH] Document config.mak in INSTALL.
Date: Mon, 05 Dec 2005 10:38:30 -0800
Message-ID: <20348.1133807910@lotus.CS.Berkeley.EDU>
X-From: git-owner@vger.kernel.org Mon Dec 05 19:39:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjLEb-0007dH-GJ
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 19:38:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbVLESic (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 13:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbVLESic
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 13:38:32 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:32409 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S932509AbVLESib (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2005 13:38:31 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8) with ESMTP id jB5IcV6d020354
	for <git@vger.kernel.org>; Mon, 5 Dec 2005 10:38:31 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id jB5IcVYG020353
	for <git@vger.kernel.org>; Mon, 5 Dec 2005 10:38:31 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13220>


The existing config.mak should satisfy almost everyone...  You 
can change the prefix and other vars catch the new setting 
anyways.  I had forgotten that ?= acts as = (lazy value binding)
and as not := (immediate value binding).

Signed-off-by: E. Jason Riedy <ejr@cs.berkeley.edu>

---

 INSTALL |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

f03c45f49ffff74df1699444612ff7b3a75bd653
diff --git a/INSTALL b/INSTALL
index 63ccf62..916ddd4 100644
--- a/INSTALL
+++ b/INSTALL
@@ -87,3 +87,6 @@ Issues of note:
    have all the libraries/tools needed, or you may have
    necessary libraries at unusual locations.  Please look at the
    top of the Makefile to see what can be adjusted for your needs.
+   You can place local settings in config.mak and the Makefile
+   will include them.  Note that config.mak is not distributed;
+   the name is reserved for local settings.
-- 
0.99.9.GIT
