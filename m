From: Kristis Makris <kristis.makris@asu.edu>
Subject: Re: Git and Scmbug integration
Date: Tue, 13 Nov 2007 17:01:33 -0700
Message-ID: <1194998493.4106.30.camel@localhost>
References: <1194980792.4106.6.camel@localhost>
	 <20071113234722.GK3268@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_morpheus-31702-1194998524-0001-2"
Cc: git@vger.kernel.org, scmbug-users@lists.mkgnu.net
To: Alex Riesen <raa.lkml@gmail.com>, jnareb@gmail.com
X-From: git-owner@vger.kernel.org Wed Nov 14 01:02:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is5i2-0001XS-SJ
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 01:02:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761003AbXKNACH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 19:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760895AbXKNACG
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 19:02:06 -0500
Received: from net.mkgnu.net ([67.40.69.52]:60240 "EHLO mail.mkgnu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760809AbXKNACF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 19:02:05 -0500
Received: from syd-mkgnu-net.dhcp.asu.edu (syd-mkgnu-net.dhcp.asu.edu [::ffff:149.169.179.39])
  (AUTH: LOGIN mkgnu@mkgnu.net)
  by morpheus with esmtp; Tue, 13 Nov 2007 17:02:03 -0700
  id 00012092.473A3AFB.00007BD6
In-Reply-To: <20071113234722.GK3268@steel.home>
X-Mailer: Evolution 2.6.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64917>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_morpheus-31702-1194998524-0001-2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-11-14 at 00:47 +0100, Alex Riesen wrote:
> > There's no hook that will trigger when a tag is applied.
>=20
> what for?

To implement the synchronous verification checks provided by Scmbug:

http://www.mkgnu.net/?q=3Dscmbug
http://files.mkgnu.net/files/scmbug/SCMBUG_RELEASE_0-23-0/manual/html-singl=
e/manual.html#VERIFICATION-CHECKS

In particular:

(1) Convention-based labeling

http://files.mkgnu.net/files/scmbug/SCMBUG_RELEASE_0-23-0/manual/html-singl=
e/manual.html#VERIFICATION-CHECKS-CONVENTION-BASED-LABELING

(2) The capability to freeze access to certain branches

http://bugzilla.mkgnu.net/show_bug.cgi?id=3D859

(3) Valid product-name verification

http://files.mkgnu.net/files/scmbug/SCMBUG_RELEASE_0-23-0/manual/html-singl=
e/manual.html#VERIFICATION-CHECKS-VALID-PRODUCT-NAME


There are a lot more checks, as you can see from the manual, that are
needed on a commit trigger, rather than just a tag trigger.

A lot of people find the integration provided by Scmbug useful and some
(Jakub, back me up here) have requested support for Git.



--=_morpheus-31702-1194998524-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHOjrd/KuTDwnYLxERAiH0AKCO6tNOcbqIckUN7wlkcbbyWcUMAgCePRo3
yXsi7OuPMiN7xpuujC+e+0Q=
=8fTD
-----END PGP SIGNATURE-----

--=_morpheus-31702-1194998524-0001-2--
