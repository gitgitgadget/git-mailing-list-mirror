Return-Path: <SRS0=UUNX=3P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FBBC2D0DB
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 19:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5EE92070A
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 19:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="YBCAeF80"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgAZTmi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jan 2020 14:42:38 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47516 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728266AbgAZTmi (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Jan 2020 14:42:38 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9338460482;
        Sun, 26 Jan 2020 19:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1580067757;
        bh=5riDw0xFv1FOT+GJ51tgsEr7bBvhUnZeXhEgqIwxiRs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=YBCAeF807/D9wIh5+aEhe0TPa6ipJph+zHc3bcfFbF9qfkVooFLMSJt8snvzKJ7C4
         sdMGEoiPQiffvMEBchAI6YJYMXN6Fe/vyy6uuCrPlsqhLfut9PpHa2ZDXPxhGPiyGH
         tmTINoE6axuRgJRPqnE3Hj2j3vc6j/9d9Xzq87yxCLJmO8M6AKX/dPGaEfph08Teie
         J5wPQrtNMiQFwoC6BKOQ3TugH1fTLh4YG0wQln0KPVnA9RcMU3b89+RD1WqEoKUnBX
         bvgbfy6mZDe/ACd4LW5gnCdgo5X74zhh/5Lohc/q4GO8Rlikv6gINXuxtiOuIdGaxW
         brxlW8aJq9PwpHP955YcPegW4DGi/VAVtffZzfRc/G9wnYb2GqzfACt4uolwkJ+nql
         pS3Q20COihSnY7t662KggMxSMHDBRTb3lfgT6YyXKQiG+vNH3/hYRkAs94L3fow/Xl
         jWjEIcV6OD7uTEFXOUeD0PT/UKwXdQ5UbjeNnVFvAbkG37PKBWf
Date:   Sun, 26 Jan 2020 19:42:33 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 00/23] SHA-256 test fixes, part 8
Message-ID: <20200126194233.GD4113372@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
References: <20200125230035.136348-1-sandals@crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2001261120430.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jL2BoiuKMElzg3CS"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2001261120430.46@tvgsbejvaqbjf.bet>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-26 at 10:25:31, Johannes Schindelin wrote:
> Hi brian,
>=20
> On Sat, 25 Jan 2020, brian m. carlson wrote:
>=20
> > This is the second-to-last series of test fixes for SHA-256.
> >
> > As mentioned previously, the patch for t3305 seems to indicate a bug in
> > the notes code and I'm not familiar enough with that code to apply a
> > fix.  This is a band-aid to get it working with SHA-256, but any
> > comments on a more robust approach would of course be welcome.
> >
> > Changes from v1:
> > * Drop patch for t3404 in favor of Dscho's fix.
> > * Drop patch for t5616 in favor of Jonathan Tan's fix.
> > * Add missing sign-off.
> > * Move test_oid_init into the correct patch.
>=20
> Would you terribly mind pushing up your local branch to a public place? I
> used the apply-from-public-inbox.sh script I maintain at
> https://github.com/git-for-windows/build-extra to apply your patch series
> on top of v2.25.0, but I got this:
>=20
> 	Applying: t5607: make hash size independent
> 	Using index info to reconstruct a base tree...
> 	M       t/t5607-clone-bundle.sh
> 	Falling back to patching base and 3-way merge...
> 	No changes -- Patch already applied.
>=20
> (I want to have a look at the notes fanout. Will keep you posted on my
> investigation there.)

The branch is test-fixes-part8 on https://github.com/bk2204/git.git.
It's currently based off master.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4t66kACgkQv1NdgR9S
9osZug/+I/IUobZ+VJmTDjxLsh+O3nGeaOhxch/DgtIn5IQ9X/CjjRSN3cWsXw5E
V4mONMxIMScHA5qALbEq8lSTu/B8adPxWueVmMf8Ui5Z62eT/1p3TVcy7rtxFu9M
p0tNOWPJoDW5Z0wJAJCdLjtyfn91sRSzjjehwWnBZP29hkUEhwye7LrqXoqHxa3G
yRBMR8FzqtvKXqD7ThqrO2CZ4alA1MbDvmLxtFO9LT4LdgSvUvy0ZUpSilZMAhb3
2Lq/2s9g4cTC453cqEYFbx0QDItgvScFgrV10XgWq3Q6uHs60RQ1TElK6kpK/jVX
0l3g398U2odI1Uob09B3UWCtH2VyfMec2/yklfLlLmSZWdr1ajByyJN3i6h651li
JZ1ZTSJN2S2JraCi5M79fkF/bJzj8Vz0hRZxPJ9kTl1zejXcySgKyFAhExh+MgE3
pGjLnn+wltV/qQ8Ubb+J7u0MiTDpxa9hF/6RRkwdUhprdTfanv0eDCuPb9d1DImj
KZ7hHPoIBLn4FscqVx6wKIQwwOvhDGKM7SPYFK2Jf2uELAdNP/nBGQhcVX22pCMi
1Mr9AqCaXttkYojpxucgUAuZotIzV+nWDNJ4X0pUhu1bS12ON0HJRqFFHnSbILIZ
a2XyyurlmvUlKKhaGvYGOSqlKm7Uin4yDLoPONxXsL0toHXssH4=
=mN5F
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--
