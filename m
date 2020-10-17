Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7341EC433E7
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 23:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34CE220878
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 23:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439876AbgJQXJT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 19:09:19 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51868 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439810AbgJQXJS (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 17 Oct 2020 19:09:18 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4F7066042C;
        Sat, 17 Oct 2020 23:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1602976127;
        bh=362HBMVE+aSqBeSR3nvUCc8Hftcdc++/XJV4Z4nqkY8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=e2xd1BE3Wi1oagJedlkA9C6HDhqwr++cOcQ1mNEDPLFFZ3xI7U+dd2jLSY2eVWCar
         luqFwhJMCbda0B3VUKargxHaQ6rYzzK8iZN1obWhe3xfE0kJUK+D1BevoPj1HljzXT
         Xgn/XZcRzmnQZLfChfZjInB2I36kXsDSQ6ssrx1+guJuUKlvM3PmeRcfSyYN8kx1lp
         tQU9XCr0FeQWEomWYATL0yCI7Zj645q6ypfEKP2OUDKC4mJKqBH2V7tKAPwuo5C8Bq
         vuhKMXODl7hxbSF1Op2JXRbpA0cd2/VdqCn5DsgjF+KbUPdf1Z6dAdKQK3+wVc5KrI
         lVLeQTtaaOTQ0RB4Hiz9I3ErV02BRr9shgDw5bF/sJ+eQXEE/0bhW8UEVc5aotdMRS
         KF6qJBVb5AhVPXRdsNPVl9kP4k7JcSJQH7wx3fqKCypr5/o0DfRX9R9ZI6Mx7FGg4M
         fO5Q2skbqfyRcA+oYDMZV7FwLbJTB5BmIs0dC0HNtt6gKqXShDe
Date:   Sat, 17 Oct 2020 23:08:40 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import: remove duplicated option-parsing line
Message-ID: <20201017230840.GH490427@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <20201015193411.GA1130491@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Dx9iWuMxHO1cCoFc"
Content-Disposition: inline
In-Reply-To: <20201015193411.GA1130491@coredump.intra.peff.net>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Dx9iWuMxHO1cCoFc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-10-15 at 19:34:11, Jeff King wrote:
> Commit 1bdca81641 (fast-import: add options for rewriting submodules,
> 2020-02-22) accidentally added two lines parsing the option
> "rewrite-submodules-from". This didn't do anything in practice, because
> they're in an if/else chain and so the second one can never trigger.
>=20
> Signed-off-by: Jeff King <peff@peff.net>

This seems clearly correct.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--Dx9iWuMxHO1cCoFc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX4t5eAAKCRB8DEliiIei
ga9xAP0choM8LRE6A5yeo9rxdDP164nXCK5F0p8cI09X5FajOAEAtrDKuV9oqdFF
08sO/lNLY8y2GB9jye3GQ2vmUjdJWgU=
=3jXT
-----END PGP SIGNATURE-----

--Dx9iWuMxHO1cCoFc--
