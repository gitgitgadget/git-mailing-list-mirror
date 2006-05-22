From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: irc usage..
Date: Mon, 22 May 2006 23:41:28 +0200
Message-ID: <20060522214128.GE16677@kiste.smurf.noris.de>
References: <Pine.LNX.4.64.0605211209080.3649@g5.osdl.org> <Pine.LNX.4.64.0605212053590.3697@g5.osdl.org> <44713BE4.9040505@gentoo.org> <Pine.LNX.4.64.0605212132570.3697@g5.osdl.org> <46a038f90605220042v369e9ff5o3dc7841472171d02@mail.gmail.com> <Pine.LNX.4.64.0605220203200.3697@g5.osdl.org> <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com> <44720C66.6040304@gentoo.org> <46a038f90605221241x58ffa2a4o26159d38d86a8092@mail.gmail.com> <Pine.LNX.4.64.0605221256090.3697@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1BKOZKwX7DAU5odC"
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Donnie Berkholz <spyderous@gentoo.org>,
	Yann Dirson <ydirson@altern.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 23 00:14:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiIfM-0002NN-6E
	for gcvg-git@gmane.org; Tue, 23 May 2006 00:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWEVWOR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 18:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWEVWOR
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 18:14:17 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:45957 "EHLO smurf.noris.de")
	by vger.kernel.org with ESMTP id S1751241AbWEVWOQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 18:14:16 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by smurf.noris.de with smtp (Exim 4.60)
	(envelope-from <smurf@smurf.noris.de>)
	id 1FiIeQ-0004wN-Aq; Tue, 23 May 2006 00:13:43 +0200
Received: (nullmailer pid 3152 invoked by uid 501);
	Mon, 22 May 2006 21:41:28 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605221256090.3697@g5.osdl.org>
User-Agent: Mutt/1.5.11
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20539>


--1BKOZKwX7DAU5odC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Linus Torvalds:
> I wonder why those "git-update-index" calls seem to be (assuming I read=
=20
> the perl correctly) done only a few files at a time. We can do a hundreds=
=20
> in one go, but it seems to want to do just ten files or something at the=
=20
> same time.

No, fifty.

I simply was too lazy to count the actual filenames' lengths. ;-)

> That thing would probably be an order of magnitude faster if written to=
=20
> use the git library interfaces directly. Of course, the CVS part is=20
> probably a big overhead, so it might not help much=20

The beast *was* mainly written to do this remotely...

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
The worst form of inequality is to try to make unequal things equal.
					-- Aristotle

--1BKOZKwX7DAU5odC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEcjAI8+hUANcKr/kRAm4iAKCF4WIekoZQyIHlbn/gROtsE2yMsgCfSPPg
I/Cjig/Kr2mp/eEsR5WPzTo=
=RJOS
-----END PGP SIGNATURE-----

--1BKOZKwX7DAU5odC--
