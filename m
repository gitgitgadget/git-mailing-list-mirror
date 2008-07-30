From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Documentation: Remove mentions of git-svnimport.
Date: Tue, 29 Jul 2008 20:38:19 -0400
Message-ID: <1217378299-733-1-git-send-email-benji@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 02:39:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNzis-00053K-8H
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 02:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753285AbYG3AiW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jul 2008 20:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753198AbYG3AiW
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 20:38:22 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:47469 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161AbYG3AiW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 20:38:22 -0400
Received: from localhost.localdomain (cpe-69-205-127-75.rochester.res.rr.com [69.205.127.75])
	by silverinsanity.com (Postfix) with ESMTP id 25C1D1FFC02D;
	Wed, 30 Jul 2008 00:38:12 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc1.154.ge3fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90716>

git-svnimport is no longer supported, so don't mention it in the
documentation.  This also updates the description, removing the
historical discussion, since it mostly dealt with how it differed from
svnimport.

Noticed by Jurko Gospodneti=C4=87 <jurko.gospodnetic@docte.hr>

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---
 Documentation/git-svn.txt |   22 ++++++----------------
 1 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index e7c0f1c..4d82a08 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -12,18 +12,10 @@ SYNOPSIS
 DESCRIPTION
 -----------
 'git-svn' is a simple conduit for changesets between Subversion and gi=
t.
-It is not to be confused with linkgit:git-svnimport[1], which is
-read-only.
-
-'git-svn' was originally designed for an individual developer who want=
s a
-bidirectional flow of changesets between a single branch in Subversion
-and an arbitrary number of branches in git.  Since its inception,
-'git-svn' has gained the ability to track multiple branches in a manne=
r
-similar to 'git-svnimport'.
-
-'git-svn' is especially useful when it comes to tracking repositories
-not organized in the way Subversion developers recommend (trunk,
-branches, tags directories).
+It provides a bidirectional flow of changes between a Subversion and a=
 git
+respository.  'git-svn' is especially useful when it comes to tracking
+repositories not organized in the way Subversion developers recommend
+(trunk, branches, tags directories).
=20
 COMMANDS
 --------
@@ -218,8 +210,7 @@ Any other arguments are passed directly to 'git-log=
'
=20
 'commit-diff'::
 	Commits the diff of two tree-ish arguments from the
-	command-line.  This command is intended for interoperability with
-	'git-svnimport' and does not rely on being inside an `git-svn
+	command-line.  This command does not rely on being inside an `git-svn
 	init`-ed repository.  This command takes three arguments, (a) the
 	original tree to diff against, (b) the new tree result, (c) the
 	URL of the target Subversion repository.  The final argument
@@ -317,8 +308,7 @@ config key: svn.findcopiesharder
 -A<filename>::
 --authors-file=3D<filename>::
=20
-Syntax is compatible with the files used by 'git-svnimport' and
-'git-cvsimport':
+Syntax is compatible with the file used by 'git-cvsimport':
=20
 ----------------------------------------------------------------------=
--
 	loginname =3D Joe User <user@example.com>
--=20
1.6.0.rc1.154.ge3fc
