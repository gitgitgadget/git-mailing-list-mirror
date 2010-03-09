From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Documentation: improve description of "git reset --keep"
Date: Tue, 09 Mar 2010 02:51:16 +0100
Message-ID: <20100309015117.10202.28588.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Peter Baumann <waste.manager@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 09 13:35:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoyTl-0001Do-Ec
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 13:24:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756564Ab0CICAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 21:00:08 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:54257 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756324Ab0CICAG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 21:00:06 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id BA07981803D;
	Tue,  9 Mar 2010 02:59:54 +0100 (CET)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 16EDC818036;
	Tue,  9 Mar 2010 02:59:51 +0100 (CET)
X-git-sha1: 6f07c91742caff3ee2cb5e9c9bb09496c40efa38 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141818>

From: Junio C Hamano <gitster@pobox.com>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-reset.txt |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 58d9b4c..645f0c1 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -53,9 +53,12 @@ OPTIONS
 	and the current commit in the working tree.
 
 --keep::
-	Resets the index to match the tree recorded by the named commit,
-	but keep changes in the working tree. Aborts if the reset would
-	change files that are already modified in the working tree.
+	Reset the index to the given commit, keeping local changes in
+	the working tree since the current commit, while updating
+	working tree files without local changes to what appears in
+	the given commit.  If a file that is different between the
+	current commit and the given commit has local changes, reset
+	is aborted.
 
 -p::
 --patch::
-- 
1.7.0.1.307.g861f4
