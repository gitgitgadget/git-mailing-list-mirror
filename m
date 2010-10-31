From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: [PATCH] Add support in sample hook script for denying annotated tags.
Date: Sun, 31 Oct 2010 14:57:09 -0500
Message-ID: <201010311457.17817.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3270060.MoEyPVg5Ro";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 31 21:14:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCeIn-0006nB-LX
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 21:14:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740Ab0JaUOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Oct 2010 16:14:48 -0400
Received: from rei.iguanasuicide.net ([209.20.91.252]:47816 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381Ab0JaUOp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 16:14:45 -0400
X-Greylist: delayed 1039 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 Oct 2010 16:14:45 EDT
Received: from 76-220-103-20.lightspeed.fyvlar.sbcglobal.net ([76.220.103.20] helo=monster.localnet)
	by rei.iguanasuicide.net with esmtpsa (TLS1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1PCe1s-0005pj-93
	for git@vger.kernel.org; Sun, 31 Oct 2010 19:57:24 +0000
User-Agent: KMail/1.13.5 (Linux/2.6.32-5-amd64; KDE/4.4.5; x86_64; ; )
X-Face: ^vamSukCH~ctN{VF@Q-&WG{+0';38cJ]\/:{x0w-b'+GPuWvNg%NAa2SuBw=&"obQ@q;2h
	6&5@)xd86p;wyaJ%f7&z_BW}Dkm.L$-#h%DUdk7thS-HC_A^Jp|#Tq4R/^q/-]wRVU^T?j
	g@-H./`NrG[
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAMFBMVEUSKVkSKVkSKVkSKVkrXb
	grXbgrXbgrXbhEddVEddXI2uzI2uxEddUrXbgSKVlvm9zseJLgAAAAC3RSTlMZS96SGZLeS95LGbtQ3
	6QAAAI0SURBVDjLbZRNbhQxEIU9sMsqCWukMNmjITkDN+AacCBW2SH1FXqk3iJRTknZsOlyn8DhAHZj
	3iv3ZCSgNBqN/fxVvfLPhGH4+NlMROpLyPdPwxCGbzkbIsoWs+HzdQgPb83yc7JzcOHPixC+mCWbRVs
	pY2lNMMz2FMIOurZpREz4LtPU6qOly/A6G9aW0krjLAJcSgcICycxRCoXWmurHcKrvHC+eDauR7oWn2
	9cQEwExrEXa7/tJlyn9gsC/DhBdWpreheun7X1KJxybF0zhLwsnsyJ/rU4AbtYPXViyxQNQlrXWTCsJ
	6GudSNWT0NXblkVuwjBlkWVJrmaAMMJqarlLCgIcWLGGZ3yj+NRXoiqYMZRfnQBQ7VIIiKVYmUnJiyr
	bjfrItJGT9eLq7hgVhV2RTa7R5XNLttjBtQ4ksKF6ESMFERfOpfZiTzPxYnCNMw1x62G9Y2gUFkeJXo
	NIyLKGpXNrHHeCJMyuaujMNdktgkR4+au3MLaBd5cCEc02GrFVlZexk7MzCCV2wzf6OJEzN41d5VtqG
	01oIhvnx8kkGi5H22edTzHVDci52R6OkAyEnPOnUAfY6NR3iGYSu4qJfPTbS5oo9tOUMHbdKE23oTci
	3cBil8dtoGZk0BF2Yq35wSeWvYeT2EE/KnhRzorfMMgDmH3vr9szxa5TVz2dBl2dyyRfV6k76A93l6G
	8GbPEj2T+kfi/kPAP8D93f6vuL0H8BCu7v+Jq3ARhvDfGP4AtLxO3F/uHbUAAAAASUVORK5CYII=
X-Eric-Conspiracy: There is no conspiracy.
X-Spam-Score: -1.9 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160449>

--nextPart3270060.MoEyPVg5Ro
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Signed-off-by: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
=2D--
 templates/hooks--update.sample |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

In one project I'm in we are using a centralized Git repository that many=20
developers have access to.  As such, we want to prevent tags from being=20
created by push operations and have them created by the administrators.

This is a modification to the sample update hook to allow this to simply be=
=20
a configuration option.

receive.denyCreate actually seems to be what my project wants, but I can se=
e=20
more fine-grained support being nice-to-have.  For example, we might want=20
to allow developers to create branches in a developer-specific namespace=20
but still disallow pushing annotated tags.

diff --git a/templates/hooks--update.sample b/templates/hooks--update.sample
index fd63b2d..c783973 100755
=2D-- a/templates/hooks--update.sample
+++ b/templates/hooks--update.sample
@@ -7,6 +7,9 @@
 #
 # Config
 # ------
+# hooks.allowannotated
+#   This boolean sets whether annotated tags will be allowed into the
+#   repository.  By default they won't be.
 # hooks.allowunannotated
 #   This boolean sets whether unannotated tags will be allowed into the
 #   repository.  By default they won't be.
@@ -43,6 +46,7 @@ if [ -z "$refname" -o -z "$oldrev" -o -z "$newrev" ]; then
 fi
=20
 # --- Config
+allowannotated=3D$(git config --bool hooks.allowannotated)
 allowunannotated=3D$(git config --bool hooks.allowunannotated)
 allowdeletebranch=3D$(git config --bool hooks.allowdeletebranch)
 denycreatebranch=3D$(git config --bool hooks.denycreatebranch)
@@ -86,6 +90,11 @@ case "$refname","$newrev_type" in
 		;;
 	refs/tags/*,tag)
 		# annotated tag
+		if [ "$oldrev" =3D "$zero" -a "$allowannotated" !=3D "true" ]; then
+			echo "*** Creating a tag is not allowed in this repository" >&2
+			exit 1
+		fi
+
 		if [ "$allowmodifytag" !=3D "true" ] && git rev-parse $refname > /dev/nu=
ll 2>&1
 		then
 			echo "*** Tag '$refname' already exists." >&2
=2D-=20
1.7.1
=2D-=20
Boyd Stephen Smith Jr.                   ,=3D ,-_-. =3D.
bss@iguanasuicide.net                   ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy         `-'(. .)`-'
http://iguanasuicide.net/                    \_/

--nextPart3270060.MoEyPVg5Ro
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkzNyhUACgkQ55pqL7G1QFnI/gCgi2di+FzyadHU39Ubzuudi0Dq
njoAn20XjmipJlIeP0h2SNYfKp3rUaxc
=Kf1Q
-----END PGP SIGNATURE-----

--nextPart3270060.MoEyPVg5Ro--
