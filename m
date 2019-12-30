Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B9FC2D0C0
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 02:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7472071E
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 02:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Yft8fiAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfL3Ccz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Dec 2019 21:32:55 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54356 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726832AbfL3Ccz (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 29 Dec 2019 21:32:55 -0500
Received: from camp.crustytoothpaste.net (wsip-174-77-115-162.ri.ri.cox.net [174.77.115.162])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5F7F960433;
        Mon, 30 Dec 2019 02:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1577673174;
        bh=BwC9BjbiBPGeIEhruHB3YN2glBGbvu8qIVCyIhiW078=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Yft8fiAMP20lmnXYMP5wMN1lh7to81+aQkSKMPInZRxIH2nSFHMOTOxYm8jT6AEx2
         QR9XkPEZhwYe5I88xBg0fuK5nBmbyIK6nM1dnILPKR9AHzMvQOnArtKCYUvlNMesbJ
         pHdfbkGwyEaw7KsV9TmLhpPvCq8sfy+hUPjYCsPfptdxzzuUpMEkuoqPKpiIe4PYTq
         6DahSt7ItRpvMQJDXVzwlr0REKPPIOoaRoVFS/dOkXSRyuozfaiTtve+J/BoKX2fxU
         CQeTtvBD+J9wH3wxaryk4nAWMT9YxM0OHX1Dqm3IBPRTrYsrA9HVaOVGstBheXOcXX
         6AG9SAsi9/EcU2rpbDIf4Q9NZkw2zTHeu56NX3GDw9bTW8zHcXz9cditcn8rApBVD9
         epN37Asg7uvjInvuAFwMa0ueZLz8tFEBuEb1dQCzQQ7x+NAj1ZwjkcIE1FuYzogGzW
         PZxMOlA6iQY5m/UzEJG3D9MXzQzImN5gUmMbKr0gY5JYY89uGab
Date:   Mon, 30 Dec 2019 02:32:50 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Arnaud Bertrand <arnaud.bertrand@abalgo.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Arnaud Bertrand <xda@abalgo.com>
Subject: Re: [RFC PATCH 0/1] *** Add branchname in commit header ***
Message-ID: <20191230023250.GC6570@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Arnaud Bertrand <arnaud.bertrand@abalgo.com>, git@vger.kernel.org,
        gitster@pobox.com, Arnaud Bertrand <xda@abalgo.com>
References: <20191229222633.23815-1-arnaud.bertrand@abalgo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HWvPVVuAAfuRc6SZ"
Content-Disposition: inline
In-Reply-To: <20191229222633.23815-1-arnaud.bertrand@abalgo.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--HWvPVVuAAfuRc6SZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-12-29 at 22:26:32, Arnaud Bertrand wrote:
> From: Arnaud Bertrand <xda@abalgo.com>
>=20
> For tracability purpose it is often necessary to know which
> commit is envolved in a branch
> Keeping track of the branchname in the commit header
> will make this traceability easy and will facilitate
> the graphical toolis that represent the branches and
> that have today to use complex algorithm to try to
> determine the branch of a commit that was known at
> the commit time.
>=20
> no big change in the code, today rebase is not considered yet
> I'm waiting feedback about that before touching
> the rebase code.

I encourage you to read back in the history of the list as to why we
haven't done this and why it's not likely to be accepted now, but let me
provide a few reasons of my own.

First, as any contributor to the mailing list can tell you, I am
absolutely terrible at naming things.  I frequently name my branches
something that makes sense to me at the time without regard to whether
that will make sense in the future.  I don't want to memorialize my
momentary thoughtlessness in the history of the repository forever.

Second, one workflow I commonly use is creating a branch with many
commits and then breaking them down into small series that are logical
and easy for review.  If I have a branch called "test-fixes-part7" with
50 commits and then I decide to split that into two branches,
test-fixes-part7 and test-fixes-part8, by copying the branch and using
git reset --hard to truncate the old one, I don't want the old branch
name in my new branch.  A lot of Git workflows assume you can reset and
rename branches this way and having the branch name in the commit header
breaks those workflows.

Third, people reuse branch names.  Right now, I have eight branches with
test fixes all starting with "test-fixes-part" because I'm working on
one major project with all of those test fixes.  However, if a developer
working on another major project also has a lot of changes to the test
suite, they may have lots of identically named branches, which would be
confusing, since our identically named test fix branches would relate to
different projects.  (See my first point.)

However, despite the fact that we aren't likely to add this in the
commit header, there are definitely ways to achieve this.

If you want to include the branch name in the commit, you can do so with
a trailer.  git interpret-trailers can then be used to manipulate and
extract these, and along with a hook, add them automatically if they're
missing.

If you're working on a more centralized project and you want to require
the branch name in your commit trailers, you can set your CI system to
fail or reject commits that don't contain them.  This is the approach
that systems like Gerrit use when the required trailers are missing and
it seems to work reasonably well.

Hopefully these suggestions are helpful in getting you the traceability
you desire without requiring fundamental changes to the way Git works.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--HWvPVVuAAfuRc6SZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4JYdIACgkQv1NdgR9S
9osY0w//bOferbz0VbK47V6+WEMsoLnVSBqBGCCMYawKTLJIMU6geheynU3WhiD8
0O1985WGnYv1y5Acx8W7ZHFKL3mJvCxrEJZ8DuRB8XoX7NDjPu/vCZzAChKUzH4j
J82noChCnQDsp7BYVY7L6mQ+wCq5xQx/ne0JATdQ5Z9Ru4Ql1RMxohTXIfI8P3L0
AaRu04k1MEdoMphwL5dJLGJzCV98ZX2bS2GFYD6NqR7Kic+uE1hm95M00Z+wganr
C7eSGw/i20cWQLo4D7tJtLkUTzag11bT1gkDIXrK0UivqllFNvvC55JMiRpV+LgG
E+sui19wkpQ0U8o+ucYXKqKQTcX+n1qY8r3h5U0e9Btb4U/GhEosIT/b8rHZRst4
t3/PHMkAgSIUdtpK9YBbIjNBl2ApZ4bXPqpU9taeR403NXblph/xZLve2Aazprmm
5+Iwk7Lg9VHdEI501s1cC/3QpTvif7ldXej5CzVcuZrGalBS8EBlbX/cIbrtGPeh
HnTqbcnXBMhyildRBi5Mici5rUDhgUwD99XWYQaPO4KLHj3SMWPpVXA3D5MgjHlJ
BmUdHNFuGpfSApBDzI9RV34VFRl45EzbnicCLB0sRdAUAoYm6CSbCJMzh4zcIn+G
F544SXLcfaCWMJ+WoBcCbvK/eS1u45X2J1p0J87L2VYqaS9ylFk=
=cn7H
-----END PGP SIGNATURE-----

--HWvPVVuAAfuRc6SZ--
