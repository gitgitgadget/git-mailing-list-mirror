Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F57C433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 23:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 261192074B
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 23:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="zsolYurr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgFJXjs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 19:39:48 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39212 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726543AbgFJXjs (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 Jun 2020 19:39:48 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 570136048D;
        Wed, 10 Jun 2020 23:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1591832356;
        bh=MaKvzx/Ar0GH6flpbBLcsmU1n8jEYl4ye7jORTwCAAI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=zsolYurrm4LxeFnxD073D0VpE3qQcwQIa/ajHbEtYBedEFgi8e48EqvBI2j7FPZV+
         KBqd6J/pZVyH6nZVj98TRlFvACsvL1K/jEFTAUQtZp0zxYIdm77pV9zp1CLnOPvkEB
         /cJ9KGJNAt0MtEy5b5zKCdyISvV+5DC58sS/ZV4z9actHW2h2u6WLZ41cUrEFMkCTW
         qocoXmU+/ZNStyBT+zKgDCLHbTQ2AzJv1eD6Mh0oOfEB7ZuxMetwYZdxaALQHSPNae
         itJLgWSKPBHnYOoC6/mx2T/mKX9llPGPwlpxEaIozH+XUtzYNoLbWN1xgXnIsGWlQJ
         Zv/+L8lTJr9m6Guu91pfjUnr2H/QPMhsfUexIPwu/qCwFW+I5+XtR8PteKbC0IH9R9
         kSWZrrA7rlh61C+LZep83QSaCt+2moOFvyM64jOysvymijJilh5lWYA+6PXvtaI4tS
         KiM6ax+KhrYny/eT6zfIpTBtIq3OnK7kk74mwZh6Y8Hq77FNXyb
Date:   Wed, 10 Jun 2020 23:39:12 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Matt Rogers <mattr94@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        don@goodman-wilson.com, stolee@gmail.com,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 8/9] fast-export: respect the possibly-overridden default
 branch name
Message-ID: <20200610233912.GU6569@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, don@goodman-wilson.com,
        stolee@gmail.com, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
 <1efe848f2b029e572cea61cadcfe36b9d3797836.1591823971.git.gitgitgadget@gmail.com>
 <CAOjrSZvm9QNUttUNVBEUMPJ8zgYEoAnSPN5_6N5uwpiM1sVrcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NHfequSh1hmJPP0s"
Content-Disposition: inline
In-Reply-To: <CAOjrSZvm9QNUttUNVBEUMPJ8zgYEoAnSPN5_6N5uwpiM1sVrcQ@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--NHfequSh1hmJPP0s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-10 at 21:54:01, Matt Rogers wrote:
> > -        * We also leave "master" as a special case, since it does not =
reveal
> > -        * anything interesting.
> > +        * We also leave the default branch name as a special case, sin=
ce it
> > +        * does not reveal anything interesting.
> >          */
> I feel this is a weird thing to do, since you're trying to anonymize the =
branch
> name,and now the default branch is identifiable with your config file.  F=
or
> example, if the default branch contains the name of my project/repo then =
this
> sounds like a recipe for accidentally sharing it. I feel a better
> alternative would
> be to exclude nothing from the anonymization or the proposed default defa=
ult
> branch name

I think this is fine because it only reveals the name of your particular
choice of default branch.  The goal of the --anonymize option is to
allow people to maintain the structure of their repositories while
stripping private information from them, primarily for debugging
purposes (e.g., providing to us for troubleshooting).

The things people want to prevent exposing are their code, data, project
names, user names, etc.: that is, anything identifying, privileged, or
private.  The default branch name isn't any of those things; we know you
have one, and for troubleshooting purposes, we aren't that interested in
what you called it.  You've almost certainly picked it out of a set of
one of 20 words that people use for this purpose, none of which are
private, and all of which are shared by millions of other repositories.

In the extremely unlikely case that it does matter, invoking git with
something like "-c default.branch=3D$(git hash-object /dev/null)" would be
sufficient to anonymize all branches.

I should point out that people frequently ask for the output of "git
config -l" for troubleshooting, and most people wouldn't consider their
default branch name to be worth sanitizing there.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--NHfequSh1hmJPP0s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXuFvHwAKCRB8DEliiIei
gRyiAP9nxf3ysO6zqfMFvHzl5MlLUpSh9dfsrUGzdIp0RNKh2gEAopc7fqS6LJwN
1ZYOWXWAJCaKqdPMtBzOHyfnV1dmvQI=
=ggih
-----END PGP SIGNATURE-----

--NHfequSh1hmJPP0s--
