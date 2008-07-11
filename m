From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [StGIT] Failure to install on RHELWS4
Date: Fri, 11 Jul 2008 22:07:35 +0200
Message-ID: <20080711200735.GK10347@genesis.frugalware.org>
References: <20080711170356.GF32184@machine.or.cz> <200807112126.39729.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bSr84fpmRhc6ULjY"
Cc: Thomas Rast <trast@student.ethz.ch>, Petr Baudis <pasky@suse.cz>,
	Git Mailing List <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 22:08:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHOv5-000089-Bd
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 22:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756192AbYGKUHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 16:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759699AbYGKUHi
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 16:07:38 -0400
Received: from virgo.iok.hu ([193.202.89.103]:50732 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759662AbYGKUHh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 16:07:37 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id A2F941B24FA;
	Fri, 11 Jul 2008 22:07:35 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id ACAA94465E;
	Fri, 11 Jul 2008 21:32:55 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 15741177001C; Fri, 11 Jul 2008 22:07:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200807112126.39729.trast@student.ethz.ch>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88166>


--bSr84fpmRhc6ULjY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2008 at 09:26:29PM +0200, Thomas Rast <trast@student.ethz.c=
h> wrote:
> > 	    pyver =3D '.'.join(str(n) for n in sys.version_info)
> > 	                              ^
> [...]
> > Python version is 2.3.4
>=20
> That is indeed too old.  Generator expressions like the above were
> introduced in 2.4:
>=20
>   http://www.python.org/dev/peps/pep-0289/

So obviously it's a bad idea to use generators for such a version check.

Also, setup.py would try to import stgit.run before the version check.

I'm sending two patches, which restore the wished "Python version 2.4 or
newer required. Found 2.2.1.final.0" error message.

(Tested with Python 2.2.1.)

--bSr84fpmRhc6ULjY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkh3vYcACgkQe81tAgORUJZbpwCePRxuc3mZC1YeZkY+JMj5nt2l
f9AAoKqyIfmrHt84679OTgFbqc6eE8+h
=Y7Vc
-----END PGP SIGNATURE-----

--bSr84fpmRhc6ULjY--
