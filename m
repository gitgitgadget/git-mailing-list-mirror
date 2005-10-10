From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: SVN import
Date: Mon, 10 Oct 2005 20:13:29 +0200
Message-ID: <20051010181329.GQ567@kiste.smurf.noris.de>
References: <pan.2005.08.19.10.00.49.401829@smurf.noris.de> <pan.2005.10.10.09.45.00.468989@smurf.noris.de> <8764s51cvp.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VLAOICcq5m4DWEYr"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 10 20:15:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP2AY-0001d3-OI
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 20:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbVJJSOf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 14:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbVJJSOf
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 14:14:35 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:40853 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S1751095AbVJJSOe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 14:14:34 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1EP29T-000582-4W; Mon, 10 Oct 2005 20:13:41 +0200
Received: (nullmailer pid 3538 invoked by uid 501);
	Mon, 10 Oct 2005 18:13:29 -0000
To: Yasushi SHOJI <yashi@atmark-techno.com>
Content-Disposition: inline
In-Reply-To: <8764s51cvp.wl@mail2.atmark-techno.com>
User-Agent: Mutt/1.5.9i
X-Smurf-Spam-Score: -2.6 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9902>


--VLAOICcq5m4DWEYr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Yasushi SHOJI:
> just tried on my svn repo, which had flat directory but moved to trunk
> dir after.  on that repo, the-current-just-pulled git-svnimport says:
>=20
>     1: Unrecognized path: /main.c
>=20
True. I could add an option which behaves as if everything that's not
recognized is seen as being on the trunk, but ...

>     git-svnimport.perl -C /tmp/test.git -i -v file:///tmp/repo/
>=20
Fixed in the last upload -- you get an -s2 option which skips the broken
first check-in, and as a special bonus it manages not to skip the *last*
version either. ;-)

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Be like a duck -- keep calm and unruffled on the surface but paddle like the
devil under water.

--VLAOICcq5m4DWEYr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDSq9J8+hUANcKr/kRAuLUAJ9/LISQQ0L03saFLLVPx9F1RqYhRQCfW6VH
nQPrKym7Oox0Q59SQZiLDpc=
=i8xG
-----END PGP SIGNATURE-----

--VLAOICcq5m4DWEYr--
