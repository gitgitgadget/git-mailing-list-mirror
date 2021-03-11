Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31F0C433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B108764FBA
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhCKCti (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 21:49:38 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38156 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229810AbhCKCtT (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 Mar 2021 21:49:19 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A82E76046C;
        Thu, 11 Mar 2021 02:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1615430959;
        bh=uLtbKS6+ddTUm+F934Bd8mmazL2J6mgxy3X3Nf9IaSA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=wgg3zcAIZ2JfV8O2i1Ww8MJiupSr3L+zYzPttmddwt5RrxvwysfnCfCovckh5Kve8
         +sz2SS2/CInNbJyI197Sxu1VNdTK0p7gSH6o6oFEfVDoq9GduI/+ah9UfOwZXSnbmR
         n7a7agLyh5IlDfMZc3QTy8Iozhz4XKzN6oFoLZWRTz2iw78w1UuoKB8hM5YjzyGR+x
         a+Jqu2B6PtvJDxKoA+pMOAjRat6Nyf/D2UiL1Cy1QeCex8FFHvccHHMtHFfYCTfErU
         a/TPtKv9vHjsEiTe4Awq5PE6F3OZ3BT3SnJlpAU/2oufk9nuLqgzR4M8Y0Tz8fXhu5
         fMtGpCdSMqH4YmH7bCFkAD43FsKa4othuze40D3lNYZRAT47+UxSIXmWC67HlMbpJ4
         8Lcu6p7tH/AkTFJE/uKkCjG7NEJEgot+dW8xRsMyIOGf/z+5S7EBVmEjDZ3RfsZOXS
         Dd1PZMY2m841RQbqAnww7YwXd9Jp/vnKtm4IYepZAFb0F6Tw7y/
Date:   Thu, 11 Mar 2021 02:49:13 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/3] t7003: test ref rewriting explicitly
Message-ID: <YEmFKYyV7DriqlY1@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
References: <YEj8meoPn/g6tCe3@coredump.intra.peff.net>
 <YEj8x5fQl1fyLGNg@coredump.intra.peff.net>
 <87wnueh7nu.fsf@evledraar.gmail.com>
 <YEl4eAR+rsayCpfT@camp.crustytoothpaste.net>
 <YEl/XRnbu5FBV+PE@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ihixy+s5XoYlp6hY"
Content-Disposition: inline
In-Reply-To: <YEl/XRnbu5FBV+PE@coredump.intra.peff.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Ihixy+s5XoYlp6hY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-03-11 at 02:24:29, Jeff King wrote:
> On Thu, Mar 11, 2021 at 01:55:04AM +0000, brian m. carlson wrote:
>=20
> > On 2021-03-11 at 00:10:29, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> > >=20
> > > On Wed, Mar 10 2021, Jeff King wrote:
> > >=20
> > > > Note these all pass currently, but the latter two will fail when run
> > > > with GIT_TEST_DEFAULT_HASH=3Dsha256.
> > >=20
> > > I don't know if anyone relies on that. Probably fine to have this as-=
is.
> >=20
> > Our CI runs that way, and I always use that mode.  Are you saying that
> > these will always fail in that mode, or that they will pass at the end
> > of the series?
>=20
> The latter; everything passes at the end. The only thing that is hurt is
> if we care about bisecting the tests with GIT_TEST_DEFAULT_HASH set

I don't have a strong opinion on this.  I'm unlikely to bisect with the
full testsuite in that way; I'd use a git bisect run with a smaller
testcase.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--Ihixy+s5XoYlp6hY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYEmFKAAKCRB8DEliiIei
gcxDAQDzlkEZExagyTbMfTuj+R80gPPDb4NFXBuE/KDt9dSvyQD/U6BWtRThJGnb
AdjAqQKX7Sj7IXHK6kAURSbdiYurvwM=
=LwLg
-----END PGP SIGNATURE-----

--Ihixy+s5XoYlp6hY--
