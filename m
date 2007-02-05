From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] core-tutorial: git-merge uses -m for commit messages
Date: Mon, 5 Feb 2007 12:34:39 +0100
Message-ID: <20070205113439.GA27077@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 05 12:34:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE27S-0003fy-HZ
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 12:34:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbXBELen (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 06:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbXBELen
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 06:34:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:34487 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932096AbXBELen (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 06:34:43 -0500
Received: (qmail invoked by alias); 05 Feb 2007 11:34:41 -0000
Received: from pD9EB951F.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.149.31]
  by mail.gmx.net (mp002) with SMTP; 05 Feb 2007 12:34:41 +0100
X-Authenticated: #5358227
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38742>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
 Documentation/core-tutorial.txt |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/core-tutorial.txt b/Documentation/core-tutorial.txt
index 9c28bea..6f30e0a 100644
--- a/Documentation/core-tutorial.txt
+++ b/Documentation/core-tutorial.txt
@@ -894,11 +894,11 @@ script called `git merge`, which wants to know which branches you want
 to resolve and what the merge is all about:
 
 ------------
-$ git merge "Merge work in mybranch" HEAD mybranch
+$ git merge -m "Merge work in mybranch" HEAD mybranch
 ------------
 
-where the first argument is going to be used as the commit message if
-the merge can be resolved automatically.
+The `-m` options specifies the commit message to be used for the merge commit
+(in case it is created).
 
 Now, in this case we've intentionally created a situation where the
 merge will need to be fixed up by hand, though, so git will do as much
@@ -981,7 +981,7 @@ resolve to get the "upstream changes" back to your branch.
 
 ------------
 $ git checkout mybranch
-$ git merge "Merge upstream changes." HEAD master
+$ git merge -m "Merge upstream changes." HEAD master
 ------------
 
 This outputs something like this (the actual commit object names
@@ -1623,8 +1623,8 @@ in both of them.  You could merge in 'diff-fix' first and then
 'commit-fix' next, like this:
 
 ------------
-$ git merge 'Merge fix in diff-fix' master diff-fix
-$ git merge 'Merge fix in commit-fix' master commit-fix
+$ git merge -m 'Merge fix in diff-fix' master diff-fix
+$ git merge -m 'Merge fix in commit-fix' master commit-fix
 ------------
 
 Which would result in:
-- 
1.5.0.rc3.544.g79b8
