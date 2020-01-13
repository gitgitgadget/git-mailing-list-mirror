Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD10C33CAF
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 23:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B362206DA
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 23:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="A/BbxtuD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgAMXPn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 18:15:43 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38152 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726536AbgAMXPn (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 18:15:43 -0500
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 31900607F7;
        Mon, 13 Jan 2020 23:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578957342;
        bh=uhPDjueNS1mYOS5vU6cgyIH+q9z1jWU9SVaaVFSU/YA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=A/BbxtuDPZbFdAoCXPzGtgT3AKq1fkgU1iMG1x3+EqnpXtzfgBqJa7HX5W5cKB5mO
         TATZ50rWscaWmFG61jmfeQU4kkFJfxs8vobwlbaentVLQscP8SVzuM/4YycjPaomD1
         CrUgz50ub+YBELbwHYvRG3mBBSiPweYofgTwWqtPXLROpcOoHMMWfUIJZnz0TN/9XC
         rOFHEfAHTv9lieRWjsJ4ei5Jce4rjhJIyNxJQctSzMw7Rbs3XStB4mPXN49LciDpNa
         MeD01PgTHYy/3f8bWjqDYoCmvgvypp/MB0uro9Ve1KQnaLIrI1N172M+w0zEzfq2+Y
         Tnr7EKbAIFMVPWeenJ4aHLkRF+z88+KpgHIrW/P861tWQH31+5BZAg3Rsq4zjCmjqB
         pO80/66hKQ+qSK+9F5b6ezkzS/ltKsyYMNMdnRz9B0U1brXWJbQwrfSes6zOZjQULC
         cz3SufYu41gVNGytjXN6PdpT2cXKDXBCNq3454AiN1bI2Qg99Sw
Date:   Mon, 13 Jan 2020 23:15:38 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 20/24] t5703: make test work with SHA-256
Message-ID: <20200113231538.GT6570@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
 <20200113123857.3684632-21-sandals@crustytoothpaste.net>
 <CAPig+cS3w=9zqSsVOQ3NtA_ESes6H6KGwwi9R+S3h53JpWgkFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ULJ2Z7kCM1hyNsWd"
Content-Disposition: inline
In-Reply-To: <CAPig+cS3w=9zqSsVOQ3NtA_ESes6H6KGwwi9R+S3h53JpWgkFg@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ULJ2Z7kCM1hyNsWd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-13 at 13:53:12, Eric Sunshine wrote:
> On Mon, Jan 13, 2020 at 7:41 AM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-r=
ef-in-want.sh
> > @@ -19,7 +19,7 @@ get_actual_commits () {
> >         git verify-pack -v o.idx >objs &&
> > -       grep commit objs | cut -c-40 | sort >actual_commits
> > +       grep commit objs | cut -d" " -f1 | sort >actual_commits
> >  }
> > @@ -37,6 +37,7 @@ check_output () {
> >  test_expect_success 'setup repository' '
> > +       test_oid_init &&
> >         test_commit a &&
>=20
> I think this `test_oid_init` is supposed to be introduced in patch
> 21/24, not here in 20/24 for which it serves no purpose.

You're right.  I'll just squash them together, since they don't really
make sense being separate.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--ULJ2Z7kCM1hyNsWd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4c+hoACgkQv1NdgR9S
9osiKA//azziWsFP2V7UAabK049JFkPQKFq4jHQ1wxsg5y5038s3EWbRuT177XO/
3CO4UiCV51D7OCvsrAxABIw+uSc9iNX20vZO0E4zmfxdq7ZfaTht4uwFSn2+t4oi
GUj96PuGJshuWJDkzD6FY5Hyyd7tuibiS0chg/91WlS567Vw9H2f1MGyE4Jfqt3H
Bxy3B7dlb5n+7HG0DKy2f6kXmjINCXQlL6HowBnRSEzifZ2IBgetthZBlVTGzGyr
LuJTYARRUC0ZaGvLiVIXOyif0DFXAKtqz2ScrJl6qRVn7EgWQoCbCqv8M+D3G8/U
2VRYLoLqODFSqzaqRcWSZk9s+hk5Qfh0hf9hycHXCJKkqj1kqkK2j7pXRhK9NQjP
DPlvXKVtL3lx/exg3JxFdwhEj1kNGSTPw1gfbUCvJpEzFLdoad09m+oyu8pOtcD7
2j2R1HUz/KFGXncvblnLGg03I9sc0M1QbGkIlQxd/8CohAKWfLqHFcV+JJJK19Wu
iqD4xPkILMAiLTlF+VZdSFZHABTavbi/Yk2wkqO3tABqmqxzi7iVO+MfuF660h4X
UPOYHvHmLyTJ5sxG/2e7Z9LNzks85Br0m6pPaiEdvSouNxze28IcgiqaaOGY/ynD
GgbqMAxslPyY4pQN2zZ/j+kaJdaqdUuYOt1jy7SZssuwTuYVMBM=
=+pw8
-----END PGP SIGNATURE-----

--ULJ2Z7kCM1hyNsWd--
