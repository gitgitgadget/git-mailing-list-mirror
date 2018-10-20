Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC8811F453
	for <e@80x24.org>; Sat, 20 Oct 2018 02:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbeJTKpI (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 06:45:08 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51598 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726502AbeJTKpI (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 20 Oct 2018 06:45:08 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:65d4:dc3c:f6f5:933b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8688B61B72;
        Sat, 20 Oct 2018 02:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1540002979;
        bh=HKsHNYN7P44MwtbdqHsoWhnSLb1g8SZFFWKSEEUnhZU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=D2VOOPH7F0MSLWT1i90rerxXapj/X5y5yNWyS8BISzTpKJmNTCHHOZjgUb8ZH0XOC
         EWo8vKzAf50pJg0uO14JFTYcbYZO8CdWHtgEPD5pSxpFsTPz2P0SwNKm4a5aW7mMee
         JeEXq+BHHeCLiTXKu90y5rrS69gccJR18aCgl2CwsJH+suuvofZxSvYgPdOy0vI2T+
         ue3tEtIQCL2mmbi+zxbJeNzdDPkKQZbgObC+4lTsXU3msyTlJSrQ9cV5kVZitlwNJr
         IpzeJf2qs46+OLKE9U+nMlse+Km1GWrzf43nUdp+awtaI3q/bezxESVYFt/xJ6dxHw
         PU8jrcrysXW3d/86wTtpPm7ay5qBkVMxx7c6N62kh2yUVjI2WlNo3m/QddYDmTCuW7
         T4ZvkJwQJiByFFJd6FqQ7NRUSzxdq6BuFC+SyfjFYzsnV3vuhGox/zd7YHLG21GlS2
         lcXjGOWbmFz3v/XIxKD7zKzSMZDiQ0itNXhev7D4UdehJ50Q0FL
Date:   Sat, 20 Oct 2018 02:36:12 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Mahmoud Al-Qudsi <mqudsi@neosmart.net>
Cc:     git@vger.kernel.org
Subject: Re: Shouldn't git be able to apply diffs that it created with
 --ignore-whitespace?
Message-ID: <20181020023612.GO432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Mahmoud Al-Qudsi <mqudsi@neosmart.net>, git@vger.kernel.org
References: <CACcTrKfVZsRC8y-89mnj6LnRHnT6ivQCHpc0p5ABXk4kds6MbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5t1z8kqiv7KqGNMe"
Content-Disposition: inline
In-Reply-To: <CACcTrKfVZsRC8y-89mnj6LnRHnT6ivQCHpc0p5ABXk4kds6MbA@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5t1z8kqiv7KqGNMe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2018 at 03:12:09PM -0500, Mahmoud Al-Qudsi wrote:
> Hello again all,
>=20
> I think I've previously broached this subject before, but I think I perha=
ps
> wasn't clear enough about what I was trying to do or why I feel that git =
is at
> fault here.
>=20
> (I'm running git 2.19.1)
>=20
> Starting with a fully-committed, not-dirty codebase, I open(ed) a poorly
> formatted, mixed-whitespace file (that I absolutely did not author!) under
> version control and make some very localized changes. My editor, being ve=
ry
> smart and helpful, fixes up the line ending on save, and I exit.
>=20
> At this point, my source file contains a) deliberate changes I want, and =
b)
> whitespace changes I wish I could commit but that should not be a part of=
 my
> patch.
>=20
> Shouldn't the following workflow be supported:
>=20
> ~> git diff -w > foo.diff
> ~> git reset --hard
> ~> git apply [--ignore-whitespace] < foo.diff

In general, git diff -w doesn't produce a patch that can be applied.
That's because it ignores all whitespace changes in a particular way.
The diff output is rendered as if the whitespace in the lines were
written as it is in the postimage (the changed file), not the preimage
(the original file).

This is useful because usually if you're, say, indenting a block of
code, you want to see the output properly indented with the new lines of
code (say, the loop or conditional) you wrote around it.  And since this
feature is designed for visual inspection, it makes sense to do it this
way.  However, it essentially means that your changes can't, in general,
be applied.

There are, of course, situations in which this might have worked in the
past, and it may indeed work for some situations still, but it won't in
the general case.  git apply --ignore-whitespace only modifies context
lines, so it doesn't affect the actual content lines in the diff.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--5t1z8kqiv7KqGNMe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvKlJwACgkQv1NdgR9S
9ot6Aw/+Nxsb31+s7g6AZCHpG4PvZSvPqzeOqN6ayaGFOEd7npQ3c2n6tfQ/BV6Y
hPKQWR1EfLIo3Eam5PJVjEDPp1rbpYiREM1YqcAMunrXpw8BOCF66pgVuRIsQ1Qk
EAqqbyUzLbqo+XY/sYHitYv9fnpcHpyn3gW3SyWnOMRUGtlm9rFaEB+TI1U9vPIR
9g7XUo8/wdC/qqt9KJM6jpR0P4jFwuqx3a7gVfIOVL6KYlavasDYVJdw5K1sYU4Z
7aY3FzkXEi5XfBJVgoUEZCV/WHlP3RztHse8xO2tCoqN4c5gzAVV8DWpav2p9lYG
pZxr9KzDERj/PxWwglSR4fsHWFBqLvIIDDnN76uUhgpBAAgZnJkhEV2Q9pm+MBf/
aFLnav+D5kjY9HZcmGXWcErq3XISqEKOhClcp6EUWlHHqCjegskUYbsW+D8/IZsA
78WQHRHAVT6i49qcpT+xRhwIk1GzptE5t9w0kfs4V01tuNsX5nNTCn2nZV2RxonA
E2PPALNyfqjXuHWC2Ze0yamdvMCeNK/MfIqTqpLOOiu/dGG4gW6RJE/4VucQtOvT
HVCaQFW3b9rqicaBCA9ciE5IMwr6KWzjdZeLofwAblQhDLqwoPW6sHRRWfpByEGd
Us7SkDDHAb1aVlqOOIAj5+20AIYMW767YC0XOCgnaoC1iBDpsfY=
=ssPn
-----END PGP SIGNATURE-----

--5t1z8kqiv7KqGNMe--
