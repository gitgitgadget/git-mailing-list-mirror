From: =?utf-8?q?V=C3=A4in=C3=B6=20J=C3=A4rvel=C3=A4?= <v@pp.inet.fi>
Subject: [PATCH 2/2] Documented "--only-untracked" flag.
Date: Thu, 23 Aug 2007 22:58:32 +0300
Message-ID: <11878991173082-git-send-email-v@pp.inet.fi>
References: <11878991123605-git-send-email-v@pp.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?q?V=C3=A4in=C3=B6=20J=C3=A4rvel=C3=A4?= <v@pp.inet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 23 21:59:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOIqI-0005EV-Qq
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 21:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757276AbXHWT7n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 23 Aug 2007 15:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756928AbXHWT7n
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 15:59:43 -0400
Received: from gw01.mail.saunalahti.fi ([195.197.172.115]:37620 "EHLO
	gw01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757230AbXHWT7S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 15:59:18 -0400
Received: from localhost.localdomain (GYKMMMCCXVII.dsl.saunalahti.fi [85.77.38.118])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id F325815195B;
	Thu, 23 Aug 2007 22:59:13 +0300 (EEST)
X-Mailer: git-send-email 1.5.3.rc6.17.g1911-dirty
In-Reply-To: <11878991123605-git-send-email-v@pp.inet.fi>
Message-Id: <4ec861b086e2d349289f956ea0fe9f4d0559a568.1187897406.git.v@pp.inet.fi>
In-Reply-To: <4fcfda4a654b003f3ae3dc8d56424b5f59f48093.1187897406.git.v@pp.inet.fi>
References: <4fcfda4a654b003f3ae3dc8d56424b5f59f48093.1187897406.git.v@pp.inet.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Also moved a paragraph about git-status options from description
section, to options section. Which makes it easier to quickly search fo=
r
git-status options without reading the description, even though the
description for options forwards to git-commit manual.

Signed-off-by: V=C3=A4in=C3=B6 J=C3=A4rvel=C3=A4 <v@pp.inet.fi>
---
 Documentation/git-runstatus.txt |    4 +++-
 Documentation/git-status.txt    |   17 ++++++++++++-----
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-runstatus.txt b/Documentation/git-runsta=
tus.txt
index dee5d0d..56af1c1 100644
--- a/Documentation/git-runstatus.txt
+++ b/Documentation/git-runstatus.txt
@@ -8,7 +8,7 @@ git-runstatus - A helper for git-status and git-commit
=20
 SYNOPSIS
 --------
-'git-runstatus' [--color|--nocolor] [--amend] [--verbose] [--untracked=
]
+'git-runstatus' [--color|--nocolor] [--amend] [--verbose] [--untracked=
] [--only-tracked]
=20
=20
 DESCRIPTION
@@ -47,6 +47,8 @@ OPTIONS
 	option only its name and a trailing slash are displayed
 	for each untracked directory.
=20
+--only-tracked:
+	Hide untracked files from the output.
=20
 OUTPUT
 ------
diff --git a/Documentation/git-status.txt b/Documentation/git-status.tx=
t
index 8fd0fc6..de9f5ff 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -8,7 +8,7 @@ git-status - Show the working tree status
=20
 SYNOPSIS
 --------
-'git-status' <options>...
+'git-status' [--only-tracked] <options>...
=20
 DESCRIPTION
 -----------
@@ -23,10 +23,6 @@ If there is no path that is different between the in=
dex file and
 the current HEAD commit, the command exits with non-zero
 status.
=20
-The command takes the same set of options as `git-commit`; it
-shows what would be committed if the same options are given to
-`git-commit`.
-
 If any paths have been touched in the working tree (that is,
 their modification times have changed) but their contents and
 permissions are identical to those in the index file, the command
@@ -35,6 +31,17 @@ subsequent operations such as `git-diff` if the work=
ing tree
 contains many paths that have been touched but not modified.
=20
=20
+OPTIONS
+-------
+--only-tracked::
+	Hide untracked files from the output.
+
+<options>::
+	The command takes the same set of options as `git-commit`; it
+	shows what would be committed if the same options are given to
+	`git-commit`.
+
+
 OUTPUT
 ------
 The output from this command is designed to be used as a commit
--=20
1.5.3.rc6.17.g1911-dirty
