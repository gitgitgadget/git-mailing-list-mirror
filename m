From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [git-svn PATCH] Fix markup in git-svn man page
Date: Fri, 04 May 2007 09:03:22 +0200
Message-ID: <20070504070003.9117.75385.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri May 04 09:04:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjrqQ-000514-M1
	for gcvg-git@gmane.org; Fri, 04 May 2007 09:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754478AbXEDHEn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 4 May 2007 03:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbXEDHEn
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 03:04:43 -0400
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:52178 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754478AbXEDHEm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 May 2007 03:04:42 -0400
Received: from c83-250-140-11.bredband.comhem.se ([83.250.140.11]:34828 helo=yoghurt)
	by ch-smtp02.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.63)
	(envelope-from <kha@treskal.com>)
	id 1HjrqI-00008L-7v; Fri, 04 May 2007 09:04:39 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by yoghurt with esmtp (Exim 4.62)
	(envelope-from <kha@treskal.com>)
	id 1Hjrp4-0002QO-7v; Fri, 04 May 2007 09:03:22 +0200
User-Agent: StGIT/0.12
X-Scan-Result: No virus found in message 1HjrqI-00008L-7v.
X-Scan-Signature: ch-smtp02.sth.basefarm.net 1HjrqI-00008L-7v 851995a656a8cd838c9688d6f4b849a1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46135>

Some of the existing markup was just plain broken, and some subcommand
options weren't indented properly.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

I poked at the markup with a stick until it rendered well (as both man
and html), but I really don't know much about asciidoc markup, so some
sanity-checking by a third party is probably a good idea.

 Documentation/git-svn.txt |   32 +++++++++++++-------------------
 1 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index fcdeeaa..c0d7d95 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -38,32 +38,30 @@ COMMANDS
 	argument.  Normally this command initializes the current
 	directory.
=20
--T<trunk_subdir>::
---trunk=3D<trunk_subdir>::
--t<tags_subdir>::
---tags=3D<tags_subdir>::
--b<branches_subdir>::
---branches=3D<branches_subdir>::
+-T<trunk_subdir>;;
+--trunk=3D<trunk_subdir>;;
+-t<tags_subdir>;;
+--tags=3D<tags_subdir>;;
+-b<branches_subdir>;;
+--branches=3D<branches_subdir>;;
 	These are optional command-line options for init.  Each of
 	these flags can point to a relative repository path
 	(--tags=3Dproject/tags') or a full url
 	(--tags=3Dhttps://foo.org/project/tags)
-
---no-metadata::
+--no-metadata;;
 	Set the 'noMetadata' option in the [svn-remote] config.
---use-svm-props::
+--use-svm-props;;
 	Set the 'useSvmProps' option in the [svn-remote] config.
---use-svnsync-props::
+--use-svnsync-props;;
 	Set the 'useSvnsyncProps' option in the [svn-remote] config.
---rewrite-root=3D<URL>::
+--rewrite-root=3D<URL>;;
 	Set the 'rewriteRoot' option in the [svn-remote] config.
---username=3D<USER>::
+--username=3D<USER>;;
 	For transports that SVN handles authentication for (http,
 	https, and plain svn), specify the username.  For other
 	transports (eg svn+ssh://), you must include the username in
 	the URL, eg svn+ssh://foo@svn.bar.com/project
-
---prefix=3D<prefix>::
+--prefix=3D<prefix>;;
 	This allows one to specify a prefix which is prepended
 	to the names of remotes if trunk/branches/tags are
 	specified.  The prefix does not automatically include a
@@ -73,7 +71,6 @@ COMMANDS
 	repository.
=20
 'fetch'::
-
 	Fetch unfetched revisions from the Subversion remote we are
 	tracking.  The name of the [svn-remote "..."] section in the
 	.git/config file may be specified as an optional command-line
@@ -104,14 +101,11 @@ accepts.  However '--fetch-all' only fetches from=
 the current
=20
 Like 'git-rebase'; this requires that the working tree be clean
 and have no uncommitted changes.
-+
---
+
 -l;;
 --local;;
 	Do not fetch remotely; only run 'git-rebase' against the
 	last fetched commit from the upstream SVN.
---
-+
=20
 'dcommit'::
 	Commit each diff from a specified head directly to the SVN
