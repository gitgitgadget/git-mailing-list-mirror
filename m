Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75443C433E0
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 19:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CAEB2075D
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 19:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="y+HeLfna"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgGJTzs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 15:55:48 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40512 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726828AbgGJTzs (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Jul 2020 15:55:48 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E7F556048A;
        Fri, 10 Jul 2020 19:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594410917;
        bh=IIeMwaCkpmUptv2+9VqS4Kjthpg9EI5aK2miO9wRUfo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=y+HeLfna8A+2JjTWAx8+EopOcfHO4zVrKR6x1NvWVDUc/pOKGCo969icOKaae02Gu
         /VJuzg94BSfGu6xJcc5kzdOHP5pvjFr3WzAt7NygsW0Ecg7tQoPOWFIhE1pVPoxmyC
         BAmiTN3blZ6YjrMr0jjT1xI904tBVmrQiZVyKaWuCyheGY/QuN27nYjxozcH2YAQ5C
         jGRKMOErwTvsJdsxc7wOQN5EfLWvtJ2iq3dLg4l3M+o9DeEsQg9LAG2s+jrUNJObq+
         Ii5iLt5cH915ZWjxl/F8lSb6MSenbmvva3ZRW7MDs6v+hucAafVeC/9RLx4qg7T8ES
         DytlNCjWDUyzagzR6A2/tIf96qtbKWcey7yznq61hgvCuglJqjUYnNmhMcwHubdMjw
         BDiJEoXaEToD877LDndaaJ00RM8z/nBW4LmOEpRr/DMvE1VL2YSp7w4RuyeaXvnTwI
         /SQ0bnWsTyZ5fj6Q6EZd/514VgdEWOKFRKZ1CZeWhLHWVokIx7v
Date:   Fri, 10 Jul 2020 19:55:07 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 00/38] SHA-256, part 3/3
Message-ID: <20200710195507.GK9782@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
 <68cc8fe8-3400-501a-ead5-a9c008605e74@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ibq+fG+Ci5ONsaof"
Content-Disposition: inline
In-Reply-To: <68cc8fe8-3400-501a-ead5-a9c008605e74@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ibq+fG+Ci5ONsaof
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-07-10 at 15:14:37, Derrick Stolee wrote:
> On 7/9/2020 10:46 PM, brian m. carlson wrote:
> > This is the final part required for the stage 4 implementation of
> > SHA-256.
>=20
> WOOHOO! What a milestone!

I'm also excited about this.  It's been a lot of work, but we're finally
here.

> As usual, your commits are excellently organized and clear. I could
> not find any fault in any of them.

Thanks.

> The proof is really in the pudding: does this pass the test suite
> when GIT_TEST_DEFAULT_HASH=3Dsha256? You add that as a mode to the
> CI scripts, so we will know.

I've seen several cases where we've accidentally regressed things with
SHA-256, so it seemed only prudent to set up CI.  I've run it locally on
my system and it works for me, but we'll see how it fares on the CI
system.

> I made a recommendation for a different model with how to do the CI,
> but it's super minor and can be done later. Basically, if we create
> a new job for SHA-256 mode, then we can more quickly identify when
> a test failure is due to that toggle and not other optional GIT_TEST_*
> variables.

I think that's a good suggestion, and I'm familiar enough with GitHub
Actions that I think I can set up an additional job.  If I reroll, I'll
try to squash such a change in.

> I hope to play around with SHA256-enabled repos a bit later, to see
> if I can find any issues poking around on my own. I doubt I will,
> with how thoroughly you modified the test suite.

For folks who are looking for a more convenient way to get patches,
you're welcome to grab them from the transition-stage-4 branch on
https://github.com/bk2204/git.git or
https://git.crustytoothpaste.net/git/bmc/git.git.  The GitHub URL has
slightly more bandwidth and a generally better uptime, since I don't
live in a datacenter.
--=20
brian m. carlson: Houston, Texas, US

--ibq+fG+Ci5ONsaof
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXwjHmwAKCRB8DEliiIei
gezcAQCZXe3Gk9c+wMo4u3foYvJHW47Ayzqc+d/oVhYIR5zEkQD/Q02VlCULTZrm
387a9hiEUlqDbtjQYOeCSX8mPRx6jAY=
=hyFd
-----END PGP SIGNATURE-----

--ibq+fG+Ci5ONsaof--
