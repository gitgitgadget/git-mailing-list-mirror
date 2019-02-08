Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D433F211B5
	for <e@80x24.org>; Fri,  8 Feb 2019 22:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfBHWHY (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 17:07:24 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33928 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726788AbfBHWHY (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Feb 2019 17:07:24 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:d42:63e7:5548:1ee8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5907F60737;
        Fri,  8 Feb 2019 22:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549663640;
        bh=5adUPoDBIWRM1JiacerL8cpkPybADcWXw8OxBrwwG2g=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=o27cQuAMM86VnKSQlH0Eh3aAK/qCZjvKypLcUVKlxtA9oIHtmgVTMJGZr1CE2LeTe
         ZGhwQDUITrqITcoFuRHbcflQ+w9m0PT5DwHHIbksYv80ryrfskZvYDU3YxVXDambKD
         BUNf40X4f/xpNHm+IaIAtKt4rzYjSKI2oCQb+vjENpdez5lNwCEkUr+ufwe5Ng/PHe
         MJf0ZSaI5f7qzbW/b+eV+RJJHfEeQC1KEzaUZO1FNSQFkV/GxFG2/GVMm0Olt7dXrt
         UQTnbANGS8PUly5VSIzgBT/Y+ZJa3S7qtUZ6LXLp04VN+i21s0p4177GD8n1qzfIbM
         SZhW8BtKFGNLOEcFdaMsibdQrZvVkepdwspwoxQeFZVBiQEFV7Afa/IqC3OHHX6AR5
         Bf8rvfmsqJVzXT30ebcvlGZeOnn0J9gn3+XJluFhqjNXe4bkzbEEWwhBmIQAyRDcjx
         EtiH6/KVFKELVXxIxax6hskW1++68eD7XN+S8PeG/pMEOoDLVOx
Date:   Fri, 8 Feb 2019 22:07:15 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
        'Linux Kernel' <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [Breakage] Git v2.21.0-rc0 - t5318 (NonStop)
Message-ID: <20190208220714.GG11927@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
        'Linux Kernel' <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
References: <000f01d4bf9e$a508eab0$ef1ac010$@nexbridge.com>
 <20190208165052.GC23461@sigill.intra.peff.net>
 <001101d4bfd6$b9430230$2bc90690$@nexbridge.com>
 <20190208180321.GB27673@sigill.intra.peff.net>
 <002501d4bfde$b26e6050$174b20f0$@nexbridge.com>
 <20190208191519.GF27673@sigill.intra.peff.net>
 <002b01d4bfe4$2d617f40$88247dc0$@nexbridge.com>
 <20190208193157.GA30952@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IuhbYIxU28t+Kd57"
Content-Disposition: inline
In-Reply-To: <20190208193157.GA30952@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--IuhbYIxU28t+Kd57
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 08, 2019 at 02:31:57PM -0500, Jeff King wrote:
> > It is available AFAIK on Linux, POSIX, and Windows under Cygwin.
> > That's more than /dev/zero has anyway. I have the patch ready if you
> > want it.
>=20
> Is it POSIX? Certainly truncate() is, but I didn't think the
> command-line tool was. If it really is available everywhere, then yeah,
> I'd be fine with it.

It's not. POSIX doesn't specify the command, and macOS lacks it, I
believe.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--IuhbYIxU28t+Kd57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxd/ZIACgkQv1NdgR9S
9ouCDBAApLzPOIF4gTaK4cvn3e/ADxolMXZ5sRX67D0Zv+bJFf1HLo/T0k+nv/fE
X/DrzNxTSpmXoHdYJQr2LEjfWHPKhgZhfJ1eiEUwyPhfAGMgT9/wrcB6ZJ8A15fP
CLZH7UpKcq/HuUEOP18l5QiA20fpX1o42DIlvFvX4H840uCwF05SpxE8Od5izr9Z
sVs3G7Zdo5fO0QmkpiToZpIRBN0I109JS0mbhS8lCz2Fvg4lm8VcxqsNOC9127BQ
dpUMUBiTzrMgxfePMq7m3LljBgdlRS7AE/MjMmMHSFTSeT4WXTkwkfK6gAFFsTEU
SUbK4CkfR4RL/v1CZjwMrgZCCyydiwbPBiMWb8pq3Zpay+55UqrWfUiJeTpmBfEd
MGzQKHtYUQYzdRsGg59Enkt+4Zdpc5K/Z0AmTUAvpu3r1gu7EWRx62TXc7xFDeKO
tgNpRf77UHKSoiJbvH74hHAbidKHkMLcPxwt2p0w1X8Dvq3vI3IGYjFgoPmTg3in
FTUr7wBmYj0QrVwbpXEPMqU0WmV8nQwZoMMZPSCGRjDnE0RRiUAv74rLuXvy+CRE
cqjKEfpP1cgyVNepTz9a1oJzBREOQBr3AGwrQVjvvz1JuF3z5XCUUaQ0cJWQlQTs
KVpOKJEkiosY7Ngnz6yWsx9eivC7M3OUgHfS+e3trwkL+SfBLHs=
=kUFU
-----END PGP SIGNATURE-----

--IuhbYIxU28t+Kd57--
