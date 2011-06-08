From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Q: how can i find the upstream merge point of a commit?
Date: Wed, 8 Jun 2011 21:29:10 +1000
Message-ID: <20110608212910.093ba753.sfr@canb.auug.org.au>
References: <20110608093648.GA19038@elte.hu>
	<20110608203433.61e02ad8.sfr@canb.auug.org.au>
	<1307529636.2322.320.camel@twins>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__8_Jun_2011_21_29_10_+1000_YMcuXhzWi0.O/F0_"
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
X-From: git-owner@vger.kernel.org Wed Jun 08 13:29:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUGwu-00067L-Rb
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 13:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754026Ab1FHL3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 07:29:20 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:57962 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750999Ab1FHL3T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 07:29:19 -0400
Received: from canb.auug.org.au (ash.rothwell.emu.id.au [IPv6:2402:b800:7003:7010:223:14ff:fe30:c8e4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtps.tip.net.au (Postfix) with ESMTPSA id 2A809144BC2;
	Wed,  8 Jun 2011 21:29:15 +1000 (EST)
In-Reply-To: <1307529636.2322.320.camel@twins>
X-Mailer: Sylpheed 3.1.1 (GTK+ 2.24.4; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175356>

--Signature=_Wed__8_Jun_2011_21_29_10_+1000_YMcuXhzWi0.O/F0_
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Wed, 08 Jun 2011 12:40:36 +0200 Peter Zijlstra <a.p.zijlstra@chello.nl> =
wrote:
>
> *groan*, I tried that, but got:
>=20
> # git describe --contains  189d3c4a94ef19fca2a71a6a336e9fda900e25e7 --mat=
ch '^v.*'
                                                                           =
      ^
These are globs. not regexps.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__8_Jun_2011_21_29_10_+1000_YMcuXhzWi0.O/F0_
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN710GAAoJEDMEi1NhKgbsXM8H/ivkUvWI/bDk5M4xImB13zxm
M+LW7ym3oKwQIVOs5i/V+uFcyK7fGJn5j6N4YQGrgb/doAwO6H0ybDGP2CelIIXM
Mu//etG/GPZZsQubtZNrB90CFzsrYAGPPvZw6bT7R4n+N6dHlwRGKnbRXw0qeNWO
OoEklH91C4zSla9VrYTCYnqxNK/lywP2uOMXvY8bT1+hLu812UkukLp6TpaqKBLR
BaBL5vWPb2DFOfKwamBounmLRKwYCnyhbFEAe9jm4u9sGRNvjaXQLYXEmVuPCCkt
5VJ2ZpjqVi3aJArnr3pxaUvJEF126e3mmYk0d32EcbL7gGBW8r2cnPOyhzE2U3Y=
=Iwkb
-----END PGP SIGNATURE-----

--Signature=_Wed__8_Jun_2011_21_29_10_+1000_YMcuXhzWi0.O/F0_--
