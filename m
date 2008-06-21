From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Move deletion of configure generated files to distclean
Date: Sat, 21 Jun 2008 03:28:24 +0200
Message-ID: <20080621012824.GG29404@genesis.frugalware.org>
References: <D4D1BF84-3D3F-4DEC-87C0-F926228E0BF5@tekrat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QHDjDLZdFPhZS56e"
Cc: git@vger.kernel.org
To: shire <shire@tekrat.com>
X-From: git-owner@vger.kernel.org Sat Jun 21 03:29:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9rvE-0003g4-GF
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 03:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbYFUB23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 21:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbYFUB23
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 21:28:29 -0400
Received: from virgo.iok.hu ([193.202.89.103]:42156 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751185AbYFUB22 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 21:28:28 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 8E0781B2507;
	Sat, 21 Jun 2008 03:28:24 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 4D7F544668;
	Sat, 21 Jun 2008 03:05:29 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 0C27D1190AD9; Sat, 21 Jun 2008 03:28:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <D4D1BF84-3D3F-4DEC-87C0-F926228E0BF5@tekrat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85685>


--QHDjDLZdFPhZS56e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2008 at 05:57:45PM -0700, shire <shire@tekrat.com> wrote:
> Running "make clean" also requires a run of "./configure ..." again becau=
se=20
> it deletes auto-generated files, which I found a little unexpected.  I=20
> figured I'd mention it as I'm not sure if this is confusing for other use=
rs=20
> or intended functionality of "make clean" vs. "make distclean", I would=
=20
> assume that the first would not revert configuration changes.

I remember I was surprised as well when first time I noticed this
behaviour, so I like your patch.

--QHDjDLZdFPhZS56e
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhcWTgACgkQe81tAgORUJYO+wCfaWM4Lobi3pphoTtcfhVAUMF3
lR4An3RA6TKI5yKJG+uUdUvJYyuQylLj
=hjfZ
-----END PGP SIGNATURE-----

--QHDjDLZdFPhZS56e--
