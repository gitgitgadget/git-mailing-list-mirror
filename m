Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14F3C433EF
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 22:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E14B611CC
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 22:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhJTW17 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 18:27:59 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37722 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229695AbhJTW16 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 20 Oct 2021 18:27:58 -0400
Received: from camp.crustytoothpaste.net (unknown [72.12.180.34])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4AD9360734;
        Wed, 20 Oct 2021 22:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1634768743;
        bh=Yx6RN8d2YB+JE5AhlVFVa8JtnFUl2jL6HZr1VsL3Fto=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=qOdPEyJMmlYQQp0X9ajV/v+ybtgGwJ2tCDs3qzS4Z6ul6QI8QWPPlJ0e96Ik7y60U
         mKmfK5aWgulxQylkTdAZZ53hKIcQtTzx1SJLIg4xPPhH/duJahgu+XoOLd7SyghBfi
         t7nhdAfF0VyUcpzPMYdkQsL2oFcoCKnqsJMhiDoUSGlT/xXQRzNgog8p7N77m2Dn5M
         o9op+Zge6hHjRtToUqoWPcvDHM0oZb1rm6MNxy5+w77sRfKrTD73uTxR2wSC1icSC+
         wzQSWc3FlkkjgQl1gvYTL9oyY4tKSzbHQFOW25dzXixF3mbSFgZ7xKiVxBwqGsZdH6
         1LzuE4ossMZI6L6Rk5iCFeW8d1c8Expi4DM1NgH4NIlRqQ/HrmxXR3T5APA86Ficps
         HQBnEubqViIfPz4EpwY+2fw+7RYhhbkfUL5bvADg1e9Dw06eK/NkB4fB7uWolzahu2
         W9/4zddfApXj/Yyik+CF6+kdsebSXCLgVgxgj68KZwPrKZUmzwP
Date:   Wed, 20 Oct 2021 22:25:23 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 3/4] gitfaq: give advice on using eol attribute in
 gitattributes
Message-ID: <YXCXU8uns1Xld5lH@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20211020010624.675562-1-sandals@crustytoothpaste.net>
 <20211020010624.675562-4-sandals@crustytoothpaste.net>
 <CAPig+cTn4fZtssPrn+z582E++Kdc2+z+=iNtp2kodR=QJVeycg@mail.gmail.com>
 <YW9wgbN/b8NkVp4z@camp.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2110201400020.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xM5sL7Zhx3sv+WXC"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2110201400020.56@tvgsbejvaqbjf.bet>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xM5sL7Zhx3sv+WXC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-10-20 at 12:02:02, Johannes Schindelin wrote:
> Hi brian,
>=20
> On Wed, 20 Oct 2021, brian m. carlson wrote:
>=20
> > On 2021-10-20 at 01:21:40, Eric Sunshine wrote:
> > > On Tue, Oct 19, 2021 at 9:06 PM brian m. carlson
> > > <sandals@crustytoothpaste.net> wrote:
> > >
> > > > diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
> > > > @@ -464,14 +465,25 @@ references, URLs, and hashes stored in the re=
pository.
> > > > +With text files, Git will generally the repository contains LF end=
ings in the
> > > > +repository, and will honor `core.autocrlf` and `core.eol` to decid=
e what options
> > > > +to use when checking files out.  You can also override this by spe=
cifying a
> > > > +particular line ending such as `eol=3Dlf` or `eol=3Dcrlf` if those=
 files must always
> > > > +have that ending (e.g., for functionality reasons).
> > >
> > > The first sentence in the paragraph is unparseable.
> >
> > Yes, I think perhaps I omitted the word "ensure".
> >
> > And I should reflect that they should have that ending in the working
> > tree, which I neglected to mention.
>=20
> Please note that Git for Windows defaults to `core.autoCRLF=3Dtrue`,
> therefore this sentence is not completely correct. Maybe something as
> short as "(except in Git for Windows, which defaults to CRLF endings)"
> would suffice?

What I meant by that sentence was that I should add, "in the working
tree" to the sentence ending "if those files must always have that
ending".  I believe that is still the case for Git for Windows, since
otherwise our shell files in the repository would be broken there, and
I'm fairly confident they are not.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--xM5sL7Zhx3sv+WXC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYXCXUwAKCRB8DEliiIei
gVr+APwL5vLTUdO8NA3mJw2Z7vX7740QP8B3UZKM8rxaLQmQ1gEAxbw+fV3GbKkN
XkNFzgUWPjEwFJqcB0PX1epkfckV4QY=
=bpQo
-----END PGP SIGNATURE-----

--xM5sL7Zhx3sv+WXC--
