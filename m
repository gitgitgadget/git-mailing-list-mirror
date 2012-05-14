From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH] Documentation: have ls-files and ls-tree "see also" each other
Date: Sun, 13 May 2012 21:28:37 -0600
Message-ID: <1336966117-22150-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 14 05:35:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STm3z-0006Ds-W5
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 05:35:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754161Ab2ENDfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 May 2012 23:35:05 -0400
Received: from qmta08.emeryville.ca.mail.comcast.net ([76.96.30.80]:39661 "EHLO
	qmta08.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754063Ab2ENDfE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 May 2012 23:35:04 -0400
X-Greylist: delayed 339 seconds by postgrey-1.27 at vger.kernel.org; Sun, 13 May 2012 23:35:04 EDT
Received: from omta11.emeryville.ca.mail.comcast.net ([76.96.30.36])
	by qmta08.emeryville.ca.mail.comcast.net with comcast
	id 9fVK1j0010mlR8UA8fVQfy; Mon, 14 May 2012 03:29:24 +0000
Received: from mmogilvi.homeip.net ([75.71.16.168])
	by omta11.emeryville.ca.mail.comcast.net with comcast
	id 9fVP1j00f3dZt5F8XfVQEw; Mon, 14 May 2012 03:29:24 +0000
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id 691AE1E9601A; Sun, 13 May 2012 21:29:23 -0600 (MDT)
X-Mailer: git-send-email 1.7.5.rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197761>

I wanted this pointer when I was looking at git-ls-files documentation
and trying to figure out how to make it list files from a specific commit
like git-ls-tree.

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
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
1.7.5.rc1
