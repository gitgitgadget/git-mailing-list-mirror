From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH v2] user-manual: mention git gui citool (commit, amend)
Date: Sun, 5 Aug 2007 23:51:19 -0400
Message-ID: <20070806035119.GB30269@fieldses.org>
References: <20070803125634.GB28323@fieldses.org> <1186318785677-git-send-email-prohaska@zib.de> <Pine.LNX.4.64.0708051457110.14781@racer.site> <20070805222213.GA12168@fieldses.org> <Pine.LNX.4.64.0708060124120.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>, gitster@pobox.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 06 05:51:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHtcw-000143-1x
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 05:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753891AbXHFDv1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 23:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753593AbXHFDv1
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 23:51:27 -0400
Received: from mail.fieldses.org ([66.93.2.214]:51558 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753556AbXHFDv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 23:51:26 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IHtcl-0001Aj-Aq; Sun, 05 Aug 2007 23:51:19 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708060124120.14781@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55105>

On Mon, Aug 06, 2007 at 01:26:21AM +0100, Johannes Schindelin wrote:
> On Sun, 5 Aug 2007, J. Bruce Fields wrote:
> > A big warning would be out of place in what is for now just an isolated
> > sentence in two different places.  But I agree with you that this would
> > be worth mentioning in any eventual full-fledged git-gui tutorial.
> 
> Unfortunately, I am really wasted by this weekend's efforts to bring 
> msysgit.git along... could you be so kind as to cut&paste the relevant 
> section in a reply to me, so I do not have to search for myself?

Sure; appended.  This isn't that different from Steffen's proposal.

> I would not normally ask for such a favour; it is relatively easy to go on 
> a search with Git, but I do have only 8 hours of sleep in the last 60 
> hours under my saddle...

Hm.  On the other hand, maybe we should just be refusing to feed your
addiction till you get some sleep.

I wanna keep this short for now, so if we really think we shouldn't
mention of the hunk-selection thing without a warning, I'd rather just
omit mention of it, and go for something like: "You can also use
gitlink:git-gui[1] to create commits and view changes in the index and
working tree", and drop the second hunk.  Whatever.

--b.

>From 407c0c87e15b3cf60347f4fc0bcdb4d239de4163 Mon Sep 17 00:00:00 2001
From: J. Bruce Fields <bfields@pig.linuxdev.us.dell.com>
Date: Sun, 5 Aug 2007 18:12:37 -0400
Subject: [PATCH] user-manual: mention git-gui

The git gui project seems to be still in early stages, but at a point
where it's worth mentioning as an alternative way of creating commits.

One feature of interest is the ability to manipulate individual diff
hunks.  However, people have found that feature not to be easily
discoverable from the user-interface.  Pending some ui improvements, a
parenthetical hint here may help.

(Thanks to Steffen Prohask and Junio Hamano for suggesting the
language.)

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 Documentation/user-manual.txt |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 9efe85c..f89952a 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1079,6 +1079,11 @@ $ git diff HEAD	    # difference between HEAD and working tree; what
 $ git status	    # a brief per-file summary of the above.
 -------------------------------------------------
 
+You can also use gitlink:git-gui[1] to create commits, view changes in
+the index and the working tree files, and individually select diff hunks
+for inclusion in the index (by right-clicking on the diff hunk and
+choosing "Stage Hunk For Commit").
+
 [[creating-good-commit-messages]]
 Creating good commit messages
 -----------------------------
@@ -2506,8 +2511,10 @@ $ gitk origin..mywork &
 
 And browse through the list of patches in the mywork branch using gitk,
 applying them (possibly in a different order) to mywork-new using
-cherry-pick, and possibly modifying them as you go using commit
---amend.
+cherry-pick, and possibly modifying them as you go using commit --amend.
+The git-gui[1] command may also help as it allows you to individually
+select diff hunks for inclusion in the index (by right-clicking on the
+diff hunk and choosing "Stage Hunk for Commit").
 
 Another technique is to use git-format-patch to create a series of
 patches, then reset the state to before the patches:
-- 
1.5.3.GIT
