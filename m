From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Sun, 27 May 2007 22:34:42 +0200
Message-ID: <20070527203442.GC8361@admingilde.org>
References: <11799589913153-git-send-email-skimo@liacs.nl> <Pine.LNX.4.64.0705240039370.4113@racer.site> <7vtzu3yrh9.fsf@assigned-by-dhcp.cox.net> <20070524072216.GE942MdfPADPa@greensroom.kotnet.org> <20070524072945.GO28023@spearce.org> <20070524073652.GH942MdfPADPa@greensroom.kotnet.org> <Pine.LNX.4.64.0705241039200.4648@racer.site> <20070524105112.GI942MdfPADPa@greensroom.kotnet.org> <Pine.LNX.4.64.0705241201270.4648@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+nBD6E3TurpgldQp"
Cc: skimo@liacs.nl, "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 27 22:34:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsPS1-0003pb-45
	for gcvg-git@gmane.org; Sun, 27 May 2007 22:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754431AbXE0Uer (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 16:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753693AbXE0Uer
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 16:34:47 -0400
Received: from mail.admingilde.org ([213.95.32.147]:39571 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808AbXE0Ueq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 16:34:46 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HsPRq-0000Sz-MR; Sun, 27 May 2007 22:34:42 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705241201270.4648@racer.site>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48576>


--+nBD6E3TurpgldQp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Thu, May 24, 2007 at 12:02:41PM +0100, Johannes Schindelin wrote:
> On Thu, 24 May 2007, Sven Verdoolaege wrote:
> > On Thu, May 24, 2007 at 10:41:30AM +0100, Johannes Schindelin wrote:
> > > On Thu, 24 May 2007, Sven Verdoolaege wrote:
> > > > You mean like a tag "submodules" that points to a text file
> > > > describing the submodules?
> > > > That's a bit of a pain to set up since you would want that
> > > > to be independent of your project.
> > >=20
> > > I could imagine this to be another extension of ls-remote.
> >=20
> > You mean extending upload-pack ?  Junio mentioned this possibility as w=
ell.
> > This only solves the git:// and ssh:// case though.
> > What to do with the other protocols?
>=20
> As we do for the refs: put it into .git/info/refs. This file is already=
=20
> meant to "cache" the output of ls-remote for dumb protocols.

why on earth do you want to store a subproject SHA1 in the
superproject.git?

The subproject only exists as a part of the superproject tree and thus
there is no "the subproject SHA1 which is used by the superproject".
It just doesn't work as you can have several superproject branches with
different subproject.  And even the superproject can itself be a
subproject.

--=20
Martin Waitz

--+nBD6E3TurpgldQp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGWetij/Eaxd/oD7IRAk0WAJ9Sre2UA/y1zGM8a1LhnpnyQ68sywCfWqYJ
c4UqHil4E4hpN9+U5+Fl/gw=
=4JYY
-----END PGP SIGNATURE-----

--+nBD6E3TurpgldQp--
