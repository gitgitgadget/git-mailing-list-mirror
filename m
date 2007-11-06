From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Give git-am back the ability to add Signed-off-by lines.
Date: Tue, 06 Nov 2007 23:35:17 +0100
Message-ID: <20071106223517.GC4382@artemis.corp>
References: <200711062133.58903.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="PuGuTyElPB9bOcsM";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Tue Nov 06 23:35:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpX1D-0007Q5-Aa
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 23:35:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754749AbXKFWfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 17:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754593AbXKFWfV
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 17:35:21 -0500
Received: from pan.madism.org ([88.191.52.104]:44241 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754166AbXKFWfU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 17:35:20 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 9A99B26487;
	Tue,  6 Nov 2007 23:35:18 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id C14801DF84; Tue,  6 Nov 2007 23:35:17 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200711062133.58903.johannes.sixt@telecom.at>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63741>


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 06, 2007 at 08:33:58PM +0000, Johannes Sixt wrote:
> This was lost in the migration to git-rev-parse --parseopt by commit
> 78443d90491c1b82afdffc3d5d2ab8c1a58928b5.
>=20
> Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
> ---
>  git-am.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/git-am.sh b/git-am.sh
> index 876b973..e5af955 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -131,7 +131,7 @@ do
>  		binary=3Dt ;;
>  	-3|--3way)
>  		threeway=3Dt ;;
> -	-s--signoff)
> +	-s|--signoff)

  Gaaaah. One more case of t/f finger-slip

>  		sign=3Dt ;;
>  	-u|--utf8)
>  		utf8=3Dt ;; # this is now default
> --=20
> 1.5.3.4.315.g2ce38
>=20

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHMOwlvGr7W6HudhwRAvuFAKCex3YQj86P8N8YfQCYnG4dG+8FwgCePcxi
t7xohV/0eTtaPjpMExk5byI=
=8SSe
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--
