From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] cvsimport: rewritten in Perl
Date: Fri, 1 Jul 2005 09:25:19 +0200
Message-ID: <20050701072519.GF10850@kiste.smurf.noris.de>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de> <20050630150239.GA20928@pc117b.liacs.nl> <20050630152125.GO10850@kiste.smurf.noris.de> <20050630154453.GA26808@pc117b.liacs.nl> <20050630161043.GR10850@kiste.smurf.noris.de> <20050630193825.GA17345@pc117b.liacs.nl> <20050630210023.GY10850@kiste.smurf.noris.de> <20050701070108.GA25803@pc117b.liacs.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bpj97y6y1cZVuO8Q"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 01 09:18:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoFnM-0000E1-Cd
	for gcvg-git@gmane.org; Fri, 01 Jul 2005 09:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263252AbVGAH0J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jul 2005 03:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263256AbVGAH0J
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jul 2005 03:26:09 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:16877 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S263252AbVGAH0C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2005 03:26:02 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1DoFto-0001qS-Cl; Fri, 01 Jul 2005 09:25:37 +0200
Received: (nullmailer pid 19292 invoked by uid 501);
	Fri, 01 Jul 2005 07:25:19 -0000
To: Sven Verdoolaege <skimo@liacs.nl>
Content-Disposition: inline
In-Reply-To: <20050701070108.GA25803@pc117b.liacs.nl>
User-Agent: Mutt/1.5.6+20040907i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--bpj97y6y1cZVuO8Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Sven Verdoolaege:
> On Thu, Jun 30, 2005 at 11:00:23PM +0200, Matthias Urlichs wrote:
> > Sven Verdoolaege:
> > > It would also be nice if the user could pass extra options
> > > to cvsps (notably '-z').
> > >=20
> > Ditto.  ;-)
>=20
> Actually, do you really have to call cvsps from within your
> script ?  Why don't you just keep the small shell script
> that links cvsps to cvs2git (your version) ?

I dislike temporary files, a shell pipe can't catch errors in earlier
stages without major hackery, Linus didn't have a problem with ripping
it out, and in an earlier life this script was called cvs2bk and called
bk directly, so I kept that.

Enough reasons? ;-)  Sure, none of them really prevent me from doing it,
but OTOH I see no reason to resurrect the shell script either.

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Christianity has nothing to offer a happy man
living in a natural, intelligible universe.
		-- George H. Smith, "Atheism: The Case Against God"

--bpj97y6y1cZVuO8Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCxO/f8+hUANcKr/kRAk4jAJ9oHbZb8XC6xcPi1veJ2snSQ4XwBQCgkW/G
OwoLYlkj08gBr53246mhVyU=
=lubW
-----END PGP SIGNATURE-----

--bpj97y6y1cZVuO8Q--
