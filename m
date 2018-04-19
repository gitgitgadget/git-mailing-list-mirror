Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 206B71F404
	for <e@80x24.org>; Thu, 19 Apr 2018 01:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752261AbeDSBZ0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 21:25:26 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57434 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752116AbeDSBZZ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 18 Apr 2018 21:25:25 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3095A60129;
        Thu, 19 Apr 2018 01:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524101124;
        bh=bCNTB30gjMTQLMqqO7M8JvS60zAC9HC8Zy1MZ0Fp5hY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=oKAaBejW4LEm1UlnFBo9MRLtBM6biZuR28HXn1UYcOF2s+LmN2bT6tkKbbjkz5ztB
         /5mq/Oc18QTRa7lcgJn0A+JuYb+xOaL5zoDZBHI9ItwwwwZKZgWf9hK/8WSdfOJHS3
         Sp+ofzGP1V3uMg5jSLRg0V2uXaMsjGtsZjBneV3yKVqmwiT5Q5vKHba9ZYP4Qkl9xs
         MG/HmUHE5R3fROHYYC4vRrLR2mrtsYY73B8wJN+CeEQ8WrwMelKKffj/tZL/S81qbp
         S7lv1tCd0lROkDuIMR6s/Y1LerreFdxRkQxJz2Jk9TwBRbZW+oVP/fr/AT26cMIMg0
         qIHHKs6PrGj47ePO8bbaTL7pM43sBZ4o4O4o3Ub5joyfdZnS0jzX2dP0l5/NdpGK15
         cnImtg8cjXPtB4rhhYMq29HuXkTbx1GeVhJ3wCVLW2GudMJ8BsPq0U89VIPovti9l7
         BFDRMuDZuDRqf6ybIDXKhv+l7dVfWJTkjlxKXOjzbCC5I2nkreX
Date:   Thu, 19 Apr 2018 01:25:17 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] doc: cleaning up instances of \--
Message-ID: <20180419012517.GE14631@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
References: <CAN0heSru4-VoCTxZ6OHU_jdTs0__xvRmd45Dd0H3L8apMKkW6w@mail.gmail.com>
 <cover.1523991648.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Oiv9uiLrevHtW1RS"
Content-Disposition: inline
In-Reply-To: <cover.1523991648.git.martin.agren@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-trunk-amd64)
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Oiv9uiLrevHtW1RS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2018 at 09:15:25PM +0200, Martin =C3=85gren wrote:
> This is a patch series to convert \-- to -- in our documentation. The
> first patch is a reiteration of 1c262bb7b2 (doc: convert \--option to
> --option, 2015-05-13) to fix some instances that have appeared since.
> The other three patches deal with standalone "\--" which we can't
> always turn into "--" since it can be rendered as an em dash.

This series looked sane to me as well.  I appreciate the work to keep
our documentation working in both AsciiDoc and Asciidoctor.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Oiv9uiLrevHtW1RS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrX7/0ACgkQv1NdgR9S
9os2bRAAwAWqcIBTF08uuRxx95tQNrJwl9qz34RJePBiO5eRiajZqKspkOQD7IPF
IGxcMYwBKatAgEYy6FCBevYIK49LFsFSqnK4a6Xe1CfJeIuBMCgdXGYoHyzxXF3C
6Guh6ZEBbLMlo56ug3PdHN+P5XBALLQi3DrCI/RGc83YUEB53p9N4EIJ7AvEsQQ9
rHWh3MB4U5TrmGH9cyMD1aFJEk37rbgHndWj4sxnsPeKYL6/X3/asIJdo2t3+MQK
vie33PXYzhA6OjmS4t8wbnthLOPaDpG/1bd7vqQXZ8/Zh+thBjjLNj1AsBcWLAxg
1wcy5QSXeq+WM1FVWrw7gJiI1jvbuXfas1Hn4DkHz/sApM27V3i7c0Ad5S06o7Es
SIzfyl43nB/+LHxj+QiDowXGbiaaF75bHtbfa/rALAzeG6UtiOQgosGFEEppPts5
txEwjsXvENWKIgAENEQLJqew6UHjdA3gwZcFjL5AQBZ/c6SDGwnWnRj7thcE3oUb
Zskx50/uqORSNJc7zVelA9DSMmwlmwVDYQsX0v0YqhbqRAnqr78qfZx2S7yFHqbp
AREUWnB+vupQ4G0BGudx9yRTL0SITdN0f774b7fvl8zigsyU35dfSvyj7BIPi8Ph
0FV8xVUlrSGtRa/dIbZrSHjY8MNnPW4jRN4tmUqwdNIeWyUu09o=
=3rPq
-----END PGP SIGNATURE-----

--Oiv9uiLrevHtW1RS--
