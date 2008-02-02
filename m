From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] Documentation/git-reset.txt: Use HEAD~N syntax everywhere (unify examples)
Date: Sat, 02 Feb 2008 03:41:01 +0200
Organization: Private
Message-ID: <3asc6spe.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 02:42:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JL7Oa-0001IL-L9
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 02:42:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760922AbYBBBlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 20:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760375AbYBBBlm
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 20:41:42 -0500
Received: from main.gmane.org ([80.91.229.2]:42585 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756849AbYBBBll (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 20:41:41 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JL7Nz-0008CH-Hb
	for git@vger.kernel.org; Sat, 02 Feb 2008 01:41:39 +0000
Received: from a91-155-183-103.elisa-laajakaista.fi ([91.155.183.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 01:41:39 +0000
Received: from jari.aalto by a91-155-183-103.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 01:41:39 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-183-103.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:M5yw1v47nitq+p6dC+0e/rPJZ1U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72204>

The examples in the documentation refer to multiple ~N commits. To
Keep the exampels unified with the same syntax, use ~N in all examples.

Signed-off-by: Jari Aalto <jari.aalto AT cante.net>
---
 Documentation/git-reset.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index a4e0a77..0566956 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -58,7 +58,7 @@ Undo a commit and redo::
 +
 ------------
 $ git commit ...
-$ git reset --soft HEAD^      <1>
+$ git reset --soft HEAD~1     <1>
 $ edit                        <2>
 $ git commit -a -c ORIG_HEAD  <3>
 ------------
@@ -80,7 +80,7 @@ $ git commit ...
 $ git reset --hard HEAD~3   <1>
 ------------
 +
-<1> The last three commits (HEAD, HEAD^, and HEAD~2) were bad
+<1> The last three commits (HEAD, HEAD~1, and HEAD~2) were bad
 and you do not want to ever see them again.  Do *not* do this if
 you have already given these commits to somebody else.
 
@@ -165,7 +165,7 @@ $ git checkout master
 $ fix fix fix
 $ git commit ;# commit with real log
 $ git checkout feature
-$ git reset --soft HEAD^ ;# go back to WIP state  <2>
+$ git reset --soft HEAD~1 ;# go back to WIP state <2>
 $ git reset                                       <3>
 ------------
 +
-- 
1.5.4-rc5.GIT-dirty



-- 
Welcome to FOSS revolution: we fix and modify until it shines
