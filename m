Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29ECC433DB
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 21:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57768650A6
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 21:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhCEVpM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 16:45:12 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34740 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229591AbhCEVpA (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 5 Mar 2021 16:45:00 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5685E60DF4;
        Fri,  5 Mar 2021 21:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1614980699;
        bh=4pLwEiIJmyj5DdBjFH+7IPvUoiRk9ie95ehFMasmrw4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=p7bfjj46V8ZLV+S55kCfbAP1R7ne8ddIUhbo4qv1rQkonpBDR+ixjvq/dTUUWT4KD
         IHZNkbUF8AWGdKgg4fIYplWAorgg6TA6UYJqprgu025lIZrdySycOOWWEO3u3wx+cp
         6d94CFlD6kt877YIVD8FDvTkablZCw1Lf/e2nLfGS/Q9hP7dWePRa16XI7TxJK8W/a
         DGk9b7+ma8HdsGNIBjk2GMn21Ocs3H0Zm5sg2QL+0SfxrDl5fMFneCaai55O0zP2P0
         8Ih9ztmhlXLG/LNjrC7AaOmRJ+YJt5fExKhRwMwy0n1NOffj3FOG/8oI/j2kOXDDhc
         n9NeLXbZ8OCuzA7k79u0Vtt6fr6LgJ40ov4znrfw8KYl6pgenPyoK+5YP9MuZ3glFn
         hd/vFYdFfKgY67c1CDF9tQrWwbQiR1ob2K+vj9r3rbLvbkJA56aKgciA7OH8ucm12v
         qJ77lQ1vKpHiQIPkx+F2xloHM5e1GuVvtVUtAJ4eEjad1SEPx1B
Date:   Fri, 5 Mar 2021 21:44:53 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Soni L." <fakedme+git@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Cross-signing commits
Message-ID: <YEKmVWHJchUhxZmn@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Soni L." <fakedme+git@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <355bb5d1-f661-4ac2-d536-d1c56ec5e408@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ymDqm/3WS4ixMKRZ"
Content-Disposition: inline
In-Reply-To: <355bb5d1-f661-4ac2-d536-d1c56ec5e408@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ymDqm/3WS4ixMKRZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-03-05 at 16:47:14, Soni L. wrote:
> We have a somewhat unusual use-case where we need to cross-sign commits. =
Is
> there any way to do this in git? As far as one can tell, attempting to
> cross-sign a commit would cause its hash to change, and creating a signed
> child commit would break fast-forward merges. So these are a no-go.

Can you explain what you mean by "cross-signing"?  Are you proposing a
situation where two parties sign the same commit?
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--ymDqm/3WS4ixMKRZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYEKmVQAKCRB8DEliiIei
gV6oAPsEzldkvSotW6ovTDDtuB3WZVVEFu9SzdHbCKTW0k7SMAEA2C+9AWSP3RhI
2OE5m4FFNUHHDus7/6P9eXq+MdYQDg0=
=SWrw
-----END PGP SIGNATURE-----

--ymDqm/3WS4ixMKRZ--
