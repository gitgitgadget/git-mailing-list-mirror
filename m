From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] git-reset.txt: Use uniform HEAD~N notation in all examples
Date: Fri, 31 Aug 2007 20:47:11 +0300
Organization: Private
Message-ID: <tzqfsijk.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 19:43:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRAWt-0000oL-Iw
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 19:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965541AbXHaRn3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 13:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965458AbXHaRn3
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 13:43:29 -0400
Received: from main.gmane.org ([80.91.229.2]:49488 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965445AbXHaRn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 13:43:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IRAWf-0000xf-1O
	for git@vger.kernel.org; Fri, 31 Aug 2007 19:43:21 +0200
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 31 Aug 2007 19:43:21 +0200
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 31 Aug 2007 19:43:21 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.3 (windows-nt)
Cancel-Lock: sha1:DawRNq6nJx7t7LVgBoLINKj7hgA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57192>

The manual mixed both caret(HEAD^) and tilde (HEAD~N) notation in
examples. This may be xconfusing to new users. The "counting" notation
HEAD~N likely to be grasped more easily because it allow successive
numbering 1, 2, 3 etc.

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-reset.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 15e3aca..c42cd26 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -55,7 +55,7 @@ Undo a commit and redo::
 +
 ------------
 $ git commit ...
-$ git reset --soft HEAD^      <1>
+$ git reset --soft HEAD~1     <1>
 $ edit                        <2>
 $ git commit -a -c ORIG_HEAD  <3>
 ------------
@@ -77,7 +77,7 @@ $ git commit ...
 $ git reset --hard HEAD~3   <1>
 ------------
 +
-<1> The last three commits (HEAD, HEAD^, and HEAD~2) were bad
+<1> The last three commits (HEAD, HEAD~1, and HEAD~2) were bad
 and you do not want to ever see them again.  Do *not* do this if
 you have already given these commits to somebody else.
 
@@ -162,7 +162,7 @@ $ git checkout master
 $ fix fix fix
 $ git commit ;# commit with real log
 $ git checkout feature
-$ git reset --soft HEAD^ ;# go back to WIP state  <2>
+$ git reset --soft HEAD~1 ;# go back to WIP state <2>
 $ git reset                                       <3>
 ------------
 +
-- 
1.5.3.rc5



-- 
Welcome to FOSS revolution: we fix and modify until it shines
