From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: Re: [PATCH] [TRIVIAL] Change default man page path to /usr/share/man
Date: Wed, 20 Jun 2007 22:42:08 +0300
Organization: TUBITAK/UEKAE
Message-ID: <200706202242.13100.ismail@pardus.org.tr>
References: <200705081349.34964.ismail@pardus.org.tr> <200705112242.44618.ismail@pardus.org.tr> <7vwszf9md5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1316103.lE1UqvUG9x";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jun 20 21:44:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I166L-0004Vv-1H
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 21:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754574AbXFTToX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 15:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754675AbXFTToX
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 15:44:23 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:41081 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754305AbXFTToX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 15:44:23 -0400
Received: from garbage.local (unknown [88.234.151.125])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 1FF536004054;
	Wed, 20 Jun 2007 22:44:12 +0300 (EEST)
User-Agent: KMail/1.9.7
In-Reply-To: <7vwszf9md5.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50562>

--nextPart1316103.lE1UqvUG9x
Content-Type: multipart/mixed;
  boundary="Boundary-01=_QMYeGx057iuj/tm"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_QMYeGx057iuj/tm
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 11 May 2007 22:44:06 Junio C Hamano wrote:
> Ismail D=C3=B6nmez <ismail@pardus.org.tr> writes:
> > Most(All?) distros /usr/share/man in MANPATH so I believe this
> > patch shouldn't break anything but well you have the final
> > say. I am ok with doing make mandir=3D/usr/share/man install-doc
>
> My preference is to do this early after 1.5.2.  I do not want to
> touch builds with trivial changes before the final.

Still not applied to 1.5.2.2. Patch attached for convenience.

Regards,
ismail

=2D-=20
Perfect is the enemy of good

--Boundary-01=_QMYeGx057iuj/tm
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

--Boundary-01=_QMYeGx057iuj/tm--

--nextPart1316103.lE1UqvUG9x
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (GNU/Linux)

iQIVAwUARnmDFEe9qviWcMsnAQKJEQ//Rk6LKabY1ankb9EPFaz30hlQyK7KnnLv
eZCdwE5SSN+t3p/qqgYWM4hnBKPZ97x9CEUDjqldctCeEn6p6w6bAqUrfy8T4Cpz
RjhxcTYbrUl9omIyNyQTCadigYocRfhjigQGhY7Ekm9eVIg45IJXc5bWKETQmJPI
f6FMvP25uAMlKiR7SHGhhIiUd/hpIw6euopd618uKOFbpYLILbV07NnulQZBR+NN
qSOBL5+C9qoXO5FJ9nete+8K1UFuFQcmjWbuFsP2PIfeToYFftkjFot+O/BZ1XWy
/6dKRjiPAii2cJRzHHUhwe82RHuNLdfHI2ZT3VLWdD49ljKdnxHoDPlv4GKOWxoq
H6NL5aauLiQgH9F6VgsmvhT6B7xnCUfqhzZ6VnKhyWn+gtUczTWbFyBWj/4u+ee3
EvXhaVaZazAfCS5f2fDzJz9ERzFEmKJqEi+pdlMcT+LR+LubTzkf+sps+al97RWJ
0lEDXcgqENyeFDLLI5ZqSeocRcXIkJLOjuYP1Hp3NEdSIwOXfh8oibKxrR348aF6
L12lYU/zAkH7tH/nB8uN7COTYKyKFA/oCSr6S3ac/hkekekgtiAFW0Qxe3xX1F1Y
pAo9Lwxs/9FO2qS01Bji03Hr50pQEapCzcRLOJxcU9XeptOuauapW1Y736/Jrtb5
FmDfkn4TMqE=
=2diL
-----END PGP SIGNATURE-----

--nextPart1316103.lE1UqvUG9x--
