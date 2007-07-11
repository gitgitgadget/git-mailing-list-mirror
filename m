From: Jan Hudec <bulb@ucw.cz>
Subject: Re: mtimes of working files
Date: Wed, 11 Jul 2007 22:26:15 +0200
Message-ID: <20070711202615.GE3069@efreet.light.src>
References: <f36b08ee0707110808h56ecbc7at9c92727c01cca508@mail.gmail.com> <Pine.LNX.4.64.0707111902040.4516@racer.site> <f36b08ee0707111136t198cf559vc85c561decf9707f@mail.gmail.com> <Pine.LNX.4.64.0707111940080.4516@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Epv4kl9IRBfg3rk"
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 11 22:26:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8ilc-0003Vt-Tp
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 22:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760103AbXGKU0U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 16:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759930AbXGKU0U
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 16:26:20 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:53963 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756643AbXGKU0U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 16:26:20 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 11DAC57317;
	Wed, 11 Jul 2007 22:26:19 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id ZI5XYHC8PMiN; Wed, 11 Jul 2007 22:26:17 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 4BADE57292;
	Wed, 11 Jul 2007 22:26:17 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1I8ilL-00049y-Do; Wed, 11 Jul 2007 22:26:15 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707111940080.4516@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52196>


--4Epv4kl9IRBfg3rk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 11, 2007 at 19:42:10 +0100, Johannes Schindelin wrote:
> Hi list,
>=20
> > > > How difficult is it to have script (or maybe existing git option)=
=20
> > > > that would make mtimes of all working files equal to time of last=
=20
> > > > commit ?
>=20
> Now I slowly get really curious.  Does _anybody_ know a scenario where=20
> this makes sense?
>=20
> (No, Eric, there are enough corner cases where your example of a clustere=
d=20
> webserver breaks down, so I am not fully convinced that this is a useful=
=20
> case.)
>=20
> Anybody enlighten me?

I don't see any case where it would be useful, though I know some version
control systems that provide that feature. I think it is supposed to just be
used for checking which view has newer version.

I first thought the idea had something to do with make, but it will actually
promptly break most build tools, because change to earlier version is
a change too, but they wouldn't detect it.

However I am getting really curious about different thing -- the solution.
Because I think the arguments from keyword expansion discussion apply here
that prevent any *reliable* (you can have unreliable ones just as you can
have unreliable keyword expansion) solution.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--4Epv4kl9IRBfg3rk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGlTznRel1vVwhjGURAkd+AKDVJIOA9lAulD2ANGIic0bNrH03dQCeN0N+
JsDp7p06mJH/r1cXCLWhhNU=
=E3Qb
-----END PGP SIGNATURE-----

--4Epv4kl9IRBfg3rk--
