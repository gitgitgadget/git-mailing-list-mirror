From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 12/13] Build in merge
Date: Fri, 27 Jun 2008 15:17:13 +0200
Message-ID: <20080627131713.GO29404@genesis.frugalware.org>
References: <cover.1214066798.git.vmiklos@frugalware.org> <0b7ea424b3d5ea18a5a8660c6aead51adcc6a40f.1214066799.git.vmiklos@frugalware.org> <57d8a308fae0012174ed4388baccf1bde8515f2f.1214066799.git.vmiklos@frugalware.org> <5cae08d3bf2852a8bbd8dc8cdf741cb4bdfa237e.1214066799.git.vmiklos@frugalware.org> <d5d80c5a068c76810edfa9c0c68de500f02780a0.1214066799.git.vmiklos@frugalware.org> <486270D5.5050204@free.fr> <20080627010609.GJ29404@genesis.frugalware.org> <4864C8F8.9020501@free.fr> <20080627125443.GK29404@genesis.frugalware.org> <4864E574.70700@freesurf.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mgZDnYS/0+W7Gp+8"
Cc: Olivier Marin <dkr+ml.git@free.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Olivier Marin <dkr@freesurf.fr>
X-From: git-owner@vger.kernel.org Fri Jun 27 15:18:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCDqA-0002Yb-2T
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 15:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbYF0NRR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 09:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752866AbYF0NRR
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 09:17:17 -0400
Received: from virgo.iok.hu ([193.202.89.103]:36078 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751128AbYF0NRR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 09:17:17 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id D6DF51B2514;
	Fri, 27 Jun 2008 15:17:15 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id D26514469A;
	Fri, 27 Jun 2008 14:50:38 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 8898D1778012; Fri, 27 Jun 2008 15:17:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4864E574.70700@freesurf.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86558>


--mgZDnYS/0+W7Gp+8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2008 at 03:04:52PM +0200, Olivier Marin <dkr@freesurf.fr> w=
rote:
> >> +       if (diff_use_color_default =3D=3D -1)
> >> +               diff_use_color_default =3D git_use_color_default;
> >> +
> >>         argc =3D parse_options(argc, argv, builtin_merge_options,
> >>                         builtin_merge_usage, 0);
> >=20
> > Have you tried this?
>=20
> I did. I forget to say that it's on top of your patch, sorry.

Aah. I should have noticed that.

I see now, your hunk is necessary when color.diff and diff.color is not
set but color.ui is.

Thanks.

--mgZDnYS/0+W7Gp+8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhk6FkACgkQe81tAgORUJaGpACfQk9i3X69JFHOcoIsSViix//G
0/4AoJP1/MN4CXTZA7XsCG1/AP8zD1yP
=5heL
-----END PGP SIGNATURE-----

--mgZDnYS/0+W7Gp+8--
