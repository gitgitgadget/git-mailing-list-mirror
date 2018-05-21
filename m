Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E63DF1F51C
	for <e@80x24.org>; Mon, 21 May 2018 01:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751778AbeEUB6J (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 21:58:09 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50758 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751030AbeEUB6J (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 20 May 2018 21:58:09 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:fc4d:8d90:22bd:91d8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 095946047A;
        Mon, 21 May 2018 01:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526867887;
        bh=QJ/ZskfLSzlCpK6wYka73GYZimKqaFqqsHIYNDpilD8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=uynSCH8Dh+ICD2RIRZQk6gelIGr6XUdJuDURlUQDFzWgXSbJ0ys6Wtb65lgOd36Cx
         dglqOCw10NY3WEUNAT+QzkY6wVxCVh7FJ90hCKgW9gS3Czd1FHlsvZvXoZ0zwoBzMm
         6xFnGlOh1mSXWYmSXugGrtO/K/3BscJiJud6FB/iMh+CC+gP+DOSBoVsR+JTzRSDPM
         s1hbagmo9u+Yv0uHXawsWp782ZLT1ElVlrEIqO2trbk/6r55+XL2YkxYpJ2WSt54ey
         9Au65LrAQATA3eM+H3YV0EBJXFJuW3lmR9d2eAMipZAdh43EoD87WKhkecbIembkG+
         Bwb0PtEkjbzlQ0IHkYAs0kyV8/FSvwijvy6obe3ukmDd1blhX18njXs830leuJyosz
         EpTwDxvwIRYe9Jm6Sf0gsV4P++oIy+jXms2lgCv/RR8dLZzY5fH2td3WzE5pwCJYV7
         jm6Vayk0nPRCS0GkTW22l8HUoqT5cjuYySbGZLj+QYb63NsS0kC
Date:   Mon, 21 May 2018 01:57:40 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2018, #02; Thu, 17)
Message-ID: <20180521015739.GE652292@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cpvLTH7QU4gwfq3S"
Content-Disposition: inline
In-Reply-To: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cpvLTH7QU4gwfq3S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 17, 2018 at 03:01:40PM +0900, Junio C Hamano wrote:
> * bc/hash-independent-tests (2018-05-16) 28 commits
>  - t5300: abstract away SHA-1-specific constants
>  - t4208: abstract away SHA-1-specific constants
>  - t4045: abstract away SHA-1-specific constants
>  - t4042: abstract away SHA-1-specific constants
>  - t4205: sort log output in a hash-independent way
>  - t/lib-diff-alternative: abstract away SHA-1-specific constants
>  - t4030: abstract away SHA-1-specific constants
>  - t4029: abstract away SHA-1-specific constants
>  - t4029: fix test indentation
>  - t4022: abstract away SHA-1-specific constants
>  - t4020: abstract away SHA-1-specific constants
>  - t4014: abstract away SHA-1-specific constants
>  - t4008: abstract away SHA-1-specific constants
>  - t4007: abstract away SHA-1-specific constants
>  - t3905: abstract away SHA-1-specific constants
>  - t3702: abstract away SHA-1-specific constants
>  - t3103: abstract away SHA-1-specific constants
>  - t2203: abstract away SHA-1-specific constants
>  - t: skip pack tests if not using SHA-1
>  - t4044: skip test if not using SHA-1
>  - t1512: skip test if not using SHA-1
>  - t1007: annotate with SHA1 prerequisite
>  - t0000: annotate with SHA1 prerequisite
>  - t: switch $_x40 to $OID_REGEX
>  - t/test-lib: introduce OID_REGEX
>  - t: switch $_z40 to $ZERO_OID
>  - t/test-lib: introduce ZERO_OID
>  - t/test-lib: add an SHA1 prerequisite
>=20
>  Many tests hardcode the raw object names, which would change once
>  we migrate away from SHA-1.  While some of them must test against
>  exact object names, most of them do not have to use hardcoded
>  constants in the test.  The latter kind of tests have been updated
>  to test the moral equivalent of the original without hardcoding the
>  actual object names.
>=20
>  Will merge to 'next'.

I think there was one minor change Stefan wanted out of this series.
I'll send a reroll (and tbdiff) with just that change.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--cpvLTH7QU4gwfq3S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlsCJ5MACgkQv1NdgR9S
9otAfRAAydH0MOLqwGwTIxSZVQF1EC3iPfJ5p8ezOihGh2Cwl3sOtZ0s1s1xfiMH
ANTwUA9QaVhptPCTPdxHtsnjbSocJgrLgmQo66bxz5EgzPhem6IZ3f+f0Gb/soKc
PG+9Hfn0dKf6KQ1qpEuD3eovwiybTN6XEpGEFhhrnka0kNTy18rRQP1f0AsrAwVk
qe2oHB09sfmCTmmfFvsC1TK+Y0vt6Jk6B49OK0RXTvXl4CWIMGiKK6535zRNiQQS
1QaMM1XJYGW6gp4EkWkR2rEi0GYpwBh+Qu1OzdN3pfoq4/Al184Z/L7BZs3FElVC
hD5l2Edz23Y7+tf+IlQq4P0PlV9Ge7bKeyhc9TvO6dkU4XaVO++DqtfdrWUIabuL
+a0phYsdQ72Rb/Vj+z3u245WRIOg7OZBm0xx3Qpj9FUHBr3RvUvps3hBnYrsHpNf
3S1inOrmWJyUC0ekCQRdT18oFFnVXYTtzQUhTvjNtHx+pZ+VU0QT8RjTLc8+sub9
UDVmTfm3R1iCUhCrAUnrwgzNeRyTGYr+uD6Vm50a7iVH3FlsE2cg0p6+GuRn+k8r
emtrwzxYkBTMGASqq53v3ZcsXAWh8AwofBfmbYlYt52lAjq2anraOVS2lJDXEVxm
23WRgLG0ADfjxhMNc6yv/JJs488DqnL/y7uKl1U+ui4dyXdsFoY=
=HQqw
-----END PGP SIGNATURE-----

--cpvLTH7QU4gwfq3S--
