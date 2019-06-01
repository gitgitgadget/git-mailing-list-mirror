Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DFCC1F462
	for <e@80x24.org>; Sat,  1 Jun 2019 01:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfFABMO (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 21:12:14 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36860 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726804AbfFABMO (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 31 May 2019 21:12:14 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1504:7263:609b:f73f])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 06F2360100;
        Sat,  1 Jun 2019 01:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1559351531;
        bh=b9jufjU+jiU/vQiZlPf0TYkJF9cAO8jyVpt8LhVFX1Y=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=CeXc8oRF86Li/Ri/Ws2PYYyUF+v6a1u2kgkK+Ra78nescLaWDC/Jg4j0ItSQoBjyh
         HOFLsOMVOZv0fAd5rV7tuGExhldElUtsbW0wEx6mTeOI1ZgMDbu7cXUW+fsLuRKxd3
         ZhOBQoeIkYSWZRXUpNYm+0Ib7WybOmOEVVqdYRPd59aGPxf1UIZhA1pK9DYyB2sots
         CpOCXc0rR8ciEknFCxkBKghwUPCJcuWwJ8txy46BZLtPp7uMqE7/70lrMBvmMROPEK
         2Q08slqWSWb/LrsWeY2N/+BbhCZVyefJ62hk1jVtDyq4kjY+sz/+gPH72Yk9F+E6s5
         EzrXaGXacdZOh9n/JzuCXpqwMipKwyvr6uOXkZ541T/mynQIaeHJ3i0mmNO+EaIQvF
         uB8TRCBMHq92cstcj5ZcVIX7pRkioqyh8/3pg8A/duPmu127DJR2MJAkckgfi81L7p
         qWTGVk6UE8sYtXZ0z+/PfFgmm3fM+izSxOI3YJM7ql3bz6Pb2L2
Date:   Sat, 1 Jun 2019 01:12:07 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Alex Levy <alex.levy@voltserver.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: possible submodule bug?
Message-ID: <20190601011206.GO8616@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alex Levy <alex.levy@voltserver.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <BN8PR11MB35711F87B0981C6897DCE3CC89180@BN8PR11MB3571.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U+NfgObvpQT1Q9Yq"
Content-Disposition: inline
In-Reply-To: <BN8PR11MB35711F87B0981C6897DCE3CC89180@BN8PR11MB3571.namprd11.prod.outlook.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--U+NfgObvpQT1Q9Yq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-05-30 at 18:16:17, Alex Levy wrote:
> I've found a workaround if I manually edit .git/config in each clone to r=
eflect the correct URL.  After doing that, running "git submodule update --=
init" works as expected.
>=20
> My understanding is that I shouldn't ever have to edit anything in the .g=
it directory.  So, have I found a bug with .gitmodules being ignored after =
adding a given submodule?  Or is this just user error, a case of "Don't do =
that.  Initialize the submodule with the correct URL and move on."?

git-submodule(1) documents this behavior under the init subcommand:

  When present, it will also copy the value of `submodule.$name.update`.
  This command does not alter existing information in .git/config. You
  can then customize the submodule clone URLs in .git/config for your
  local setup and proceed to `git submodule update`; you can also just
  use `git submodule update --init` without the explicit 'init' step if
  you do not intend to customize any submodule locations.

The goal is to let you customize the URL. For example, maybe you are
using an open-source project with submodules but you're on a restricted
corporate network where access to certain sites is prohibited, or maybe
the server hosting the submodule is down temporarily or permanently.

So this isn't really a bug, but more of a feature, even if it's
inconvenient in this particular case.

You can, however, use "git submodule sync" to sync across updated
changes to the URL. This is a bunch easier and faster than editing
things by hand or with "git config".
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--U+NfgObvpQT1Q9Yq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlzx0OYACgkQv1NdgR9S
9ouB2RAAz5r+H4leK+hlYR0a7FTfPdWBAGkFOuhpUgJFY68bbzGcrDdG6ZJlHoMB
f1kQ4pzQ8XdzEr3TnJk8GRQzcKOvs24eXrHsUCiJ1hZbjMWohqofPosJth/TpOPJ
jfYrvfF4lGKj5gTO8NTplr1f71OH7DOThjc2bqc0vFfNEG2fcNfNaGD8w9BKWorS
SHFbtFBBID3hGaddjDQ2EFFXADC8wQEIZVhDUFcOPZi0OqMZ++Wm5VqbDvuQIgCZ
2nMOaOrRrhTEhyUKCAptK/RJSa9xokeGuWD5xqqQPtMPLTIy8Z3SK0Rgti3npp03
bTVJVgwjYiYFQNKcSu11pXsguX7Lj60EjeCStyqNdD8cpjvC4PRX+ZFx1n0OxOiF
CcVesM4YuOb+2T4AEC5Dn9yXuovpznphTPKCjaDt906z3wZMU+cX/llpjlDDkO16
Y9OWi/n1B4+r28WrAkg7BOILVDGD+M1K2CrL6xJhTZOzxZW5mwlV1ebW06gm/V7O
gZ0V9eL5sK/l+YtuwWdbjoXQB1QhyudiefJ280vtEbYiqsRnAhXOzlUjnlun4Jdg
+B8yH/ml8mBweLs5BkFTePZ4OxijcL45IzD83rKjFGjsY1bFI7O9BFu4KU4/rCIh
ilQdmXyraYkADhd9xaDOjzDRoduL9govV1F9OLqlcGJMMtrUp2A=
=kN9Z
-----END PGP SIGNATURE-----

--U+NfgObvpQT1Q9Yq--
