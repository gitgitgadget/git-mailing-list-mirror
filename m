From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: [PATCH] [TRIVIAL] Change default man page path to /usr/share/man
Date: Tue, 8 May 2007 13:49:31 +0300
Organization: TUBITAK/UEKAE
Message-ID: <200705081349.34964.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1280488.eGhWabj8ki";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 08 12:48:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlNF5-0006Aq-0h
	for gcvg-git@gmane.org; Tue, 08 May 2007 12:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966745AbXEHKsF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 06:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966481AbXEHKsE
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 06:48:04 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:41019 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S966745AbXEHKsC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 06:48:02 -0400
Received: from southpark.local (unknown [85.97.17.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 8D4645F805DF
	for <git@vger.kernel.org>; Tue,  8 May 2007 13:47:55 +0300 (EEST)
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46563>

--nextPart1280488.eGhWabj8ki
Content-Type: multipart/mixed;
  boundary="Boundary-01=_7WFQGLmx5HxsJX4"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_7WFQGLmx5HxsJX4
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

According to FHS standard default man page path is $prefix/share/man [0] ,=
=20
attached patch fixes this for GIT.

[0] http://www.pathname.com/fhs/pub/fhs-2.3.html#USRSHAREMANMANUALPAGES

Signed-off-by: Ismail Donmez <ismail@pardus.org.tr>

Regards,
ismail

=2D-=20
Le mieux est l'ennemi du bien.

--Boundary-01=_7WFQGLmx5HxsJX4
Content-Type: text/x-diff;
  charset="utf-8";
  name="mandir.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mandir.patch"

=2D-- Documentation/Makefile	2007-02-26 21:20:28.000000000 +0200
+++ Documentation/Makefile	2007-02-28 01:18:07.672166995 +0200
@@ -26,7 +26,7 @@
=20
 prefix?=3D$(HOME)
 bindir?=3D$(prefix)/bin
=2Dmandir?=3D$(prefix)/man
+mandir?=3D$(prefix)/share/man
 man1dir=3D$(mandir)/man1
 man7dir=3D$(mandir)/man7
 # DESTDIR=3D

--Boundary-01=_7WFQGLmx5HxsJX4--

--nextPart1280488.eGhWabj8ki
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.3 (GNU/Linux)

iD8DBQBGQFW+Gp0leluI9UwRAqj4AJ90r9R/qA8KzluZsaVmYgSCnNOLjQCeI3ad
hBX70pg6b1nRkeAtflLNGDw=
=34o0
-----END PGP SIGNATURE-----

--nextPart1280488.eGhWabj8ki--
