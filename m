Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B82C433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 00:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6413A60E54
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 00:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbhJMAt2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 20:49:28 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60240 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231672AbhJMAtZ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Oct 2021 20:49:25 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CD6C960423;
        Wed, 13 Oct 2021 00:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1634086002;
        bh=YT+qA5MHQFs3VI+K0MAsBuaSFejvH/zLSJDi9uGET7I=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=xor/VgDwh+zJUtSBlwoLIiY9yi4SaRRKr+rSzWnp+4xXlnkAdbSJS9o2RBeoS7ErR
         RPCGkNoqie+8tKmR38Pwshf8q84pWmqnVQeU3GKTB1eoH5bS7b+6a5czAp25hqkxeE
         CcgAv5EScm+s2bz65ev/Ao5YBonLEJrrev7vt6cfu+03pSyj4sW8LngI9n7eye10QM
         HkScNi67mdf2xBUnxipCbfQeWUBOqKezuaDyBRmKyzk/6j2RJSY+DRsj98cmxU6qGQ
         ZgVFTpRc1AsoKozQZqkTpSnrdvqsouRh5/Vu65F0Oi6c1BTvBAfT9bu6v6w0krI4pe
         njitTnRrMJvmb6bcczRQS/+TIpHtjLLviMLJ5/HVwFqdDIWPPYtoMY0IMovz5LJeYr
         /slLzrj8fO0ShdxibNvgWgCrSRbfIfiL+jHUEuWANkNrrcrLnyrs2IKqi9hIfWvCGL
         +ctUNOCb18zSJKxgcMtLAcKzMMRYp8LWZuum5zLsgRejgOkOJsU
Date:   Wed, 13 Oct 2021 00:46:36 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Conditional config includes based on remote URL
Message-ID: <YWYsbGHwQZbEuTCa@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <cover.1634077795.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iI/cHkeQTtjLGq7U"
Content-Disposition: inline
In-Reply-To: <cover.1634077795.git.jonathantanmy@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--iI/cHkeQTtjLGq7U
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-10-12 at 22:57:21, Jonathan Tan wrote:
> Previously [1], I sent a patch set for remote-suggested configs that are
> transmitted when fetching, but there were some security concerns. Here
> is another way that remote repo administators can provide recommended
> configs - through conditionally included files based on the configured
> remote. Git itself neither transmits nor prompts for these files, which
> hopefully reduces people's concerns.
>=20
> More information is in the commit message of patch 2.

I won't go into the details of the patches, since I'm a little low on
time at the moment, but I think from what I've seen of the cover letter
and the commit messages, this approach is much better from a security
perspective and, provided we can get the kinks mentioned downthread
ironed out, I'd be happy to see this merged.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--iI/cHkeQTtjLGq7U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYWYsawAKCRB8DEliiIei
gZ8xAQD7gyNbJeYnBkNaUHMVDIvvBx1LvRhPKDh7NJpYXju8agD/eoiFWOmwLF8v
tfiZTM4e74xu+5N2+DR+xkjWX6PmEwQ=
=E9wT
-----END PGP SIGNATURE-----

--iI/cHkeQTtjLGq7U--
