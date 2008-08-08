From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Documentation: commit-tree: remove 16 parents restriction
Date: Fri,  8 Aug 2008 09:52:55 +0200
Message-ID: <1218181975-12093-1-git-send-email-trast@student.ethz.ch>
Cc: gitster@pobox.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 09:54:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRMns-0002hG-Qw
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 09:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279AbYHHHxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 03:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753427AbYHHHxU
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 03:53:20 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:16152 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753027AbYHHHxT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 03:53:19 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 8 Aug 2008 09:53:18 +0200
Received: from localhost.localdomain ([129.132.149.43]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 8 Aug 2008 09:53:18 +0200
X-Mailer: git-send-email 1.6.0.rc2.19.g3c9ba
X-OriginalArrivalTime: 08 Aug 2008 07:53:18.0047 (UTC) FILETIME=[D1E5D6F0:01C8F92B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91630>

ef98c5ca lifted the 16 parents restriction in builtin-commit-tree.c,
but forgot to update the documentation.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-commit-tree.txt |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index feec584..92ab3ab 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -16,12 +16,12 @@ This is usually not what an end user wants to run directly.  See
 linkgit:git-commit[1] instead.
 
 Creates a new commit object based on the provided tree object and
-emits the new commit object id on stdout. If no parent is given then
-it is considered to be an initial tree.
+emits the new commit object id on stdout.
 
-A commit object usually has 1 parent (a commit after a change) or up
-to 16 parents.  More than one parent represents a merge of branches
-that led to them.
+A commit object may have any number of parents. With exactly one
+parent, it is an ordinary commit. Having more than one parent makes
+the commit a merge between several lines of history. Initial (root)
+commits have no parents.
 
 While a tree represents a particular directory state of a working
 directory, a commit represents that state in "time", and explains how
-- 
1.6.0.rc2.19.g3c9ba
