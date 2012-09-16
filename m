From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 7/8] Doc clean: add See Also links
Date: Sun, 16 Sep 2012 11:58:02 +0100
Message-ID: <1347793083-4136-8-git-send-email-philipoakley@iee.org>
To: gitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 16 13:50:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDDN7-0006zX-5n
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 13:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146Ab2IPLth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2012 07:49:37 -0400
Received: from smtp2go.com ([207.58.142.213]:44260 "EHLO smtp2go.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751719Ab2IPLtg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 07:49:36 -0400
X-Greylist: delayed 3092 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Sep 2012 07:49:36 EDT
X-Mailer: git-send-email 1.7.8.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205605>

'git clean' is controlled by gitignore, excludes,
and core.excludesfile. Provide See Also links for them.

Use of core.excludesfile is implied.

Signed-off-by: Philip Oakley <philipoakley@iee.org>

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 79fb984..9a977b7 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -63,6 +63,12 @@ OPTIONS
 	Remove only files ignored by git.  This may be useful to rebuild
 	everything from scratch, but keep manually created files.
 
+SEE ALSO
+--------
+linkgit:gitignore[5]
+linkgit:gitrepository-layout[5]
+The optional configuration variable `core.excludesfile` linkgit:git-config[1]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
1.7.8.msysgit.0
