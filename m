Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E457C433DB
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 21:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11C4C22209
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 21:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbhAPVqX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 16:46:23 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54526 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726385AbhAPVqV (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 Jan 2021 16:46:21 -0500
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E1C3760781;
        Sat, 16 Jan 2021 21:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1610833510;
        bh=8arqko610+XsKUZBT3DB7UHZHM8SEoV/Pb41cURpAgs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=BOK0UfRdWmknEZwj0hBJfWebwYM0+0vtTAdUCI1LO8e92yLFPAsT1Bmh2I0yUt0I5
         WRSfckw5bqDVIEQ4ld6EkbaZqt5zN6Qemgfri4mS7pnAypSyJilBWSvVVOjGr81Oif
         mwkO6DnHrY/G7Hw03RqL1c/OhTRswSgltgi+8ycq5mWHOovNEY+zfWAVCTHzhayxuV
         ep4tAttJCMjGH9mHaoEy0C98wKrdrupxIwsyyfuwtEbupfx5yV92g/wIRhTzYgOEpn
         oWXmSzkYsYEMMYmUVP+PZTQfna1LWOHPM1d24g0pA73xJSesDvtG/Kpyb/LgEHI/TL
         iRs/Za719odfL00ZIK6BDfMWbMKJK2xwSGSoH0hvSHIDE20pwbzW+sugzA62EXHDwQ
         Y0VOkU5/zxzZpnv4AJe5oAkoMmB4WDcQQEodnCHoDATo4d0+eBvQh++h9oMFftRpRI
         92B6Rd3GeZ85Xjd+qDF+Q9QzJUu67W/LUtWXmQ4qbwvBS3obohD
Date:   Sat, 16 Jan 2021 21:45:05 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Alan Mackenzie <acm@muc.de>
Subject: Re: [PATCH v2] docs: rephrase and clarify the git status --short
 format
Message-ID: <YANeYQ3ZLGtAsQqa@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Alan Mackenzie <acm@muc.de>
References: <X/oAhdZlLwcFRCrR@ACM>
 <20210110190448.779754-1-sandals@crustytoothpaste.net>
 <xmqqr1mr6x71.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="E39KwhOxAdmjmicb"
Content-Disposition: inline
In-Reply-To: <xmqqr1mr6x71.fsf@gitster.c.googlers.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--E39KwhOxAdmjmicb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-01-11 at 20:22:10, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > This uses text from Junio's email, so his sign-off will be required
> > here.  I assume that won't be a problem, but I can send a v3 if it is.
>=20
> Actually I find the text so vastly improved from "here is my
> attempt" version in the discussion that, other than the paragraph
> structure, there is nothing left that I can call my contribution.
> I'll sign the resulting commit off anyway, though ;-)

Well, I did use some of your text verbatim, though, and the sign-off is
necessary.  Not that it's easily distinguishable in our history since
you're the maintainer, but I also like to be meticulous about sign-offs
because I think it makes sure that people get due credit for their
contributions.

> > +There are three different types of states that are shown using this fo=
rmat, and
> > +each one uses the `XY` syntax differently:
> > ...
> > +
> > +Note that the term _merge_ here also includes rebases using the default
> > +`--merge` strategy, cherry-picks, and anything else using the merge ma=
chinery.
>=20
> Even if rebase uses the good-old "format-patch | am -3" pipeline, it
> would result in an index with entries at higher stages.  So I am not
> sure if this "Note that" helps the reader.

I'll rephrase.

> > +In the following table, these three classes are shown in separate sect=
ions, and
>=20
> This iteration has improved the "Three different classes of paths
> are shown" in the "here is my attempt" version to "Three different
> types of states ..."; shouldn't we be doing the same here with
> s/classes/types of states/?

Can do.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--E39KwhOxAdmjmicb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYANeYQAKCRB8DEliiIei
gRBnAQCAR1KfDDtbS0UOSWmZt7BiVSlPS4U4fJTwy8D5/6Ea2QEA36E+d9/9JiIh
3gvCA/JMRCBel8tsAVlipi7BocfmrQE=
=3Zv1
-----END PGP SIGNATURE-----

--E39KwhOxAdmjmicb--
