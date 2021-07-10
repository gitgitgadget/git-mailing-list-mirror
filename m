Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9E4C07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 21:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CDA26128D
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 21:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhGJV5n (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 17:57:43 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39150 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229515AbhGJV5n (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 10 Jul 2021 17:57:43 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 207A86044E;
        Sat, 10 Jul 2021 21:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1625954067;
        bh=Co2ANaJG8Dni+k0EfciGPRwCR+Z2GI2wS2FGKhZL5Do=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=sZe1XmHKSewViRLgqChKX0R/wqe8o/4gqtEALPKTWfXrLMe0wb7rnc5MNJA4tEMyT
         WXCH12gOqnkSg3/oUEgq0tXpSo10i+pVCsj+j0iUSTRt3ExDHrspYySbxvKFuB3JHu
         p9vCJteDR8EeZfgX3rvMj0tX6OzPGKLepppt0SjTncZkZypu5D4tnI2JoygXZnFukV
         wQ4wgNZfvhTqttcI1C3yoCcC8Ur9W5imnZ4hElO1Czpmz10sHOMYiPJBBTYkp4YaIu
         yq+cr6ASQ11ERmKBRjSQq07IoWijV1qNDvM1AWul41+CQQIFIuY+ikc7tg3rkeJqxH
         GU2SThnAIokyyHZ25r8KoiEPk82NwBjr5X4oWSVfLIj0QtPijVi+GDxvBgvTTsD4X5
         jpjkacxEpkDHRNIyhb6yff7pu/ckjhB3KQh+PiSreT8p90YdLsvStcCs9YnZ6uT4FT
         Vr2cP22fRDt400bOi1kRW7UwDV9QGyM7JMyRer6wvuN1QER4N8k
Date:   Sat, 10 Jul 2021 21:54:16 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH] revision: allow pseudo options after --end-of-options
Message-ID: <YOoXCJV2ssef/KsN@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jiang Xin <worldhello.net@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
References: <20210708150316.10855-1-worldhello.net@gmail.com>
 <YOcvaFL7+6qcIOUa@camp.crustytoothpaste.net>
 <CANYiYbGYzbMoU_2wb4duppASoYUjGLsJsr692Xe3GaVBOXUsBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xOzyhRrDkcHzmFDF"
Content-Disposition: inline
In-Reply-To: <CANYiYbGYzbMoU_2wb4duppASoYUjGLsJsr692Xe3GaVBOXUsBA@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xOzyhRrDkcHzmFDF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-07-09 at 01:33:23, Jiang Xin wrote:
> New test case in t6000 covered this case. Branch "--output=3Dyikes"
> which starts with a dash is used as revision after the option
> "--end-of-options", and it won't be interpreted as an option.
>=20
>     test_expect_success 'parse pseudo option "--not" after "--end-of-opti=
ons"' '
>         cat >expect <<-EOF &&
>         > three
>         EOF
>         git log --pretty=3D"%m %s" --end-of-options \
>                 HEAD --not --output=3Dyikes -- \
>                 two/three >actual &&
>         test_cmp expect actual
>     '
>=20
> But for the original implementation, because pseudo revision options
> (--branches, --tags, --not, ..., etc) can not be used after the
> "--end-of-options" option, we have to put "--end-of-options" at the
> end of revisions, such as:
>=20
>     git log --pretty=3D"%m %s" rev1 --not rev2 rev3 rev4 \
>             --end-of-options -- path/file

Or you could just use the other syntax and not have the problem.  Or you
could write this:

  git log --pretty=3D"%m %s" refs/heads/rev1 --not --end-of-options rev2 re=
v3 rev4 \
          -- path/file

Unless there's a functional problem we're trying to solve, I'd much
rather we didn't make --end-of-options means
--end-of-some-options-but-not-others.  That makes it hard to reason
about, and if someone does have a need for disabling all options, then
we have to add another option.  It's also incompatible with the previous
behavior, so whereas "--not" used to be a revision, now it's an option.

It's unfortunate that we're not using -- here instead of
--end-of-options because the former is the standard syntax, but that's
what we have now since that's already used elsewhere.

> Yes, "--end-of-options" must be used if there is a revision which
> starts with dash, such as branch "--output=3Dyikes" in t6000. That's
> even stranger, for we have to write  command in the middle of
> revisions like this:
>=20
>     git log --pretty=3D"%m %s" rev1 --not rev2 rev3 \
>             --end-of-options --output=3Dyikes -- path/file
>=20
> I know "rev1..rev2" and "rev2 ^rev1", but I prefer to use "rev1 --not
> rev2 rev3" instead of "rev1 ^rev2 ^rev3".

I don't think a personal preference is a good reason to change this.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--xOzyhRrDkcHzmFDF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYOoXCAAKCRB8DEliiIei
gdEjAQDiVB57clWRdMSi8I+Ph5cQMLw6e/xu4uQhwzTLMQsDdgD+LdfSWuG/SpxT
MFVBJk8CEodjenvBrwjgdh/gJgDEWw8=
=y9gt
-----END PGP SIGNATURE-----

--xOzyhRrDkcHzmFDF--
