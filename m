From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Dangling blob after git gc
Date: Thu, 27 Nov 2008 14:53:42 +0100
Message-ID: <20081127135342.GX4746@genesis.frugalware.org>
References: <20081127133027.GW4746@genesis.frugalware.org> <vpqzljlnuwo.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xPLL5cPndR2UZ7Mw"
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Nov 27 14:55:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5hKf-00080P-FS
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 14:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725AbYK0Nxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 08:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752187AbYK0Nxo
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 08:53:44 -0500
Received: from virgo.iok.hu ([212.40.97.103]:43780 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752725AbYK0Nxn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 08:53:43 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 8383F580A7;
	Thu, 27 Nov 2008 14:53:42 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 6DA544465E;
	Thu, 27 Nov 2008 14:53:42 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 3925611901A1; Thu, 27 Nov 2008 14:53:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <vpqzljlnuwo.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101814>


--xPLL5cPndR2UZ7Mw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2008 at 02:46:47PM +0100, Matthieu Moy <Matthieu.Moy@imag.f=
r> wrote:
> from man git-gc:
>=20
>      The optional configuration variable gc.pruneExpire controls
>      how old the unreferenced loose objects have to be before
>      they are pruned. The default is "2 weeks ago".
>=20
> Git can hardly know for sure whether a dangling object is actually a
> temporary object used by another instance of git or actually an unused
> object. Older versions of Git required you to explicitely say --prune
> to mean "OK, _I_ am sure, you can prune the objects", newer do it the
> safe way by removing only objects old enough.

So it was a user error, thanks for pointing out the relevant
documentation. :)

--xPLL5cPndR2UZ7Mw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkupmYACgkQe81tAgORUJZ6ZgCglI4mqfvmVgPOYXxaW1ApsuWT
MiQAn3xmlToaxgpo5r+D4zzuJG0Tv4/j
=esFU
-----END PGP SIGNATURE-----

--xPLL5cPndR2UZ7Mw--
