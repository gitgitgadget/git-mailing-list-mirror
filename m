From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] Debian packaging for 0.99.4
Date: Thu, 11 Aug 2005 22:24:10 +0200
Message-ID: <20050811202410.GB5411@kiste.smurf.noris.de>
References: <pan.2005.08.10.22.11.25.242201@smurf.noris.de> <46a038f9050810155642bb5580@mail.gmail.com> <20050810233953.GV28270@kiste.smurf.noris.de> <E1E33Zb-0004dT-Bx@highlab.com> <46a038f90508102144358a4bcf@mail.gmail.com> <Pine.LNX.4.58.0508102200560.3295@g5.osdl.org> <E1E35vU-0004nP-JR@highlab.com> <Pine.LNX.4.58.0508110915210.3295@g5.osdl.org> <E1E3IOG-0005HO-AK@highlab.com> <20050811201558.GA2874@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Cc: Sebastian Kuzminsky <seb@highlab.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 22:26:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3JcY-000426-AU
	for gcvg-git@gmane.org; Thu, 11 Aug 2005 22:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbVHKUZo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 16:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbVHKUZn
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 16:25:43 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:59843 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S932435AbVHKUZn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2005 16:25:43 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1E3Jb3-0004hT-J1; Thu, 11 Aug 2005 22:24:24 +0200
Received: (nullmailer pid 21152 invoked by uid 501);
	Thu, 11 Aug 2005 20:24:10 -0000
To: Sam Ravnborg <sam@ravnborg.org>
Content-Disposition: inline
In-Reply-To: <20050811201558.GA2874@mars.ravnborg.org>
User-Agent: Mutt/1.5.6+20040907i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Sam Ravnborg:
> >=20
> > Anyway, enough of this.  I understand the name will not change and I'm
> > ok with that.  I'll deal with it on our (Debian's) end.
>=20
> The easy fix is to kill the small git script that is not
> mandatory anyway (as far as my quick grep told me).

I'd vote to keep the scripts in the default build, so that people
who like to compile their own package (i.e. everybody _except_ the
Debian packager ;-) get to keep their git and cg scripts.

A small Debian-specific patch to rename the offending scripts (and drop
the Conflicts: entries) is cheap.

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Experience *that breathing.*
=46rom books and words come fantasy,
and sometimes, from fantasy comes union. -- Rumi, tr. Coleman Barks

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC+7Pq8+hUANcKr/kRAnHUAKCarZZ8j5fOI9Wp/tPIQBDmBFCGHACdHCBL
fSkzwjNQQy0H36BsqQzORvs=
=xYk8
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
