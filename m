Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC8CC7EE25
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 21:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239449AbjDZVGw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 17:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239968AbjDZVGu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 17:06:50 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5773584
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 14:06:48 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 7A4515A569;
        Wed, 26 Apr 2023 21:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1682543207;
        bh=hnDLsjbcPaXFB4djfLkAeBNS48mO/YbVVyg2V4UTmMU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=yNKca+zyfwVcGCjHq2MkoQDWqpYde0bG9kAiwNqNb2wd3HodyLpVwdxBdDgJbXEUG
         g6ncvlANH+E3PhnGGlWplGbpsADV3vXDe7Wl7LU0ywIcrELBiMNLSvoRTkr19fxrUb
         D1omvxELfMqZgdK0eB/ixOMt5B0p+S2UmO48E2u7fkP7LAU0gS1Z4foVkrDMUjkk9+
         RIlIEg6y6sDcb48UnSjckk7qWYaa6LWhmlC70kTQkZZHSN30qUYw/OLJ6xT/f8L/rz
         FJwnUTC3xtq6x57CXFWL3zjWjv++ApR9/Nz5Ovzmt4ZL9oQfw2hkYsDMUnEgU6BrJu
         Pa8eZ6bB2sMUNTwRlI0boY7t/7y71wum3tigA2I5kEY8DfIjU6HNFw4Rrp4Mks7K6N
         QRcpnA5Q+6vBmS8n7qRw37gGJp5zzj23UayJwoOL+S/6L89NbAb2gjUIDX6Wbn3bWD
         N3r+45bXuaUYSGTCO2X8NrwLm4zK7IixywBYJpel3PpSjiFA4Lf
Date:   Wed, 26 Apr 2023 21:06:46 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Adam Majer <adamm@zombino.com>
Subject: Re: [PATCH] doc: GIT_DEFAULT_HASH is and will be ignored during
 "clone"
Message-ID: <ZEmSZmfUpIcZAM6c@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Adam Majer <adamm@zombino.com>
References: <d04c430e-b609-b0a1-fd0f-0f3734d5c3b1@zombino.com>
 <20230405200153.GA525125@coredump.intra.peff.net>
 <xmqqa5zmukp5.fsf@gitster.g>
 <xmqq355euj2i.fsf@gitster.g>
 <ZEhHsJh20gtiDBd9@tapette.crustytoothpaste.net>
 <xmqqcz3ry2sw.fsf@gitster.g>
 <ZEhuMML6n8F+cNLg@tapette.crustytoothpaste.net>
 <20230426112508.GB130148@coredump.intra.peff.net>
 <xmqqcz3qwuj7.fsf@gitster.g>
 <xmqqzg6uvfpo.fsf_-_@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="F7qJWVExsWBS1MZT"
Content-Disposition: inline
In-Reply-To: <xmqqzg6uvfpo.fsf_-_@gitster.g>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--F7qJWVExsWBS1MZT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-04-26 at 15:13:55, Junio C Hamano wrote:
> The phrasing "is currently ignored" was prone to be misinterpreted
> as if we were wishing if it were honored.  Rephrase it to make it
> clear that the experimental variable will be ignored.
>=20
> In the longer term, after/when we allow incremental/over-the-wire
> migration of the object-format, i.e. cloning from an SHA-1
> repository to create an SHA-256 repository (or vice versa) and
> fetching and pushing between them would bidirectionally convert the
> object format on the fly, it is likely that we would teach a new
> option "--object-format" to "git clone" to say "you would use
> whatever object format the origin uses by default, but this time, I
> am telling you to use this format on our side, doing on-the-fly
> object format conversion as needed".  So it is perfectly OK to
> ignore the settings of this experimental variable, even after such
> an extension happens that makes it necessary for us to have a way to
> create a new repository that uses different object format from the
> origin repository.

I have a different proposal which clarifies when it will and will not be
honoured in my series.  I think we would want to honour this variable
once we have SHA-1 and SHA-256 interop, and can convert on the fly, so I
think keeping the "currently" here is a good idea.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--F7qJWVExsWBS1MZT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZEmSZgAKCRB8DEliiIei
gfW6AP9Y0qbNXE1lTy4Kq+FZ2DoSMsyO2uL/6bJ+8enYbzQ4xAEA+Bg1Jrq+Tozd
vMqV/oUql3DYxZkD/VN00fT2i3pZhQE=
=xd63
-----END PGP SIGNATURE-----

--F7qJWVExsWBS1MZT--
