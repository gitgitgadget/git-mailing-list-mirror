From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH v2] Documentation: Remove mentions of git-svnimport.
Date: Tue, 29 Jul 2008 21:16:01 -0400
Message-ID: <20080730011601.GA944@Hermes>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jurko =?utf-8?Q?Gospodneti=C4=87?= <jurko.gospodnetic@docte.hr>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Wed Jul 30 03:17:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO0JZ-0005Ws-1i
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 03:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754127AbYG3BQK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jul 2008 21:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754174AbYG3BQI
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 21:16:08 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:50869 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753862AbYG3BQH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 21:16:07 -0400
Received: from localhost.localdomain (cpe-69-205-127-75.rochester.res.rr.com [69.205.127.75])
	by silverinsanity.com (Postfix) with ESMTP id DC7461FFC02E;
	Wed, 30 Jul 2008 01:15:54 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90723>

git-svnimport is no longer supported, so don't mention it in the
documentation.  This also updates the description, removing the
historical discussion, since it mostly dealt with how it differed from
svnimport.  The new description gives some starting points into the
rest of the documentation.

Noticed by Jurko Gospodneti=C4=87 <jurko.gospodnetic@docte.hr>

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---

 Replaces the remaining comparison to git-svnimport with pointers
 to the rest of the documentation.

 Documentation/git-svn.txt |   26 ++++++++++++--------------
 1 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index e7c0f1c..f230125 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -12,18 +12,18 @@ SYNOPSIS
 DESCRIPTION
 -----------
 'git-svn' is a simple conduit for changesets between Subversion and gi=
t.
-It is not to be confused with linkgit:git-svnimport[1], which is
-read-only.
+It provides a bidirectional flow of changes between a Subversion and a=
 git
+respository.
=20
-'git-svn' was originally designed for an individual developer who want=
s a
-bidirectional flow of changesets between a single branch in Subversion
-and an arbitrary number of branches in git.  Since its inception,
-'git-svn' has gained the ability to track multiple branches in a manne=
r
-similar to 'git-svnimport'.
+'git-svn' can track a single Subversion branch simply by using a
+URL to the branch, follow branches laid out in the Subversion recommen=
ded
+method (trunk, branches, tags directories) with the --stdlayout option=
, or
+follow branches in any layout with the -T/-t/-b options (see options t=
o
+'init' below, and also the 'clone' command).
=20
-'git-svn' is especially useful when it comes to tracking repositories
-not organized in the way Subversion developers recommend (trunk,
-branches, tags directories).
+Once tracking a Subversion branch (with any of the above methods), the=
 git
+repository can be updated from Subversion by the 'fetch' command and
+Subversion updated from git by the 'dcommit' command.
=20
 COMMANDS
 --------
@@ -218,8 +218,7 @@ Any other arguments are passed directly to 'git-log=
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
@@ -317,8 +316,7 @@ config key: svn.findcopiesharder
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
