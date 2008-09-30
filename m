From: "martin f. krafft" <madduck@madduck.net>
Subject: [PATCH] Improve git-log documentation wrt file filters
Date: Tue, 30 Sep 2008 21:57:50 +0200
Message-ID: <1222804670-2833-1-git-send-email-madduck@madduck.net>
References: <20080930192553.GI21310@spearce.org>
Cc: "martin f. krafft" <madduck@madduck.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 30 21:59:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KklNx-0002l1-5O
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 21:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbYI3T6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 15:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751720AbYI3T6f
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 15:58:35 -0400
Received: from clegg.madduck.net ([193.242.105.96]:33430 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbYI3T6e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 15:58:34 -0400
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 3CD511D40A6;
	Tue, 30 Sep 2008 21:57:56 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 552C49F247;
	Tue, 30 Sep 2008 21:57:51 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id EC5F844B7; Tue, 30 Sep 2008 21:57:50 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <20080930192553.GI21310@spearce.org>
X-Virus-Scanned: ClamAV 0.94/8361/Tue Sep 30 16:28:47 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97152>

The need for "--" in the git-log synopsis was previously unclear and
confusing. This patch makes it a little clearer.

Thanks to hyy <yiyihu@gmail.com> for his help.

Signed-off-by: martin f. krafft <madduck@madduck.net>
---
 Documentation/git-log.txt |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 0446bad..5a3a625 100644
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
+[--] <path>...::
+	Show only commits that affect any of the specified paths. To
+	prevent confusion with options and branch names, paths may need to be
+	prefixed with "-- " to separate them from options or refnames.
 
 
 include::rev-list-options.txt[]
-- 
1.5.6.5
