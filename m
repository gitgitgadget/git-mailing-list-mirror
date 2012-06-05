From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH] Documentation: have ls-files and ls-tree "see also" each other
Date: Mon,  4 Jun 2012 23:10:37 -0600
Message-ID: <1338873037-4343-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 05 07:17:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbm8a-0004zf-Ud
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 07:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754346Ab2FEFQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 01:16:55 -0400
Received: from qmta12.emeryville.ca.mail.comcast.net ([76.96.27.227]:37575
	"EHLO qmta12.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752259Ab2FEFQz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jun 2012 01:16:55 -0400
X-Greylist: delayed 348 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Jun 2012 01:16:54 EDT
Received: from omta15.emeryville.ca.mail.comcast.net ([76.96.30.71])
	by qmta12.emeryville.ca.mail.comcast.net with comcast
	id JTmR1j0031Y3wxoACVB5on; Tue, 05 Jun 2012 05:11:05 +0000
Received: from mmogilvi.homeip.net ([75.71.16.168])
	by omta15.emeryville.ca.mail.comcast.net with comcast
	id JVB41j00k3dZt5F8bVB4Fl; Tue, 05 Jun 2012 05:11:05 +0000
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id 108811E9601A; Mon,  4 Jun 2012 23:11:04 -0600 (MDT)
X-Mailer: git-send-email 1.7.10.2.484.gcd07cc5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199200>

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---

I could have used these references when I was looking at git-ls-files
documentation and trying to figure out how to make it list files
from a specific commit like git-ls-tree.

(This is a resend.  I sent this patch a couple of weeks ago,
but it apparently slipped through the cracks.)

 Documentation/git-ls-files.txt |    2 +-
 Documentation/git-ls-tree.txt  |    4 ++++
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 4b28292..8ce3c3b 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -207,7 +207,7 @@ pattern file appears in.
 
 SEE ALSO
 --------
-linkgit:git-read-tree[1], linkgit:gitignore[5]
+linkgit:git-ls-tree[1], linkgit:git-read-tree[1], linkgit:gitignore[5]
 
 GIT
 ---
diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index 16e87fd..1cd52cc 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -95,6 +95,10 @@ Object size identified by <object> is given in bytes, and right-justified
 with minimum width of 7 characters.  Object size is given only for blobs
 (file) entries; for other entries `-` character is used in place of size.
 
+SEE ALSO
+--------
+linkgit:git-ls-files[1]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
