Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538FEC43463
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 18:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08A022073A
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 18:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgITS6X (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 14:58:23 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35154 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726109AbgITS6X (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 20 Sep 2020 14:58:23 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EF21960756;
        Sun, 20 Sep 2020 18:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1600628302;
        bh=7TeFTD50J1H/rEjzB7xdUYFHT5mF4Z5+l4ueLecWWok=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=aaYMPeTfBJJkWjswJzYWJf8RPz92g879HhaoimRN/q/NsQeh7u81XIGxnx7835NS8
         f6Sfw7zGk68/YLhIqCaLDbOUFzSCBdfRJ64UX7fgpQi6mkpcrmuhC/XWh2FkAaSpxX
         wWi5nloNtTil+/1pn46ta5OkPkHMtnB1sM8zBxoggpU96u2H2s//7mp/abfADU2Egs
         y64Uii3Oe8bRqpPZKuLRN/84XvKZEqlnwbogSN1cuT7iJFgK/epYgmY6JnbqcGF4jQ
         QyPUZVYPys80uMbw4bMmIScJ3QT11MRShsKP6Ct37jrV5mXbySR9qSDV9ngaNxBgND
         BMkjJjK4HWJO6GvH9VWg5K6KrtDvQYkY6Mr3hvBlmvEgs2wSc68kBD27g+MtQ+MBxZ
         1iiDFZPAqeoc2AIzLt5S+PIk/5hS/ZVea3Ec+EcN9FeDI7qB4Rg9So/RylzTZCovEv
         NqNBYpaxRrbRe/sLUGjrCtmI826imYQAdWn7uRn8aj/1g1J94CY
Date:   Sun, 20 Sep 2020 18:58:17 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/4] builtin/rev-parse: learn --null-oid
Message-ID: <20200920185817.GJ67496@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Chris Torek <chris.torek@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <cover.1600427894.git.liu.denton@gmail.com>
 <004f2e4c92918a7a4e452d49e98ef15f1c5ac545.1600427894.git.liu.denton@gmail.com>
 <20200918141125.GB1602321@nand.local>
 <20200918212609.GC67496@camp.crustytoothpaste.net>
 <CAPx1Gvd6vcvM410wZUZygr4-2Ob6gaScF3DnBtWWsT95XDmKSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="W13SgbpmD6bhZUTM"
Content-Disposition: inline
In-Reply-To: <CAPx1Gvd6vcvM410wZUZygr4-2Ob6gaScF3DnBtWWsT95XDmKSQ@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--W13SgbpmD6bhZUTM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-09-20 at 04:25:33, Chris Torek wrote:
> On Fri, Sep 18, 2020 at 2:34 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > What I typically do when I write shell scripts, and which may obviate
> > the need for this patch is turn this:
> >
> >   [ "$oid" =3D 0000000000000000000000000000000000000000 ]
> >
> > into this:
> >
> >   echo "$oid" | grep -qsE '^0+$'
> >
> > This is slightly less efficient, but it's also backwards compatible
> > with older Git version assuming you have a POSIX grep.
>=20
> Note that a lot of `grep`s do not have `-q` and/or `-s` so the
> portable variant of this is `grep '^0+$' >/dev/null` (you only need
> the `2>&1` part if you're concerned about bad input files or
> an error on a pipe or something).

If we're looking for best compatibility here, then using egrep and
/dev/null is best, I agree.  I personally use the POSIX version because
it's been that way since at least 2001 and I don't have a problem with
requiring compliance with a 19-year-old standard.  But for Git, we
should definitely do whatever we do in the testsuite if we use this
approach, since presumably that works everywhere.

As Andreas pointed out, there are ways to avoid the external process
that we could stuff in a shell function.  I'm not picky.

> > I'm not sure we need an empty tree and empty blob object, because it's
> > pretty easy to write these:
> >
> >   git hash-object -t tree /dev/null
> >   git hash-object -t blob /dev/null
> >
> > That's what I've done in some of the transition code at least.
>=20
> That's what's recommended in my 2012 stackoverflow Q&A, too.
> The use of `/dev/null` directly here is perhaps unsatisfactory on
> old Windows systems, though...?

I believe all modern versions of Git for Windows provide /dev/null via
the shell, since it's required for a lot of things to work, so I'm not
worried about this case.  It is definitely good to think about Windows,
though.
--=20
brian m. carlson: Houston, Texas, US

--W13SgbpmD6bhZUTM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX2emSQAKCRB8DEliiIei
gZxKAQC4lYu66eaOyEd2wFHslmp6fJRgri6tCQn6RXRKVwxsGAD9EvPGlR1+t4tu
0W8oXCFS1p02xrhQZSABWDunyWbFFgA=
=Op5b
-----END PGP SIGNATURE-----

--W13SgbpmD6bhZUTM--
