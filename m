From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Fixed a command line option type for builtin-fsck.c
Date: Tue, 30 Oct 2007 21:20:50 +0100
Message-ID: <20071030202050.GA9776@artemis.corp>
References: <1193771721-2880-1-git-send-email-Emilian.Medve@Freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="yrj/dFKFPuw6o+aM";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: spearce@spearce.org, gitster@pobox.com, git@vger.kernel.org
To: Emil Medve <Emilian.Medve@Freescale.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 21:21:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImxaH-0001vF-9U
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 21:21:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051AbXJ3UUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 16:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752980AbXJ3UUz
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 16:20:55 -0400
Received: from pan.madism.org ([88.191.52.104]:34634 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752636AbXJ3UUx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 16:20:53 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id C638B20C15;
	Tue, 30 Oct 2007 21:20:51 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 18A3EDC90; Tue, 30 Oct 2007 21:20:50 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Emil Medve <Emilian.Medve@Freescale.com>, spearce@spearce.org,
	gitster@pobox.com, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1193771721-2880-1-git-send-email-Emilian.Medve@Freescale.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62751>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 30, 2007 at 07:15:21PM +0000, Emil Medve wrote:
> The typo was introduced by this commit: 5ac0a2063e8f824f6e8ffb4d18de74c55=
aae7131
>=20
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>

Acked-By: Pierre Habouzit <madcoder@debian.org>

  good catch.

> ---
>=20
> This patch applies to the 'next' branch
>=20
>  builtin-fsck.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/builtin-fsck.c b/builtin-fsck.c
> index 64da3bd..e4874f6 100644
> --- a/builtin-fsck.c
> +++ b/builtin-fsck.c
> @@ -680,7 +680,7 @@ static struct option fsck_opts[] =3D {
>  	OPT_BOOLEAN(0, "cache", &keep_cache_objects, "make index objects head n=
odes"),
>  	OPT_BOOLEAN(0, "reflogs", &include_reflogs, "make reflogs head nodes (d=
efault)"),
>  	OPT_BOOLEAN(0, "full", &check_full, "also consider alternate objects"),
> -	OPT_BOOLEAN(0, "struct", &check_strict, "enable more strict checking"),
> +	OPT_BOOLEAN(0, "strict", &check_strict, "enable more strict checking"),
>  	OPT_BOOLEAN(0, "lost-found", &write_lost_and_found,
>  				"write dangling objects in .git/lost-found"),
>  	OPT_END(),
> --=20
> 1.5.3.4.1458.g3e72e-dirty
>=20

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHJ5IivGr7W6HudhwRAr5HAKCRWskbofzZUuV1Mz6X8Qd+AP/LZACfQYgU
tqXVIfMfjfUGDBVvR/Ci00M=
=z2eE
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
