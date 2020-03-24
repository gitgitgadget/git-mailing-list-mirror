Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAD7C18E5B
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 23:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12277206F8
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 23:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="nWCctRN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgCXX7k (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 19:59:40 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:32924 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727054AbgCXX7k (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Mar 2020 19:59:40 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1CF7D6077C;
        Tue, 24 Mar 2020 23:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1585094379;
        bh=5jChKXLYPAugFBv8twB7NW6WedGapkYKuTcRtZYJZ0g=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=nWCctRN74qvXR8icQcmvxajk5bSpJsw1uoE9rjBPsVRlu4kOom/khOzkQZ2ock9CL
         BEsFdHF44VObSMAaOH/mxmW1x2xcdOvvBrdPypoo8MAlGusxloWu9iDK7HOowZm5Vi
         OiAxsrYfI7MDwD9YnNdXeiBwXKqNSC6w5e1nSQL9QYLFpuviKwddhJFdVhvkidEMlr
         Cf+DorNaBeJb/VkE8AWYYPQz4cPc3h/701DasekwIsXhgOaICr/9rLkoCYy1WkrXp1
         wHtZwR3JtNU9U0XzMDg0dqMcItWyWqJlFlUIWl84dIA0yRHeyHLG/hpXfNhvuZ+L+1
         UTgvtAI8hoyJ3Ml7GiNLviELNKeUQe8xaKcpHCw2pMpLoMpTUe5+Q2Zh1ZUJSLMLgI
         BW/xVC7jzXf2XG3Rpc7xJaU1BI12joohKPoQsuaBLssmpBLjEUDVLbU5HL9jwueJV8
         BOUcm5T7E96xTIT+Tx58XmjbC9u5g7Iblw74nO1XG2bZKAhQOVt
Date:   Tue, 24 Mar 2020 23:59:34 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Smalls <jon@smalls.rocks>
Cc:     git@vger.kernel.org,
        Torey Adler - NOAA Federal <torey.adler@noaa.gov>
Subject: Re: git > 2.10.1 fails to update index on macOS 10.14.5
Message-ID: <20200324235934.GI6499@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Smalls <jon@smalls.rocks>, git@vger.kernel.org,
        Torey Adler - NOAA Federal <torey.adler@noaa.gov>
References: <7b8b23f8-e12a-bde9-4b9e-ca8c908d1203@smalls.rocks>
 <20200323231351.GD6499@camp.crustytoothpaste.net>
 <414a10db-18d4-0c19-eafe-fbb85811fffe@smalls.rocks>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="54ZiyWcDhi/7bWb8"
Content-Disposition: inline
In-Reply-To: <414a10db-18d4-0c19-eafe-fbb85811fffe@smalls.rocks>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--54ZiyWcDhi/7bWb8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-24 at 01:36:18, Jonathan Smalls wrote:
>=20
>=20
> On 3/23/20 19:13, brian m. carlson wrote:
> > What exactly do you mean by "doesn't recognize any file changes"?  Can
> > you tell us what commands you ran and what you expected to see, and what
> > you actually saw?  That information would be helpful for us to track
> > down what might be happening.
>=20
> In git-2.22:
>=20
> I would write a change to a file. Running `git status` would return that =
the
> working directory was clean, and `git commit .` would show that there were
> no changes to commit.
> 	However I could target a specific file like `git commit test.txt`, and g=
it
> would successfully recognize the change, and write the commit. I could al=
so
> run `git reset --hard`, and that would update the index to reflect the
> change that I had just written rather than resetting the working directory
> to match the latest commit. If I ran `git reset --hard` a second time, th=
at
> command would reset the working directory.

Does running "ls -l" on the file before and after show different
timestamps and file sizes?  Does "git config -l | grep -iE 'checkstat|ctime=
'"
show anything?  Can you use the stat(1) command to tell us whether the
change results in a device or inode number change (if that's possible
using the macOS version)?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--54ZiyWcDhi/7bWb8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXnqe5gAKCRB8DEliiIei
ga/gAQDuujgefzEqBKD9Y0iq2hdM/mSl7Kk4oX4sg1yu6nGVNgEA5IWLkngasm0M
wLHXNDui1hi2qyzSMbRGPqtBuGDJGQc=
=Hfzd
-----END PGP SIGNATURE-----

--54ZiyWcDhi/7bWb8--
