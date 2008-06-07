From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH v2] git-commit.txt: Correct option alternatives
Date: Sat,  7 Jun 2008 13:06:45 +0200
Message-ID: <1212836805-20684-1-git-send-email-s-beyer@gmx.net>
References: <200806070534.45761.chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 13:08:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4wHA-0000gh-A5
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 13:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755782AbYFGLHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 07:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755824AbYFGLHH
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 07:07:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:37840 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755770AbYFGLHF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 07:07:05 -0400
Received: (qmail invoked by alias); 07 Jun 2008 11:07:02 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp063) with SMTP; 07 Jun 2008 13:07:02 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19RtvIgLY5REtTXxFyv7V6Of0x1mbU5hlDHO5zyzs
	f+Hx7x3AEf3ncN
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K4wFx-0005Nz-Gf; Sat, 07 Jun 2008 13:06:45 +0200
X-Mailer: git-send-email 1.5.5.1.491.gadf2.dirty
In-Reply-To: <200806070534.45761.chriscool@tuxfamily.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84198>

This patch fixes the SYNOPSIS in git-commit.txt:
 * --amend is not an alternative option to -c/-C/-F/-m
 * -m and -F are not alternative options to -c/-C,
   because you can reuse authorship from a commit (-c/-C)
   but change the message (-m/-F).

Furthermore, for long-option consistency --author <author>
is changed to --author=<author>.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
Thanks, Christian.
Sometimes I'm too blind.

 Documentation/git-commit.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 02d4baa..40bf63e 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -8,9 +8,9 @@ git-commit - Record changes to the repository
 SYNOPSIS
 --------
 [verse]
-'git-commit' [-a | --interactive] [-s] [-v] [-u]
-	   [(-c | -C) <commit> | -F <file> | -m <msg> | --amend]
-	   [--allow-empty] [--no-verify] [-e] [--author <author>]
+'git-commit' [-a | --interactive] [-s] [-v] [-u] [--amend]
+	   [(-c | -C) <commit>] [-F <file> | -m <msg>]
+	   [--allow-empty] [--no-verify] [-e] [--author=<author>]
 	   [--cleanup=<mode>] [--] [[-i | -o ]<file>...]
 
 DESCRIPTION
@@ -68,7 +68,7 @@ OPTIONS
 	Take the commit message from the given file.  Use '-' to
 	read the message from the standard input.
 
---author <author>::
+--author=<author>::
 	Override the author name used in the commit.  Use
 	`A U Thor <author@example.com>` format.
 
-- 
1.5.5.1
