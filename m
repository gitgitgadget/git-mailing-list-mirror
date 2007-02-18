From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] Allow passing of an alternative CVSROOT via -d.
Date: Sun, 18 Feb 2007 18:53:56 +0100
Message-ID: <45D892B4.4000005@fs.ei.tum.de>
References: <45D88A14.4040400@fs.ei.tum.de> <Pine.LNX.4.63.0702181834340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCF36D2AE1C6456DA003CAEC8"
Cc: git@vger.kernel.org, Martin Langhoff <martin@catalyst.net.nz>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 18 18:54:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIqEk-00041n-6E
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 18:54:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792AbXBRRyG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Feb 2007 12:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751791AbXBRRyG
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Feb 2007 12:54:06 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:41983 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbXBRRyF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Feb 2007 12:54:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 9221028170;
	Sun, 18 Feb 2007 18:54:00 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id sde2qQ5oz038; Sun, 18 Feb 2007 18:54:00 +0100 (CET)
Received: from [62.216.207.82] (ppp-62-216-207-82.dynamic.mnet-online.de [62.216.207.82])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 0C497280E4;
	Sun, 18 Feb 2007 18:53:59 +0100 (CET)
User-Agent: Mail/News 1.5.0.4 (X11/20060619)
In-Reply-To: <Pine.LNX.4.63.0702181834340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40082>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCF36D2AE1C6456DA003CAEC8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin wrote:
>> This is necessary if using CVS in an asymmetric fashion, i.e. when the=

>> CVSROOT you are checking out from differs from the CVSROOT you have to=

>> commit to.
>=20
> Does
>=20
> 	CVSROOT=3Dbla git-cvsexportcommit...
>=20
> not work?

no, cvs seems to ignore the environment variable.  at least export CVSROO=
T=3Dhost:/dir didn't have any effect.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enigCF36D2AE1C6456DA003CAEC8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF2JK3r5S+dk6z85oRAl/DAJ0VNz5e/TG8H2k+Ehm6JXs4iCP6/wCgk24p
mbh/hpZDPxMF78M8c0Wk5GI=
=j/kJ
-----END PGP SIGNATURE-----

--------------enigCF36D2AE1C6456DA003CAEC8--
