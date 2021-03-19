Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60435C433C1
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 21:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29F896191D
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 21:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhCSVDm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 17:03:42 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:44536 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229956AbhCSVDW (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Mar 2021 17:03:22 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 90D5560479;
        Fri, 19 Mar 2021 21:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1616187771;
        bh=fsGmlCIVI2ypYt6RlNCql2prqGgoRD7ktSN8LO7WTSo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=IvOZ+ohBB5Bf7sHy7esrvwXGw2rV54A4LNHJXpoJjwGL4ARs5UevYEEG0UdBLq5I/
         yLXBP3BnhMMkOGKWIHoK7fIc/Pzra3midIcsgfXtP0X5l+Jmmf9Ne+lNtu7C/LPRoN
         wtet0rk7Z8Odtxbgi4T23f92PA43pDmpOyCGJLkAykgOw4jbQkE9iHYHNya2HvVIjT
         kaxjSrAkHFBRR3s0e8gUr1fV7R/q3d9E7JpALFDq5Rbmlg5nV2mLMZf4wM3tVmpj3M
         KHhHeDDTR2Tw4ZomKiV7Ly9Pkl78UD/Tpjpj/GTLTeHfg5zfckX4WhddzZy4mfq/eS
         Ko/2BLBSbnXt8TShh+wz8XsO4cjFixXk29oXC0MxViXDqAbcXWOv7HbIh3RZBSw18l
         OyA2snA640RtzgJDoxuVJ/IIHm6SO8GkwtT5hg2r6H/zcgLc2dZBlwi5P9MOOAuOeT
         4hmGiaDpQ2DydvXEnRrPk6/jsIGPFWI6wX4XLhzu8pkmm8rybRE
Date:   Fri, 19 Mar 2021 21:02:46 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Christian Chavez <x10an14@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Are there any publicly known funders (companies or otherwise) of
 git development?
Message-ID: <YFURduetSoPW/Scd@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Christian Chavez <x10an14@gmail.com>, git@vger.kernel.org
References: <CAF6oXFsnvvacvUY89s65us7-UprpvV-NaOQ3owGTF25xcJqnkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Gd3ZdGApbD/kfq25"
Content-Disposition: inline
In-Reply-To: <CAF6oXFsnvvacvUY89s65us7-UprpvV-NaOQ3owGTF25xcJqnkg@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Gd3ZdGApbD/kfq25
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-03-19 at 19:31:56, Christian Chavez wrote:
> Hi!
>=20
> Idle curiosity question - stemming from an argument with somewhat
> inebriated co-worker(s):
> > How is the Git development (being an open-source product) pro bono? Don=
e for free?
>=20
> Or is there any (publically known - not just an employee "randomly"
> being told to upstream a bugfix) funded effort?
> Such as with the Linux kernel project - where companies/organizations
> put up money for X amount of time/efforts/projects?

There are people in the Git development community who usually work on
Git most or full time as part of their role.  That doesn't mean those
patches immediately make it to the list (oftentimes they are tested and
deployed internally first), but they do generally work on Git most of
the time and their patches do eventually show up on the list.

There are also people who work on Git with their employer's 20% time.  I
believe we have several such contributors here in this case.

There are also people like me who usually contribute independently.  I
have sent patches upstream that directly benefit my employer by fixing a
direct need (in some cases written during work hours, in some cases not,
depending on my employer at the time), but the vast majority of my work
is independent and done on my own time.  There are others who just
contribute independently altogether because they enjoy it.

I would say that of the top 20 contributors historically, I know that 4
fit into the first category, 2 fit into the second category, and 3 more
have some other corporate affiliation known to me (but not into what
category they fall).  There are others who have more recent
contributions who are also known to send patches on behalf of their
employer.  I just don't know about the rest, mostly because it hasn't
come up in context and it's never been important to me.

There are some employers that are well known to employ people in the
first and second categories, as well as some that are known to have
staff that send patches on behalf of their employer.

Hopefully that answers your question reasonably well, even if it's a
little vague because I lack all the details.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--Gd3ZdGApbD/kfq25
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYFURdgAKCRB8DEliiIei
gfWJAQDKcvL2WHMdvv47OWgEf7G2iGcFWw3fmiw50/rYigxxTAEA2IUpCBnuE1NR
xwhFaDDR10AUlKZ5OW8WLTl2YaIrWgM=
=XKIL
-----END PGP SIGNATURE-----

--Gd3ZdGApbD/kfq25--
