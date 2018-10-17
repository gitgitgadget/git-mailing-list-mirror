Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C5F91F453
	for <e@80x24.org>; Wed, 17 Oct 2018 00:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbeJQIrg (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 04:47:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50996 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726168AbeJQIrg (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 Oct 2018 04:47:36 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:90d0:bd19:fb95:28cb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2895261B72;
        Wed, 17 Oct 2018 00:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539737670;
        bh=Am4JaYIuPPuOYys8wfugLChoYdGw184bqJKu7HSgV5w=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=TnA8+m9DQyioIce6pzr97QuUisEhvC76u7YKbVAF5oYVXAjuyoRGNwwZ4LLKAl5eo
         D2mCRD+Ww6zMa6U5GWerBXaPWdyOI66DoqzOmIZ2SUDE/az+3oH/tZTazmc+E1+A6R
         IOEC/adBUL21SF3+ftrWrSkutqnRtchoJ5y1yUQ1EjtmgN2EYS3+8vrNlvk1zjuO7V
         mlwQF+q5uRk2wkWdi+r+9isoHH9vxM1xhZGld7YdE94tAJJVebGBQRKmilGJEZxZLK
         IFlBACFYlRAqA9zqBA15gBgcNqC6cxPm50x5F8rgVYDq1X/p9fQMPRGh4lzuuju7nb
         uxoY21GsJcl3yQZLIXZn/KgHpH4zRJk/nvgbBwjJAXOhxKWxw4LRlvppeSYPYSkqGu
         JSlAeNW22O/7HUioIoDMwyJoKUDQJ1ktlGfIOf4S9uiLyK5YNFGstWMt+ukfZ3q5RC
         17dm5OpwyJc0Cdu9CHWwqoDJmTrKmhbfWEXZGmKc4WpKt/TdEKf
Date:   Wed, 17 Oct 2018 00:54:24 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stas Bekman <stas@stason.org>
Cc:     git@vger.kernel.org
Subject: Re: problem with not being able to enforce git content filters
Message-ID: <20181017005424.GH432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stas Bekman <stas@stason.org>, git@vger.kernel.org
References: <5d4966c8-8171-9a0a-5120-f7c151c2b81f@stason.org>
 <20181016232636.GF432229@genre.crustytoothpaste.net>
 <038d40b9-0b35-b93f-9377-7c0bb12bce8e@stason.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xVNRhe5Alm/fDnuT"
Content-Disposition: inline
In-Reply-To: <038d40b9-0b35-b93f-9377-7c0bb12bce8e@stason.org>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xVNRhe5Alm/fDnuT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2018 at 04:48:13PM -0700, Stas Bekman wrote:
>=20
> >> And the devs honestly try to do their best to remember to configure the
> >> filters, but for some reason they disappear for them, don't ask me why,
> >> I don't know. This is an open source project team, not a work place.
> >=20
> > This sounds like it could be easily solved by continuous integration.
> > You could set up a job on any of a variety of services that checks that
> > a pull request or other commit is clean when when the filter runs.  If
> > it doesn't pass, the code doesn't merge.
>=20
> This is an excellent idea wrt to PRs. Thank you, Brian! I will implement
> that.
>=20
> It doesn't help with direct commits to master, since CI would be
> detecting it after it was committed. And when that happens we all know
> that already because 'git pull' fails.

Typically projects that have CI set up don't allow direct pushes to
master, since that tends to allow to bypass CI, or they allow it only in
exceptional circumstances (e.g., reverts).  Also, typically most
projects want to have some sort of review before code (resp. documents,
other contributions) are merged.  Most Git hosting platforms, including
GitHub, offer protected branches, so it's something to consider.

There is a possible alternative, and that's that if your project has
some sort of build file (e.g., a Makefile), you can set it up to
automatically insert hooks or git configuration into developers'
systems, optionally only if it's in a Git repository.  For example, you
could add a pre-commit hook that fails if the filters are disabled.

These are the approaches that tend to work well for most projects.  I
tend to prefer the CI approach with restricted branches because often I
want to customize my hooks, but your project will decide what works best
for it.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--xVNRhe5Alm/fDnuT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvGiEAACgkQv1NdgR9S
9ovyow/5AUvW3qR/WnaMGtON40pHsQGGFUNREJCZL0PJMkm+xKr3sL1deoOfz1dM
EkmQfLfwOlvIXH1/wxuMcGhO1cOYSfjVv/FRRSsj3ZyJz2BoIUM5fFeAYu79BYlj
8A/Xptyw1Gc69JtX0xbw0gaqlYyJVl7YHta1k6/cZOFZYHxIBMyN3YvfgC2uC6Xj
CFOw0mmuB08efW9IynDSRElqBZPJ4tog3Uj+HDK/yDM7xxA0NfWskxSiA7o4FKBs
qLKlZXygI3g2npXfEPM7CvfTEOJwFKUlfG5rf47TBA4zkkOKzZVWjhV4F1T9r6UQ
uR6mIzmbptvyjXT6Ud0g3LESRs9Kc1KytD4ry4VzBgyOqZ0fUOL+ZPnPewzUaLhV
ppepjJXZGOnIcM0+n9ykN3wNqxIjF19FVvddgsKsoD+3fnQ3nCU5fPDi0pLk0Wv9
OSjsb9QNjwqDn8pRsEJ6Qr15drz0yr0JrZ7erRKEzUfqP5GhW25eISkWOBYYOoC7
JJ12ZTHrKzvS/H6nDM2Cu5c1fWJbfjnWzcpCboZjQBmyD06LYq28t6TQl/xuOAE+
A+Ipxd9HmDVzu3m/2rZ+pZzNr66jN1RlwBZ2rychzp2ujcNJKOl4/P3xOopgnfXP
uvSse7mmMt27asFwAUdUoajpz+RiCXC30qVIs9kKqx0zzMrrYZA=
=fnAH
-----END PGP SIGNATURE-----

--xVNRhe5Alm/fDnuT--
