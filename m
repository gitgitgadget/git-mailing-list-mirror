Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8ADCC433DB
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 18:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CE5464E54
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 18:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhB1SHt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 13:07:49 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59606 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231295AbhB1SHs (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Feb 2021 13:07:48 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E305760DF4;
        Sun, 28 Feb 2021 18:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1614535627;
        bh=aKSuiwuHD9z7hXtCYGjJP41YNFsQp/8b9zk3itblV5I=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=dhb9g9c3Sg5x6t+P7HUWPFXoNgpS8+6GpFuycn2KIWCwnWsIZFCRv1sOHmCgqEiIg
         M9lItjbyY+oSuO+jR11GddGQ+MLt5hKxh2KIbon6p2nLdgc/bV3nQhbSy2Vsm9qmdN
         aXa6pjJK9tNTfmkXX8EkA/hSOiN1zHJKvj3/sjXr6k37G2cqORCGF/yN+O8OmBcQhz
         WTu1INwFtOKOsnS+T4Gxs1F4dbLBP1CxmUiz1cbbLE3BSNs2Dp94o29GzmqDfcfG6t
         6N2x+Mljo/n+VQdRSJCmtTbIchyS5QtkHj2XZBtTovvzRzzvU4FmNXvDCQleA0k4rW
         1l77L3FWBhQI0HZ6ocF6Jq89r0YobhMOxL1eIMM3lOd3gXKivUjkCm/+vzGgngMVNN
         Ab7Wz44yD0eqnTb9pqAriRP+h+xJPVtUXCsOrzU1g9Jikj98/eGLuB7C08/oTLW0sg
         tfot1eSA9W1wiKptJaxP2FunLRNaiPGQGkaVnBcSsCGOr5aiC56
Date:   Sun, 28 Feb 2021 18:07:01 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/4] docs: add a FAQ section on push and fetch problems
Message-ID: <YDvbxSfulnzY6vGp@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20210227191813.96148-1-sandals@crustytoothpaste.net>
 <20210227191813.96148-4-sandals@crustytoothpaste.net>
 <87k0qsl65o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gxF74i0FNNSnuwYP"
Content-Disposition: inline
In-Reply-To: <87k0qsl65o.fsf@evledraar.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--gxF74i0FNNSnuwYP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-02-28 at 12:37:39, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> I haven't looked in details at the content of the FAQ itself being added
> here (as far as proposed solutions etc. go), but I wonder if this
> wouldn't be 10x more useful to users if we cross-linked these errors
> with the docs, e.g.:
>=20
> diff --git a/remote-curl.c b/remote-curl.c
> index 0290b04891..ffb1001703 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -829,7 +829,7 @@ static int run_slot(struct active_request_slot *slot,
>                                 strbuf_addstr(&msg, curl_errorstr);
>                         }
>                 }
> -               error(_("RPC failed; %s"), msg.buf);
> +               error(_("RPC failed (see 'git help faq'); %s"), msg.buf);
>                 strbuf_release(&msg);
>         }

Sure, I can send a patch to do that.  That's a great idea.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--gxF74i0FNNSnuwYP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYDvbxQAKCRB8DEliiIei
gcsBAP9TYSgBVnPmo3TijHJSeDnNztNieStQDFwcUssYrzl8BgD7BxbAJM0H3RA0
KgY447gKhbIxPQ8EZAVbNF8DJxPkgAI=
=yf6n
-----END PGP SIGNATURE-----

--gxF74i0FNNSnuwYP--
