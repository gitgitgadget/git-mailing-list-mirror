Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6590D1F954
	for <e@80x24.org>; Sun, 19 Aug 2018 21:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbeHTBKg (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 21:10:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55340 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726349AbeHTBKg (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Aug 2018 21:10:36 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6E3016047A;
        Sun, 19 Aug 2018 21:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1534715856;
        bh=tU8avw+VEaQoL31Ipf1NqH0mkVMrmlInH9sP3NlnNgY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=LAO8xXC6+NfDUhOrT9/Yw1vp1zkanK7dWUnoD/HctXgysRxumkDyBqHve+CuXrl+4
         kujBLwDFuvMQBp7PVMyfnK27qUAJL9DMZzQbPH0qrFN7atkR241iP8nqFD7ZOoZkrD
         IFLfQkbC8ap/RbD0zV2E36uC4p5mJW1aY6CdrJn6Ll4YVBtG5fQ8yjve1ME/vdwm9s
         0qfCoHvIgSfPjk5fvxsh0RART6O0R5VVjZ9sN7ca96wZThP35mIgfEBWWMGkHgNReu
         z2sYOHzBCZDO2mSjm2JBSjEHzCoGQd0e7FM8ZOpDZc6Z/uQfIPonkG0NHFkYvSIQRj
         PUXFcacSIo6Mq+PdFx2xa2rzcy+lhM6x2y8AMOE0KW/0iqsFtcAJId4vCdHe6dPHaX
         NgDMH3Ze1NbbobkRhce9sMdKKuytStjDUPziVOOC3Z//tdfNhTEDNPhpejWEIemk6s
         adupnhWIqyQhFwrhk1exvYUbBSaFlAGCzuVK6jpvAq8MAmKMrjG
Date:   Sun, 19 Aug 2018 21:57:32 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 05/11] t0027: make hash size independent'
Message-ID: <20180819215732.GJ70480@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
References: <20180819175351.449973-1-sandals@crustytoothpaste.net>
 <20180819175351.449973-6-sandals@crustytoothpaste.net>
 <CAPig+cS6Z+U-Z26m-eW-JX5D29ONSb_Zzur2fvWGb_ZMbmF4UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yr6OvWOSyJed8q4v"
Content-Disposition: inline
In-Reply-To: <CAPig+cS6Z+U-Z26m-eW-JX5D29ONSb_Zzur2fvWGb_ZMbmF4UQ@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--yr6OvWOSyJed8q4v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 19, 2018 at 04:10:21PM -0400, Eric Sunshine wrote:
> On Sun, Aug 19, 2018 at 1:54 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > We transform various object IDs into all-zero object IDs for comparison.
> > Adjust the length as well so that this works for all hash algorithms.
> >
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> > diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> > @@ -15,8 +15,9 @@ compare_ws_file () {
> > -       tr '\015\000abcdef0123456789' QN00000000000000000 <"$2" >"$exp"=
 &&
> > +       tr '\015\000abcdef0123456789' QN00000000000000000 <"$2" >"$exp+=
" &&
>=20
> My immediate thought upon reading this was whether "+" is valid in
> Windows filenames. Apparently, it is, but perhaps (if you re-roll) it
> would make sense to use a character less likely to cause brain
> hiccups; for instance, "exp0'.

The reason I picked that is that we use it quite a bit in the Makefile,
so it seemed like an obvious choice for a temporary file name.  If you
feel strongly I can pick something else, but I thought it would be
reasonably intuitive for other developers.  Maybe I was wrong, though.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--yr6OvWOSyJed8q4v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlt558wACgkQv1NdgR9S
9ouKjw/7Bh7C8VCr4hmFK4RBFYFY+0RnCdVGdcqL1YQXD3TQpNMAuk+Cf/Dit3OY
RCWKvZ+p7yUfNmLlZdjpD6SGgh/Q/40AGOuIwfh0ZGEzQiRj2FZaoaHWMmlrfLs1
bzMTwUjDzOwPcp0jR25F1DLFBPPBe4nrlO7BdCL0MnW6bf0AtB4mNhDUxcnXcQjq
cMg1wY7KJ9AC/ohu0AmUjK4ax9ZhQPU9UMxTnzuVfVjUWA+OXXU0DF1rACaVT2VW
Pc/z0bcwPM7UKdVFTziTaFhFci8FuJskQC/+ObFmR6CMfMhjtOIQy/eywpzff93D
4cOp4VhnlS1lWeuMBOo4K+tK5SNv0OAJRjo0TZ9Xucv5t9OZdi3slQtASojdrkyo
r6I/hMofhnqWXD3MbAcE/Nl5mYqIDxjqySKQtNfS8xfrtMBL8lrxY/n0YIZnXi1K
/orQsf7LE/109WQdo3dMps5/2n7t8osVfwlkGVut/p4mReoagSwcrzSKAUNvGkL7
CiGuyjW6d6mccBzi1ZvQ3AIpqxspNUZGhnDmPUIMLcF7MWFsxG24Yrd6WMjdAJwM
IWkdotuJaYjm3gT+SYzKW3/JDWR5pNCvHU043vBs2xwZ939jG893/zpBQcffExwf
FaTHk2ipNGGY5n+qpParWGnOiThiUpkXnKj27ImIPANDMTZQjFw=
=6N5Z
-----END PGP SIGNATURE-----

--yr6OvWOSyJed8q4v--
