From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH 2/2] tutorial: Use "git merge" instead of "git pull ."
Date: Fri, 12 Jan 2007 12:58:21 +0100
Message-ID: <87odp4319e.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Jan 12 11:59:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5K84-0001x7-CC
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 11:59:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161053AbXALK67 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 12 Jan 2007 05:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932833AbXALK66
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 05:58:58 -0500
Received: from ifae-s0.ifae.es ([192.101.162.68]:42342 "EHLO ifae-s0.ifae.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932827AbXALK66 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 05:58:58 -0500
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id l0CAwte23072
	for <git@vger.kernel.org>; Fri, 12 Jan 2007 11:58:56 +0100
To: Git Mailing List <git@vger.kernel.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36669>



Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 Documentation/tutorial.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index 4b7eba3..45abfa5 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -211,7 +211,7 @@ at this point the two branches have diverged, with =
different changes
 made in each.  To merge the changes made in experimental into master, =
run
=20
 ------------------------------------------------
-$ git pull . experimental
+$ git merge experimental
 ------------------------------------------------
=20
 If the changes don't conflict, you're done.  If there are conflicts,
@@ -320,10 +320,10 @@ could pull the changes into her master branch:
=20
 -------------------------------------
 $ git checkout master
-$ git pull . remotes/bob/master
+$ git merge bob/master
 -------------------------------------
=20
-The last command is a pull from the "bob/master" branch in Alice's
+The last command is a merge of the "bob/master" branch in Alice's
 own repository.
=20
 Alice could also perform both steps at once with:
--=20
1.5.0-rc1.GIT
