Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C0361F453
	for <e@80x24.org>; Thu,  8 Nov 2018 01:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbeKHKvS (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 05:51:18 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:53398 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728164AbeKHKvS (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 8 Nov 2018 05:51:18 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:941b:b2ff:ecfe:7f28])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AE02A6077B;
        Thu,  8 Nov 2018 01:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1541639898;
        bh=A4hRsSNoiiORxVfqmRVRCEYMBPIc+wOepMvNeMI6fG4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=SGof9V0fU/l5QELEHzECCJXTsqNklAzQJ27Bk5rfbAsjBE7tAlWcTKoWh/LPX1UP5
         sHbsp/+mE3RhWgbU8Cgsjws4qZ+r37HEgh/Af/2dm7dzF1jbzDs6U/B7O0HQiDzt3B
         RWFEaElQuaqX4tU5mqyI8+gvzQUpx14yTWOvVi4enxucqzKTX/VlpCOi04mYzF+T7B
         la1lyZ//n8AFwWPMZ+PIi/pex6YHt3O598kdd6MkyT0CBD5u3UFxLBlJg4B10sHFJn
         vGf8253lEuzHLE3qUrVvAEKC5xddh8OKFq68MR9tvwIpDFjahEdDsw42fKv+ocHaHN
         2a0ZwMiHo+H2q1VyRqAqZ1lGbj7vrYbSedZlYzNYil0wNhPi8M20PJfEr9N/FC87Bl
         /cXXyAeA2qCRQ2YB0kTH6NSzmct4mQB/DNwJhe9jXljQysMFCHiDo1sm6epGSRJSxm
         yni9EAkQfDBCpsQjzmdV+EdgbURFfNI3gM2WGU8id1QSLCZz4x4
Date:   Thu, 8 Nov 2018 01:18:13 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Daniel Stenberg <daniel@haxx.se>
Cc:     "Force.Charlie-I via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] http: add support selecting http version
Message-ID: <20181108011813.GE890086@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Daniel Stenberg <daniel@haxx.se>,
        "Force.Charlie-I via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.69.git.gitgitgadget@gmail.com>
 <alpine.DEB.2.20.1811071443130.3368@tvnag.unkk.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X3gaHHMYHkYqP6yf"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1811071443130.3368@tvnag.unkk.fr>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--X3gaHHMYHkYqP6yf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 07, 2018 at 02:44:51PM +0100, Daniel Stenberg wrote:
> On Wed, 7 Nov 2018, Force.Charlie-I via GitGitGadget wrote:
>=20
> > Normally, git doesn't need to set curl to select the HTTP version, it
> > works fine without HTTP2. Adding HTTP2 support is a icing on the cake.
>=20
> Just a FYI:
>=20
> Starting with libcurl 7.62.0 (released a week ago), it now defaults to the
> "2TLS" setting unless you tell it otherwise. With 2TLS, libcurl will atte=
mpt
> to use HTTP/2 for HTTPS URLs.

With this information, I think I would rather we rely on libcurl to do
this rather than putting it in Git.  Users will automatically get the
best supported protocol instead of having to configure it manually.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--X3gaHHMYHkYqP6yf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvjjtQACgkQv1NdgR9S
9ovohA//RuI/N8Y+kw+V789GgoEBTS0SEBbW3ZAEVQ0Ll+50RKN4zhoxmDVoaQTO
c/7xahM7V7htrvOYewsMD5/hY/tIbpHomaoJiuuZtgLGW2D253U+f7qxIY0hJbmc
aVjKPSbWDvcrowlJn41WJ8RVUw38xOoicBPMoBXn+2wqKxWUZVVLOQOqMAMl4SkB
VVyxujYXCz9yzjoYlIfAUTT+Z8jv5RYa0YQSqPH2KuqPuk7PPsMbI3ft7ZEFomRZ
ltKobAlzmT+QvVogzRax+jIOtQhCxGoY6WPSL4vPnsZwXFBflocNrykdOuAEqNtL
veHMToNWYPrML+KcPH5pNCw1lalWwAGYDK4LGo5E7AKIXz6OtM64/y5KezXhy3IS
d2KTRrv45ApFDPjbpsX3EWldUW/X8bG6ZivMDhWIiYGLjDAgyC3UEAqf/XbJvGxM
JBdg/P9SeQd3nNvJYW7CyRjlrxylFw7dt74F7GgCcfyCZ4a8+CESEroRlPHhSTI0
wstX4lzpobgVlxgRLsSvLgcnP/LAND7Gh6f0hNMNFsag4wm4V285iSaXCBG2iDeS
YjoVxqD3St8UOVHo203ghXQ7aT4em8+r8c2LtlxP5Ufgagyu/8ocvObYwVws8Iqs
3TBCysy7xpOJPxHNaUeASt4YVwg/CIIU4VwzMqUXmPUeBctliBs=
=WYeV
-----END PGP SIGNATURE-----

--X3gaHHMYHkYqP6yf--
