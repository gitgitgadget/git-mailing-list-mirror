From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH] Documentation: Move "git diff <blob> <blob>"
Date: Tue, 18 Jun 2013 17:58:50 +0300
Message-ID: <1371567530-21811-1-git-send-email-kevin@bracey.fi>
Cc: Junio C Hamano <gitster@pobox.com>, Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 18 17:06:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoxTq-0006cW-N0
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 17:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245Ab3FRPFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 11:05:55 -0400
Received: from 19.mo5.mail-out.ovh.net ([46.105.35.78]:40918 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755926Ab3FRPFy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 11:05:54 -0400
X-Greylist: delayed 410 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Jun 2013 11:05:54 EDT
Received: from mail30.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id 22316FFAE0F
	for <git@vger.kernel.org>; Tue, 18 Jun 2013 16:59:02 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 18 Jun 2013 16:59:01 +0200
Received: from 62-183-157-30.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@62.183.157.30)
  by ns0.ovh.net with SMTP; 18 Jun 2013 16:58:57 +0200
X-Ovh-Mailout: 178.32.228.5 (mo5.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.3.rc0.28.g4b02ef5
X-Ovh-Tracer-Id: 8480559574632403166
X-Ovh-Remote: 62.183.157.30 (62-183-157-30.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: 42
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiiedrieejucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecuudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlgedvmd
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 42
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiiedrieejucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecuudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlgedvmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228247>

The section describing "git diff <blob> <blob>" had been placed in a
position that disrupted the statement "This is synonymous to the
previous form".

Reorder to place this form after all the <commit>-using forms, and the
note applying to them. Also mention this form in the initial description
paragraph.

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 Documentation/git-diff.txt | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index a7b4620..78d6d50 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -18,8 +18,8 @@ SYNOPSIS
 DESCRIPTION
 -----------
 Show changes between the working tree and the index or a tree, changes
-between the index and a tree, changes between two trees, or changes
-between two files on disk.
+between the index and a tree, changes between two trees, changes between
+two blob objects, or changes between two files on disk.
 
 'git diff' [--options] [--] [<path>...]::
 
@@ -56,11 +56,6 @@ directories. This behavior can be forced by --no-index.
 	This is to view the changes between two arbitrary
 	<commit>.
 
-'git diff' [options] <blob> <blob>::
-
-	This form is to view the differences between the raw
-	contents of two blob objects.
-
 'git diff' [--options] <commit>..<commit> [--] [<path>...]::
 
 	This is synonymous to the previous form.  If <commit> on
@@ -87,6 +82,11 @@ and the range notations ("<commit>..<commit>" and
 "<commit>\...<commit>") do not mean a range as defined in the
 "SPECIFYING RANGES" section in linkgit:gitrevisions[7].
 
+'git diff' [options] <blob> <blob>::
+
+	This form is to view the differences between the raw
+	contents of two blob objects.
+
 OPTIONS
 -------
 :git-diff: 1
-- 
1.8.3.rc0.28.g4b02ef5
