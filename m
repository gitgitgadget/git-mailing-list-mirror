Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1DDC433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 01:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A1A560EE7
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 01:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbhITB16 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 21:27:58 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43998 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230053AbhITB16 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Sep 2021 21:27:58 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 66B646044D;
        Mon, 20 Sep 2021 01:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1632101161;
        bh=C4U/b1jC8TKOxrIly/CShIjrVPvdSsrSctsoVpyGoE0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=v9kPZ8Wagjx3Rd2gJT4sojOv8nxoYFMk2nOpBeoqsyPHU5XqkFT/ubYNs/MB8rDMZ
         v4LgYJ0MvKwI2A1HK4MJhzfxSW9/m3epWVn/tn7xsRvK3+g+Sb7eYhT1/8qB/WpwWm
         jD5kH0DOyOSf7SeEQcyLZQ1CsZGsAMzwRIJML6PTX6O/fnVdVxdHuPEgFgl73RBX/p
         vLjrj8WDpVU5rFjPfsbLpKwKnjfgln8F8tVRXKfRxlzqOeZMw/PHkGx5vLlvzGMjsY
         TmAM795ryr5YUB7eEwyDvjF01gSF7xSGct3r4M9jLyWt0fjcOtLD5y3tFDFxwhqjMb
         d9zVB4kHUgUlvOfiN4wM+MgGakyfoMV3RxF/Khh34fyY5gLzJPBWQR+trua8aWV3r7
         4D9Sl7sD+UTeXO1nCagQJjBze2RIce3FBF+4W8BGR0HuXc3DeUfULGMXCyNQdANlZ2
         mv1DmLrFI7fInKpACpdj5Q+2w9mnuNupxfmsIXc6i9dVolF7N7k
Date:   Mon, 20 Sep 2021 01:25:54 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net,
        jnareb@gmail.com, pclouds@gmail.com, carenas@gmail.com,
        avarab@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 3/6] commit-graph: turn on commit-graph by default
Message-ID: <YUfjIjgk2IwcJNI8@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net,
        jnareb@gmail.com, pclouds@gmail.com, carenas@gmail.com,
        avarab@gmail.com, Derrick Stolee <dstolee@microsoft.com>
References: <pull.292.v3.git.gitgitgadget@gmail.com>
 <pull.292.v4.git.gitgitgadget@gmail.com>
 <651e2d526b2a3f6c63c64cfe1f049eef94d39c07.1565721461.git.gitgitgadget@gmail.com>
 <xmqq8rzsdqlq.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5s7j4Fz6688k7IB7"
Content-Disposition: inline
In-Reply-To: <xmqq8rzsdqlq.fsf@gitster.g>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5s7j4Fz6688k7IB7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-09-20 at 00:42:57, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
> > diff --git a/repo-settings.c b/repo-settings.c
> > index 309577f6bc..d00b675687 100644
> > --- a/repo-settings.c
> > +++ b/repo-settings.c
> > @@ -2,6 +2,8 @@
> >  #include "config.h"
> >  #include "repository.h"
> > =20
> > +#define UPDATE_DEFAULT_BOOL(s,v) do { if (s =3D=3D -1) { s =3D v; } } =
while(0)
> > +
> >  void prepare_repo_settings(struct repository *r)
> >  {
> >  	int value;
> > @@ -16,6 +18,8 @@ void prepare_repo_settings(struct repository *r)
> >  		r->settings.core_commit_graph =3D value;
> >  	if (!repo_config_get_bool(r, "gc.writecommitgraph", &value))
> >  		r->settings.gc_write_commit_graph =3D value;
> > +	UPDATE_DEFAULT_BOOL(r->settings.core_commit_graph, 1);
> > +	UPDATE_DEFAULT_BOOL(r->settings.gc_write_commit_graph, 1);
>=20
>=20
> This is a "review comment" that is more than 2 years late X-<, but I
> noticed that this is used to muck with a structure that was
> initialized by filling it with \0377 bytes.
>=20
> +           /* Defaults */
> +           memset(&r->settings, -1, sizeof(r->settings));
>=20
> but the structure is is full of "int" and "enum", so apparently this
> works only on 2's complement architecture.

This statement is true, but are there systems capable of running Git
which don't use two's complement?  Rust requires two's complement signed
integers, and there's a proposal[0] to the C++ working group to only
support two's complement because "[t]o the author=E2=80=99s knowledge no mo=
dern
machine uses both C++ and a signed integer representation other than
two=E2=80=99s complement".  That proposal goes on to note that none of MSVC,
GCC, or LLVM support other options.

Personally I am not aware of any modern processor which provides signed
integer types using other than two's complement.

[0] http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2018/p0907r4.html
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--5s7j4Fz6688k7IB7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYUfjIAAKCRB8DEliiIei
gYVvAP9j8xao1G9SV14eHk8QWj8yHhZIXo7aLn2ZvbegtYgxSgD+Ibmo1ud/ywED
G7idr/EMPu1ji0NudbVHkrlVPdYd4AA=
=NrBC
-----END PGP SIGNATURE-----

--5s7j4Fz6688k7IB7--
