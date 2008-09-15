From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Documentation: warn against merging in a dirty tree
Date: Tue, 16 Sep 2008 00:49:54 +0200
Message-ID: <1221518994-26111-2-git-send-email-trast@student.ethz.ch>
References: <200809160048.31443.trast@student.ethz.ch>
 <1221518994-26111-1-git-send-email-trast@student.ethz.ch>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Miklos Vajna <vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 16 00:51:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfMug-0005Rw-44
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 00:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134AbYIOWuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 18:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755517AbYIOWuF
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 18:50:05 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:21538 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752974AbYIOWuC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 18:50:02 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 16 Sep 2008 00:49:59 +0200
Received: from localhost.localdomain ([84.75.158.234]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 16 Sep 2008 00:49:59 +0200
X-Mailer: git-send-email 1.6.0.2.469.g5ab27
In-Reply-To: <1221518994-26111-1-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 15 Sep 2008 22:49:59.0300 (UTC) FILETIME=[61A40C40:01C91785]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95954>

Merging in a dirty tree is usually a bad idea because you need to
reset --hard to abort; but the docs didn't say anything about it.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>

---
 Documentation/git-merge.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 685e1fe..3798e16 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -22,6 +22,11 @@ The second syntax (<msg> `HEAD` <remote>) is supported for
 historical reasons.  Do not use it from the command line or in
 new scripts.  It is the same as `git merge -m <msg> <remote>`.
 
+NOTE: Usually it is a bad idea to merge with a dirty tree or index.
+      If you get conflicts and want to abort (instead of resolving),
+      you need to `git reset \--hard` which loses the uncommitted
+      changes.
+
 
 OPTIONS
 -------
-- 
tg: (1293c95..) t/doc-merge-reset (depends on: origin/master)
