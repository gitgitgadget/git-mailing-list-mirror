From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v6 4/7] pull: add --merge option
Date: Fri, 2 May 2014 01:37:53 +0000
Message-ID: <20140502013753.GE75770@vauxhall.crustytoothpaste.net>
References: <1398988808-29678-1-git-send-email-felipe.contreras@gmail.com>
 <1398988808-29678-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="phCU5ROyZO6kBE05"
Cc: git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>,
	John Keeping <john@keeping.me.uk>, Jeff King <peff@peff.net>,
	Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"W. Trevor King" <wking@tremily.us>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 03:38:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg2QR-0000gp-8m
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 03:38:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbaEBBh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 21:37:58 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47465 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751338AbaEBBh6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 May 2014 21:37:58 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:b5e1:3ff0:63e4:293d])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 2BC8728087;
	Fri,  2 May 2014 01:37:57 +0000 (UTC)
Mail-Followup-To: Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>,
	John Keeping <john@keeping.me.uk>, Jeff King <peff@peff.net>,
	Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"W. Trevor King" <wking@tremily.us>
Content-Disposition: inline
In-Reply-To: <1398988808-29678-5-git-send-email-felipe.contreras@gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.14-trunk-rt-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247920>


--phCU5ROyZO6kBE05
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2014 at 07:00:05PM -0500, Felipe Contreras wrote:
> Also, deprecate --no-rebase since there's no need for it any more.
>=20
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/git-pull.txt |  8 ++++++--
>  git-pull.sh                | 10 +++++++++-
>  2 files changed, 15 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index 9a91b9f..767bca3 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -127,8 +127,12 @@ It rewrites history, which does not bode well when y=
ou
>  published that history already.  Do *not* use this option
>  unless you have read linkgit:git-rebase[1] carefully.
> =20
> ---no-rebase::
> -	Override earlier --rebase.
> +-m::
> +--merge::
> +	Force a merge.
> ++
> +See `pull.mode`, `branch.<name>.pullmode` in linkgit:git-config[1] if yo=
u want
> +to make `git pull` always use `--merge`.

So I'm confused here, and maybe you can enlighten me.  As I read this
documentation, --merge would always force a merge, like --no-ff.  If so,
I don't see an option to preserve the existing behavior, which is the
I-don't-care-just-do-it case.  If the behavior is different, then this
documentation needs to be improved, I think, along with the
documentation earlier in the series.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--phCU5ROyZO6kBE05
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTYvbxAAoJEL9TXYEfUvaL0hIQAJrgXRpKJv2sOtR3LIX+WkfT
duDiL93Xr5wKN2dCb5/THRXD9qmv2hJycSuYbE7HgZ48luW0CvFICZSUdivSSR9Z
OVDEssk/+65//OMaTce876Jn8i+q0IlgJVV5uyOqGlGTZMpbTMyyKpL2FMVyAImP
q7XDMDRm5PMASgl65fNw9cLsFoY1Hn+9RZpO3ZijN8+m0xGhuiRM7LGZTPM6yk2q
dcZOR8NS4sEX2sO2fV6eK/G4LbfNlRcJQPSrTPrELGW352qZa0GQ6jarrk3sBzCk
LE8nEtMTcAvwOhg05YBo6sMKGIp61LjDcW+vFWVaDHIDINGfH/+9KOFmgApq9SCm
gbLuBwm17yAyCklRlFsU7cC2C1R0LXaAUGc21klLA+ZoT+ILAFva9COzjnD13oe7
wGCghDDh48FFgMCJ44r4DC+TXn75IdwZZSsGNjG2Cy67kEZ/AsTTLOOgh3nQOWqg
rhmXorQS5cA79lqQlXYzvvocTYs16MaOEYFIds6VHkQU8ccaWyk7llgP7kos0hH4
jjndDTBBDzzt8rNiocFE6JWmZIBi0is0HAmT6XFCdomPFQCCz9jFosLkorGoe+f0
oJQ5hN4hcdyDJqKQjPfgTCq+Atnyw11pWeqkQbhrAuHUlUviFVygoPsw7XZ1a/VC
RJumAQQTnnH4z8gvfvg+
=70Cf
-----END PGP SIGNATURE-----

--phCU5ROyZO6kBE05--
