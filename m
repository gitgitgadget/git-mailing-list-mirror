From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>
Subject: [PATCH] document --exec for git-push
Date: Tue, 16 Jan 2007 16:02:02 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070116150201.GA2427@cepheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Jan 16 16:01:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6po7-0008KP-Tf
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 16:01:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbXAPPA6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 16 Jan 2007 10:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbXAPPA6
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 10:00:58 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:43813 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751153AbXAPPA5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Jan 2007 10:00:57 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1H6po0-0005OO-Q2
	for git@vger.kernel.org; Tue, 16 Jan 2007 16:00:56 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id l0GF0sTX016751
	for <git@vger.kernel.org>; Tue, 16 Jan 2007 16:00:54 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id l0GF0sDd016750
	for git@vger.kernel.org; Tue, 16 Jan 2007 16:00:54 +0100 (MET)
To: git@vger.kernel.org
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <zeisberg@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36941>

The text is just copied from git-send-pack.txt.

Signed-off-by: Uwe Kleine-K=F6nig <zeisberg@informatik.uni-freiburg.de>
---
 Documentation/git-push.txt |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

There are still some options undocumented, but I don't know what they
do exacly:

	--thin
	--no-thin
	--repo=3D
	-v

(OK, I just now saw -v and I'm to lazy to do it now :-)

Best regards
Uwe

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 197f4b5..a19631d 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -8,7 +8,7 @@ git-push - Update remote refs along with associated obj=
ects
=20
 SYNOPSIS
 --------
-'git-push' [--all] [--tags] [-f | --force] <repository> <refspec>...
+'git-push' [--all] [--tags] [--exec=3D<receive-pack>] [-f | --force] <=
repository> <refspec>...
=20
 DESCRIPTION
 -----------
@@ -67,6 +67,12 @@ the remote repository.
 	addition to refspecs explicitly listed on the command
 	line.
=20
+\--exec::
+	Path to the 'git-receive-pack' program on the remote
+	end.  Sometimes useful when pushing to a remote
+	repository over ssh, and you do not have the program in
+	a directory on the default $PATH.
+
 -f, \--force::
 	Usually, the command refuses to update a remote ref that is
 	not a descendant of the local ref used to overwrite it.
--=20
1.5.0.rc1.g581a

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D72+PS+point+in+inch
