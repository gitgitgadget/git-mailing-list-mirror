From: Felipe Balbi <balbi@ti.com>
Subject: Re: Failure to extra stable@vger.kernel.org addresses
Date: Mon, 19 Nov 2012 17:37:23 +0200
Message-ID: <20121119153723.GA18697@arwen.pp.htv.fi>
References: <20121119095747.GA13552@arwen.pp.htv.fi>
 <20121119151845.GA29678@shrek.podlesie.net>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Cc: Felipe Balbi <balbi@ti.com>, <git@vger.kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Krzysztof Mazur <krzysiek@podlesie.net>
X-From: git-owner@vger.kernel.org Mon Nov 19 16:44:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TaTW8-0006pr-4W
	for gcvg-git-2@plane.gmane.org; Mon, 19 Nov 2012 16:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753326Ab2KSPny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2012 10:43:54 -0500
Received: from devils.ext.ti.com ([198.47.26.153]:39645 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855Ab2KSPny (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2012 10:43:54 -0500
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id qAJFhpT2017944;
	Mon, 19 Nov 2012 09:43:51 -0600
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id qAJFhpAj004287;
	Mon, 19 Nov 2012 09:43:51 -0600
Received: from dlelxv22.itg.ti.com (172.17.1.197) by dfle72.ent.ti.com
 (128.247.5.109) with Microsoft SMTP Server id 14.1.323.3; Mon, 19 Nov 2012
 09:43:51 -0600
Received: from localhost (h68-4.vpn.ti.com [172.24.68.4])	by
 dlelxv22.itg.ti.com (8.13.8/8.13.8) with ESMTP id qAJFhnIJ007595;	Mon, 19 Nov
 2012 09:43:50 -0600
Content-Disposition: inline
In-Reply-To: <20121119151845.GA29678@shrek.podlesie.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210045>

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 19, 2012 at 04:18:45PM +0100, Krzysztof Mazur wrote:
> On Mon, Nov 19, 2012 at 11:57:47AM +0200, Felipe Balbi wrote:
> > Hi guys,
> >=20
> > for whatever reason my git has started acting up with
> > stable@vger.kernel.org addresses. It doesn't manage to extract a valid
> > adress from the string:
> >=20
> >  Cc: <stable@vger.kernel.org> # v3.4 v3.5 v3.6
> >=20
> > Removing the comment at the end of the line makes things work again. I
> > do remember, however, seeing this working since few weeks back I sent a
> > mail to stable (in fact the same one I'm using to test), so this could
> > be related to some perl updates, who knows ?!?
>=20
> You probably just installed Email::Valid package.
>=20
> The current git-send-email works a little better and just prints an error:
>=20
> W: unable to extract a valid address from: <stable@vger.kernel.org> #v3.4=
 v3.5 v3.6
>=20
>=20
> This patch should fix the problem, now after <email> any garbage is
> removed while extracting address.

worked like a charm. When you send as a proper patch, you can add my:

Tested-by: Felipe Balbi <balbi@ti.com>

thanks

--=20
balbi

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQqlIzAAoJEIaOsuA1yqREVG4P/1/L/WBlZ2NnONO5zlSEOyWW
yR1Nvu44xJKnKADHhe23n00/UzH2k97Of7/5AqtP7BDHjgRcU41TyiCClIKfCENQ
QjG13CrU+3Sv7GpKa3zH2q8mNNgh+aBYBKkz7+R4vtJnLbBZ8TepOHim2dBh3gzT
ZlEWC9JqUQaXIdHtuH6BsNsERTbWEOX5WNYewqHFBQkIcmfvZ4bb+OX4eRhb7sdO
3bxIl06m/gw0gJnncwLBrtQXXXCBxQeLmjsPC+EJyYR67VY5vJ38FcUQAWugkGFz
OSqJFiei4/BxlXC+Ar89wn3PzBG/Mase0byGfKzQT7jpM1kacetvhQN01Cw9X1Ib
TXEp8er0JKedY3QrCy87zu+FbnN5h/EgH9Wrw0OpmHZumd0DaX2ViKXWQlpqeftL
5hZrkIw6jWwQ7L6XSTv4/m1h6XESoRYzblKKdrOIOV1xS4MiHwo1ykAcfz9RWE1u
46YQF3uuM4/qRV4G5C1/mr5p0NsK4/Pqimt8EJTIXNKwNy0x8v55DyC+EQtDN7sQ
qLsHlFO1Ze0TWSEhPyHog8vp9l3wTzVMWWuCe+u1JGWRbhedDH3SrDXC+DBu4Z1B
sfh16+0DNqeONKWgwaWznOv3r+YApFR0McfdlnQbePRqq09faiIGhwLgW/WNunkW
21hSMviupsscyYYKs5pe
=X2W2
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
