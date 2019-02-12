Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43E151F453
	for <e@80x24.org>; Tue, 12 Feb 2019 00:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfBLAxg (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 19:53:36 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34208 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727782AbfBLAxg (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Feb 2019 19:53:36 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9913D6042D;
        Tue, 12 Feb 2019 00:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549932814;
        bh=oCQ8tlKI+aA/sHwSU5XXC+zk8yhstOcoaoN72IPuHt8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=r6qRugaxrWRgnt8BuXtDwj9jpbyUCBRbQ14jfvS0dn2V5wIKKxkrtBq499VGBsn7k
         UGmwpNlDfcApdXAiZWNPchlaWKnijEWZef/Kf6y4LtQ9P5J4k+bocmS0ILTyWNj7bY
         sAA+dRUnN1hyx+NUbcOygBRTeD4b+Hd+3Bwmb3B1JSUBhhziIQWaIoc9E8OxhO+oQ4
         s1JrCTptWnJ9eDTQs3wDCuiP6VHVUJd3ZoDA5XD6VKBNDZiKZPhpCJd5/56hE+hOm+
         YkNDKJUHJsBLooyB7MrxohfolzU2CD63+GUDYnNN6COg/42XrfBgiS477Ol3adBGZ8
         +Ul4BnDbIGCqLKF3TuSLNUFqvIKgCfXJAf/dUk1rnN8Oopt7K2SPPTs2C9C6F2xTwK
         CjUG7LXaAJ2YS5zRh2zTCF3KoVlrybVRdkk0Mi+hkwWHeQNzHWA7NibCfkZWxbjajw
         GfAoACE0Cvs2h0O5ShxuB4xv2h0BITWRRzxu1abX+dfHNXRt8EX
Date:   Tue, 12 Feb 2019 00:53:29 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kevin Daudt <me@ikke.info>, git@vger.kernel.org,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Rich Felker <dalias@libc.org>
Subject: Re: [PATCH v3] utf8: handle systems that don't write BOM for UTF-16
Message-ID: <20190212005329.GD684736@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Rich Felker <dalias@libc.org>
References: <20190209200802.277139-1-sandals@crustytoothpaste.net>
 <20190211012639.579489-1-sandals@crustytoothpaste.net>
 <20190211214306.GB14229@alpha>
 <20190211235835.GB684736@genre.crustytoothpaste.net>
 <xmqqtvh9g857.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4zI0WCX1RcnW9Hbu"
Content-Disposition: inline
In-Reply-To: <xmqqtvh9g857.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4zI0WCX1RcnW9Hbu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 04:31:00PM -0800, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> >> -       cat lf.utf8.raw | iconv -f UTF-8 -t UTF-${i} >lf.utf${i}.raw &&
> >> -       cat crlf.utf8.raw | iconv -f UTF-8 -t UTF-${i} >crlf.utf${i}.r=
aw &&
> >> +       cat lf.utf8.raw | eval "write_utf${i}" >lf.utf${i}.raw &&
> >> +       cat crlf.utf8.raw | eval "write_utf${i}" >crlf.utf${i}.raw &&
> >>         cp crlf.utf${i}.raw eol.utf${i} &&
> >>=20
> >>         cat >expectIndexLF <<-EOF &&
> >
> > I'll squash in this fix, thanks.
>=20
> Thanks, all.  In the meantime, what I've pushed out has this
> applied immediately on top.  Unless there is anything else, I could
> squash it in in my next pushout I plan to do tonight, before getting
> ready to tag -rc1 tomorrow.

I've just sent a v4 with this squashed in. Whether you want to pick that
up or squash this into v3 is up to you.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--4zI0WCX1RcnW9Hbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxiGQkACgkQv1NdgR9S
9ouIAQ/+LkziuA29KrOf5ysMO028H8vE3N0a5DBEGhL/UsvKsFy+1A7apRiV+rpS
iZqopazVd+yfMWZjeigDliMaB+3LEHAeXeR79M87ad/BqJdPZ2/GdkqCl9hNejXA
dExUt8oEcJI2+8k2i149OfVwLrQ2JGt0kVBtnqW84KsPIoE9jbDvKhZm/UZdLDFx
IcpYQzuUluv4ydj+hJ2zvsRCibfHTjc2gJ5gkv1HQwfqAAPRqyPRMDRylIlAP7Xp
HqZw4oBmanAv2SbWWIhbIZnVuq5Sidy/PS+QIZTd0FaosyVe+kfGbcFqb5EeoMl3
J+hJXIcZeFexvVuMQ+nt5Gy6Odw0Rm+eDr5y189gfXfEU9fQI7wtN4U+pESePBTS
ZI/3nG5SuBaHqBvGrFAYaE96wEzdiUSuslZ7BHMFcKlb0EvSXflZU0omHvqzMZ0A
xlD+QLKL6G9qq1azR/KZoDvbIGeEsFwPpnesHmEM/HY2RfcoMKgWukdmmR+CDND1
dqrnBYn0gtOfqhvv7jlYDRwL7sIdrAlKgGRKKLSfYW4pEwSf13pWKDSOslG+DNUc
KTkxsMSOp8vXBxvsOkjINKRYTwvTTfT6c1lEm2wsB6+5Mn1kZGzHkoSY1TGDivZm
HpZZK5t0qSeNxDsMl5ocVAPMZUaPmXNgrUjKjRRKDwsPzSd4Jtk=
=xqN0
-----END PGP SIGNATURE-----

--4zI0WCX1RcnW9Hbu--
