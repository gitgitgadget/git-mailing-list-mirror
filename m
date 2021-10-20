Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6862EC433EF
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 21:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 521AC61130
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 21:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhJTVjt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 17:39:49 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37670 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229695AbhJTVjs (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 20 Oct 2021 17:39:48 -0400
Received: from camp.crustytoothpaste.net (unknown [72.12.180.34])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D320060473;
        Wed, 20 Oct 2021 21:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1634765823;
        bh=AFFQw7KBNzxYwDq25IHmK2NkexDoKlrvLmqYDPFHlT8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=WPkbqPMq1StgoAilF29mCIlDAsyRplGm11wYhjdvedP8uLmPY7flxzcwRoBn1odCD
         cqUSq8tTrWyRRFJDcRHOCUq5jgzQdFP+YLsVQVV+80ssg7fWPIRhHG+3mbxwlrk6/6
         3gZBg6HIoEhokHVeU/FgWOFs5Xe64/jiGt0ZzmGSywl1ODAhDd+KeQSuFPqFXalWKp
         tR5ZP+k2z7Gu4bLRKRXgbZUl7g/xS2HGrh9oxSKnkY0HoEvC4EtDQmMcNYp6jnjWBZ
         7IgQuGUZgrA+6YoBcXnVJsmJsvuvIaZF/R99/x8JilSMdNQ5j4D2XE/rwu/gcxN3QS
         pBFxg24L91ywktyBbdl48az7X9NSzFhOTN3aPvfzVInfKLYHOKnreRDj3zDqU9My5T
         XrWMk2jTgxx+8CzD7+bQIFLqhqDaaZQp4H+RMFprNxsGU6wglWjfJ6qyLPx23mXhgx
         oidj5f79YFQWwoXp0jSwr3mP3EZdH8WVes7vWA8LFFOwsDY0gVb
Date:   Wed, 20 Oct 2021 21:36:41 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 4/4] gitfaq: add entry about syncing working trees
Message-ID: <YXCL6dyhoBA708X0@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20211020010624.675562-1-sandals@crustytoothpaste.net>
 <20211020010624.675562-6-sandals@crustytoothpaste.net>
 <CAPig+cR=wQYthORMfyf4ShBCTXyWkQJqH6YHuW4Uv-Ys3wef5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="td/XbbeboF47vcdJ"
Content-Disposition: inline
In-Reply-To: <CAPig+cR=wQYthORMfyf4ShBCTXyWkQJqH6YHuW4Uv-Ys3wef5g@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--td/XbbeboF47vcdJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-10-20 at 01:38:47, Eric Sunshine wrote:
> On Tue, Oct 19, 2021 at 9:06 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > gitfaq: add entry about syncing working trees
>=20
> You sent two [4/4] patches. I'm guessing the one prefixed by "gitfaq:"
> is the correct one.

Yes, I appear to have done a bad cherry-pick.  Will fix in v2.

> Considering the potential damage which can result from this sort of
> synching, this entire section seems too gentle. My knee-jerk reaction
> is that it would be better to strongly dissuade upfront rather than
> saying that it's okay to do this if you really want to. As such, I'm
> wondering if organizing the section like this would be better:
>=20
> (1) Make a strong statement against doing this: "<strong>Don't do it.</st=
rong>"

I agree this is dangerous.  The reason this is so painful is why I long
ago stopped having a desktop: I needed to sync in-progress work
frequently, and having multiple machines is too much of a hassle for
that case.  The laptop is more portable and can be used everywhere, even
if less powerful.

However, some people do legitimately need to work on the same project
across machines, and the current tooling for syncing stashes and other
in-progress work is insufficient.  Therefore, if we just tell people,
"Don't do this," they're going to stop reading and ignore us, because
we've neglected their needs and they have a job to do.  That would be
worse, because instead of using something like rsync, they might use a
cloud syncing service, and then they'll be really in a bad place.

However, I'm happy to try the reorganization you proposed, even if I
don't necessarily adopt the strength of the proposal, and see how it works.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--td/XbbeboF47vcdJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYXCL6QAKCRB8DEliiIei
ga5rAP9lf1PiQuovKlDuE9D7+4FaQW5fHV4dLLZo6rzS1IgLbAD/Wu9bSYHZMWAN
XIAwlvLZkMu+QHhs2VePLBz8zRZJ5AU=
=/1bw
-----END PGP SIGNATURE-----

--td/XbbeboF47vcdJ--
