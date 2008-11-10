From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Install issues
Date: Mon, 10 Nov 2008 12:39:24 +0100
Message-ID: <20081110113924.GR24201@genesis.frugalware.org>
References: <20081110121739.15f77a01@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NN5Sl4cwfoGvUMzV"
Cc: git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Mon Nov 10 12:40:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzV8K-0007rr-NP
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 12:40:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754531AbYKJLj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 06:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754194AbYKJLj0
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 06:39:26 -0500
Received: from virgo.iok.hu ([193.202.89.103]:36444 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753947AbYKJLj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 06:39:26 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 8290B580D1;
	Mon, 10 Nov 2008 12:39:24 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 6F8D14465E;
	Mon, 10 Nov 2008 12:39:24 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 4149E119019E; Mon, 10 Nov 2008 12:39:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081110121739.15f77a01@pc09.procura.nl>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100516>


--NN5Sl4cwfoGvUMzV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2008 at 12:17:39PM +0100, "H.Merijn Brand" <h.m.brand@xs4al=
l.nl> wrote:
> git-1.6.0.4 112 > make check
> for i in *.c; do sparse -g -O2 -Wall  -DSHA1_HEADER=3D'<openssl/sha.h>' -=
DNO_STRLCPY -D__BIG_ENDIAN__ -D__powerpc__ $i || exit; done
> /bin/sh: sparse: command not found
> make: *** [check] Error 127
>=20
> Maybe the Makefile could be a little more user-friendly with a message
> like
>=20
> 	"Cannot run 'make check', as you do not have 'sparse' installed.
> 	 Did you mean to run 'make test' instead?"

Care to send a patch?

--NN5Sl4cwfoGvUMzV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkYHWwACgkQe81tAgORUJa5XwCcDHAuctj0XWJ2J89xIPjElErw
7X8AoIX3/IPD33+nBYo+HwlzkaP+iD0R
=+/Gj
-----END PGP SIGNATURE-----

--NN5Sl4cwfoGvUMzV--
