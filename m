Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF0DC433ED
	for <git@archiver.kernel.org>; Sat,  1 May 2021 02:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CE1761407
	for <git@archiver.kernel.org>; Sat,  1 May 2021 02:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhEACCQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 22:02:16 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45324 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230298AbhEACCP (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 30 Apr 2021 22:02:15 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E15F66041F;
        Sat,  1 May 2021 02:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1619834455;
        bh=h5NTJLcehVy6BwToOKnDtzs+/mCENWHaUTS3r6b/5JY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=vAgk9knEZqJwhtCbqk8D5cS1jHDmfozS43wnR1OAhh3nDn8/dXQerEtHfQ6phLX1z
         2HI3dHjzu06eidq6jAQcWd8ynocB24cy/Dpql8sfx8u4dD03Vs26cAxIymyZSE3Xdw
         NzZtBQDfkdyqHQaL4qHT7VVZhbwpBfcoXb1eUsHpTCQI92eYyPL1SwsNrwuNmMMADj
         QIk3RW3SrT5sp3GyfJybpAx/Dxnawvc5rwJ+MWjBjx3uupECbdfuLASIFRJpxjneue
         TpRsd+u63SBGSuT/ykTUwaPkr1VIlTCPrNlPvdAtedmk2pw+2GtdEGY/TRhFHPdWZV
         6ISXoTmEOifAJ/IQ58wz7yLSTRaFwbRdac0ll1mxUtGm18JrcQlft//wh8e3UqMfuh
         t1XcOvaxHVlARjMJ+C3zxrzgin/Z0lRdNn1Q+f8ACo78/3sqX7YWqsUrtUEiSP4m9O
         ZAs24efvUFRcYzgffZPF7oiqXByr7BrA2t7aX2bGvha2IZo9z1U
Date:   Sat, 1 May 2021 02:00:49 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        me@ttaylorr.com, avarab@gmail.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] urlmatch: do not allow passwords in URLs by default
Message-ID: <YIy2UZWeNiWfa1jp@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        me@ttaylorr.com, avarab@gmail.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.945.git.1619807844627.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kcBThRu/4aP3hzLc"
Content-Disposition: inline
In-Reply-To: <pull.945.git.1619807844627.gitgitgadget@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--kcBThRu/4aP3hzLc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-30 at 18:37:24, Derrick Stolee via GitGitGadget wrote:
> Create a new config option, core.allowUsernamePasswordUrls, which is
> disabled by default. If Git attempts to parse a password from a URL in
> this form, it will die() if this config is not enabled. This affects a
> few test scripts, but enabling the config in those places is relatively
> simple.

Let's call this http.allowUsernamePasswordURLs (or
http.allowCredentialsInURL) because this is ultimately about HTTP and
HTTPS (and maybe FTP if we still support that, which I certainly hope we
do not).  SSH doesn't have URLs and won't read a password from either
the URL or a credential helper, since OpenSSH won't read a password from
anything but a terminal (which is secure, but occasionally irritating).

> This will cause a significant change in behavior for users who rely upon
> this username:password pattern. The error message describes the config
> that they must enable to continue working with these URLs. This has a
> significant chance of breaking some automated workflows that use URLs in
> this fashion, but even those workflows would be better off using a
> different mechanism for credentials.

I will admit to using this pattern in a test I was writing just this
week.  I ultimately switched to an environment-based credential helper
(=C3=A0 la FAQ) in my test, but I think automated tests and other situations
where the credentials don't matter are really the only cases where this
is okay.  I do think we will break some systems as a result, especially
in situations where users cannot otherwise specify credentials (e.g., a
SaaS offering which clones your repository to provide some
functionality).

So I am a bit torn about this.  On one hand, we should really encourage
much more secure options whenever possible and I'm glad this does this,
but on the other hand, there are some useful cases where this is
unobjectionable or at least the least terrible option and the config
option may be a problem.  Don't let my doubts hold up this series if
everyone else is for it, though.  It's definitely an improvement in
security.

It is my intention (in my copious free time) to adjust credential
helpers to support arbitrary auth schemes (e.g., Bearer).  At that
point, I plan to deprecate support for Authorization extra headers.  In
that case, because the user is guaranteed to have the opportunity to
edit the config, they are guaranteed to have credential helper support
and therefore there are no use cases we're excluding.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--kcBThRu/4aP3hzLc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYIy2UAAKCRB8DEliiIei
gXc+AP4gwwdj3ooVUkAkFeC5Ia3/hNkIXSgxLcO9obuKwfvNPwEA4lIUVY5+CdVw
8s7Bq5ZEb0epVbt3oKgsGjDHqFfR0QU=
=jnFi
-----END PGP SIGNATURE-----

--kcBThRu/4aP3hzLc--
