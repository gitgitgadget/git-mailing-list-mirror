From: David Kastrup <dak@gnu.org>
Subject: [PATCH] Documentation/user-manual.txt: fix a few omissions of gitlink commands.
Date: Wed, 8 Aug 2007 17:34:28 +0200
Message-ID: <86hcnat4uk.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 08 17:37:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IInbP-0004Hw-Mf
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 17:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882AbXHHPhf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 11:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009AbXHHPhf
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 11:37:35 -0400
Received: from main.gmane.org ([80.91.229.2]:53102 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752555AbXHHPhe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 11:37:34 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IInbI-0006lW-9e
	for git@vger.kernel.org; Wed, 08 Aug 2007 17:37:32 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Aug 2007 17:37:32 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Aug 2007 17:37:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:OvgGskLkvNn1N9Wb5era/5bhLPc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55326>


Signed-off-by: David Kastrup <dak@gnu.org>
---
 Documentation/user-manual.txt |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index f89952a..4c9d69b 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1796,11 +1796,12 @@ taken from the message containing each patch.
 Public git repositories
 -----------------------
 
-Another way to submit changes to a project is to tell the maintainer of
-that project to pull the changes from your repository using git-pull[1].
-In the section "<<getting-updates-with-git-pull, Getting updates with
-git pull>>" we described this as a way to get updates from the "main"
-repository, but it works just as well in the other direction.
+Another way to submit changes to a project is to tell the maintainer
+of that project to pull the changes from your repository using
+gitlink:git-pull[1].  In the section "<<getting-updates-with-git-pull,
+Getting updates with git pull>>" we described this as a way to get
+updates from the "main" repository, but it works just as well in the
+other direction.
 
 If you and the maintainer both have accounts on the same machine, then
 you can just pull changes from each other's repositories directly;
@@ -2057,7 +2058,8 @@ $ cd work
 Linus's tree will be stored in the remote branch named origin/master,
 and can be updated using gitlink:git-fetch[1]; you can track other
 public trees using gitlink:git-remote[1] to set up a "remote" and
-git-fetch[1] to keep them up-to-date; see <<repositories-and-branches>>.
+gitlink:git-fetch[1] to keep them up-to-date; see
+<<repositories-and-branches>>.
 
 Now create the branches in which you are going to work; these start out
 at the current tip of origin/master branch, and should be set up (using
@@ -2512,9 +2514,9 @@ $ gitk origin..mywork &
 And browse through the list of patches in the mywork branch using gitk,
 applying them (possibly in a different order) to mywork-new using
 cherry-pick, and possibly modifying them as you go using commit --amend.
-The git-gui[1] command may also help as it allows you to individually
-select diff hunks for inclusion in the index (by right-clicking on the
-diff hunk and choosing "Stage Hunk for Commit").
+The gitlink:git-gui[1] command may also help as it allows you to
+individually select diff hunks for inclusion in the index (by
+right-clicking on the diff hunk and choosing "Stage Hunk for Commit").
 
 Another technique is to use git-format-patch to create a series of
 patches, then reset the state to before the patches:
-- 
1.5.3.rc4.43.gaf14
