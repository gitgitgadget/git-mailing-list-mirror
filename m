From: "Jeffrey C. Ollie" <jeff@ocjtech.us>
Subject: Re: Can git-svn treat specify paths as branches ?
Date: Tue, 03 Jul 2007 07:53:16 -0500
Message-ID: <1183467196.3868.1.camel@lt21223.campus.dmacc.edu>
References: <4b3406f0707030212h1e029023sf74c5c7b0e95654b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jLfH1OFfllA4ResBjHaQ"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 14:53:25 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5hsh-0000BH-49
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 14:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176AbXGCMxV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 08:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752913AbXGCMxV
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 08:53:21 -0400
Received: from homer.isunet.net ([63.175.164.9]:49671 "EHLO homer.isunet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752261AbXGCMxU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 08:53:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by homer.isunet.net (Postfix) with ESMTP id 210F2388235
	for <git@vger.kernel.org>; Tue,  3 Jul 2007 07:02:15 -0500 (CDT)
Received: from homer.isunet.net ([63.175.164.9])
 by localhost (homer [63.175.164.9]) (amavisd-new, port 10024) with ESMTP
 id 21806-08 for <git@vger.kernel.org>; Tue,  3 Jul 2007 07:02:14 -0500 (CDT)
Received: from max1.ocjtech.us (dsl-ppp239.isunet.net [63.175.164.239])
	by homer.isunet.net (Postfix) with ESMTP id 4813D38823D
	for <git@vger.kernel.org>; Tue,  3 Jul 2007 07:02:14 -0500 (CDT)
Received: from [161.210.6.122]
	by max1.ocjtech.us with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.62)
	(envelope-from <jeff@ocjtech.us>)
	id 1I5hsf-0002xg-Vi
	for git@vger.kernel.org; Tue, 03 Jul 2007 07:53:22 -0500
In-Reply-To: <4b3406f0707030212h1e029023sf74c5c7b0e95654b@mail.gmail.com>
X-Mailer: Evolution 2.8.3 (2.8.3-2.fc6) 
X-Virus-Scanned: by amavisd-new at isunet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51487>


--=-jLfH1OFfllA4ResBjHaQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-07-03 at 17:12 +0800, Dongsheng Song wrote:
> For google code projects, the repositories organized is:
>=20
> branches  tags  trunk  wiki
>=20
> Can I treat wiki as a branch? i.e.
>=20
> [svn-remote "svn"]
>         url =3D http://serf.googlecode.com/svn
>         fetch =3D trunk:refs/remotes/trunk
>         branches =3D branches/*,wiki:refs/remotes/*
>         tags =3D tags/*:refs/remotes/tags/*

What's the structure underneath the wiki directory?  If it's just
content, I'd use:

fetch =3D wiki:refs/remotes/wiki

Jeff


--=-jLfH1OFfllA4ResBjHaQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGika4rtk7xyyIQRERAp8FAJwIqtDq6APn37A7cProvbg2/hcs8ACfacLW
/Ev/5VgQ1+XEJFHYQ660TlQ=
=UDeZ
-----END PGP SIGNATURE-----

--=-jLfH1OFfllA4ResBjHaQ--
