Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA2D41F42B
	for <e@80x24.org>; Sat, 11 Nov 2017 00:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754185AbdKKAdC (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 19:33:02 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55922 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754072AbdKKAdB (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Nov 2017 19:33:01 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 91B9F604A0;
        Sat, 11 Nov 2017 00:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1510360378;
        bh=AsOTZXTQnR1R/YjZWEibHk1JOIifW7tdFLKoKy/aN94=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=vBPdKkM/OpeJqpURzZaqV0Q0iQhLDGHFipTHrWSK86hv+LhhnZTfs4Sf4MQHxlkkN
         TtK0AeSjvjsGdfbgFRqapZhZTySesCQKnIcMQzannhrTyehq5eO2Vwm5cEte24kDbD
         ulooEFPXXGFXNrEBp/lDvNPBjT/MZQ5zUSj8/BepcqNiHpHcH6zX4OI7dUdhAS+ou0
         Xdfc7hjV/0V6yPDKYD9Ucw9Yf5tJFGWMFhkhLIayttg62ucvRYwRx0bPwK6t6GLRR0
         k+TynHur+c22P+AkeC5zU8Tt+07F4TP0jNBmDS5QGR07GVl9CSbK1dpX30anyDwbsT
         dn8hH9CXUWcUY6f1Y0qdKOZvM5fkz17G3Sz99XXoldDm/0lQ7TZ+KmaLhLltHoP5uJ
         /VOc/zo89GERH39IVASzkGeUS8VbYVS3BB6GNjgTMcYUCho4+oA8RajaVGyO54dXfd
         ENJ2C1BW3AiydKP6TUBLpk6RxuzIrXGooIdJUdnG2GZ5+QfyW6a
Date:   Sat, 11 Nov 2017 00:32:52 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2017, #03; Wed, 8)
Message-ID: <20171111003252.qbslnl4rs6655q7g@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqinell3of.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r2ykiuztmot2ow4d"
Content-Disposition: inline
In-Reply-To: <xmqqinell3of.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.12.0-2-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--r2ykiuztmot2ow4d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2017 at 02:50:24PM +0900, Junio C Hamano wrote:
> * bc/submitting-patches-in-asciidoc (2017-10-30) 2 commits
>  - Documentation: convert SubmittingPatches to AsciiDoc
>  - Documentation: enable compat-mode for Asciidoctor
>=20
>  The SubmittingPatches document has been converted to produce an
>  HTML version via AsciiDoc/Asciidoctor.
>=20
>  Any further comments?  Otherwise, will merge to 'next'.

I think you had wanted some changes, so let me send out a fixed series.

> * bc/hash-algo (2017-10-30) 4 commits
>  - Switch empty tree and blob lookups to use hash abstraction
>  - Integrate hash algorithm support with repo setup
>  - Add structure representing hash algorithm
>  - setup: expose enumerated repo info
>=20
>  An infrastructure to define what hash function is used in Git is
>  introduced, and an effort to plumb that throughout various
>  codepaths has been started.
>=20
>  cf. <20171028181239.59458-1-sandals@crustytoothpaste.net>

I'll be rerolling this as well.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--r2ykiuztmot2ow4d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.2 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAloGRTQACgkQv1NdgR9S
9ossIxAAmzwBoRlVFmy3jmJ4LqwqFdjjpDO6BNHTCTC+4xry7kuDMSPC50vurjbR
tVVOgX5vHKtIa+hq2a6+f1SItFidi7Zq548LDniaOCB6exjuLKekjxacWNIrzS0+
tS3HCQNIsDbW/wcaPx9qK+A6eXDCcEaGdKB7tGcXn+eNvivlTEgEa+ndnyXP+nz5
n0vAvmjqFJvYm3mLDW4CZkTrb8gLsOavkKtlWBsDuq3HaassHB21bveW6Zu3f44G
XOdJqIE58VP3VCjBmQMNSMn3OXolVFlsgfx/hMrTqSgPaeGEUumDgMZhlAdf6iEO
xgHyj3kmGGnv6/J+y6FxPUqzCrTd6V1/jnvtjeLpMPuNqw00CNmhEH532YsludwN
c3Up2fXmpWv3OvOiv8hBq/y/oltDDXmxvhwB5d0qORzjT92dF8kI80vM5KFkOsbC
r9gL4jbqQZEQ6xyZ1AB+fWLFhG4RGbuMo16AnUUR1ROvs9+MZzu0Uk3FoZ0rm6v3
lKnV6CuEcdLdFZB/gUK7y0kQT6oHKVVSe+whTAedJnqJWFJjdKEHdgyXqAobpxAO
8iMmUVdaDc6KfXeeFd0qFk+w9H2UYZszdc1i9Jp5plD5nlooohf6N7Nf3DRKF6hw
p/q559zp0H4lz+yUGBnQiMQWvxRFSeNb2t8b+F/b/x9DuNUiOJA=
=juPG
-----END PGP SIGNATURE-----

--r2ykiuztmot2ow4d--
