From: Federico Mena Quintero <federico@novell.com>
Subject: [PATCH 1/4] Mention that git-branch will not automatically check
	out the new branch
Date: Mon, 17 Sep 2007 20:07:37 -0500
Message-ID: <1190077657.22387.58.camel@cacharro.xalalinux.org>
References: <1190077493.22387.54.camel@cacharro.xalalinux.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 18 03:06:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXRWa-000600-K3
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 03:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753592AbXIRBFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 21:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752923AbXIRBFI
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 21:05:08 -0400
Received: from jericho.provo.novell.com ([137.65.248.124]:19836 "EHLO
	jericho.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753592AbXIRBFH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 21:05:07 -0400
Received: from [164.99.193.124] ([164.99.193.124])
	by jericho.provo.novell.com with ESMTP; Mon, 17 Sep 2007 19:04:56 -0600
In-Reply-To: <1190077493.22387.54.camel@cacharro.xalalinux.org>
X-Mailer: Evolution 2.11.5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58517>

Signed-off-by: Federico Mena Quintero <federico@gnu.org>
---
 Documentation/git-branch.txt |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 33bc31b..47e6f49 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -24,7 +24,9 @@ and option `-a` shows both.
 In its second form, a new branch named <branchname> will be created.
 It will start out with a head equal to the one given as <start-point>.
 If no <start-point> is given, the branch will be created with a head
-equal to that of the currently checked out branch.
+equal to that of the currently checked out branch.  Note that this
+will create the new branch, but it will not switch the working tree to
+it; use "git checkout <newbranch>" to switch to the new branch.
 
 When a local branch is started off a remote branch, git can setup the
 branch so that gitlink:git-pull[1] will appropriately merge from that
-- 
1.5.2.4
