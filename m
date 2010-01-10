From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 2/4] Documentation: warn prominently against merging with dirty trees
Date: Sun, 10 Jan 2010 01:02:40 +0100
Message-ID: <e330d8ca1a9ec38ce40b0f67123b1dd893f0b31c.1263081032.git.trast@student.ethz.ch>
References: <cover.1263081032.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 10 01:03:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTlGz-0004Qp-GA
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 01:03:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939Ab0AJADJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2010 19:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752967Ab0AJADI
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 19:03:08 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:17336 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752784Ab0AJADG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 19:03:06 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.213.0; Sun, 10 Jan
 2010 01:03:04 +0100
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.213.0; Sun, 10 Jan
 2010 01:02:43 +0100
X-Mailer: git-send-email 1.6.6.218.g502b0
In-Reply-To: <cover.1263081032.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136544>

We do this for both git-merge and git-pull, so as to hopefully alert
(over)users of git-pull to the issue.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-merge.txt |    4 ++++
 Documentation/git-pull.txt  |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 4896587..3277f4e 100644
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
1.6.6.218.g502b0
