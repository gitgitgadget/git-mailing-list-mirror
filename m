From: "martin f. krafft" <madduck@madduck.net>
Subject: [PATCH] Improve git-log documentation wrt file filters
Date: Tue, 30 Sep 2008 16:36:12 +0200
Message-ID: <1222785372-32336-1-git-send-email-madduck@madduck.net>
Cc: "martin f. krafft" <madduck@madduck.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 30 16:37:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkgME-00051Z-Jb
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 16:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822AbYI3Oge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 10:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752424AbYI3Oge
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 10:36:34 -0400
Received: from clegg.madduck.net ([193.242.105.96]:47300 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097AbYI3Ogd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 10:36:33 -0400
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 4A04B1D40A6;
	Tue, 30 Sep 2008 16:36:21 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 889649F247;
	Tue, 30 Sep 2008 16:36:12 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 30F5A44B7; Tue, 30 Sep 2008 16:36:12 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.5
X-Virus-Scanned: ClamAV 0.94/8359/Tue Sep 30 15:29:02 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97122>

The need for "--" in the git-log synopsis was previously unclear and
confusing. This patch makes it a little clearer.

Thanks to hyy <yiyihu@gmail.com> for his help.

Signed-off-by: martin f. krafft <madduck@madduck.net>
---
 Documentation/git-log.txt |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 0446bad..b7409f8 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -8,7 +8,7 @@ git-log - Show commit logs
 
 SYNOPSIS
 --------
-'git log' <option>...
+'git log' [<options>] [<since>..<until>] [[--] <path>...]
 
 DESCRIPTION
 -----------
@@ -57,8 +57,10 @@ include::diff-options.txt[]
 	Note that only message is considered, if also a diff is shown
 	its size is not included.
 
-<path>...::
-	Show only commits that affect any of the specified paths.
+-- <path>...::
+	Show only commits that affect any of the specified paths. To
+        prevent confusion with options and branch names, paths should be
+        prefixed with "-- " to separate them from options or refnames.
 
 
 include::rev-list-options.txt[]
-- 
1.5.6.5
