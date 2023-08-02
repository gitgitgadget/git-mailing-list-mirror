Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4109C04A94
	for <git@archiver.kernel.org>; Wed,  2 Aug 2023 21:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbjHBV2J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Aug 2023 17:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbjHBV2C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2023 17:28:02 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A0C1734
        for <git@vger.kernel.org>; Wed,  2 Aug 2023 14:28:01 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id CB6AB5A336;
        Wed,  2 Aug 2023 21:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1691011680;
        bh=B4sXFX/7rmxdaBWrh1hn0vRIOipx3Lns5/mwzKi6Rws=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=am2WKk+x5HVNNCpq4sDC9EyhUHrhrSpabAIW31YLgPmnVu/CskOy5/Ywip6Iex9/W
         jaCGRCXJsfbWsGX1D9V+6Fomeuuo3y0leo1bal9bynH210sOBMDqXdT5TYD3q/dZUb
         OqPFCmWdqLw9GHGmNhbnuWdNHL71DdMlJ3SjZr5Ci3zP1Uo2DmVGdKtZFrbMH+YiOL
         oYswJsmDEqT2FWSO5yEU3QlgP/VQSBME1OnbLDdr3DcBDxbFtUSV3TWZ7h3h9q9URR
         1F/3KUPrdYe/imQMz+B9Rbf9k2NXryI6idwxV69uW/MK6QkOv5UiLrQMnNMxRwfWP2
         4v2oqhb7bAPLCzIvYcSy9tK725BZA6bC7TuOJmiz92zJ+NWYpPGVIcC8TXm3nvwVWT
         45nMGl8u17G4/zZriHJhpGfZifbuJKn/vmKQm35pKcZ78IBZg1XeQHkYQWc781nN5B
         nqddXKwX1KurojGSfUhO7WSLn0dS/b80O5vLa0ut56vp9liYCr+
Date:   Wed, 2 Aug 2023 21:27:58 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "Thomas J. Faughnan Jr." <thomas@faughnan.net>,
        "Daniel P." <danpltile@gmail.com>
Subject: Re: [PATCH] ident: don't consider trailing dot crud
Message-ID: <ZMrKXvdshOAHVGqV@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        "Thomas J. Faughnan Jr." <thomas@faughnan.net>,
        "Daniel P." <danpltile@gmail.com>
References: <ZMghdgIaQB4L88WR@tapette.crustytoothpaste.net>
 <20230731214435.1462098-1-sandals@crustytoothpaste.net>
 <xmqqpm4721lm.fsf@gitster.g>
 <xmqqsf918k4j.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="P5q8fYgcLsfCJ3Qs"
Content-Disposition: inline
In-Reply-To: <xmqqsf918k4j.fsf@gitster.g>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--P5q8fYgcLsfCJ3Qs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-08-02 at 16:49:32, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > I wonder if this needs some credit to those involved in the original
> > thread?
>=20
> I've had this on 'seen' as-is, hoping to see a quick update so that
> we can merge it down to 'next' before -rc0; here is a minimally
> touched-up version I'll replace it with.

That's fine.  I was planning to do a re-roll today (since my Tuesdays
tend to be occupied with French classes), but I'm happy with what you
have.  Let me know if you're expecting a re-roll nevertheless, and I'll
try to get one out to you.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--P5q8fYgcLsfCJ3Qs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZMrKXgAKCRB8DEliiIei
gc7WAP4w4C0b4B0x6eULBe+vfuoMAs6FUC/Mf+9MVAeWTVxDiwEAsOp7+9qNK4pe
f46RhxrVB7oen02UAQRctVJPp26xLQY=
=xpFo
-----END PGP SIGNATURE-----

--P5q8fYgcLsfCJ3Qs--
