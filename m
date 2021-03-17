Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF45C433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 22:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AA4664F17
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 22:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhCQWHE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 18:07:04 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42934 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229460AbhCQWGu (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 Mar 2021 18:06:50 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 360D960457;
        Wed, 17 Mar 2021 22:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1616018809;
        bh=Ugan7ineXZLoqycvFwb2c+jHXeqUY5gNekHpt3jhVco=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=kP1yRo2EwsYIxSOKNbHymenxbDH5Wkg5IBW9vprPc4fQEY99Hb6gNQStfDsCfmnxX
         QWhpxHDjz6sYKf8Lz75qHtRJ+h/pILPeoNCy7As1trLXmhPoufFXfH8OxC3rpgrMLw
         BzFaFQsVW3yn4kB074Mfi9Kh41c5c3bUeZ3O2DbDhigeKs0ncVBfSy3HLkg1HouFog
         /indS0R1uDZ0bHoaBGdizk01DoMhBW5lcN9b6dqPAwcDzCVDS61GNj4zN2X3TujlkY
         ckL5GADy9H+xuOlTKUFLAJSM6S5qo7KwZ6DzCk7exDriFhSDEDa0NcrjiLYnjzr+kb
         p8tbrRZaYZ2+euLj4v62erwkd3oqq8/1a72S5pkhTCxmuoJtzm6jWGgjTkiQ4SOyXK
         OXez2xsDfIRbSm3NCmXDo9XE93dWI77cv1EL/d+E+26N+z8dUemTn3xYWbWmuicUPK
         LPGD4H3r/G5+BsuKFzc0f5fp/ylTLi6y4CYjcaYFQyONwDNRLhQ
Date:   Wed, 17 Mar 2021 22:06:44 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     Eli Schwartz <eschwartz@archlinux.org>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: Regarding the depreciation of ssh+git/git+ssh protocols
Message-ID: <YFJ9dI96TO5IdGRZ@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Drew DeVault <sir@cmpwn.com>,
        Eli Schwartz <eschwartz@archlinux.org>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
References: <C9Y2DPYH4XO1.3KFD8LT770P2@taiga>
 <YE+ftT2WaKDzc+45@google.com>
 <C9Y4NXXX6HRI.1IROIK8ZXK4S2@taiga>
 <YE/ZSiuIsMs3ucVM@camp.crustytoothpaste.net>
 <C9YD4AEUH84L.29FP64NJJ1BPU@taiga>
 <YFADuptwV7iR76g5@google.com>
 <40740478-8b3c-b33e-8bb4-a2d68b83d385@archlinux.org>
 <YFCckC8fHmEyOAnp@camp.crustytoothpaste.net>
 <C9YUBUYH7PWU.3PHDZR2YCUEOX@taiga>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FYZNAhMP5+6z5uOy"
Content-Disposition: inline
In-Reply-To: <C9YUBUYH7PWU.3PHDZR2YCUEOX@taiga>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--FYZNAhMP5+6z5uOy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-03-16 at 14:21:13, Drew DeVault wrote:
> On Tue Mar 16, 2021 at 7:54 AM EDT, brian m. carlson wrote:
> > So I'm very much opposed to adding, expanding, or giving any sort of
> > official blessing to this syntax, especially when there are perfectly
> > valid and equivalent schemes that are already blessed and registered
> > with IANA.
>=20
> This convention is blessed by the IANA, given that they have
> accepted protocol registrations which use this convention:
>=20
> https://www.iana.org/assignments/uri-schemes/uri-schemes.xhtml

I assume that you're volunteering to write the RFC to register these
with IANA?  If not, then they are indeed non-standard and will remain
so.

I should point out that I don't believe the IANA will accept such a
registration, because they will believe it to be duplicative of the
existing scheme.  But if you want to go this route, we should only
proceed if we register them with IANA.

> > It's difficult enough to handle parsing of SSH specifications and
> > distinguish them uniformly from Windows paths (think of an alias named
> > "c"), so I'd prefer we didn't add additional complexity to handle this
> > case.
>=20
> There's no additional complexity here: git remotes are URIs, and any
> implementation which parses them as such already deals with this case
> correctly. Any implementation which doesn't may face all kinds of
> problems as a consequence: SSH without a user specified, HTTPS with
> Basic auth in the URI username/password fields (or just the password,
> which is also allowed), and so on. Any sane and correct implementation
> is pulling in a URI parser here, and if not, I don't think it's fair for
> git to constrain itself in order to work around some other project's
> bugs.

We accept local paths in a variety of situations and SSH specifications,
neither of which are URLs.  The ultimate problem is that we support
Windows paths and need to handle them correctly on Windows but don't
support them on other operating systems and need to not handle them
there.  So, somehow, in portable code which does not vary based on
operating system, we need to decide what should be a local path and what
should be an SSH specification and do that in a way compatible with Git.

Git LFS has also run into the problem that the URL parser we use has
gotten stricter in a point release due to CVEs against it which broke
various kinds of parsing of our SSH URLs that were previously accepted.
This almost certainly bit other Go-based tools that work with Git
repositories as well, since everyone uses the standard library URI
parser.

If we only supported valid URLs, this would be much, much easier.  That
is not at all the case, and it has never been the case for Git.

> > Lest you think that only Git has to handle parsing these
>=20
> I don't, given that my argument stems from making it easier for
> third-party applications to deal with git URIs :)

This does not make my life as a maintainer of said third-party
application easier.  It complicates it significantly, because people
often upgrade Git without upgrading Git LFS and then are unhappy when
the five-year old version they use from their distro doesn't support
every new feature.

Adding this feature which duplicates existing functionality does not
improve my life as a user of Git, as a developer of Git, as a maintainer
of a number of third-party tools which interact with Git, or as someone
who maintains part of a hosting platform.

It also will inevitably confuse users who will want to know the relevant
difference between the URLs and which they should use.  They will then
see the new type of URL and wonder why it does not work with the version
they are using.  And many users already don't understand the difference
between HTTPS and SSH URLs, which is compounded by the fact that many
Windows users have never before and will never otherwise use SSH.

In case it was not already clear, I'm very strongly opposed to this
proposal.  It seems to make a lot of needless work without a clear and
convincing benefit.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--FYZNAhMP5+6z5uOy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYFJ9cwAKCRB8DEliiIei
gUZjAP9Wbu6ZkQEFvm3EDubr9Q7wKurJ9JSI88l+wjJ9espFUAEA/4mmEIXZfM0w
iKcW2Boi3JAhJENK1gDoW0oByCcrewU=
=Y3vI
-----END PGP SIGNATURE-----

--FYZNAhMP5+6z5uOy--
