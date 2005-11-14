From: Kevin Geiss <kevin@desertsol.com>
Subject: [PATCH 4/4] git-cvsexportcommit.perl: fix typos in output
Date: Mon, 14 Nov 2005 09:43:51 -0700
Message-ID: <20051114164351.GE9131@raven.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Nov 14 17:47:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbhQx-0007b8-9y
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 17:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbVKNQnw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 11:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbVKNQnw
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 11:43:52 -0500
Received: from 12-219-167-192.client.mchsi.com ([12.219.167.192]:56193 "EHLO
	desertsol.com") by vger.kernel.org with ESMTP id S1751183AbVKNQnw
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 11:43:52 -0500
Received: from kevin by desertsol.com with local (Exim 4.50)
	id 1EbhQt-00086V-Po; Mon, 14 Nov 2005 09:43:51 -0700
To: martin.langhoff@gmail.com, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11819>

---

 git-cvsexportcommit.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

applies-to: 717dd9ec543f5d2d6cc4b9c0af41c2f80c615f0f
7c7460d88ef6d677ad9fa29880c2fb47e4a88d6b
diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index d49494a..5a8c011 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -78,7 +78,7 @@ $opt_v && print "Applying to CVS commit 
 
 # grab the commit message
 `git-cat-file commit $commit | sed -e '1,/^\$/d' > .msg`;
-$? && die "Error extraction the commit message";
+$? && die "Error extracting the commit message";
 
 my (@afiles, @dfiles, @mfiles);
 my @files = `git-diff-tree -r $parent $commit`;
@@ -188,7 +188,7 @@ my $cmd = "cvs commit -F .msg $commitfil
 
 if ($dirtypatch) {
     print "NOTE: One or more hunks failed to apply cleanly.\n";
-    print "Resolve the conflicts and then commit using:n";
+    print "Resolve the conflicts and then commit using:\n";
     print "\n    $cmd\n\n";
     exit(1);
 }
---
0.99.9.GIT
