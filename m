Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9685C433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 23:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8F322076B
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 23:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="xxawV6TL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgHLXDK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 19:03:10 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41470 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726510AbgHLXDK (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 12 Aug 2020 19:03:10 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1F70860456;
        Wed, 12 Aug 2020 23:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1597273359;
        bh=rH/EyflsX6aJgXaZSU8BzoaC25sWLmDwaTvB7TcKLJM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=xxawV6TLrU1k0sRFVW7tkXsSccUJMOA4KlSWccm/esC8RnIl89CNTEYk0Fc2eBhnD
         3ZG2SbGZeqDT4YnF3re23HgNlzu9GyXzfwGWCxMhLDIv4B0jyUYx7OMumH+HU8FfXu
         FQAdSvFA0qgMzxQ2e3Ikjuwxq6uAwa0cePUQlO8O1vidFD8adlqwnmccR8Hjbr0ueb
         tKzZpZQh6VellxKPXPKU+5e8TuC54KTJH4l31fS5zf6/HmQsUXixc3ii/IEUWzyybn
         Zwq4X3nfj/c4tpXXFcq3ue9cxcN27zO/3+xMxdU2goxsKGKs3M1PQSsuVyZ5Cl8QPj
         Z03EOI9Ql/gSOjZdgeN1o7XjC4669DfdbMkAw0nYVeeQlkAPkjMpafEfKqt47p0/RC
         YhAL0pWaSQskuvEsaN8oAzHq1mMRYlGwz/v/frHjKnd+PwVbCBkIjBWJbI4bxU5jmc
         7WqyTYFOvpK7HKmNDzuB6BCGnRnKNxffe2ggNVOZspbyLc/6Zak
Date:   Wed, 12 Aug 2020 23:02:31 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Viktor Hozhyi <viktor.hozhyi@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Files 'Test.txt' and 'test.txt' are different in Git database,
 but are the same on Windows file system issue
Message-ID: <20200812230231.GH8085@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Viktor Hozhyi <viktor.hozhyi@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <DA41ECC7-D5D4-4E85-A4C3-C55CC2A73D53@hxcore.ol>
 <27608194-0D85-4D71-8D88-C1278D8DA173@hxcore.ol>
 <CAAkwws_Y56QF8XnsBgG+HSF_mRpetJGh6TnTbjCgdwZ88kov=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tT3UgwmDxwvOMqfu"
Content-Disposition: inline
In-Reply-To: <CAAkwws_Y56QF8XnsBgG+HSF_mRpetJGh6TnTbjCgdwZ88kov=A@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--tT3UgwmDxwvOMqfu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-08-12 at 19:58:55, Viktor Hozhyi wrote:
> On Wed, Aug 12, 2020 at 10:56 PM Viktor <viktor.hozhyi@gmail.com> wrote:
> >
> > Hi,
> >
> >
> >
> > I=E2=80=99m not sure whether this behavior is on Windows only, so it=E2=
=80=99s up to you guys.

This behavior happens on any case-insensitive file system.  That means
on Windows when the directory is not marked case-sensitive, on macOS if
the file system is case-insensitive, and also in some other scenarios
(e.g., case-insensitive JFS on Linux).

Both Windows 10 and macOS are capable of using case-sensitive file
systems or directories, so this is not exclusive to any one operating
system.

> > Repro steps:
> >
> > 1.         Having branch (let say) develop with empty working tree and =
empty repository =E2=80=93 create 2 more branches (=E2=80=98foo=E2=80=99 an=
d =E2=80=98bar=E2=80=99)
> >
> > 2.         Commit file =E2=80=98Test.txt=E2=80=99 with content =E2=80=
=98Test=E2=80=99 to =E2=80=98foo=E2=80=99 branch
> >
> > 3.         Switch to =E2=80=98bar=E2=80=99  branch and commit file =E2=
=80=98test.txt=E2=80=99 with content =E2=80=98test=E2=80=99 (pay attention =
lower-case)
> >
> > 4.         Merge =E2=80=98foo=E2=80=99 to develop
> >
> > 5.         Merge =E2=80=98bar=E2=80=99 to develop
> >
> > After it when you switch to develop =E2=80=93 you always will have =E2=
=80=98local changes=E2=80=99. You can perform stash, hard reset, commit =E2=
=80=93 you always will have local changes (and many following errors on oth=
er git operations due to local changes).
> >
> > Reason =E2=80=93 we have different files in Git DB (=E2=80=98Test.txt=
=E2=80=99 and =E2=80=98test.txt=E2=80=99), but when git restores them onto =
Windows file system =E2=80=93 it just will rewrite 1 file with another, bec=
ause for Windows file system =E2=80=93 it is 2 equal names.

Git was designed for Unix systems where files are case sensitive.  This
is the only behavior that produces correct results for all languages and
locales; it's impossible to correctly do locale-insensitive case
folding.  That Git is case sensitive is very much by design.

If you're seeing this problem, you can do something like this:

  git mv --cached Test.txt test.txt

For a directory, you'd need to do this:

  git mv Test temp
  git mv temp test

That will move Test.txt into test.txt, which will solve your problem by
creating exactly one file.  If you prefer, you can do it the other way
as well.

That's the only possible solution if you're using a case-insensitive
file system; the other choice is to use the Windows 10 tools to make the
repository and its child directories case sensitive.
--=20
brian m. carlson: Houston, Texas, US

--tT3UgwmDxwvOMqfu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXzR1BwAKCRB8DEliiIei
gc16APwMrAIcsG3+HRrmP1y5pnxKv/vkofaovR9efGeOyWlEEQD/Z0eLyVHv4He7
c5y0yZ3M5UbtqCuUIuz3YSfwXl6YfwI=
=+okb
-----END PGP SIGNATURE-----

--tT3UgwmDxwvOMqfu--
