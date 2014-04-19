From: Max Kirillov <max@max630.net>
Subject: [PATCH] Documentation: git-gui: describe gui.displayuntracked
Date: Sun, 20 Apr 2014 00:47:14 +0300
Message-ID: <20140419214714.GA7427@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 19 23:55:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbdEF-0003yV-DC
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 23:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbaDSVzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2014 17:55:14 -0400
Received: from p3plsmtpa11-04.prod.phx3.secureserver.net ([68.178.252.105]:37520
	"EHLO p3plsmtpa11-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751241AbaDSVzN (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Apr 2014 17:55:13 -0400
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Apr 2014 17:55:13 EDT
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa11-04.prod.phx3.secureserver.net with 
	id rxnE1n0073gsSd601xnL6v; Sat, 19 Apr 2014 14:47:22 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246542>

Signed-off-by: Max Kirillov <max@max630.net>
---
Documentation for the option introduced in e632b3c0d3
 Documentation/config.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bbba728..41e31ce 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1277,6 +1277,10 @@ gui.diffcontext::
 	Specifies how many context lines should be used in calls to diff
 	made by the linkgit:git-gui[1]. The default is "5".
 
+gui.displayuntracked::
+	Determines if linkgit::git-gui[1] shows untracked files
+	in the file list. The default is "true".
+
 gui.encoding::
 	Specifies the default encoding to use for displaying of
 	file contents in linkgit:git-gui[1] and linkgit:gitk[1].
-- 
1.8.4.rc3.902.g80a4b9e
