From: Tom Jones <tom@oxix.org>
Subject: [PATCH] Add -S, --gpg-sign option to manpage of "git commit"
Date: Sun, 21 Oct 2012 20:46:37 +0100
Message-ID: <20121021195455.43D8F7D4C@ralph.oxix.org>
Cc: tom@oxix.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 21 22:01:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQ1iB-0003CG-Vk
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 22:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534Ab2JUUBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 16:01:15 -0400
Received: from ralph.oxix.org ([81.187.158.195]:38408 "EHLO ralph.oxix.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754384Ab2JUUBP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 16:01:15 -0400
X-Greylist: delayed 378 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Oct 2012 16:01:15 EDT
Received: by ralph.oxix.org (Postfix, from userid 1000)
	id 43D8F7D4C; Sun, 21 Oct 2012 20:54:55 +0100 (BST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208142>

git commit -S, --gpg-sign was mentioned in the program's help message,
but not in the manpage.

This adds an equivalent entry for the option in the manpage.
---
 Documentation/git-commit.txt |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 9594ac8..0e0a22c 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
 	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
 	   [--date=<date>] [--cleanup=<mode>] [--status | --no-status]
-	   [-i | -o] [--] [<file>...]
+	   [-i | -o] [--] [-S[keyid]] [<file>...]
 
 DESCRIPTION
 -----------
@@ -276,6 +276,10 @@ configuration variable documented in linkgit:git-config[1].
 	commit message template when using an editor to prepare the
 	default commit message.
 
+-S[<keyid>]::
+--gpg-sign[=<keyid>]::
+	GPG-sign commit.
+
 \--::
 	Do not interpret any more arguments as options.
 
-- 
1.7.2.5
