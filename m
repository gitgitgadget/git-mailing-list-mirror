From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [BUG?] git-merge appends extra string to user's message?
Date: Wed, 2 Dec 2009 16:54:46 +0100
Message-ID: <20091202155446.GU31763@genesis.frugalware.org>
References: <20091202192030.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="js+/jT5SQQin5+Fm"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 16:54:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFrXb-0003YE-Pu
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 16:54:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754555AbZLBPyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 10:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754455AbZLBPyn
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 10:54:43 -0500
Received: from virgo.iok.hu ([212.40.97.103]:35754 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754363AbZLBPyn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 10:54:43 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 07E2B5809B;
	Wed,  2 Dec 2009 16:54:47 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id C9DF642F0A;
	Wed,  2 Dec 2009 16:54:46 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 7B88F1240011; Wed,  2 Dec 2009 16:54:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091202192030.6117@nanako3.lavabit.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134341>


--js+/jT5SQQin5+Fm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 02, 2009 at 07:20:30PM +0900, Nanako Shiraishi <nanako3@lavabit=
=2Ecom> wrote:
> % git merge -m "Merge early part of side branch" `git rev-parse side~2`
> % git show -s=20
> commit 37217141e7519629353738d5e4e677a15096206f
> Merge: e68e646 a1d2374
> Author: ???????????? ????????? <nanako3@lavabit.com>
> Date:   Wed Dec 2 14:33:20 2009 +0900
>=20
>     Merge early part of side branch
>=20
>     Merge commit 'a1d2374f8f52f4e8a53171601a920b538a6cec23'

At least it's intentional. When I wrote builtin-merge I remember I
checked that the script version had this behaviour and that's why I
implemented the same way in C.

--js+/jT5SQQin5+Fm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksWjcYACgkQe81tAgORUJZBEQCghKCg5BPtFaC0bKAgRq0orGnI
gDoAniNmQd2LPeEJnQH+UAbIS2ah3obH
=jRfJ
-----END PGP SIGNATURE-----

--js+/jT5SQQin5+Fm--
