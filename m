From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [SCRIPT] cg-rpush & locking
Date: Thu, 2 Jun 2005 12:04:17 +0200
Message-ID: <20050602100417.GG16616@kiste.smurf.noris.de>
References: <Pine.LNX.4.58.0506011951150.1876@ppc970.osdl.org> <Pine.LNX.4.21.0506020223570.30848-100000@iabervon.org> <20050602071453.GA16616@kiste.smurf.noris.de> <20050602073205.GA31482@muru.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 12:04:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdmXm-0004bo-S2
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 12:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVFBKGG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 06:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVFBKGG
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 06:06:06 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:2540 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S261363AbVFBKFx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2005 06:05:53 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1DdmYk-0002UE-Iq; Thu, 02 Jun 2005 12:04:32 +0200
Received: (nullmailer pid 28316 invoked by uid 501);
	Thu, 02 Jun 2005 10:04:17 -0000
To: Tony Lindgren <tony@atomide.com>
Content-Disposition: inline
In-Reply-To: <20050602073205.GA31482@muru.com>
User-Agent: Mutt/1.5.6+20040907i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Tony Lindgren:
> I don't think locking for the duration of the push really is a problem.
> It is unlikely that there would be so many people pushing that it would
> cause inconvenience... Of course it would be nice to optimize it if
> possible.
>=20
Since an 'atomic' cmpxchg operation is actually easier to program than a
lockfile with timeout handling etc., I would hope so. ;-)

> I would assume the biggest problem for most people is how they can push
> through a firewall. From that point of view it would make sense to do
> the push as a cgi script rather than something over ssh.

When in doubt, do both ... I'd certainly prefer ssh if at all possible.

> And with a cgi script you can of course optimize the locking and use
> tmp files before renaming which are a bit hard to do with rsync.
>=20
rsync is going away anyway for git usage (long-term), I'd assume. It
certainly becomes more and more ineffective the more our history is
growing.

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
No one can guarantee the actions of another.
		-- Spock, "Day of the Dove", stardate unknown

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCntmg8+hUANcKr/kRAi8mAKCDJgdD5eZ1QPqvPt/1jwnwRdAvJwCfe5/U
EseXsHEIbY9UzXXqVrFyuks=
=Bkq5
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
