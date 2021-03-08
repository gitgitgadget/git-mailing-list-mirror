Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC4FC433E0
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 23:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B9A065253
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 23:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbhCHXXE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 18:23:04 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36730 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229471AbhCHXWp (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 8 Mar 2021 18:22:45 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1604760DF4;
        Mon,  8 Mar 2021 23:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1615245734;
        bh=tKCbHS2Dyb8R26b2ac6R06/aMsrEEbYg+IStBoxOm0o=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=OGo0DM9Y6fUjW4h9pxqZsHYNoz0NFWIBgznheLp77332ckGphuo3WrN+34EjJeR6o
         5xoZxOWCKTcoCfgJ8OtuGbuDCko+7gqxXNVLj9DkLZ9JdA+Sy5mYxZ6iRZJPbme8Vr
         Fo/6sORNhWhBMyuwhYWseOnEi2yJj48BbpwYoHwz8yHxoNENwvHT46Ux1nLrUP19yM
         LzagddsmDqXnEpoMsJlRLHgoykbmAYRRGsPxT3YhgAyFI1JXcmEfEy64gLxCxaTXhY
         CbbHurC/zoe86CBefHzFCdrRzc3IUHqMlVjl5T+AoseSdaDAN5h3S0qOHAn0Qhe1tQ
         IA49UfpEV1ChaF4OqXtZytGrjii5t+fL1IyyeL1WgErLdz2SMJEpS7ir/Mc9FlsgsL
         AbFk54YZ+GR8+QfwXjIu5BC4bbWDROP+J3RsbXVJEIwidAa+4/VeBYUdBytuXrDyHa
         7/T1oFm3B3nrCXSJCRQ1ZeXjLinNMqjD0GnA4xK9VfE0RmOs8+V
Date:   Mon, 8 Mar 2021 23:22:10 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, jvusich@amazon.com
Subject: Re: [PATCH] builtin/init-db: handle bare clones when core.bare set
 to false
Message-ID: <YEaxomZIluLVRWEr@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, jvusich@amazon.com
References: <D99DD9AD-54E5-4357-BA50-8B9CAE23084E@amazon.com>
 <20210308131718.546055-1-sandals@crustytoothpaste.net>
 <CAPig+cRoZPg96aSgPoswYf-fz1_1Hxc1NfAER0kUB8Hy00WB9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZSPOHTTQ4E4bpvhv"
Content-Disposition: inline
In-Reply-To: <CAPig+cRoZPg96aSgPoswYf-fz1_1Hxc1NfAER0kUB8Hy00WB9Q@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ZSPOHTTQ4E4bpvhv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-03-08 at 16:43:58, Eric Sunshine wrote:
> On Mon, Mar 8, 2021 at 8:18 AM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > In 552955ed7f ("clone: use more conventional config/option layering",
> > 2020-10-01), clone learned to read configuration options earlier in its
> > execution, before creating the new repository.  However, that led to a
> > problem: if the core.bare setting is set to false in the global config,
> > cloning a bare repository segfaults.  This happens because the
> > repository is falsely thought to be non-bare, but clone has set the work
> > tree to NULL, which is then dereferenced.
> > [...]
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
>=20
> Perhaps this deserves a:
>=20
>     Reported-by: Joseph Vusich <jvusich@amazon.com>

Good point.  Will fix.

> > diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
> > @@ -104,6 +104,13 @@ test_expect_success 'redirected clone -v does show=
 progress' '
> > +test_expect_success 'clone does not segfault with --bare and core.bare=
=3Dfalse' '
> > +       test_config_global core.bare false &&
> > +       git clone --bare "file://$(pwd)/parent" clone-bare &&
>=20
> Can this be done more simply as:
>=20
>     git clone --bare parent clone-bare &&
>=20
> or even:
>=20
>     git clone --bare . clone-bare &&
>=20
> without mucking about with $(pwd)?

Sure.  I pulled the line from the test above, but I agree that's nicer.

> > +       git -C clone-bare rev-parse --is-bare-repository >is-bare &&
> > +       test "$(cat is-bare)" =3D true
>=20
> These days, we'd probably say:
>=20
>     echo true >expect &&
>     git -C clone-bare rev-parse --is-bare-repository >actual &&
>     test_cmp expect actual
>=20
> but it's subjective and minor; not at all worth a re-roll.

There's enough nits to warrant a v2, so I can do one.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--ZSPOHTTQ4E4bpvhv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYEaxoQAKCRB8DEliiIei
gSg6AQCLs8ilf7rGNX3ngjsqO3xrbAGbNBgm8oJnE/7bKr/e7gEAi6R2Mtg320Zw
BZ6ySR5lH0MnhbR3V+LLh/SgJtQnWgU=
=VS2l
-----END PGP SIGNATURE-----

--ZSPOHTTQ4E4bpvhv--
