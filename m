From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Segfault on merge with 1.6.2.1
Date: Sun, 29 Mar 2009 14:17:00 +0200
Message-ID: <20090329121700.GN22446@genesis.frugalware.org>
References: <op.urifmtkkso3nzr@sulidor.mdjohnson.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zbGR4y+acU1DwHSi"
Cc: git@vger.kernel.org
To: Michael Johnson <redbeard@mdjohnson.us>
X-From: git-owner@vger.kernel.org Sun Mar 29 14:18:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LntyI-0008IX-BF
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 14:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305AbZC2MRG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 08:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbZC2MRF
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 08:17:05 -0400
Received: from virgo.iok.hu ([212.40.97.103]:41583 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738AbZC2MRE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 08:17:04 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 63C8E5810F;
	Sun, 29 Mar 2009 14:17:01 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 44AD044783;
	Sun, 29 Mar 2009 14:17:00 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id CEB3011F0824; Sun, 29 Mar 2009 14:17:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <op.urifmtkkso3nzr@sulidor.mdjohnson.us>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115023>


--zbGR4y+acU1DwHSi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 28, 2009 at 11:19:31AM -0500, Michael Johnson <redbeard@mdjohns=
on.us> wrote:
> The 1.6.2.1 version just segfaults, but 1.5.6.5 says:
>=20
> /usr/bin/git-merge: line 438: 32335 Segmentation fault      =20
> git-merge-$strategy $common -- "$head_arg" "$@"
> Merge with strategy recursive failed.
>=20
> In all cases, .git/index.lock is left behind.

That's because 1.6.2.1 has git-merge in C and it calls merge-recursive
directly without a fork. Could you try it in gdb and provide a
backtrace, please?

--zbGR4y+acU1DwHSi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknPZrwACgkQe81tAgORUJY5BACaAsFmdrASFyDzMI3l2y/8+jeF
79IAoKn9pvHBNf533hSGMoSPksegi2Ne
=W2wh
-----END PGP SIGNATURE-----

--zbGR4y+acU1DwHSi--
