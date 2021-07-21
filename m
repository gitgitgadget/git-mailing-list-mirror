Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A499C6377B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 22:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 068DC61029
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 22:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhGUWQF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 18:16:05 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40260 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230324AbhGUWQE (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 21 Jul 2021 18:16:04 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1354E6044E;
        Wed, 21 Jul 2021 22:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1626908170;
        bh=rOYIUesdLWcDKbIHoe2kPh6Zn2m8IcwZXbKSZYKI6T8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=vpyhN1ZnB9HYrQ8fK19609B0HOOaqtyrHh5QrZY9jm1wEXjV9LIiP15AUs/AVjSnR
         yo2pWwsi56NJK162+FEsfn30PeX9kY/6DZrMIfSdTQQZm5XapquCPLDZ8h+Td5MOTm
         F4D9EEI1ooc8SsbrSvd6Ujl5nn1eRdYfYrK8hT0uEl5PKiZOdF+dK3VeZyYXT9YAqq
         lI2+5ThAMzKsPPoDpRYR6VvVzWs6Eduu37GXXxyPu3+Ua9p4uKm+GMqBEETmr9bmyA
         Tyh7RCuzDpbGd1e/6xk3UXRSIqR/L+WcW2pKcChFDHEoCWKqyg9qcdh29xwgmB18Vs
         +lmLqPb3F3O5YI6v3X1mwXljOA0UmFn5RMkWrPtmzhwOnWMJKtT1TSHCiJ+JKki2G/
         sSLa2vEKpj8XU90LiflcgIWhzJjI93QV6hx1mFmdq8fKmlghOseDx27gktk44DueZG
         97kMQNgn4jJ4pXdNnjJpRHG6bAetHRl1uTVJTX4Zfee2q5rOCdS
Date:   Wed, 21 Jul 2021 22:56:06 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>,
        "Tom G . Christensen" <tgc@jupiterrise.com>,
        Mischa POSLAWSKY <git@shiar.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/5] drop support for ancient curl
Message-ID: <YPimBp+TkaJ9ycuM@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>,
        "Tom G . Christensen" <tgc@jupiterrise.com>,
        Mischa POSLAWSKY <git@shiar.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
 <cover-0.5-00000000000-20210721T220402Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LySiYGc5XRCc50J+"
Content-Disposition: inline
In-Reply-To: <cover-0.5-00000000000-20210721T220402Z-avarab@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--LySiYGc5XRCc50J+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-07-21 at 22:22:11, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> This series simplifies the http code by dropping support for curl
> versions older than 7.19.4, released in March 2009.
>=20
> This was last discussed on-list in 2017:
> http://lore.kernel.org/git/20170809120024.7phdjzjv54uv5dpz@sigill.intra.p=
eff.net
>=20
> My reading of why it didn't get integrated at the time was:
>=20
>  - The original commit messages are opinionated about git not working
>    on these versions anyway, as noted in the original thread that's
>    only true of vanilla curl, but anyone impacted by these issues at
>    the time was probably using e.g. RHEL, which had backports that
>    confused the issue.
>=20
>  - While in 2017 these versions were already ancient, RHEL 5 (released
>    in 2007) was still seeing some notable production use.
>=20
>    It finally got "we really mean it now" EOL'd in late 2020 when
>    extended life-cycle support ended (see
>    https://access.redhat.com/support/policy/updates/errata). RHEL 6
>    does not have a libcurl affected by these changes.
>=20
>  - It ended with a patch to "error on too-old curl", i.e. to make
>    compiling on versions older than 7.19.4 an error. I've ejected that
>    per the discussion about backports confusing that issue.

I'm in favor of this series.  I'm actually in favor of dropping support
for RHEL 6 as well, since there is nobody providing public security
support for it, and therefore nobody but people paying Red Hat (that is,
not this project) can be expected to safely run it.  I also think ten
years is about the reasonable maximum lifetime of software.

So, with or without those changes, this seems like a good approach to
me.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--LySiYGc5XRCc50J+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYPimBQAKCRB8DEliiIei
gduDAQD4n/5yRRm9Z7WKmOBTRMANGm8YbT9Uz3HSR327np9nIgD+OYi8/NQElLXG
bgIn41TtV6xOETUGo6+eeFwP17tj0gM=
=pUss
-----END PGP SIGNATURE-----

--LySiYGc5XRCc50J+--
