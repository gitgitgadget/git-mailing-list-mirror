From: Tilman Sauerbeck <tilman@code-monkey.de>
Subject: Re: [PATCH] Added support for dropping privileges to git-daemon.
Date: Sat, 19 Aug 2006 15:29:24 +0200
Message-ID: <20060819132922.GA6644@code-monkey.de>
References: <1155990772.6591@hammerfest> <e5bfff550608190623j58de8c1cn6a9304249ee1ecb8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
X-From: git-owner@vger.kernel.org Sat Aug 19 15:29:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEQtH-0000Yp-C8
	for gcvg-git@gmane.org; Sat, 19 Aug 2006 15:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbWHSN30 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Aug 2006 09:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWHSN30
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Aug 2006 09:29:26 -0400
Received: from code-monkey.de ([81.169.170.126]:39943 "EHLO code-monkey.de")
	by vger.kernel.org with ESMTP id S1751378AbWHSN30 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Aug 2006 09:29:26 -0400
Received: from hammerfest (c-180-198-91.bi.dial.de.ignite.net [62.180.198.91])
	by code-monkey.de (Postfix) with ESMTP id ADCC3B428
	for <git@vger.kernel.org>; Sat, 19 Aug 2006 15:29:24 +0200 (CEST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <e5bfff550608190623j58de8c1cn6a9304249ee1ecb8@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25720>


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Marco Costalba [2006-08-19 15:23]:
> >
> >+       if (!user ^ !group)
> >+               die("either set both user and group or none of them");
> >+
> >
>=20
> Just a  question. Why simply not
>=20
>       if (user ^ group)

Because gcc doesn't like that:
 error: invalid operands to binary ^

Regards,
Tilman

--=20
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing on usenet and in e-mail?

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE5xIy27uLisrW2w8RAo7kAJ4oQtKI1J1kHMbMoEUyMA092jgX+QCeK2wu
/prmdMn3qkmGr0988bQly9Y=
=4x53
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
