Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93B941F453
	for <e@80x24.org>; Mon, 11 Feb 2019 23:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbfBKX6q (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 18:58:46 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34166 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727256AbfBKX6q (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Feb 2019 18:58:46 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E8C936042D;
        Mon, 11 Feb 2019 23:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549929522;
        bh=6g65lTSqdMxJsdOBGddkTsDFiQldBB3v6pJVYZfJevo=;
        h=Date:From:To:Subject:References:Content-Type:Content-Disposition:
         In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
         Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Dg1y96QVUyvxdDbV0RTpxmPBcBtv3IEmOljth5VGFdIPy9VYGT/Gn+K65+5mEEN9q
         qvmdqaKljWpn0M55Jp1erPuZPBnzw8QR4hAIYReT+J17RuF+r0y5oSWeMOpu4m3swU
         WM7+gqOc3do12yFfY5IY82v4zq7db+DOjHlwhv82tOy2OE+1gXIsjqupOvXJgV6tDt
         bSvQ7Vd+wwbsOoy8nhfF4JVk1VVjq1mqlo/YYdOmxU1IqSwN3NpCnF3K+eQ5//w0NJ
         NYBErceQwCWwHWzLvcXUZMmJ8sFWUqaRMjmcj+NfP8WtF8mFXWO2VqLRLclevtGKTh
         sztyP2PzfenmYPd1YI42BtuOkL/4U8LOD5BpEonclK+7rxz9HwRK+DOtPrpeH7ojvp
         jg3qHQzruLrN+/9m+sgz7mGqZigBTcES9b//ZbmJG1sKxIMUins1+qler36ix9U4zo
         PgG63p7LZojZ2xw4xB50T4eAV1cBvOJ5pRLldBBMLne6EzPP9MH
Date:   Mon, 11 Feb 2019 23:58:36 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Kevin Daudt <me@ikke.info>, git@vger.kernel.org,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Rich Felker <dalias@libc.org>
Subject: Re: [PATCH v3] utf8: handle systems that don't write BOM for UTF-16
Message-ID: <20190211235835.GB684736@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kevin Daudt <me@ikke.info>, git@vger.kernel.org,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Rich Felker <dalias@libc.org>
References: <20190209200802.277139-1-sandals@crustytoothpaste.net>
 <20190211012639.579489-1-sandals@crustytoothpaste.net>
 <20190211214306.GB14229@alpha>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline
In-Reply-To: <20190211214306.GB14229@alpha>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 10:43:06PM +0100, Kevin Daudt wrote:
> With some additional fixes, this indeed does solve the issue for Alpine
> Linux, thanks.
>=20
> I had to fix the following as well:
>=20
> iff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encod=
ing.sh
> index 8936ba6757..8491f216aa 100755
> --- a/t/t0028-working-tree-encoding.sh
> +++ b/t/t0028-working-tree-encoding.sh
> @@ -148,8 +148,8 @@ do
>         test_when_finished "rm -f crlf.utf${i}.raw lf.utf${i}.raw" &&
>         test_when_finished "git reset --hard HEAD^" &&
>=20
> -       cat lf.utf8.raw | iconv -f UTF-8 -t UTF-${i} >lf.utf${i}.raw &&
> -       cat crlf.utf8.raw | iconv -f UTF-8 -t UTF-${i} >crlf.utf${i}.raw =
&&
> +       cat lf.utf8.raw | eval "write_utf${i}" >lf.utf${i}.raw &&
> +       cat crlf.utf8.raw | eval "write_utf${i}" >crlf.utf${i}.raw &&
>         cp crlf.utf${i}.raw eol.utf${i} &&
>=20
>         cat >expectIndexLF <<-EOF &&

I'll squash in this fix, thanks.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxiDCsACgkQv1NdgR9S
9ot/Ug/+Idu7mDKuecFZyCxnK3I91LifWrQh28+e+2emaXQ8O3n6l9V92xqdES1b
j2NUpmr32WWmDoQ1T8UDOAP7SZ0weBtgVl0cjpW5drHlU/TqUQuDgn/oyqVFhJXB
ypch6XGEErSg94ZrzRImKzePb4ukj4fsyAsPrpMimnMfreyDg9L5YsN4dk1h9Il/
XTHgV2sRObcMmZxaH/3DwZ5o1LsI22ZH7C0IxdDFMoMZdmqQHHLBjkF3Yj38JHlt
RjoltVYMh922vWcW/sfIWnv1qNe8y+qTxtInCdd+dWFaD31DE5rFCa2VVK4CRDiU
/mtdTylcFa3RbglGkRo6oseOFHK4m1TJE58ky8IoGaSCpu9jtpvpsFGPLzolYgXm
xrP0vgq3Jw6Z0ymE8tGdJFY3yBYyaFr6YDcom/QrVxq65ldWH3Lv/g4kZOtKkl79
MyGHGT2RhShc+laatrKa244keG/k7fbrJSUoXLrwdXM23+4xhbLEz7nEzOjtliuO
jVjZ0HG74CCxY6MAdjr5Fn3uDu1czUP66Df89nrBRs9YGm/D/NOEvsm2aaUm/MfX
AUGo+W5u8taUUW4qtBr2SuEd3fHpv/Ny6ZROqiG1TBr9pXWz/M6braXNYrKR4Zq+
wluzA3dSghmnwjFnDPRSSEJPgZj96j7TqqGVci81c6l83zZEGsU=
=SIrO
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--
