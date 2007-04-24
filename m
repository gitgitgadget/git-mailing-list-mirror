From: Josh Triplett <josh@freedesktop.org>
Subject: [PATCH] Fix typo in git-am: s/Was is/Was it/
Date: Mon, 23 Apr 2007 17:32:04 -0700
Message-ID: <462D5004.1080607@freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig46A6654FE848B0F32C800DD4"
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 02:32:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg8xV-0002JH-Gl
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 02:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030937AbXDXAcj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 20:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030959AbXDXAci
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 20:32:38 -0400
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:36113 "EHLO
	mail7.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030937AbXDXAci (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 20:32:38 -0400
Received: (qmail 10088 invoked from network); 24 Apr 2007 00:32:37 -0000
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.122]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail7.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <git@vger.kernel.org>; 24 Apr 2007 00:32:37 -0000
User-Agent: Icedove 1.5.0.10 (X11/20070329)
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45392>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig46A6654FE848B0F32C800DD4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 git-am.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index e69ecbf..c9f66e2 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -291,7 +291,7 @@ do
 			<"$dotest/$msgnum" >"$dotest/info" ||
 			stop_here $this
 		test -s $dotest/patch || {
-			echo "Patch is empty.  Was is split wrong?"
+			echo "Patch is empty.  Was it split wrong?"
 			stop_here $this
 		}
 		git-stripspace < "$dotest/msg" > "$dotest/msg-clean"
--=20
1.5.1.1



--------------enig46A6654FE848B0F32C800DD4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGLVAEGJuZRtD+evsRApqEAJ0WGp2jjBoNGYPVe/VxeDTsub83xwCfYHZF
qB1uaHDWHjY0QlCKG4oDW74=
=4mVh
-----END PGP SIGNATURE-----

--------------enig46A6654FE848B0F32C800DD4--
