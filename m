From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 3/5] Docs: add some long/short options
Date: Sun,  8 Jun 2008 03:36:10 +0200
Message-ID: <1212888972-29039-3-git-send-email-s-beyer@gmx.net>
References: <7vy75hlzvv.fsf@gitster.siamese.dyndns.org>
 <1212888972-29039-1-git-send-email-s-beyer@gmx.net>
 <1212888972-29039-2-git-send-email-s-beyer@gmx.net>
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 03:37:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K59qe-0000LG-Fk
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 03:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756255AbYFHBgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 21:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755973AbYFHBgg
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 21:36:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:37292 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755894AbYFHBgf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 21:36:35 -0400
Received: (qmail invoked by alias); 08 Jun 2008 01:36:33 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp055) with SMTP; 08 Jun 2008 03:36:33 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+pOvAntLipqgbVIZVUpdYhBssOl1n67KDeNog/RN
	1ZB+XEJep8jPBr
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K59pM-0007Yp-So; Sun, 08 Jun 2008 03:36:12 +0200
X-Mailer: git-send-email 1.5.6.rc1.21.g03300
In-Reply-To: <1212888972-29039-2-git-send-email-s-beyer@gmx.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84243>

Namely:
 git-clean.txt: --dry-run --quiet
 git-count-objects.txt: --verbose
 git-quiltimport.txt: -n
 git-remote.txt: -v --verbose

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
Hi,

this was a kind of semi-automated search to find the options that are not 
documented in the manual.
Besides deprecated or unofficial ones, my search found those listed here
and those from the following patches.

Regards,
  Stephan

PS: Because the patches are so tiny, I didn't want to make several ones.

 Documentation/git-clean.txt         |    2 ++
 Documentation/git-count-objects.txt |    1 +
 Documentation/git-quiltimport.txt   |    2 ++
 Documentation/git-remote.txt        |   10 +++++++++-
 4 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index deebf3b..37a82ee 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -30,9 +30,11 @@ OPTIONS
 	git-clean will refuse to run unless given -f or -n.
 
 -n::
+--dry-run::
 	Don't actually remove anything, just show what would be done.
 
 -q::
+--quiet::
 	Be quiet, only report errors, but not the files that are
 	successfully removed.
 
diff --git a/Documentation/git-count-objects.txt b/Documentation/git-count-objects.txt
index e1219b3..1ba85a2 100644
--- a/Documentation/git-count-objects.txt
+++ b/Documentation/git-count-objects.txt
@@ -18,6 +18,7 @@ them, to help you decide when it is a good time to repack.
 OPTIONS
 -------
 -v::
+--verbose::
 	In addition to the number of loose objects and disk
 	space consumed, it reports the number of in-pack
 	objects, number of packs, and number of objects that can be
diff --git a/Documentation/git-quiltimport.txt b/Documentation/git-quiltimport.txt
index d0bc182..0600379 100644
--- a/Documentation/git-quiltimport.txt
+++ b/Documentation/git-quiltimport.txt
@@ -29,6 +29,8 @@ preserved as the 1 line subject in the git description.
 
 OPTIONS
 -------
+
+-n::
 --dry-run::
 	Walk through the patches in the series and warn
 	if we cannot find all of the necessary information to commit
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index e97dc09..782b055 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -9,7 +9,7 @@ git-remote - manage set of tracked repositories
 SYNOPSIS
 --------
 [verse]
-'git-remote'
+'git-remote' [-v | --verbose]
 'git-remote' add [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>
 'git-remote' rm <name>
 'git-remote' show <name>
@@ -22,6 +22,14 @@ DESCRIPTION
 Manage the set of repositories ("remotes") whose branches you track.
 
 
+OPTIONS
+-------
+
+-v::
+--verbose::
+	Be a little more verbose and show remote url after name.
+
+
 COMMANDS
 --------
 
-- 
1.5.5.1
