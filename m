Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C525C433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 01:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CDD42343B
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 01:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbhAHB63 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 20:58:29 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:48532 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727669AbhAHB63 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 Jan 2021 20:58:29 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9D4D160781;
        Fri,  8 Jan 2021 01:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1610071067;
        bh=HRTUHOO20uocPm8G//qvpFo4VpSZqXKaGqKZOFXzLE8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=iF/JBUa/TH4wVMlchYhMoAtj+9ZBScoAHrBekNiZWjS9fj2GUAXnhJ4qmaC1G5qrd
         YdukT2N83LXioZ+ecahUlxgtX7vZsgqJiE3LSQ1FFoQZU5nZezuUWKh/t0Ujpz2bSF
         GSBAcQR1WiXKLFw46CBI+FLLvhdecAchnbOCeWtIu/3dShaszttN6Ezq/KurzF8RHH
         52SnYCrFozQ0pNwl/gCvMze0G3YHxc3Mbkjmi82Dbb6qwogtlVFNHkbZdVzM72NO9n
         cc9/dq7pljdM0kmQuyUDLiGYBr+CH7nYUg+VhPzi7cFw2IJJ6itPiMF2HQShLcAiHn
         e8gP9Sg1DBJCiH4SCXJZHtQC4J2/i5oW2sPq3gXGVCxe0RDN8KZfjn20ZFS0e4LCug
         kx93kisXaab0CF+atzDgSZghdIm//mlr+ZlslZSyEbV3wHWfXCBqG9jvq1/kgTexGS
         4m/xQgycd2/FuOTQ3ieEemL8NgfUXqoDpWMuCNeIwPunTEDUiLA
Date:   Fri, 8 Jan 2021 01:57:40 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] CoC: update to version 2.0 + local changes
Message-ID: <X/e8FIexuAL0FqZ5@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
References: <xmqq5z4mjdbq.fsf@gitster.c.googlers.com>
 <20201228171734.30038-3-avarab@gmail.com>
 <xmqqmtxxedwd.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G0Zl57fSMVyD5yn+"
Content-Disposition: inline
In-Reply-To: <xmqqmtxxedwd.fsf@gitster.c.googlers.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--G0Zl57fSMVyD5yn+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-12-28 at 22:58:42, Junio C Hamano wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>=20
> > This change intentionally preserves a warning emitted on "git diff
> > --check". It's better to make it easily diff-able with upstream than
> > to fix whitespace changes in our version while we're at it.
>=20
> I think there are only two lines that needs to tolerate trailing
> whitespaces, and even if we strip them, it should be still easily
> diff-able with the upstream with --ignore-space-at-eol or whatever
> appropriate option, so I am not sure if it is worth try "keeping"
> these whitespace breakage.
>=20
> If you still want to do so, we should tweak .gitattributes so that
> "git diff --check" would not trigger.
>=20
> > 1. https://www.contributor-covenant.org/version/2/0/code_of_conduct/cod=
e_of_conduct.md
>=20
> Yes, thanks for the full URL.  In 5cdf2301 (add a Code of Conduct
> document, 2019-09-24) we pointed at the HTML version, but if we ship
> MD and they have MD, using theirs as the base makes perfect sense.
>=20
> Sign-off plus acks need to be collected here.

Acked-by: brian m. carlson <sandals@crustytoothpaste.net>
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--G0Zl57fSMVyD5yn+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX/e8EwAKCRB8DEliiIei
gYVEAQD/xwcuD/HMoMfDpQr5kdw6QuX4hV75HrIfvoDJYWXt7wD/RXKCeO0pzJC5
UUFKF37TokqyNiP+vmg5nlZXCMq+vQM=
=G/b+
-----END PGP SIGNATURE-----

--G0Zl57fSMVyD5yn+--
