From: Federico Mena Quintero <federico@novell.com>
Subject: [PATCH 2/4] Copy the docs for --track and --notrack from
	git-checkout to git-branch
Date: Mon, 17 Sep 2007 20:10:05 -0500
Message-ID: <1190077805.22387.61.camel@cacharro.xalalinux.org>
References: <1190077493.22387.54.camel@cacharro.xalalinux.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 18 03:07:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXRYz-0006bR-1f
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 03:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739AbXIRBHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 21:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753174AbXIRBHh
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 21:07:37 -0400
Received: from jericho.provo.novell.com ([137.65.248.124]:19906 "EHLO
	jericho.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753506AbXIRBHg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 21:07:36 -0400
Received: from [164.99.193.124] ([164.99.193.124])
	by jericho.provo.novell.com with ESMTP; Mon, 17 Sep 2007 19:07:24 -0600
In-Reply-To: <1190077493.22387.54.camel@cacharro.xalalinux.org>
X-Mailer: Evolution 2.11.5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58518>

The docs for git-branch did not mention --track and --notrack in
the OPTIONS section.

Signed-off-by: Federico Mena Quintero <federico@gnu.org>
---
 Documentation/git-branch.txt |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 47e6f49..8b98b52 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -93,6 +93,20 @@ OPTIONS
 --no-abbrev::
 	Display the full sha1s in output listing rather than abbreviating them.
 
+--track::
+	Set up configuration so that git-pull will automatically
+	retrieve data from the remote branch, otherwise you'll have to
+	use "git pull <url>" explicitly.  Set the
+	branch.autosetupmerge configuration variable to true if you
+	want git-checkout and git-branch to always behave as if
+	'--track' were given.
+
+--no-track::
+	When -b is given and a branch is created off a remote branch,
+	set up configuration so that git-pull will not retrieve data
+	from the remote branch, ignoring the branch.autosetupmerge
+	configuration variable.
+
 <branchname>::
 	The name of the branch to create or delete.
 	The new branch name must pass all checks defined by
-- 
1.5.2.4
