From: Sergei Organov <osv@javad.com>
Subject: [PATCH] Documentation: quote commit messages consistently.
Date: Fri, 02 Nov 2007 20:12:57 +0300
Message-ID: <878x5ga7vq.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 18:14:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io05x-0007Ed-Qy
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 18:14:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759960AbXKBRNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 13:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759717AbXKBRNI
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 13:13:08 -0400
Received: from javad.com ([216.122.176.236]:2297 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757323AbXKBRNG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 13:13:06 -0400
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lA2HD2m41777
	for <git@vger.kernel.org>; Fri, 2 Nov 2007 17:13:03 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1Io04n-0001qP-7k
	for git@vger.kernel.org; Fri, 02 Nov 2007 20:12:57 +0300
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63145>


Documentation quotes commit messages 14 times with double-quotes, and 7
times with single-quotes. The patch turns everything to double-quotes.

A nice side effect is that documentation becomes more Windoze-friendly
as AFAIK single quotes won't work there.

Signed-off-by: Sergei Organov <osv@javad.com>
---
 Documentation/core-tutorial.txt |    8 ++++----
 Documentation/everyday.txt      |    4 ++--
 Documentation/git-reset.txt     |    2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/core-tutorial.txt b/Documentation/core-tutorial.txt
index 5df97a1..99817c5 100644
--- a/Documentation/core-tutorial.txt
+++ b/Documentation/core-tutorial.txt
@@ -828,7 +828,7 @@ that branch, and do some work there.
 ------------------------------------------------
 $ git checkout mybranch
 $ echo "Work, work, work" >>hello
-$ git commit -m 'Some work.' -i hello
+$ git commit -m "Some work." -i hello
 ------------------------------------------------
 
 Here, we just added another line to `hello`, and we used a shorthand for
@@ -853,7 +853,7 @@ hasn't happened in the `master` branch at all. Then do
 ------------
 $ echo "Play, play, play" >>hello
 $ echo "Lots of fun" >>example
-$ git commit -m 'Some fun.' -i hello example
+$ git commit -m "Some fun." -i hello example
 ------------
 
 since the master branch is obviously in a much better mood.
@@ -1607,8 +1607,8 @@ in both of them.  You could merge in 'diff-fix' first and then
 'commit-fix' next, like this:
 
 ------------
-$ git merge -m 'Merge fix in diff-fix' diff-fix
-$ git merge -m 'Merge fix in commit-fix' commit-fix
+$ git merge -m "Merge fix in diff-fix" diff-fix
+$ git merge -m "Merge fix in commit-fix" commit-fix
 ------------
 
 Which would result in:
diff --git a/Documentation/everyday.txt b/Documentation/everyday.txt
index 08c61b1..ce7c170 100644
--- a/Documentation/everyday.txt
+++ b/Documentation/everyday.txt
@@ -109,7 +109,7 @@ $ tar zxf frotz.tar.gz
 $ cd frotz
 $ git-init
 $ git add . <1>
-$ git commit -m 'import of frotz source tree.'
+$ git commit -m "import of frotz source tree."
 $ git tag v2.43 <2>
 ------------
 +
@@ -300,7 +300,7 @@ $ git merge topic/one topic/two && git merge hold/linus <8>
 $ git checkout maint
 $ git cherry-pick master~4 <9>
 $ compile/test
-$ git tag -s -m 'GIT 0.99.9x' v0.99.9x <10>
+$ git tag -s -m "GIT 0.99.9x" v0.99.9x <10>
 $ git fetch ko && git show-branch master maint 'tags/ko-*' <11>
 $ git push ko <12>
 $ git push ko v0.99.9x <13>
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 15e3aca..87afa6f 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -157,7 +157,7 @@ need to get to the other branch for a quick bugfix.
 ------------
 $ git checkout feature ;# you were working in "feature" branch and
 $ work work work       ;# got interrupted
-$ git commit -a -m 'snapshot WIP'                 <1>
+$ git commit -a -m "snapshot WIP"                 <1>
 $ git checkout master
 $ fix fix fix
 $ git commit ;# commit with real log
-- 
1.5.3.4
