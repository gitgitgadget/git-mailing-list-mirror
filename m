Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E71991F461
	for <e@80x24.org>; Fri,  6 Sep 2019 23:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405441AbfIFX34 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 19:29:56 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58558 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392731AbfIFX3z (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Sep 2019 19:29:55 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:6959:e43b:5cf6:a465])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 557AA60459;
        Fri,  6 Sep 2019 23:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1567812593;
        bh=vM+NdEtmY1/uqR1u6nEl9Dtt/72vNKjEGoTEcwkfFdQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=eOix6CPOK/8YtJWck/dIWRyOJTW/3VPwXMWsxPNSCK9ii3pY9oMpmYfv+H4V59Q6s
         LWVnudi8DbBSgWfP1ib38w4M43v+hMrSy/CAgMOn4VQqYW9MTbJiAhMkaoZ0CO59iM
         lYSfOMM5Tsh72qQklfoMZSSleqZ6qKgZ13fSo+LiDy8yph7WGG82Zw8c3VoAYG33Hm
         vri49s5LOkNxJl9e9q6/pGwCDOSX8nZQRQT6DMdd/Ek7lp+DhU1b96F3H8E5dHcP2r
         2XYw6ku1FmINgGqNlnOm7lk9AQEX/O2fAhwoqsop+8tDRGZ4nTZ9y2ANGFbUJBcoT1
         vcGo8YODYIo2pW7kw+wFx37VsN7GGIBhT//mYvrWeI8RYt8mlpEywCDM/D1qKHue4Q
         9QD+djW81ajaHCJMHt7FDsi+9KeaaiLnISc+lb5ODdPgITMAuRmq1b9u4MWTix8+Wd
         vw+jqEonMv0LmR3LigPxOhb0Qu0KVFHKOXB+JWdFhQ0U7yx4SpY
Date:   Fri, 6 Sep 2019 23:29:47 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Todd Zullinger <tmz@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] asciidoctor-extensions: provide `<refmiscinfo/>`
Message-ID: <20190906232947.GJ11334@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Todd Zullinger <tmz@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <CAN0heSr2zCQMM6wOM0UnD28qj_VygQ5CQHGHhMR9+H23snpt5Q@mail.gmail.com>
 <cover.1567534373.git.martin.agren@gmail.com>
 <20190904032609.GD28836@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pMCBjikF2xGw87uL"
Content-Disposition: inline
In-Reply-To: <20190904032609.GD28836@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--pMCBjikF2xGw87uL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-04 at 03:26:10, Jeff King wrote:
> On Tue, Sep 03, 2019 at 08:51:19PM +0200, Martin =C3=85gren wrote:
> > When I posted v1, it turned into quite a thread [1] on AsciiDoc vs
> > Asciidoctor vs Asciidoctor 2.0 and differences in rendering. (I am on
> > Asciidoctor 1.5.5.)
>=20
> Yes, sadly I still can't format the docs at all with 2.0.10 (which is
> what ships in Debian unstable).

I'll look into this.  I requested the upgrade in sid.

If it's the lack of DocBook 4.5 support, then I'll probably need to
patch xmlto for that.  DocBook 5 has been around for a decade now, so
it's time for xmlto to support it properly.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--pMCBjikF2xGw87uL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1y6+sACgkQv1NdgR9S
9otw+xAAxXri3RQXioMgMTGthDkWP/edEiVzkbrTpm8WXPYLRjjXlnDpGGs8mdev
s/FOkhcA1KdJl3w6yK3aY59l2afwquFJdDQM7RcSlpCp7311aerJdpDjLE+hx2ZT
9SUag9QE3MfXJNGpFVkD1i1eNDqSXLfeYPSbI1iymxQ2ZdNE6M74+vfBekWHJOMt
Xk80KvuEH77q3QHCqStATAR/ptADGX8Gr9UnW5CZPadgBh7bzhuk3c9uI8fom0QO
aM5vl4I8QimLgOEkIYQq+u9PVqEK2XcvTY91kV6Zqmjc/FrmSJ3IGXPyBxEkGIYc
zmJrDusgcq6o8Y3YeFSHuyusQof9tbhlfE1uCMHon7Im/oqV6bKQQpDPii4KDycb
oxaPx/Wc8lulfWN+fmr6C6d92vMDGL8P0S/5ZINSYVWA9KewRYm8KePAXjpPsCSZ
XSe99CabjDab/o0qpuQdgB8ECAWfl55Pm2Cwnvo38kJicFriGmY5aGUBvjfuBx3t
f0Y3ND8tgT/x7480sBcGuTlcWYByDV4XnQx+cpEF/Aom7IZyDXFWvwjbw73WI5DZ
9YvPTNJ09zKeaUBbhQ8IyqtWHaS6FCobGWHVyLBy9lRDwMwfVbUW04PcvzLoJl4m
RKd7InM8FYZM2OGmVaZ5j9MiM2WR/GmPJ0l1ae3QAhnzclpZWr8=
=ypmr
-----END PGP SIGNATURE-----

--pMCBjikF2xGw87uL--
