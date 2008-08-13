From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH (1b)] merge-recursive.c: Add more generic
	merge_recursive_generic()
Date: Wed, 13 Aug 2008 19:26:22 +0200
Message-ID: <20080813172622.GB12871@leksak.fem-net>
References: <1218559514-16890-1-git-send-email-vmiklos@frugalware.org> <1218572040-23362-1-git-send-email-s-beyer@gmx.net> <20080812214410.GG18960@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Aug 13 19:27:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTK8J-0003GP-9B
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 19:27:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbYHMR01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 13:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751855AbYHMR01
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 13:26:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:41696 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751306AbYHMR00 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 13:26:26 -0400
Received: (qmail invoked by alias); 13 Aug 2008 17:26:23 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp054) with SMTP; 13 Aug 2008 19:26:23 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+iPN9NakWinBDN06DXy+/WNTL2u05TTYcVXGWaEv
	Q5c+AYt8LM2y7G
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KTK74-0003X3-4W; Wed, 13 Aug 2008 19:26:22 +0200
Content-Disposition: inline
In-Reply-To: <20080812214410.GG18960@genesis.frugalware.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92247>


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Miklos Vajna wrote:
> On Tue, Aug 12, 2008 at 10:13:59PM +0200, Stephan Beyer <s-beyer@gmx.net>=
 wrote:
> > merge_recursive_generic() takes, in comparison to to merge_recursive(),
> > no commit ("struct commit *") arguments but SHA ids ("unsigned char *"),
> > and no commit list of bases but an array of refs ("const char **").
> >=20
> > This makes it more generic in the case that it can also take the SHA
> > of a tree to merge trees without commits, for the bases, the head
> > and the remote.
> >=20
> > merge_recursive_generic() also handles locking and updating of the
> > index, which is a common use case of merge_recursive().
>=20
> Then what about adding an extra parameter to merge_recursive_generic()
> so that merge_recursive_setup() could be a static function?

Could it?

I did not intend to replace merge_recursive() by merge_recursive_generic(),
because merge_recursive() may be the better choice in cases where the caller
only deals with commit objects and never with tree objects directly.
Or if the caller does not want to lock the index or do some other stuff
with the index...
In that case merge_recursive_setup() is still needed, isn't it?

Regards,
  Stephan

--=20
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFIoxk+bt3SB/zFBA8RAhLmAKCNibZzdGe7JBQqMTLBrS5fleWM8QCghAeQ
5tAtW2b2bVSNyJgg7FNIkpk=
=KOuw
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
