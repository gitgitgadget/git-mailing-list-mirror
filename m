From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] Documentation/git-svnimport.txt: fix typo.
Date: Thu, 29 Mar 2007 06:41:42 +0000
Message-ID: <20070329064142.31967.qmail@9e1b5fdb164509.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 29 08:41:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWoK9-0000Rx-73
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 08:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933510AbXC2Gl0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 02:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934000AbXC2GlZ
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 02:41:25 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:55468 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933510AbXC2GlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 02:41:25 -0400
Received: (qmail 31968 invoked by uid 1000); 29 Mar 2007 06:41:42 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43404>

This was noticed by Frederik Schwarzer.  SVN's repository by default has
trunk, tags/, and branch_es_/.

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 Documentation/git-svnimport.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-svnimport.txt b/Documentation/git-svnimport.txt
index b166cf3..bdae7d8 100644
--- a/Documentation/git-svnimport.txt
+++ b/Documentation/git-svnimport.txt
@@ -27,7 +27,7 @@ repository, or incrementally import into an existing one.
 SVN access is done by the SVN::Perl module.
 
 git-svnimport assumes that SVN repositories are organized into one
-"trunk" directory where the main development happens, "branch/FOO"
+"trunk" directory where the main development happens, "branches/FOO"
 directories for branches, and "/tags/FOO" directories for tags.
 Other subdirectories are ignored.
 
-- 
1.5.1-rc2.GIT
