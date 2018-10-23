Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 680A01F453
	for <e@80x24.org>; Tue, 23 Oct 2018 00:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbeJWJEl (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 05:04:41 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51848 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725799AbeJWJEk (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 23 Oct 2018 05:04:40 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e0bc:761d:9be1:27bc])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BC33361B72;
        Tue, 23 Oct 2018 00:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1540255426;
        bh=snEWsOb6e/m6s8FcFpcUx7zahrsom+vMtAODGkf3fvw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=rXaR0ufo2OaYgEqgBdsdzQvEnX8OL/2XB83uxXE2XJyLS9bjPrPfMZjNJmzn92x4l
         LVS6foq3CROuIiZ47y8GbI9Pvq5JzC+Sp6+eeCslJ4riW3WMJk/8LhGhcBG3+3cZ6q
         Rh3D3Efron4s1yy12LukPkrqxZMjS3O8b45H3Kg5wrZuDWMfJozpkZexpXsSViNDXS
         IgC8+z6FyTzhJI88JeSOFzOGSRrm8hsEKozXuXZSF/gn8ScNCoe+OMrpFuVW/OOuE9
         buxue1GFARy1DStcnhJD4i5iAqzZfkY99q3KOgL/G0UhH+VdRGyaNMZhtRUkKSKBUI
         irdKNFPe9Filey1SQ89Mudww5t0evHc2C9DmYRd9Q0+rOYw3d5abpI3kJ9C9djQKvq
         SuGKd1BK6mbiEezoSh3Ima+3oIgrKTLfWF6GWOOo3eP6fkia3EMfdi0LtEk93S3HbO
         d/R9V5TQPdSKjHlq9sYpoCkaH6jZOLy4Tzmm2aXB9Jz6oCSbjLM
Date:   Tue, 23 Oct 2018 00:43:41 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 10/12] Add a base implementation of SHA-256 support
Message-ID: <20181023004340.GA6119@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
References: <20181022024342.489564-1-sandals@crustytoothpaste.net>
 <20181022024342.489564-11-sandals@crustytoothpaste.net>
 <20181022094440.GD30222@szeder.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <20181022094440.GD30222@szeder.dev>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 22, 2018 at 11:44:40AM +0200, SZEDER G=C3=A1bor wrote:
> To protect us from potential "macro redefinition" errors, these
> #undefs should come before the #defines above.  Note also that BLKSIZE
> is not #undef-ed.

Ah, okay.  I think I misread your suggestion.  I'll see if anyone has
more comments, and then reroll with that change.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvObrwACgkQv1NdgR9S
9ot9VQ//Sh+Kc75zBgMJrc7Wt4N7WgVUdm6LtSIsLgc35/dpFfiB8s9HCU2tTBSD
MQMG8UQAyeXZO8YJ9IGabKEj8+6jkHeWRnQuk7UxyyFAF8AgJ3UtmXHGcl0uXtbI
L85RLMc3j6oIq7mCzGAv14mGq8b2/reGgDWxvT70uGlyuAn/1rMt7woI62eY49DO
AYub3UEp/C3KC5kQ+K2o8GruQj9GuO01ZcGrcyguPC+hRoiynBkYEEeA1nNmcs8m
DjgvFYr1tOs9HXOXLxpBXXJlpWvSajLgm5JCLo3+cptOYXIF2ZGPAPzCs/D/vzM1
7ifM0VxgtnJFwG7wOXSMLRiVvRTHQZpPsBduXak67Cxrb6jCMNuA29gJNJxNEsr3
jSLh2v2qjDuJBH+dyXoA/UaswvL3Z/1oC1lth953i+1KgBO3Q6eY4KOML2nlsKvv
zis559UKLDTo8yezzIoo1oif055SfAansV3hs/LliFFISkPCIf9qwr27dwgvyzN6
KJgKzMfOBa/W5wr6AWyoBa4zY+rd8sW9nfxyZwL1qezYgmgKNei4KNqa8O6fpKL/
kh/uYHiQaX8K867Vd6KjKxDXUIaBuH6LYoEz0b+fuULGiSUYXsEpSDJE5pWxyaan
NLqZK/NQm4B4E2zd0dnmz5ATovozVKgbi9pIirVw7t6ld2HWJ5M=
=V8TE
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
