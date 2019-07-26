Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 662211F462
	for <e@80x24.org>; Fri, 26 Jul 2019 07:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbfGZHn1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 03:43:27 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57100 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725903AbfGZHn0 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 26 Jul 2019 03:43:26 -0400
Received: from genre.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3B0EF6081D;
        Fri, 26 Jul 2019 07:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1564127003;
        bh=SM68Is1c3uutZTPTkW9yEKTq89pDhEa+mF3Xm9YR6Jk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=UHg5ZMGSoZ0H/px/p/QtZNiLPTKjBBPOwH1M5TA8+MlyC1GHzYKTMneXqBCjQp820
         xEyChvzkq0t4upKSEOp42ZjgCi5X97S5UTbncMmIH8Wb4XDwp6H5Iw8KUCHD06MZkP
         3ENsAo40qHlns3Mon+YRrjcVcesqQqEVocyuROcEfF6enMDV7raRTbb3cGzLcka5du
         PxKy6GPbQAGRSIzf4FlvMv5Tgjpk+NIn9Wjk4NB8qylcsAFKwXEb3jbY/r6Ddkiu/b
         2g6FurUHTTlybvflzMVaO5SeHPu87joKRzhLnvAKVCOBTrxIyzsM92dbN5Nh1nDVxJ
         iflt18MXDv/xMOgpfUksPuGXRr41yAmmO5ff3/3ZGoiZNhxX91kJlCQfMg+e7/OJZE
         CGj+zUM/Ux9juhSp2rw27hTFMptxiPpOrrQ493a4cuAdp335vcWJCGB0kVz75iibaB
         /NK56Z9x2p2ut7NSrhcLpsVe+NrdHGuXKK8ogv8FqYTy2gPWTG7
Date:   Fri, 26 Jul 2019 07:43:17 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 10/12] t/lib-rebase: prepare for testing `git rebase
 --rebase-merges`
Message-ID: <20190726074317.GD9319@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.294.git.gitgitgadget@gmail.com>
 <ae9e72b73bf2da0de3a5369748ebd358656588d9.1564049474.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qGV0fN9tzfkG3CxV"
Content-Disposition: inline
In-Reply-To: <ae9e72b73bf2da0de3a5369748ebd358656588d9.1564049474.git.gitgitgadget@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 5.0.0-trunk-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qGV0fN9tzfkG3CxV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-07-25 at 10:11:22, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>=20
> The format of the todo list is quite a bit different in the
> `--rebase-merges` mode; Let's prepare the fake editor to handle those
> todo lists properly, too.
>=20
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/lib-rebase.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
> index 7ea30e5006..662a958575 100644
> --- a/t/lib-rebase.sh
> +++ b/t/lib-rebase.sh
> @@ -44,10 +44,10 @@ set_fake_editor () {
>  	rm -f "$1"
>  	echo 'rebase -i script before editing:'
>  	cat "$1".tmp
> -	action=3Dpick
> +	action=3D\&

So we set action to "&" so we can use it as the result in the sed
expression below=E2=80=A6

>  	for line in $FAKE_LINES; do
>  		case $line in
> -		pick|p|squash|s|fixup|f|edit|e|reword|r|drop|d)
> +		pick|p|squash|s|fixup|f|edit|e|reword|r|drop|d|label|l|reset|r|merge|m)
>  			action=3D"$line";;
>  		exec_*|x_*|break|b)
>  			echo "$line" | sed 's/_/ /g' >> "$1";;
> @@ -61,8 +61,8 @@ set_fake_editor () {
>  			echo "$action XXXXXXX False commit" >> "$1"

but then here it doesn't look like "&" is a thing we'd want to use. Is
there something I'm missing about this particular case?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--qGV0fN9tzfkG3CxV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl06rxUACgkQv1NdgR9S
9ouCGw/+NO7vrDMS3eUHGkwUNuManGkQls5rEh2yd6UCHLPTpDfHK6uOu511oNfv
CtMclAG/veuYD4kP13AuUvLYJJIaWzTBw3gGfGzCqJw3ycaclOBjs+37MA/b6Lth
cwPODNaknueeoTvtJs+OjIEPoYYd1W9WNiiJj8/PC4qE9sG1K1kymJO/cTyoXT5W
vBDPfZbdk7679Qaw8/9gWHDZp0mZi/q9Bfl/eQ+jUb+H9VgG6ggBVjMVvAI6s46D
/uHo0jhm8D1iz5zAaMKKeD1WmZIm2IGkOIdMdt2SPDKKgsB8o0hqt1DWvyjdYuC5
FwedEckuFi0fLspXabNOalRywHXiJvcjchkgMWz7wDbxUg4n8Cd9bsOIBIdM/X78
OUUDdrwEjhhHGS2ykxQRIROFR/UJ84Sy1EX+zrgNg693O1JUKReea7BuYcvpN9jK
2pnpIGgrcGUgWyOgd+ErM8ErkKkkHxE9K4LK5DWu8KyTBNMrBLzUiqQHeNGlv6SP
XH0LTK2l50ZW2pNWyCXWgpu9zFwt6UPkNdm7dlHNQpPdZKDhxBMIYTDccHLCisVj
GKrhgFGRAkZlOq2l7QTFcC6v4JTKQUqtMgnFbokYwLQC7eWu4US+n7KpJAhpZqTb
RHUq9DsAQTXgX1rgNtv8YPUsdB+/J1UlfiKX7VYJifOrGq5n5mY=
=OYrG
-----END PGP SIGNATURE-----

--qGV0fN9tzfkG3CxV--
