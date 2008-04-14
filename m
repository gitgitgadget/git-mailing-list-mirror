From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: [PATCH/RFC 01/10] Teach rebase interactive the mark command
Date: Mon, 14 Apr 2008 11:27:49 +0200
Message-ID: <20080414092749.GA15098@alea.gnuu.de>
References: <69a88a530804131351n7d9f8188vf2bbb0174ade3ca0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Cc: git@vger.kernel.org, junio@pobox.com, Johannes.Schindelin@gmx.de
To: Paul Fredrickson <paul.fredrickson@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 12:43:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlM9L-0005I8-V7
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 12:43:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330AbYDNKlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 06:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753571AbYDNKll
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 06:41:41 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:3467 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752748AbYDNKll (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 06:41:41 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 186184880B3; Mon, 14 Apr 2008 12:41:37 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JlKyb-0001DO-RE; Mon, 14 Apr 2008 11:27:49 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JlKyb-0003xX-FL; Mon, 14 Apr 2008 11:27:49 +0200
Content-Disposition: inline
In-Reply-To: <69a88a530804131351n7d9f8188vf2bbb0174ade3ca0@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79498>


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Paul,

Paul Fredrickson schrieb am Sun 13. Apr, 13:51 (-0700):
> > Jrg Sommer <joerg@alea.gnuu.de> wrote:
> > > > Wouldn't
> > > >
> > > > pick 5cc8f37 (init: show "Reinit" message even in ...)
> > > > mark 1
> > > > pick 18d077c (quiltimport: fix misquoting of parse...)
> > > > mark 2
> > > > reset 1
>=20
> I like the idea of adding marks to an interactive rebase in general, but =
instead
> of adding a separate command, what if rebase *automatically* marked all t=
he
> commits in the session:
>=20
>     1: pick 5cc8f37 (init: show "Reinit" message even in ...)
>     2: pick 18d007c (quiltimport: fix misquoting of parse ...)
>     reset 1
>     merge 2

This format would be incompatible with the current format and it makes
the parsing a little bit more difficult; the first column contains a mark
or a command. No, I think that's not a good idea.

Have a nice day, J=F6rg.
--=20
Der Hase l=E4uft schneller als der Fuchs,
denn der Hase l=E4uft um sein Leben.

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIAyOVwe0mZwH1VIARAgjSAKCeZtEjiwroQkg44mEimlPOmfyldACghsDB
2U7XpnSXr7pq+wC1QxB58PQ=
=K+az
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
