From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH 4/6] manual: add some markup.
Date: Tue, 9 Oct 2007 23:03:11 +0200
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071009210310.GF31317@ins.uni-bonn.de>
References: <20071009205755.GB31317@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 23:04:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfMFD-0003DI-Vf
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 23:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754464AbXJIVDv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 17:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754441AbXJIVDv
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 17:03:51 -0400
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:34364 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754007AbXJIVDu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 17:03:50 -0400
X-Greylist: delayed 316 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Oct 2007 17:03:50 EDT
Received: from localhost.localdomain (xdsl-87-78-163-242.netcologne.de [87.78.163.242])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id F402D400009E5
	for <git@vger.kernel.org>; Tue,  9 Oct 2007 23:03:48 +0200 (CEST)
Received: from ralf by localhost.localdomain with local (Exim 4.63)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1IfMER-0000mi-AJ
	for git@vger.kernel.org; Tue, 09 Oct 2007 23:03:11 +0200
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071009205755.GB31317@ins.uni-bonn.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60439>

---
 Documentation/glossary.txt    |    2 +-
 Documentation/user-manual.txt |   10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/glossary.txt b/Documentation/glossary.txt
index 5645177..fc18744 100644
--- a/Documentation/glossary.txt
+++ b/Documentation/glossary.txt
@@ -281,7 +281,7 @@ This commit is referred to as a "merge commit", or sometimes just a
 [[def_pickaxe]]pickaxe::
 	The term <<def_pickaxe,pickaxe>> refers to an option to the diffcore
 	routines that help select changes that add or delete a given text
-	string. With the --pickaxe-all option, it can be used to view the full
+	string. With the `--pickaxe-all` option, it can be used to view the full
 	<<def_changeset,changeset>> that introduced or removed, say, a
 	particular line of text. See gitlink:git-diff[1].
 
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 2b1b324..df482e6 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1536,7 +1536,7 @@ dangling tree b24c2473f1fd3d91352a624795be026d64c8841f
 Dangling objects are not a problem.  At worst they may take up a little
 extra disk space.  They can sometimes provide a last-resort method for
 recovering lost work--see <<dangling-objects>> for details.  However, if
-you wish, you can remove them with gitlink:git-prune[1] or the --prune
+you wish, you can remove them with gitlink:git-prune[1] or the `--prune`
 option to gitlink:git-gc[1]:
 
 -------------------------------------------------
@@ -1555,7 +1555,7 @@ Recovering lost changes
 Reflogs
 ^^^^^^^
 
-Say you modify a branch with gitlink:git-reset[1] --hard, and then
+Say you modify a branch with `gitlink:git-reset[1] --hard`, and then
 realize that the branch was the only reference you had to that point in
 history.
 
@@ -1684,7 +1684,7 @@ $ git pull
 More generally, a branch that is created from a remote branch will pull
 by default from that branch.  See the descriptions of the
 branch.<name>.remote and branch.<name>.merge options in
-gitlink:git-config[1], and the discussion of the --track option in
+gitlink:git-config[1], and the discussion of the `--track` option in
 gitlink:git-checkout[1], to learn how to control these defaults.
 
 In addition to saving you keystrokes, "git pull" also helps you by
@@ -2412,7 +2412,7 @@ $ git rebase --continue
 
 and git will continue applying the rest of the patches.
 
-At any point you may use the --abort option to abort this process and
+At any point you may use the `--abort` option to abort this process and
 return mywork to the state it had before you started the rebase:
 
 -------------------------------------------------
@@ -2481,7 +2481,7 @@ $ gitk origin..mywork &
 
 and browse through the list of patches in the mywork branch using gitk,
 applying them (possibly in a different order) to mywork-new using
-cherry-pick, and possibly modifying them as you go using commit --amend.
+cherry-pick, and possibly modifying them as you go using `commit --amend`.
 The gitlink:git-gui[1] command may also help as it allows you to
 individually select diff hunks for inclusion in the index (by
 right-clicking on the diff hunk and choosing "Stage Hunk for Commit").
-- 
1.5.3.3.g34c6d
