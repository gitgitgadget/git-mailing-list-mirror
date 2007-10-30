From: Sergei Organov <osv@javad.com>
Subject: [PATCH] core-tutorial: Use new syntax for git-merge.
Date: Tue, 30 Oct 2007 22:54:02 +0300
Message-ID: <87lk9k4bvp.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 20:54:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImxAN-00027C-64
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 20:54:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646AbXJ3TyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 15:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753165AbXJ3TyH
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 15:54:07 -0400
Received: from javad.com ([216.122.176.236]:1535 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752430AbXJ3TyF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 15:54:05 -0400
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id l9UJs3m38759
	for <git@vger.kernel.org>; Tue, 30 Oct 2007 19:54:04 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1ImxA2-0002c7-41
	for git@vger.kernel.org; Tue, 30 Oct 2007 22:54:02 +0300
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62744>


The patch below turns core-tutorial to use new syntax for
git-merge. Please take close look at the last diff chunk, -- I'm not sure I
got it right as it didn't have HEAD in the original version, -- was it already
wrong before the patch?

---
 Documentation/core-tutorial.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/core-tutorial.txt b/Documentation/core-tutorial.txt
index d8e78ac..02255d8 100644
--- a/Documentation/core-tutorial.txt
+++ b/Documentation/core-tutorial.txt
@@ -878,7 +878,7 @@ script called `git merge`, which wants to know which branches you want
 to resolve and what the merge is all about:
 
 ------------
-$ git merge "Merge work in mybranch" HEAD mybranch
+$ git merge -m "Merge work in mybranch" mybranch
 ------------
 
 where the first argument is going to be used as the commit message if
@@ -965,7 +965,7 @@ to the `master` branch. Let's go back to `mybranch`, and run
 
 ------------
 $ git checkout mybranch
-$ git merge "Merge upstream changes." HEAD master
+$ git merge -m "Merge upstream changes." master
 ------------
 
 This outputs something like this (the actual commit object names
@@ -1607,8 +1607,8 @@ in both of them.  You could merge in 'diff-fix' first and then
 'commit-fix' next, like this:
 
 ------------
-$ git merge 'Merge fix in diff-fix' master diff-fix
-$ git merge 'Merge fix in commit-fix' master commit-fix
+$ git merge -m 'Merge fix in diff-fix' master diff-fix
+$ git merge -m 'Merge fix in commit-fix' master commit-fix
 ------------
 
 Which would result in:
-- 
1.5.3.4
