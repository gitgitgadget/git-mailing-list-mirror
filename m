From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Documentation: move away misplaced 'push --upstream' description
Date: Sat, 23 Jan 2010 23:18:23 +0100
Message-ID: <c9fc2b7c73b401d59c15cc290a116f60d3ce13de.1264285016.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 23 23:18:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYoJg-0006rp-0z
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 23:18:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908Ab0AWWSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 17:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751660Ab0AWWSq
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 17:18:46 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:22502 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751523Ab0AWWSp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 17:18:45 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.213.0; Sat, 23 Jan
 2010 23:18:45 +0100
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.213.0; Sat, 23 Jan
 2010 23:18:23 +0100
X-Mailer: git-send-email 1.6.6.1.577.gf1430
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137867>

e9fcd1e (Add push --set-upstream, 2010-01-16) inadvertently patched
the description of --upstream in the middle of that of --repo.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
[And this, too.]

 Documentation/git-push.txt |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index c63932b..73a921c 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -122,13 +122,6 @@ nor in any Push line of the corresponding remotes file---see below).
 	the name "origin" is used. For this latter case, this option
 	can be used to override the name "origin". In other words,
 	the difference between these two commands
-
--u::
---set-upstream::
-	For every branch that is up to date or successfully pushed, add
-	upstream (tracking) reference, used by argument-less
-	linkgit:git-pull[1] and other commands. For more information,
-	see 'branch.<name>.merge' in linkgit:git-config[1].
 +
 --------------------------
 git push public         #1
@@ -139,6 +132,13 @@ is that #1 always pushes to "public" whereas #2 pushes to "public"
 only if the current branch does not track a remote branch. This is
 useful if you write an alias or script around 'git push'.
 
+-u::
+--set-upstream::
+	For every branch that is up to date or successfully pushed, add
+	upstream (tracking) reference, used by argument-less
+	linkgit:git-pull[1] and other commands. For more information,
+	see 'branch.<name>.merge' in linkgit:git-config[1].
+
 --thin::
 --no-thin::
 	These options are passed to 'git send-pack'.  Thin
-- 
1.6.6.1.577.gf1430
