Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B66E01F462
	for <e@80x24.org>; Mon, 10 Jun 2019 22:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388757AbfFJWJb (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 18:09:31 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60012 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728651AbfFJWJb (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 10 Jun 2019 18:09:31 -0400
Received: from genre.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6959360435;
        Mon, 10 Jun 2019 22:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1560204569;
        bh=AH9BJttAyr6gIAEoajQUVw9CY0ge6UVk4rA99aMnnz8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=hTlC0DJjW0TvwFGVWVjw7DzYGNXeHc3vJ/besj+JbJ6CTADF0BlczDZeLjAbPPtsp
         LPEgUqLggtlUmL9Yp3sqqa625DUWWX0Wm2ejRxyD/ie4r3hZxCxaQH+P/1YLEgqUvU
         e5xwKskWmwNd9ad2zFsd5YOQl3mS/h4BemqCdqcCJYjUDQyv4Nto/+4+vBkz/94idc
         A9VdE7sfEVWldghVq/B6E7g6kjvVJcUy4kRpVsTWDkWrjrXc9P7XLSfyF3Cw/L9Iz7
         t7kdI17rC9IjA66ZGHdiFK7NGXXHHlEfT048g9bHNKDcg297biGxIfk9pqwNXEfSsf
         CPVVpaH3WTaHAL34wfVhoiyhKkRc3PLRV/qFPZWPcqVKPJAfl61aYPWzCOvsj/B4h4
         DQLVTGUZ30BMd2sf7VJQCUj4wciL8fm8mwyH6Kpa7sD1kK+jESKhlW57CBHa119xIF
         KMRAU3qq4GUcvCdZ8VuuvtaD8T22Foq+5M1qU0RQF6Hldn+dmWy
Date:   Mon, 10 Jun 2019 22:09:25 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 03/10] t1450: make hash size independent
Message-ID: <20190610220924.GY8616@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190609224400.41557-1-sandals@crustytoothpaste.net>
 <20190609224400.41557-4-sandals@crustytoothpaste.net>
 <CAPig+cT_457aAXEXYm1ZrFVuLmFeKVaJ7ahf9AmbrWwuoSRKfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j+Rb494BzBd9643b"
Content-Disposition: inline
In-Reply-To: <CAPig+cT_457aAXEXYm1ZrFVuLmFeKVaJ7ahf9AmbrWwuoSRKfQ@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--j+Rb494BzBd9643b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-06-10 at 07:57:18, Eric Sunshine wrote:
> On Sun, Jun 9, 2019 at 6:44 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > Replace several hard-coded full and partial object IDs with variables or
> > computed values.  Create junk data to stuff inside an invalid tree that
> > can be either 20 or 32 bytes long.  Compute a binary all-zeros object ID
> > instead of hard-coding a 20-byte length.
> > [...]
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> > diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> > @@ -9,6 +9,7 @@ test_description=3D'git fsck random collection of tests
> >  test_expect_success setup '
> > +       test_oid_init &&
> >         git config gc.auto 0 &&
> >         git config i18n.commitencoding ISO-8859-1 &&
> >         test_commit A fileA one &&
> > @@ -16,7 +17,8 @@ test_expect_success setup '
> >         git checkout HEAD^0 &&
> >         test_commit B fileB two &&
> >         git tag -d A B &&
> > -       git reflog expire --expire=3Dnow --all
> > +       git reflog expire --expire=3Dnow --all &&
> > +       test_oid_init
> >  '
>=20
> Why does this function call test_oid_init() twice?

Probably because this was a squash of a couple different patches. I'll
reroll with that fixed.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--j+Rb494BzBd9643b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlz+1RQACgkQv1NdgR9S
9osOEBAAxcH/GYTt9v/zF60fD18utWz2AIrtqiXuhmoKAMM0JMogzdU6Y27pFrGE
M/9eCZ1xLJ+jTJfX8gbKA04zdB8VzME875Ws5ZLiAcBEb7qZI/Vl0liFbX78lVf1
764X3fgfLAryoGVNky5hPUwDaDKKUNRmgMD7xY9bZveQ+gOnRAV74TnqFx/XFu3s
RFZ6CLkVeRoCE42wHJpJ70yamMuhkiwIw06b/PObG9Zd1zr+D45Pgy0BVNB22j2f
kriPJNDPPl2NiqC58cyStn239NXkhHMiWRhs0xxodYANEcIv5Yz1BKkV36cbb77G
0kQIed5sUEnm6FG+jMQUl2pSDUumqynEK5MQt5IXVNYR7P1I+k2gkE2+/uWKQfIh
R9vwihrtcl4uz2FOX6gDQvJfs/Ram5zmLeVp0Hdv3wK6UAKhfgeCt6+xHIPFW+8q
s8MkwXTI9EQHQL3uGwF7EMNY3a9vKECaT3VqoekzFjyJPYBZq7eCJ6MDTpKD8j4i
9w56KSuGFM69qlcH/Grm77jPUWVWHbt4+trha6zcESJfWbiY95smjqf3hFBgofI4
rtD88fegqKFOP1AbgjXgqM7KleeEWH17iJ8JPcFeATlLBBSxc0IZ/ZG2bo1iAgnB
CUtbMSIOjuk8OnAkYFjyeMzaZOETpU+eRH+2gxA71kZ0wivQSNo=
=HNxO
-----END PGP SIGNATURE-----

--j+Rb494BzBd9643b--
