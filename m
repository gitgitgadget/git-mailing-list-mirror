Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCE2C4332E
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 01:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D23206C3
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 01:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="kftQ6CJg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgCWBLZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 21:11:25 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59798 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726946AbgCWBLY (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 22 Mar 2020 21:11:24 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 621E360732;
        Mon, 23 Mar 2020 01:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1584925883;
        bh=llUonMCkxo6mhs6mZAln/uFRm9dMhb47V3UEDPmziV8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=kftQ6CJgJGN66R/ZajbwUQUH1M5nPdqRNxFuX5l9qkj4fH0/ueDJyCcWZqUn6hfbN
         1uhA9Ggl59r57BKYQ+lsk/yZ9WqeFVEq+hfzbbMiPUNUwu3/j/2rfWRImr2rJIk+JV
         XQ4+ftq7reeeCMnCkrbdsAhUMPdkR/+gfXy2kPGIJqsyPewyWUxKcXPaTWNXIosJCu
         zWcePqQwOIDzOoopuNASwyQnOyMDRqyFKTnLyqi8urx0cRtq7EMmaoIWTZR4fB7j85
         koZcvm+Dza8uCSENmG6mzWH5CLykOw83IQc1m3f7EI10MjkJ8yMMMD9gwSgtVPuxBM
         yXhanardP+1lK/MolKVa9UPhcnqDAU6DkUqPX/F4Rf0KDpGv4KrBzA+MTGFboi+R9t
         1J/T46y2Q53aaEXQwW7bJpW8T+iq3TS/CgdH+eztJrhADF0BmOgSD0MMMoEH7YZHXu
         wmr/7pwGAT3lATkLipq4jW3W2S8agib3H1hOaRbWC8SKaJ5VxX/
Date:   Mon, 23 Mar 2020 01:11:17 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Benjamin Shropshire <benjamin.shropshire@economicmodeling.com>
Cc:     git@vger.kernel.org
Subject: Re: Relative url values in .gitmodules confusingly sensitive to
 clone via ssh vs https.
Message-ID: <20200323011117.GC6499@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Benjamin Shropshire <benjamin.shropshire@economicmodeling.com>,
        git@vger.kernel.org
References: <CAAjm7Ga5JOJ2w=01o1-x-80HMGVaYQQy8SBBb-zJ6MOQAe4SxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Content-Disposition: inline
In-Reply-To: <CAAjm7Ga5JOJ2w=01o1-x-80HMGVaYQQy8SBBb-zJ6MOQAe4SxQ@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-17 at 18:34:09, Benjamin Shropshire wrote:
> From my perspective, this is a bug.
>=20
> If I clone a repo twice like this:
>=20
> git clone https://github.com/user/repo.git ./https
> git clone git@github.com:user/repo.git ./ssh
>=20
> And if it contains a .gitmodules like this:
>=20
> [submodule "x"]
>     path =3D xxx
>     url =3D ../../different-user/something.git
>=20
> When I `git submodule update --init --recursive` in each, only the
> HTTPS version works. the SSH version confusingly seems to try to find
> something at ~/different-user/something.git or some other path in the
> local file system.

What version of Git are you using?  This works fine for me on a recent
next.  In addition, I see we have tests for this in t0060, and adding an
additional case for this appears to pass.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXngMtQAKCRB8DEliiIei
gcSaAP0a9Oy5Sl77FAOSqpRl8fQ3bpxOKF70XTgrCo9BIH+lxQEAvI7T7qZywFmP
ZHh/JZ1Eja30yA1wA6jhAWQ+q5ICfgg=
=/q8/
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--
