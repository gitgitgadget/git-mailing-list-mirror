From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH] Document push --no-verify
Date: Wed, 22 May 2013 11:23:08 +0200
Message-ID: <bac9440ba0c977f6bd4207ac423f82b716947cc0.1369214470.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Aaron Schrab <aaron@schrab.com>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 22 11:23:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uf5Gh-0001PL-02
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 11:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755236Ab3EVJXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 05:23:24 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:4900 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754878Ab3EVJXW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 05:23:22 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 22 May
 2013 11:23:11 +0200
Received: from linux-k42r.v.cablecom.net (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 22 May
 2013 11:23:10 +0200
X-Mailer: git-send-email 1.8.3.rc3.490.g2f233b5
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225141>

ec55559 (push: Add support for pre-push hooks, 2013-01-13) forgot to
add a note to git-push(1) about the new --no-verify option.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---

The insertion spot is at the end, because the existing ordering is
indistinguishable from random.  This should also be fixed, but is a
much bigger change and probably not suitable for an -rc period.


 Documentation/git-push.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index d514813..426b3d2 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git push' [--all | --mirror | --tags] [--follow-tags] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
 	   [--repo=<repository>] [-f | --force] [--prune] [-v | --verbose] [-u | --set-upstream]
-	   [<repository> [<refspec>...]]
+	   [--no-verify] [<repository> [<refspec>...]]
 
 DESCRIPTION
 -----------
@@ -195,6 +195,9 @@ useful if you write an alias or script around 'git push'.
 	be pushed. If on-demand was not able to push all necessary
 	revisions it will also be aborted and exit with non-zero status.
 
+--no-verify::
+	Bypass the pre-push hook (see linkgit:githooks[5]).
+
 
 include::urls-remotes.txt[]
 
-- 
1.8.3.rc3.490.g2f233b5
