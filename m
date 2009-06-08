From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] git-stash.txt: update synopsis, pop description
Date: Mon,  8 Jun 2009 11:56:05 -0500
Message-ID: <bJxDhbQFsPIm1ZUO8mSkwwlB-otpEtzhr6sRzDVsNjTkeMld-7T4NskTGr48iYOe3w8KU1kPuDA@cipher.nrlssc.navy.mil>
Cc: gitster@pobox.com, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 08 18:56:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDi97-0000DH-Jp
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 18:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755332AbZFHQ4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 12:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755293AbZFHQ4U
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 12:56:20 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57804 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755078AbZFHQ4T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 12:56:19 -0400
Received: by mail.nrlssc.navy.mil id n58GuGYD027107; Mon, 8 Jun 2009 11:56:16 -0500
X-OriginalArrivalTime: 08 Jun 2009 16:56:16.0496 (UTC) FILETIME=[09BEA700:01C9E85A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121088>

From: Brandon Casey <drafnel@gmail.com>

Internally, the 'pop' subcommand of git-stash calls the 'apply' subcommand.
Hence, 'pop' accepts the same options as 'apply'.  Make this clear by
placing 'apply' and 'pop' next to each other in the synopsis, and state it
explicitly in the description of 'pop'.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 Documentation/git-stash.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 1cc24cc..7dda416 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -9,8 +9,8 @@ SYNOPSIS
 --------
 [verse]
 'git stash' list [<options>]
-'git stash' (show | drop | pop ) [<stash>]
-'git stash' apply [--index] [<stash>]
+'git stash' (show | drop) [<stash>]
+'git stash' (apply | pop) [--index] [<stash>]
 'git stash' branch <branchname> [<stash>]
 'git stash' [save [--keep-index] [<message>]]
 'git stash' clear
@@ -80,7 +80,7 @@ pop [<stash>]::
 	Remove a single stashed state from the stash list and apply it
 	on top of the current working tree state, i.e., do the inverse
 	operation of `git stash save`. The working directory must
-	match the index.
+	match the index.  `pop` accepts the same options as `apply`.
 +
 Applying the state can fail with conflicts; in this case, it is not
 removed from the stash list. You need to resolve the conflicts by hand
-- 
1.6.3.1.24.g152f4
