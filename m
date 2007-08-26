From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 6/6] Documentation/user-manual.txt: fix a few omissions of gitlink commands.
Date: Sun, 26 Aug 2007 12:17:02 -0400
Message-ID: <16258.5718361244$1188145077@news.gmane.org>
References: <11881450221019-git-send-email->
 <11881450231606-git-send-email->
 <11881450231010-git-send-email->
 <11881450233251-git-send-email->
 <11881450231946-git-send-email->
 <11881450232171-git-send-email->
Cc: git@vger.kernel.org, David Kastrup <dak@gnu.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Aug 26 18:17:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPKo7-0003GX-8d
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 18:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248AbXHZQRR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 12:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753237AbXHZQRR
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 12:17:17 -0400
Received: from mail.fieldses.org ([66.93.2.214]:57990 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753186AbXHZQRF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 12:17:05 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IPKnP-0007U6-DM; Sun, 26 Aug 2007 12:17:03 -0400
X-Mailer: git-send-email 1.5.2.2.238.g7cbf2f2
In-Reply-To: <11881450232171-git-send-email->
Message-Id: <a115daff12d8d26975ff15a4278a212df2c8c70b.1188139206.git.bfields@citi.umich.edu>
In-Reply-To: <464a8a7a15fc70efbcf56c4569f0f7275a9c76fe.1188139206.git.bfields@citi.umich.edu>
References: <464a8a7a15fc70efbcf56c4569f0f7275a9c76fe.1188139206.git.bfields@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56700>

From: David Kastrup <dak@gnu.org>

Signed-off-by: David Kastrup <dak@gnu.org>
---
 Documentation/user-manual.txt |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 1c3f0e6..2e8c050 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1728,11 +1728,12 @@ taken from the message containing each patch.
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
@@ -1989,7 +1990,8 @@ $ cd work
 Linus's tree will be stored in the remote branch named origin/master,
 and can be updated using gitlink:git-fetch[1]; you can track other
 public trees using gitlink:git-remote[1] to set up a "remote" and
-git-fetch[1] to keep them up-to-date; see <<repositories-and-branches>>.
+gitlink:git-fetch[1] to keep them up-to-date; see
+<<repositories-and-branches>>.
 
 Now create the branches in which you are going to work; these start out
 at the current tip of origin/master branch, and should be set up (using
-- 
1.5.3.rc5.19.g0734d
