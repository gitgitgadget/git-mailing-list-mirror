Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3395420248
	for <e@80x24.org>; Thu, 28 Feb 2019 23:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbfB1Xu1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 18:50:27 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35076 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725955AbfB1Xu0 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 28 Feb 2019 18:50:26 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:a4e9:9ba4:4fd2:4493])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 12F2B60429;
        Thu, 28 Feb 2019 23:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1551397823;
        bh=PqM2oXzljOtaEjDNWHhXOacy3xQJ7ZZP3FhC6mV4vRM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=smxpECPuFTLQPhhmsbdQQr6vqBbMePNzS1PycLurhLLZYVXKbrrMNYfNPVCFbhcDa
         c4n05lHsYemlBEu2EjoALWxJJbpvLzTZhCsMDrv1S6GVEEZKRCIOL8YhVdtsBh0uW1
         QNVAJlPPr/ZUWKRGXn0dbsd1TxaKngx4NiiSviwIT36KVqrlU7TSf/NZ0f1PPLzVSQ
         mMc1VXrAa/3waZNfyGSD6fuXrpVQHsGduLlyVZsMD2x3p64TdXBVUsreFnRFl+om0n
         l0ivKr/kwtKa0rmIlm2me3gsVUocb8tokVaRQ6hdyb/OQ+LjJ2zR81ziOCJ8UvkHZK
         BU4CKuLnlmVVwqjbOeRwB83+UK/huDb5hsJvDWL38neP04YPUTuusoSsYliSdQTzfF
         jTi70iOH+5WX64kOIXOCAFupMUknP7XSbZrSSwrVcvJC8/p/Tios3J0lE+3TXbFOyY
         M3vRmFugTFW6mkTUmCEXlNa+NEDrHR7IGfHIFCgrsRfq34T31/L
Date:   Thu, 28 Feb 2019 23:50:18 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/3] asciidoctor-extensions: fix spurious space after
 linkgit
Message-ID: <20190228235018.GE601925@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
References: <CAN0heSqLbn7dRu4eARpyMqhFYpj3Pr5i=EMPnQZK9hUfWmf-KQ@mail.gmail.com>
 <cover.1551290936.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a1QUDc0q7S3U7/Jg"
Content-Disposition: inline
In-Reply-To: <cover.1551290936.git.martin.agren@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--a1QUDc0q7S3U7/Jg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 27, 2019 at 07:17:51PM +0100, Martin =C3=85gren wrote:
> Just like v1 [1], this v2 removes a spurious space which shows up in a
> large number of places in our manpages when Asciidoctor expands the
> linkgit:foo[bar] macro. The only difference is a new paragraph in the
> commit message of the first patch to explain why we need to explicitly
> list a file we depend on.
>=20
> Thanks Eric and brian for your comments on v1.
>=20
> [1] https://public-inbox.org/git/cover.1551123979.git.martin.agren@gmail.=
com/
>=20
> Martin =C3=85gren (3):
>   Documentation/Makefile: add missing xsl dependencies for manpages
>   Documentation/Makefile: add missing dependency on
>     asciidoctor-extensions
>   asciidoctor-extensions: fix spurious space after linkgit
>=20
>  Documentation/Makefile                  | 4 ++--
>  Documentation/asciidoctor-extensions.rb | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

This version looks good to me. Thanks again for getting this cleaned up.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--a1QUDc0q7S3U7/Jg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlx4c7oACgkQv1NdgR9S
9ov7Lg/+M5/tgYV8i+W6vViNM/ROB/H8cWEfZvea/JVfpoF9VVJJzG8g4h8Y9p/S
AUduna0A8C9doe8YTpVyeCCSoBD6IkbOBaCLtQHUsWUI3srNKhM9H/gNZJs5yIxd
pD2HrxjKi+kHd1Spo9iAwmc0T8DLtFSMOLfC7k3v4laEP6bLpbMgLpzKLvB7e5Ho
pHmqy/ZnybrpYG9MeUUKm5fTTksVZNnDX4N0YiC9RZMSq6qjPaY2hkDdOvhnC266
SI/R1cpiQ0e38sCYSB9MelEVeaciFCSmS5tLjD+wmn+xJ5oqzsc0DuDj+445GL7l
kU6kpSIt+B/cgmSXrTnZvdmGceI54kHMBp7BNDF+Khtx/tGAM2asYh+bl0VbM4dB
MoyQtyzRnFMd2Fl9uxer7QOxZbUm3YNYdHD9OR4/S9cgYzROIxKCjwGqDYlF3wsm
yRZRQEThraHVOeo5JO2/qA+vkebC+TxNYiakT+9xt3Hs8wlBalgnGqwAluinp9NI
gJU28WgkuCqyipA36BINgUCRKL3vWsofaS3tKYlLVSh0jDeHXKB6OJK3HR/fLhp+
W85afpftFZSRhbEEApFt82yZ7QBi5DTULQYUdrLJ5AmmJ4HTIIO6rX2hQnlXwmKA
AJSVRBuX5dIhVKBwXjDXU6LhIOofL6esehiLrWwTUmvMTXLr5Rs=
=Dz9h
-----END PGP SIGNATURE-----

--a1QUDc0q7S3U7/Jg--
