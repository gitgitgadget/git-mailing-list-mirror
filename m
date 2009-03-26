From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH TopGit] hooks/pre-commit.sh: fix bashism
Date: Thu, 26 Mar 2009 10:29:54 +0100
Organization: Pengutronix
Message-ID: <49CB4B12.3020408@pengutronix.de>
References: <1237981384-7857-1-git-send-email-bert.wesarg@googlemail.com> <20090326090009.GA7570@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3747B59D31551FD64DEAD357"
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	Marc Kleine-Budde <m.kleine-budde@pengutronix.de>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Thu Mar 26 10:31:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmlw6-0003N8-Px
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 10:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbZCZJaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 05:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbZCZJaK
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 05:30:10 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43430 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbZCZJaI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 05:30:08 -0400
Received: from themisto.ext.pengutronix.de ([92.198.50.58] helo=[127.0.0.1])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <mkl@pengutronix.de>)
	id 1LmluS-0006JM-MQ; Thu, 26 Mar 2009 10:30:04 +0100
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
In-Reply-To: <20090326090009.GA7570@pengutronix.de>
X-Enigmail-Version: 0.95.0
X-SA-Exim-Connect-IP: 92.198.50.58
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on
	metis.extern.pengutronix.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=4.5 tests=AWL,BAYES_00,RCVD_IN_PBL
	shortcircuit=no autolearn=no version=3.2.4
X-SA-Exim-Version: 4.2.1 (built Tue, 09 Jan 2007 17:23:22 +0000)
X-SA-Exim-Scanned: Yes (on metis.ext.pengutronix.de)
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114755>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3747B59D31551FD64DEAD357
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Uwe Kleine-K=F6nig wrote:
> This was introduced in fcb488d51e72c7414f9beb40ad06bf529b8b38dc.
> A similar fix was suggested by martin f krafft, too.

Works here on ubuntu bin /bin/sh is a link to /bin/dash

> Reported-by: Bert Wesarg <bert.wesarg@googlemail.com>
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
Tested-by: Marc Kleine-Budde <mkl@pengutronix.de>

> ---
> Hello,
>=20
> this should fix the issue now.
>=20
> If I don't get negative feed back I will push this change later today.
> I'm open for acks, too.
>=20
> Best regards and thanks
> Uwe
>=20
>  hooks/pre-commit.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/hooks/pre-commit.sh b/hooks/pre-commit.sh
> index a12cfa6..9d677e9 100644
> --- a/hooks/pre-commit.sh
> +++ b/hooks/pre-commit.sh
> @@ -20,7 +20,7 @@ tg_util
>  if head_=3D$(git symbolic-ref -q HEAD); then
>  	case "$head_" in
>  		refs/heads/*)
> -			git rev-parse -q --verify "${head_/#refs\/heads/refs\/top-bases}" >=
/dev/null || exit 0;;
> +			git rev-parse -q --verify "refs/top-bases${head_#refs/heads}" >/dev=
/null || exit 0;;
>  		*)
>  			exit 0;;
>  	esac

Marc

--=20
Pengutronix e.K.                         | Marc Kleine-Budde           |
Linux Solutions for Science and Industry | Phone: +49-231-2826-924     |
Vertretung West/Dortmund                 | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686         | http://www.pengutronix.de   |


--------------enig3747B59D31551FD64DEAD357
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAknLSxYACgkQjTAFq1RaXHNB2QCfT+S4kspKX2Tf0lAKCG/7DrA+
KNkAoIjcW24z7pON3tUjjL8ofCyNf5Mr
=NNX5
-----END PGP SIGNATURE-----

--------------enig3747B59D31551FD64DEAD357--
