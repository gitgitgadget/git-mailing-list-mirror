From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH] config.txt: update branch.<name>.merge documentation
Date: Sat, 03 Feb 2007 16:29:40 +0100
Message-ID: <87irejgsyj.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 03 16:30:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDMq6-0008M6-Gl
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 16:30:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946323AbXBCPaA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 3 Feb 2007 10:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992427AbXBCPaA
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 10:30:00 -0500
Received: from ifae-s0.ifae.es ([192.101.162.68]:42992 "EHLO ifae-s0.ifae.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946323AbXBCP37 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 10:29:59 -0500
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id l13FTuj01556
	for <git@vger.kernel.org>; Sat, 3 Feb 2007 16:29:57 +0100
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38566>



Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 Documentation/config.txt |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e5e019f..f129de9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -233,11 +233,12 @@ branch.<name>.remote::
 branch.<name>.merge::
 	When in branch <name>, it tells `git fetch` the default refspec to
 	be marked for merging in FETCH_HEAD. The value has exactly to match
-	a remote part of one of the refspecs which are fetched from the remot=
e
-	given by "branch.<name>.remote".
+	the remote or local part of one of the refspecs which are fetched
+	from the remote given by "branch.<name>.remote".
 	The merge information is used by `git pull` (which at first calls
 	`git fetch`) to lookup the default branch for merging. Without
-	this option, `git pull` defaults to merge the first refspec fetched.
+	this option and when fetching a non default remote, `git pull`
+	defaults to merge the first refspec fetched.
 	Specify multiple values to get an octopus merge.
=20
 color.branch::
--=20
1.5.0.rc2.579.g7df8
