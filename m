From: Thomas Schwinge <tschwinge@gnu.org>
Subject: Re: [PATCH] Don't rely on unspecified behavior
Date: Sat, 28 Jul 2007 21:43:06 +0200
Message-ID: <20070728194306.GA32203@fencepost.gnu.org>
References: <20070728173948.GD23337@cip.informatik.uni-erlangen.de> <11856471952272-git-send-email-tschwinge@gnu.org> <Pine.LNX.4.64.0707282028130.14781@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 28 21:41:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEsA6-0002v5-Lp
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 21:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574AbXG1TlL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 15:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752953AbXG1TlJ
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 15:41:09 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:48937 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679AbXG1TlI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 15:41:08 -0400
Received: from tschwinge by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <tschwinge@gnu.org>)
	id 1IEsBu-0001Ag-PX; Sat, 28 Jul 2007 15:43:06 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707282028130.14781@racer.site>
X-Homepage: http://nic-nac-project.de/~schwinge/
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54054>


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

On Sat, Jul 28, 2007 at 08:30:07PM +0100, Johannes Schindelin wrote:
> On Sat, 28 Jul 2007, Thomas Schwinge wrote:
> > Calling access(p, m) with p =3D=3D NULL is not specified, so don't do t=
hat.  On
> > GNU/Hurd systems doing so will result in a SIGSEGV.
> >=20
> > Signed-off-by: Thomas Schwinge <tschwinge@gnu.org>
> > ---
>=20
> Isn't this the same patch as you sent before?

As I wrote in <20070728182542.GA22651@fencepost.gnu.org>: ``I noticed
that the patch I sent was prepared for an old version of the file.  I'll
send an updated patch that applies to the current revision.''

> > +		if (excludes_file !=3D NULL && !access(excludes_file, R_OK))
>=20
> We usually omit the "!=3D NULL"; see the other source code in git.git.

Okay, so I should sent a thusly modified version to get it applied?


Regards,
 Thomas

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFGq5xKgfzh735dTTURAsUGAKCAFYj5o4q1iygSmQbwlA/TGECefgCeP1ze
IZUcz6ta7wx5v2iDV/oWLCQ=
=JrZp
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
