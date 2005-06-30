From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] cvsimport: rewritten in Perl
Date: Thu, 30 Jun 2005 23:00:23 +0200
Message-ID: <20050630210023.GY10850@kiste.smurf.noris.de>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de> <20050630150239.GA20928@pc117b.liacs.nl> <20050630152125.GO10850@kiste.smurf.noris.de> <20050630154453.GA26808@pc117b.liacs.nl> <20050630161043.GR10850@kiste.smurf.noris.de> <20050630193825.GA17345@pc117b.liacs.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GaWsjkDAZOZFz3yq"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 22:59:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do68D-0007z4-LG
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 22:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263079AbVF3VGc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 17:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263112AbVF3VDo
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 17:03:44 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:8876 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S263088AbVF3VA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2005 17:00:59 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1Do692-0001CC-Ak; Thu, 30 Jun 2005 23:00:52 +0200
Received: (nullmailer pid 17267 invoked by uid 501);
	Thu, 30 Jun 2005 21:00:23 -0000
To: Sven Verdoolaege <skimo@liacs.nl>
Content-Disposition: inline
In-Reply-To: <20050630193825.GA17345@pc117b.liacs.nl>
User-Agent: Mutt/1.5.6+20040907i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--GaWsjkDAZOZFz3yq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Sven Verdoolaege:
> On Thu, Jun 30, 2005 at 06:10:43PM +0200, Matthias Urlichs wrote:
> > I'll find it. However, you don't actually need to re-import your
> > existing CVS->GIT trees; as long as the dates and the branch names
> > match, my script will continue where the other left off.
>=20
> That seems to work, once I figured out I had to pass in the "-o master"
> option (as cvs2git didn't create an "origin" branch).
>=20
Yes -- that's intentional, as the "master" branch is the one you're
going to add your own work to once the improt is finished. Using
"master" as CVS HEAD would mean that incremental imports no longer work.

> If you don't, you get a rather cryptic message:
> usage: git-read-tree (<sha> | -m [-u] <sha1> [<sha2> [<sha3>]])
> read-tree failed: 256
>=20
> You probably want to check whether the origin branch actually
> exists.
>=20
I'll add that, thanks.

> Apparently you also need to pass the '-x' option to cvsps.
> Otherwise, it won't look at anything new.
>=20
Ditto.

> It would also be nice if the user could pass extra options
> to cvsps (notably '-z').
>=20
Ditto.  ;-)

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Don't let grass grow on the path of friendship.
		-- Blackfoot Indian

--GaWsjkDAZOZFz3yq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCxF1n8+hUANcKr/kRAmr8AJ4isQKfQSmBumg4j0yPM4xfJ35nVwCfV4np
z6BhNNWpV4mMknbWN7bdHsU=
=eiOp
-----END PGP SIGNATURE-----

--GaWsjkDAZOZFz3yq--
