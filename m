From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: [PATCH/RFC 06/10] Unify the lenght of $SHORT* and the commits
	in the TODO list
Date: Sun, 13 Apr 2008 18:39:50 +0200
Message-ID: <20080413163950.GA3179@alea.gnuu.de>
References: <1207785521-27742-1-git-send-email-joerg@alea.gnuu.de> <1207785521-27742-2-git-send-email-joerg@alea.gnuu.de> <1207785521-27742-3-git-send-email-joerg@alea.gnuu.de> <1207785521-27742-4-git-send-email-joerg@alea.gnuu.de> <1207785521-27742-5-git-send-email-joerg@alea.gnuu.de> <1207785521-27742-6-git-send-email-joerg@alea.gnuu.de> <1207785521-27742-7-git-send-email-joerg@alea.gnuu.de> <7vej9cndqp.fsf@gitster.siamese.dyndns.org> <20080412091345.GA31356@alea.gnuu.de> <7v63umff7r.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 02:05:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlCCk-0003fZ-2W
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 02:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338AbYDNAEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2008 20:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753304AbYDNAE3
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 20:04:29 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:1406 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753251AbYDNAE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 20:04:27 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 74AB248809E; Mon, 14 Apr 2008 02:04:24 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JlCA5-0005nn-Un; Mon, 14 Apr 2008 02:03:06 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jl5F8-0001MA-1H; Sun, 13 Apr 2008 18:39:50 +0200
Content-Disposition: inline
In-Reply-To: <7v63umff7r.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79430>


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hallo,

Junio C Hamano schrieb am Sat 12. Apr, 23:20 (-0700):
> J=C3=B6rg Sommer <joerg@alea.gnuu.de> writes:
>=20
> > =E2=80=9CThis makes it easier to test for equality of a commit in the T=
ODO list
> > and one of SHORTUPSTREAM, SHORTHEAD or SHORTONTO.=E2=80=9D
>=20
> "Equality testing?" --- that makes me worried.  short=3D7 does not chomp
> them at 7 but only tells rev-parse to use at least 7.  You may get 8 or
> more if there are other objects that share the same prefix when you get
> them.
>=20
> Perhaps by forcing "at least 7" everywhere you are getting consistent
> result that makes them easier to compare.

That's what I want.

> But considering that this is a candidate for a general mechanism to
> eventual grow into the git-sequencer, and that we expect to have richer,
> smarter, and/or more complex set of tools that feeds you the TODO list,
> I'd feel safer if the internal comparison used to determine which one
> commit the user meant in his TODO file is robust and does not rely on
> where the abbreviated object name was chomped at.

I use it one time while building the TODO list given to the editor. I've
to replace $UPSTREAM with $ONTO everywhere $UPSTREAM occures.

Do you still have a bad feeling? I can replace all tests by

  test "$(git rev-parse $a)" =3D "$(git rev-parse $b)"

Bye, J=C3=B6rg.
--=20
Was man m=C3=BChelos erreichen kann, ist gew=C3=B6hnlich nicht der M=C3=BCh=
e wert,
erreicht zu werden.

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIAjdVwe0mZwH1VIARAjvQAJkBdYocfvWqxOlkdpVXF15evo832wCggZ9D
NkclP2ela3PWxtGE17E4kjQ=
=l/uy
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
