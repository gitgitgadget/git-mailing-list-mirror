Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76824C433B4
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 01:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09DA561428
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 01:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbhDVBLt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 21:11:49 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39112 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234640AbhDVBLs (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 21 Apr 2021 21:11:48 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 00A9C6042C;
        Thu, 22 Apr 2021 01:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1619053844;
        bh=b/o4ILpt49Nbo49/w1mPqTmWkW0zwKlvR4X81o4HEYE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=IkFI9hRMGRedbelafQ1wi/j3Ff2oODdcfWouhC4UT19I1QRatcoLqek19FtfsJjmh
         WkgDoiMsZtfpjRn4IjDIFxSsE7zmw/svf4DnOq0XSASdROAG3MzuuQbR0F5fjCv57C
         axd6SVJiAKFTa1/eYAF+uIbmOvg/q0JsY7lkOmCi22+fG6lu0MSNrvVkn3DkOJWWfQ
         g3uTcTrm/sxy8KnatOvHlPuXvkH08pjT+i2DPSpMwzpelRwfvA/fzJv420vZcRpFHu
         cnmtcXJww9QzM2iLUmI/MEDP8AfPJfxsZZl1d1fmpFEMH1dSBmVWuuDUdDjOpIx5cX
         M0UjEt/CI7rUHqHcLljMVDSSOGajJbjZ2qUwlXIHRGoytebElaFltLWpHjvgphnrm+
         f2ZNZNc1PYnxeZ+nHhsf5hqnon3M3t4BgZEYzSfqg5mRPtNMtu+xlrQQgWVYB+Xs3T
         2NXqYkIVdCqRaHvjd1JSvVtsw9zwLM/ju1s9pBHQ8hETHgDAM5+
Date:   Thu, 22 Apr 2021 01:10:38 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] mailinfo: strip CR from base64/quoted-printable email
Message-ID: <YIDNDjJh8vQujkFU@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>,
        git@vger.kernel.org
References: <20210421013404.17383-1-congdanhqx@gmail.com>
 <YH+ct4haFn4q5qNB@camp.crustytoothpaste.net>
 <YIAVjpdwQhPJbVbl@danh.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NlJi5O32ngNHF1J9"
Content-Disposition: inline
In-Reply-To: <YIAVjpdwQhPJbVbl@danh.dev>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--NlJi5O32ngNHF1J9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-21 at 12:07:42, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
> I think replace "SMTP servers" with "mailing list managers" is
> correct. I don't feel comfortable to call it out, since I don't know
> if other managers do it that way or not.

I think that's fair.  I would hope not for the reasons I mentioned, but
it also would not be surprising to me if others did nevertheless.

> Make sense, this patch was sent mostly for some discussion first.
> Would you mind suggest something for the option.
>=20
> I'm thinking about --quoted-cr=3D<nowarn|warn|fix>, mimicking the
> --whitespace option.

I think that sounds like a great name.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--NlJi5O32ngNHF1J9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYIDNDgAKCRB8DEliiIei
gVV8APwJZcyHq6pfwE+PZkf7pm5Y4q328woBofPblP03xZ/eqgEA20Q+D/zViTDb
j+TpcarYvP4o5pJRvJRlNLi9RgKEhQY=
=dq8r
-----END PGP SIGNATURE-----

--NlJi5O32ngNHF1J9--
