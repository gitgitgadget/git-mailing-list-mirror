From: Brad King <brad.king@kitware.com>
Subject: [PATCH] Documentation/submodule: Add --force to update synopsis
Date: Tue, 26 Feb 2013 19:41:34 -0500
Message-ID: <7bf0424a37df48a59e4d45fb93f8518ff2db00f5.1361925124.git.brad.king@kitware.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 01:51:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAVEo-0006Al-FH
	for gcvg-git-2@plane.gmane.org; Wed, 27 Feb 2013 01:51:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932729Ab3B0Aus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 19:50:48 -0500
Received: from 66-194-253-20.static.twtelecom.net ([66.194.253.20]:36737 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932156Ab3B0AuG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 19:50:06 -0500
X-Greylist: delayed 501 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Feb 2013 19:50:06 EST
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id 9D88D809C; Tue, 26 Feb 2013 19:41:34 -0500 (EST)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217192>

In commit 9db31bdf (submodule: Add --force option for git submodule
update, 2011-04-01) we added the option to the implementation's usage
synopsis but forgot to add it to the synopsis in the command
documentation.  Add the option to the synopsis in the same location it
is reported in usage and re-wrap the options to avoid long lines.

Signed-off-by: Brad King <brad.king@kitware.com>
---
 Documentation/git-submodule.txt |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index a0c9df8..c604731 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -13,8 +13,9 @@ SYNOPSIS
 	      [--reference <repository>] [--] <repository> [<path>]
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
-'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch] [--rebase]
-	      [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
+'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
+	      [-f|--force] [--rebase] [--reference <repository>] [--merge]
+	      [--recursive] [--] [<path>...]
 'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
 	      [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
-- 
1.7.10.4
