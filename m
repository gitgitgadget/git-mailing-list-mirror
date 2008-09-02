From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] Documentation: fix disappeared lines in 'git stash' manpage
Date: Tue,  2 Sep 2008 03:35:24 +0200
Message-ID: <1220319324-23012-1-git-send-email-szeder@ira.uka.de>
References: <20080902012804.GB6739@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 03:37:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaKpB-0005BO-BE
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 03:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010AbYIBBfn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Sep 2008 21:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbYIBBfm
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 21:35:42 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:54006 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbYIBBfm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 21:35:42 -0400
Received: from [127.0.1.1] (p5B13393C.dip0.t-ipconnect.de [91.19.57.60])
	by mrelayeu.kundenserver.de (node=mrelayeu7) with ESMTP (Nemesis)
	id 0ML2xA-1KaKni3ILT-0002iG; Tue, 02 Sep 2008 03:35:24 +0200
X-Mailer: git-send-email 1.6.0.1.171.gaaac
In-Reply-To: <20080902012804.GB6739@neumann>
X-Provags-ID: V01U2FsdGVkX1/SNz2D13MGyKZ5cJkJJ8iGufpqHuWEUhF3iKu
 +uVmAPz9II+zcAGKtVy2pnOUls36Sgf5ZO5+aTc5mOVJ/d0VZj
 XXdaUtYPe/YXVgwfGHAqQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94637>

Asciidoc removes lines starting with a dot when creating manpages.
Since those lines were comments in use case examples showing shell
commands, preceed those lines with a hash sign.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/git-stash.txt |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 49e2296..cdf3cf1 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -159,7 +159,7 @@ perform a pull, and then unstash, like this:
 +
 ----------------------------------------------------------------
 $ git pull
-...
+# ...
 file foobar not up to date, cannot merge.
 $ git stash
 $ git pull
@@ -174,7 +174,7 @@ make a commit to a temporary branch to store your c=
hanges away, and
 return to your original branch to make the emergency fix, like this:
 +
 ----------------------------------------------------------------
-... hack hack hack ...
+# ... hack hack hack ...
 $ git checkout -b my_wip
 $ git commit -a -m "WIP"
 $ git checkout master
@@ -182,18 +182,18 @@ $ edit emergency fix
 $ git commit -a -m "Fix in a hurry"
 $ git checkout my_wip
 $ git reset --soft HEAD^
-... continue hacking ...
+# ... continue hacking ...
 ----------------------------------------------------------------
 +
 You can use 'git-stash' to simplify the above, like this:
 +
 ----------------------------------------------------------------
-... hack hack hack ...
+# ... hack hack hack ...
 $ git stash
 $ edit emergency fix
 $ git commit -a -m "Fix in a hurry"
 $ git stash apply
-... continue hacking ...
+# ... continue hacking ...
 ----------------------------------------------------------------
=20
 Testing partial commits::
@@ -203,13 +203,13 @@ more commits out of the changes in the work tree,=
 and you want to test
 each change before committing:
 +
 ----------------------------------------------------------------
-... hack hack hack ...
+# ... hack hack hack ...
 $ git add --patch foo            # add just first part to the index
 $ git stash save --keep-index    # save all other changes to the stash
 $ edit/build/test first part
 $ git commit foo -m 'First part' # commit fully tested change
 $ git stash pop                  # prepare to work on all other change=
s
-... repeat above five steps until one commit remains ...
+# ... repeat above five steps until one commit remains ...
 $ edit/build/test remaining parts
 $ git commit foo -m 'Remaining parts'
 ----------------------------------------------------------------
--=20
1.6.0.1.171.gaaac
