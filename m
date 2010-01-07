From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/2] Documentation: warn prominently against merging with dirty trees
Date: Thu, 7 Jan 2010 18:03:27 +0100
Message-ID: <c2893e026e8180d5e990277e3f91f560e81ea452.1262883414.git.trast@student.ethz.ch>
References: <2e53c91e536e1ff585bc7464c1b8863e6cc45c45.1262883414.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 07 18:04:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSvmL-0000vd-Sq
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 18:04:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990Ab0AGRDv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 12:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468Ab0AGRDr
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 12:03:47 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:5568 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750838Ab0AGRDo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 12:03:44 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.213.0; Thu, 7 Jan
 2010 18:03:42 +0100
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.213.0; Thu, 7 Jan
 2010 18:03:27 +0100
X-Mailer: git-send-email 1.6.6.202.gdf32a
In-Reply-To: <2e53c91e536e1ff585bc7464c1b8863e6cc45c45.1262883414.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136357>

We do this for both git-merge and git-pull, so as to hopefully alert
(over)users of git-pull to the issue.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-merge.txt |    4 ++++
 Documentation/git-pull.txt  |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 7dbde7a..b224daf 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -22,6 +22,10 @@ The second syntax (<msg> `HEAD` <commit>...) is supported for
 historical reasons.  Do not use it from the command line or in
 new scripts.  It is the same as `git merge -m <msg> <commit>...`.
 
+*Warning*: Running 'git-merge' with uncommitted changes is
+discouraged: while possible, it leaves you in a state that is hard to
+back out of in the case of a conflict.
+
 
 OPTIONS
 -------
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index b932011..b3fa312 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -24,6 +24,10 @@ when merging local branches into the current branch.
 Also note that options meant for 'git-pull' itself and underlying
 'git-merge' must be given before the options meant for 'git-fetch'.
 
+*Warning*: Running 'git-pull' (actually, the underlying 'git-merge')
+with uncommitted changes is discouraged: while possible, it leaves you
+in a state that is hard to back out of in the case of a conflict.
+
 OPTIONS
 -------
 
-- 
1.6.6.202.gdf32a
