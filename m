Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DF6C433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 23:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0816F2068E
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 23:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="pbXTLdP4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgFOXK5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 19:10:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39322 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725960AbgFOXK4 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Jun 2020 19:10:56 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5F6316048A;
        Mon, 15 Jun 2020 23:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592262656;
        bh=dUklA8aUBBAjrQaRbbQoc6juJzz9RjvdB0YxCXiehjM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=pbXTLdP4wLwWf4jE/yzEaRx00J62y9li4VwSequXPDJ35o9TpphneC3Dvp6RSrTFO
         XI81KngfcQ1/aFTkyi93Z5mBGgNEAaQnbiZ6//bsSRg3Z1LUzHX30ySHIk9a2Qeioq
         GbdmrkZBR5fsv4Lkd3M1ipR8fGPMV7zsImxAfRF85k8v69gxx2NzB5HyIWAtMqoH2L
         ubsML9BAdidu68Fh6xcjNtXpTPjtYxNpUsDrVjCkpuW/BuZOH1DG5PexQhyKdujk4p
         xsxht0LPHXuVa4+Gz+clChd00ka3nRxuY1Vt+mhg5FeCJ40jj479SXj+14zYAyqnja
         fCsY0T3LPaudqDjC5Sgg7q7YeHNESuA4ZASUAHh1mbZ1DPtX7gbXyXLGstD11R2FKQ
         HWXhchEpBBY2HpFsBOArp/5wUXKHb+qia/jFxWvHc+zm1ITArdnU6fb8fauZtGacQG
         ctPb0dAN9+pnpSVf+WQ3qhvPLq/tMHZHceiktg8gXXcDnrJBvuY
Date:   Mon, 15 Jun 2020 23:10:49 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/9] Allow overriding the default name of the default
 branch
Message-ID: <20200615231049.GE6531@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
 <20200615100327.3mwft27oj7h2bixg@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DqhR8hV3EnoxUkKN"
Content-Disposition: inline
In-Reply-To: <20200615100327.3mwft27oj7h2bixg@yadavpratyush.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--DqhR8hV3EnoxUkKN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-15 at 10:03:27, Pratyush Yadav wrote:
> For example, my vim plugins are submodules in the '~/.vim/bundle'
> directory. When I want to update them, I run:
>=20
>   git submodule foreach 'git remote update && git reset --hard origin/mas=
ter'
>=20
> With this change hitting a Git release, more and more people would call
> their main branch different names they like. So what is the recommended
> way to do something like this now? How do I checkout the tip of the main
> branch? How do I push to the main branch? How do I pull from the main
> branch? And so on...

This is a common issue that's long existed but may become more common as
people change their branches.  I believe when you clone that it by
default pulls down a HEAD reference for the remote.  So you can use
origin/HEAD (a symref) in this case to use the correct default branch,
whatever it may be called.  Then your code doesn't have to care about
the actual name, which is probably better anyway.

If you want to know the actual name, you can use this: git rev-parse
--abbrev-ref origin/HEAD.

If the owner of the repository chooses to change that name or if you
lack the HEAD reference for a remote, you can fix it with "git remote
set-head origin -a".

I'll see if I can find time this week to work up a FAQ entry about how
to do this, since it seems to be a common question folks have.  I myself
wasn't aware of "git remote set-head" until the other day, so I don't
expect others to be familiar with it, either.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--DqhR8hV3EnoxUkKN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXuf/+QAKCRB8DEliiIei
gW6TAPsF9kTNTGAZEVwRANRMHC9YVXssN/iITCs9REp7l2mPDgD/fuNWJU2yn77C
iwuhEgJb5MyZMjZbfKyP371KM6uh0wA=
=yn56
-----END PGP SIGNATURE-----

--DqhR8hV3EnoxUkKN--
