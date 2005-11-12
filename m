From: "Fernando J. Pereda" <ferdy@ferdyx.org>
Subject: [PATCH Cogito] Fix t/t9300-seek.sh
Date: Sat, 12 Nov 2005 23:39:14 +0100
Message-ID: <20051112223914.GA1150@ferdyx.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
X-From: git-owner@vger.kernel.org Sat Nov 12 23:39:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eb41s-00008W-Bg
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 23:39:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbVKLWjV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 17:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbVKLWjV
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 17:39:21 -0500
Received: from 170.Red-213-96-222.staticIP.rima-tde.net ([213.96.222.170]:45203
	"EHLO smtp.ferdyx.org") by vger.kernel.org with ESMTP
	id S964867AbVKLWjU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2005 17:39:20 -0500
Received: from localhost (localhost [127.0.0.1])
	by smtp.ferdyx.org (Postfix) with ESMTP id 76C2B8D314
	for <git@vger.kernel.org>; Sat, 12 Nov 2005 23:39:03 +0100 (CET)
Received: from smtp.ferdyx.org ([127.0.0.1])
	by localhost (tungsteno [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 07664-01 for <git@vger.kernel.org>;
	Sat, 12 Nov 2005 23:39:01 +0100 (CET)
Received: from posidon.ferdyx.org (posidon.ferdyx.org [192.168.0.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.ferdyx.org (Postfix) with ESMTP id DBEE28D30B
	for <git@vger.kernel.org>; Sat, 12 Nov 2005 23:39:00 +0100 (CET)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	ferdy@ferdyx.org; Sat, 12 Nov 2005 23:39:15 +0100 (CET)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at ferdyx.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11716>


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

After 'seeking' to the first commit, identical should have 'identical'
instead of 'nonconflicting'.

Signed-off-by: Fernando J. Pereda <ferdy@gentoo.org>

---

 t/t9300-seek.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

applies-to: 25610e0bf9968dc98709a8ca271db70806c2dbac
8c1240eaa91f1f805535287e7a6a037c341453b4
diff --git a/t/t9300-seek.sh b/t/t9300-seek.sh
index d3fed11..55a3f19 100755
--- a/t/t9300-seek.sh
+++ b/t/t9300-seek.sh
@@ -82,8 +82,8 @@ test_expect_success 'current commit shou
 #	"[ -e newdir/newfile ] && [ -e newdir/newfile.rej ]"
 test_expect_success 'different should be v1' \
 	"[ $(cat different) =3D v1 ]"
-test_expect_success 'identical should be nonconflicting' \
-	"[ $(cat identical) =3D nonconflicting ]"
+test_expect_success 'identical should be identical' \
+	"[ $(cat identical) =3D identical ]"
=20
 test_expect_success 'unseeking' \
 	"cg-seek"
---
0.99.9g

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDdm8SCkhbDGC9KNQRApXZAKCHnRpqvutk9KifkU1KDcphECjvUgCZAXpT
Nww+A7reXhH+FiXztuYvf54=
=hmY0
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
