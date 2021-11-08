Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB214C433F5
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 01:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0169610C8
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 01:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbhKHB4T (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Nov 2021 20:56:19 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50992 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229715AbhKHB4S (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 7 Nov 2021 20:56:18 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5679B6043F;
        Mon,  8 Nov 2021 01:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1636336414;
        bh=t3E9Qqmt0iAJm06HbxAeFoIetMuYxiulBD6Q72C69tI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=PKYsuRaRU6eKSh4b5E3vSJSfNr6A/+MJhrPU8VQWaJS+H0wESlBFwCZF3WtCXmmV4
         BnRk4rMWeCCzC3F/otao/od9fcdqLQ/BHTvkIIOHUDQL6dxryxp2xSGLs8serm00HH
         mIboTvABBHDC5evJuntVitR7+3LGG+6R4/ZzrrVmuruvkF2M9oT0PgFYouexz1kYJz
         b2ncsHpTXpthQNhB2Wj8fbUdMqXBIGEZbbn0r6GX1PgapSj3pPFX8yxzVh93rPwKj8
         NAx+io5TotY/ozAalAte1OrDvIQvXOLf+QdNImz/Nt+JqFF/SlH2+k1Lk8ZrGBwG0n
         j2atev7wKdTubMrkS5eo+mskSFnjYsnqL4qKoPR+xu4/xoNyICQ6wCGJ9kKY2NMqZm
         3+EM7aFSf32MtLJ6EYxJZpINt8/09Y1uxDXyBG9Ie6Vo+4ag3c8OKmjGomTHf1sF95
         SLztKbRklEb0eOOz6IYweLcG526IuyCWe5I+YdE4VST3KUPuOAj
Date:   Mon, 8 Nov 2021 01:53:30 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/3] gitfaq: add documentation on proxies
Message-ID: <YYiDGhkaaQq7gpLK@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20211107225525.431138-1-sandals@crustytoothpaste.net>
 <20211107225525.431138-2-sandals@crustytoothpaste.net>
 <CAPig+cT5bU3K9aUk=Y6YAOJjAmDvOWitYD_jtgHap_BYs2mPgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Dg7wF29G9AKEEhg3"
Content-Disposition: inline
In-Reply-To: <CAPig+cT5bU3K9aUk=Y6YAOJjAmDvOWitYD_jtgHap_BYs2mPgA@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Dg7wF29G9AKEEhg3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-11-07 at 23:27:24, Eric Sunshine wrote:
> I've seen this come up on the mailing list a couple times recently,
> though I haven't really followed along and don't use Git through an
> SSH proxy, thus I did have to go do some reading to understand what
> this is talking about. Perhaps people searching out this FAQ entry
> will already have sufficient context to understand what this is
> saying, so maybe no additional context is needed here. However, I was
> wondering if it might make sense for this to give a bit of reason
> explaining _why_ these tools need to be configured to not exit
> immediately upon EOF. As it stands now, this solution is a black box;
> it will work but people won't understand why. Perhaps that doesn't
> matter since most people consulting a FAQ like this probably just want
> to get the thing working and don't care about the underlying details.
> Then again, if the underlying reason is made more readily apparent,
> maybe this knowledge can become more widespread.

I'll try to see if I can stuff in a sentence there about why that's
necessary.  I think I understand it sufficiently well to summarize it.

> "modify, tamper with, change" sounds like it came from the Department
> of Redundancy Department. I like the sound of "tamper with" since the
> image it conveys feels quite suitable here. Perhaps this could be
> simplified to:
>=20
>    The proxy cannot tamper with or buffer the...

I realize this sounds redundant, but I'm trying to avoid the situation
where people say, "I'm not _tampering_ with it, since I'm authorized to
do this by the company.  I'm just modifying it to remove this
inappropriate content/malware/data leak."  My goal here is to make it
crystal clear that if you do this, you'll break things, and provide
ammunition for people to go to their IT departments and say, "Look, your
proxy prevents me from doing my job.  The Git developers say so.  Fix
it."

I can drop one of "change" and "modify", though, since I think they're
synonyms.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Dg7wF29G9AKEEhg3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYYiDGQAKCRB8DEliiIei
gZYpAQDJ4QRMWWXNgaJLpTxhNWRuAYhGLGn246u8w3zcyzXqZgD/VrROEtO2YDvs
ic4kpKppH2RDjQmpJnLObNR6aMlUnAs=
=33P6
-----END PGP SIGNATURE-----

--Dg7wF29G9AKEEhg3--
