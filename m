From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] Fix typo in remote branch example in git user manual
Date: Tue, 5 Jun 2007 08:47:51 +0000
Message-ID: <20070605084751.23322.qmail@fcde833ae749fc.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 05 10:47:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvUhW-0001ls-Vz
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 10:47:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757143AbXFEIrd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 04:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761647AbXFEIrd
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 04:47:33 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:48790 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757143AbXFEIrd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 04:47:33 -0400
Received: (qmail 23323 invoked by uid 1000); 5 Jun 2007 08:47:51 -0000
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49170>

In Documentation/user-manual.txt the example
 $ git checkout --track -b origin/maint maint
under "Getting updates with git pull", should read
 $ git checkout --track -b maint origin/maint

This was noticed by Ron, and reported through
 http://bugs.debian.org/427502

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 Documentation/user-manual.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 7eaafa8..342de6d 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1682,7 +1682,7 @@ automatically set the default remote branch to pull from at the time
 that a branch is created:
 
 -------------------------------------------------
-$ git checkout --track -b origin/maint maint
+$ git checkout --track -b maint origin/maint
 -------------------------------------------------
 
 In addition to saving you keystrokes, "git pull" also helps you by
-- 
1.5.2
