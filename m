From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 2/6] user-manual: fix inconsistent example
Date: Sat, 10 Mar 2007 23:35:27 -0500
Message-ID: <11735877332438-git-send-email-bfields@citi.umich.edu>
References: <7vr6s42xgm.fsf@assigned-by-dhcp.cox.net> <11735877311383-git-send-email-bfields@citi.umich.edu> <11735877321525-git-send-email-bfields@citi.umich.edu>
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 11 05:35:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQFmY-0000iw-RJ
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 05:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933064AbXCKEfl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 23:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933113AbXCKEfl
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 23:35:41 -0500
Received: from pool-138-88-140-139.esr.east.verizon.net ([138.88.140.139]:50381
	"EHLO pad.fieldses.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933064AbXCKEfj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 23:35:39 -0500
Received: from pad.fieldses.org (pad.fieldses.org [127.0.0.1])
	by pad.fieldses.org (8.13.8/8.13.8) with ESMTP id l2B4ZXSi022225;
	Sat, 10 Mar 2007 23:35:33 -0500
Received: (from bfields@localhost)
	by pad.fieldses.org (8.13.8/8.13.8/Submit) id l2B4ZXEE022224;
	Sat, 10 Mar 2007 23:35:33 -0500
X-Mailer: git-send-email 1.5.0.gb75812-dirty
In-Reply-To: <11735877321525-git-send-email-bfields@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41904>

From: J. Bruce Fields <bfields@citi.umich.edu>

The configuration file fragment here is inconsistent with the text
above.  Thanks to Ramsay Jones for the correction.

Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/user-manual.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index a5e7b53..8b5709b 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -601,8 +601,8 @@ a new stanza:
 $ cat .git/config
 ...
 [remote "linux-nfs"]
-        url = git://linux-nfs.org/~bfields/git.git
-	fetch = +refs/heads/*:refs/remotes/linux-nfs-read/*
+	url = git://linux-nfs.org/pub/nfs-2.6.git
+	fetch = +refs/heads/*:refs/remotes/linux-nfs/*
 ...
 -------------------------------------------------
 
-- 
1.5.0.gb75812-dirty
