From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: [PATCH] Use perl instead of tac
Date: Wed, 30 Apr 2008 11:39:50 +0200
Message-ID: <20080430093950.GA16806@alea.gnuu.de>
References: <8D73338C-4EC3-4078-8A34-51DAC1842C2B@silverinsanity.com> <20080427064250.GA5455@sigill.intra.peff.net> <739FA851-F7F5-4CF9-B384-25AA7022B0C2@silverinsanity.com> <slrng1be8l.25r.joerg@alea.gnuu.de> <86k5iib0g9.fsf@blue.stonehenge.com> <slrng1bqhb.25r.joerg@alea.gnuu.de> <04EB077D-CB35-4253-A9EA-2085890C3639@silverinsanity.com> <20080430090206.GA21826@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Cc: git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 14:04:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrB3E-0004OX-4m
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 14:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756902AbYD3MDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 08:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758529AbYD3MDz
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 08:03:55 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:3096 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758520AbYD3MDx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 08:03:53 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 97F6048803A; Wed, 30 Apr 2008 14:03:51 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jr8n0-00053Y-R1; Wed, 30 Apr 2008 11:39:50 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jr8n0-0004Rc-Cv; Wed, 30 Apr 2008 11:39:50 +0200
Content-Disposition: inline
In-Reply-To: <20080430090206.GA21826@alea.gnuu.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80831>


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hallo Brian,

J=C3=B6rg Sommer schrieb am Wed 30. Apr, 11:02 (+0200):
> Brian Gernhardt schrieb am Mon 28. Apr, 15:13 (-0400):
> > Now that I think about it, the generation of marks could be done by a =
=20
> > second loop over the list.  Notice what commits need to be marked in =
=20
> > loop 1, then add the mark commands in loop 2.  Both of these loops woul=
d=20
> > function in the same direction, removing the need for either tac or per=
l.
>=20
> You are right.

=E2=80=A6 but I found the problem. I don't know how to pass the list from o=
ne
subshell to the other.

% { echo pick; echo merge; a=3D12 } | { echo +$a+; while read line; do echo=
 $line; done; }
++
pick
merge

The only idea I have is a file. Do you have a better idea?

% { echo pick; echo merge; a=3D12 } >/tmp/tmp; \
  { echo +$a+; while read line; do echo $line; done; } < /tmp/tmp
+12+
pick
merge

Bye, J=C3=B6rg.
--=20
Viele Leute glauben, dass sie denken, wenn sie lediglich
ihre Vorurteile neu ordnen.

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIGD5mwe0mZwH1VIARAjJgAKCsmKj//9ooOojWA/MYec0yYCGClACgomTK
B7weCpS7PYfP4Y1LzHP50pY=
=ox4j
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
