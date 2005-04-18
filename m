From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: [patch] fork optional branch point normazilation
Date: Mon, 18 Apr 2005 12:45:19 +0200
Message-ID: <1113821119.16288.13.camel@nosferatu.lan>
References: <Pine.LNX.4.44.0504171614150.2625-100000@bellevue.puremagic.com>
	 <Pine.LNX.4.58.0504171636590.7211@ppc970.osdl.org>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-cTCdM+R3p9HgQRjWErPH"
Content-Transfer-Encoding: 8bit
Cc: Brad Roberts <braddr@puremagic.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 12:38:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNTdb-0002YE-HO
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 12:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbVDRKlw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 06:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVDRKlw
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 06:41:52 -0400
Received: from ctb-mesg7.saix.net ([196.25.240.79]:64700 "EHLO
	ctb-mesg7.saix.net") by vger.kernel.org with ESMTP id S262024AbVDRKlt
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 06:41:49 -0400
Received: from gateway.lan (wblv-146-244-27.telkomadsl.co.za [165.146.244.27])
	by ctb-mesg7.saix.net (Postfix) with ESMTP id 850271C98;
	Mon, 18 Apr 2005 12:41:32 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id 36FFF3A26DB;
	Mon, 18 Apr 2005 12:47:45 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 31996-16; Mon, 18 Apr 2005 12:47:38 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id D2C853A26DA;
	Mon, 18 Apr 2005 12:47:38 +0200 (SAST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504171636590.7211@ppc970.osdl.org>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-cTCdM+R3p9HgQRjWErPH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2005-04-17 at 16:39 -0700, Linus Torvalds wrote:
>=20
> On Sun, 17 Apr 2005, Brad Roberts wrote:
> >
> > braddr:x:1000:1000:Brad Roberts,,,:/home/braddr:/bin/bash
> >=20
> > All gecos entries on all my debian boxes are of the form:
> >=20
> >    fullname, office number, office extension, and home number
>=20
> Ahh, ok.
>=20
> I'll make the "cleanup" thing just remove strange characters from the end=
,=20
> that should fix this kind of thing for now.
>=20
> I'd just remove everything after the first strange number, but I can also=
=20
> see people using the "lastname, firstname" format, and I'd hate to just=20
> ignore firstname in that case.
>=20

If we get the info from /etc/passwd, then we should just use whatever
before the first [,;] (see patch I posted earlier).  If not, then I
think AUTHOR_* should be sane).


--=20
Martin Schlemmer


--=-cTCdM+R3p9HgQRjWErPH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCY4+/qburzKaJYLYRAjkNAJ475Ir6MBncclyb9MStMgAF4DOZFACgmWZf
5dCWMTSjoq7XH8rCN9m09uI=
=MRLO
-----END PGP SIGNATURE-----

--=-cTCdM+R3p9HgQRjWErPH--

