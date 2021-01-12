Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DA2C433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 02:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2996222E03
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 02:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbhALCZb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 21:25:31 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51334 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726645AbhALCZa (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Jan 2021 21:25:30 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5A4FB60781;
        Tue, 12 Jan 2021 02:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1610418288;
        bh=oDrETecXoPypAZwlo7cJh9bKCQ8f4gDOZAvjzKRBgcA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=sMgdBrSoQ0P4LWb6oclheKGvgsM3mxwAhSmFgn83T5IOHxE+JMvpKih5Y9lsxht6H
         PCmO85G1uRqULAnU8Ln0AA8EyKdQkI2KKfcmICwi71ZqTq0FYCGwAXSu8lQTUs4+0D
         g2D/aq3fjQff5pJTa9bknoQR1hgtbJWxCTOy1Pn/br1cs0/4LMRPVPkUoz03SFqT5r
         36J+qqHW4MPOdoGohkVGe5ht0eI6MjTfejuBMsd+hl51UGInDLACOnPLAKMForeiVK
         5GjyhYtoac5tTpDbz01Twxo5cAKcpwoENGicc/2xppR4Evoz1OpDdJrTaHPom3/yI2
         OgI6vGAp6SzZ341PCKnfSARrUqG8jKHRVhReshhAvJufqFnUEqbl26VJzBX/yu65Mu
         XdkN6DyCEaMD+bW9DWi8MnUNMLcDf/gYiC7WkSJKR6pcJ6HJHScqW2TWRSR0PvcDMJ
         uCyao7RiuwvA+jfwQtxbo0/7HopJUifgX3S9HjjVz9zFsYCs4pZ
Date:   Tue, 12 Jan 2021 02:24:41 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/5] Support for commits signed by multiple algorithms
Message-ID: <X/0IaVkxqbYxKJBf@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>
References: <20210111003740.1319996-1-sandals@crustytoothpaste.net>
 <20210111035840.2437737-1-sandals@crustytoothpaste.net>
 <xmqq5z436rwe.fsf@gitster.c.googlers.com>
 <X/zfdA8uUAdx0oEu@camp.crustytoothpaste.net>
 <xmqqft366her.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KystvZ3+L8llFtpU"
Content-Disposition: inline
In-Reply-To: <xmqqft366her.fsf@gitster.c.googlers.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--KystvZ3+L8llFtpU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-01-12 at 02:03:08, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > I just noticed this because I'm now getting to the case where we write
> > (and sign) both SHA-1 and SHA-256 versions of commits and I thought I'd
> > better send in a patch sooner rather than later, since there's a lot
> > more prep work (surprise) before we get to anything interesting.
>=20
> Uncomfortably excited to hear this ;-)

Here's a brief summary of what's ahead:

* struct object_id is going to have an algorithm member.
* Consequently, there will be per-algorithm null OIDs.
* To efficiently compare and copy OIDs of all sizes (notably in khash
  tables, where things otherwise become tricky), we'll zero-pad SHA-1
  OIDs and always compare the full buffer.
* For all of these reasons, oidread (or similar) will become practically
  required.
* Objects will be mapped into the loose object store when written, and
  each type of object will have a function to convert it between formats
  if required.
* The testsuite will learn a mode not to stuff invalid OIDs into things,
  since those will no longer work (because those OIDs can't be mapped
  and so we can't create SHA-1 versions of them).  That will necessitate
  another large set of prerequisite additions in the testsuite.

In progress work can be seen on the transition-interop branch at
https://github.com/bk2204/git.git.  I should point out that it is very
in progress; the tip will definitely fail the testsuite in certain
cases.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--KystvZ3+L8llFtpU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX/0IaAAKCRB8DEliiIei
gVzJAQDM8YGlBkKr7SxHEaKURVsWFWFadYwquVcU8KMFusABkAEAtGgA6AIM0jBy
mv/9kPXN/e7YXJxP8pLAY6U1OfR5zwE=
=HGWI
-----END PGP SIGNATURE-----

--KystvZ3+L8llFtpU--
