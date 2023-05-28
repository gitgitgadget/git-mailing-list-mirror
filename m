Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEBCC77B7C
	for <git@archiver.kernel.org>; Sun, 28 May 2023 22:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjE1WvN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 May 2023 18:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjE1WvM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2023 18:51:12 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DE6B9
        for <git@vger.kernel.org>; Sun, 28 May 2023 15:51:10 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id AE2925A215;
        Sun, 28 May 2023 22:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1685314269;
        bh=+KHEuDXoB7w9pEd1avUC7SBNjIy5ygyKKCG6xYbuymc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=C09RhlhYjU7mvB50jn3uc1HA28KgNLFCoRxt2A4k5FtJcKIfBjXnyGTaqWKxFqIuG
         Rq4ALJvJQ8b0VJJ1oSvtISMJrXjD3dtyDjNKBa1iwZ6yxh2quATEP8oYiKmDWTmOmk
         UCBSQ45VM5guMczqnB0/oPlSnGxMh/SkhkEgkZHFhPrfIfDlTAv1H0M6ZWdlKYU0tR
         O+2aAvKbSpYkY6iv18dd/2HkWVJvJxJ+Wl9bCQFuhHYnL0ChZEZVHQHuLrg8S681FG
         WFGaNiK/Yme46vWE+nWMSneFhAmkYDLFgRQDfaRZNh5z3SQRMRIUmwQ+KApiXz3RBD
         QOmdIUFoVhFN2n1k/WRdlGhWK+b0JonrC9QnsiNZK9HCKpIX5GOdI8Mf/aAOWDIJrn
         7L18v3mIESfcHyDdjABOEJ44bEc+iHhFy0eiN8n2GuJb/VXsglJY1iR19a0XWfWpFX
         fsRyb9kKiErQYTfN65za8kMP5u1Usu+fd54hFLgTD37LQ65opqe
Date:   Sun, 28 May 2023 22:51:07 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, msuchanek@suse.de,
        lessleydennington@gmail.com, me@ttaylorr.com,
        mjcheetham@github.com, M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH] doc: gitcredentials: introduce OAuth helpers
Message-ID: <ZHPa27fbAoKL0uGj@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, msuchanek@suse.de,
        lessleydennington@gmail.com, me@ttaylorr.com, mjcheetham@github.com,
        M Hickford <mirth.hickford@gmail.com>
References: <pull.1538.git.1685303127237.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f4uYkjGCcTiPEzMB"
Content-Disposition: inline
In-Reply-To: <pull.1538.git.1685303127237.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--f4uYkjGCcTiPEzMB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-05-28 at 19:45:27, M Hickford via GitGitGadget wrote:
> From: M Hickford <mirth.hickford@gmail.com>
>=20
> OAuth credential helpers are widely useful but work differently to other
> credential helpers, so worth introducing in the docs.
>=20
> Link to relevant projects.

There are many possible implementations of credential helpers, and I'd
prefer we didn't specifically propose any of them here.  We ship with
some in contrib, and I think it would be better to fix them to be
functional for this use case rather than link to external projects.

I expect, however, that functionally, that will be difficult to do,
given the fact that OAuth typically requires registration with the
remote system, and thus we'd intrinsically be prioritizing some
well-known forges over less-known or personally-hosted forges, which
we've traditionally tried not to do.  For example, your
git-credential-oauth contains a hard-coded list of 11 forges (and also
proposes adding credentials for new ones into the config, which isn't
really a secure way to store secrets).
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--f4uYkjGCcTiPEzMB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZHPa2wAKCRB8DEliiIei
gfldAQDrNjWuLXGluiTnwyGvLeKPvwcJlR//mldPEsKeH+aSSAD8CZSmRKAI9zfH
JLiTigM8V++7nGdvA/7ylqSA7L+8qgo=
=god9
-----END PGP SIGNATURE-----

--f4uYkjGCcTiPEzMB--
