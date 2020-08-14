Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D29FC433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 01:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7B352078D
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 01:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="lc8g1MbI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgHNBLj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 21:11:39 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41504 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726522AbgHNBLj (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Aug 2020 21:11:39 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 96FD060129;
        Fri, 14 Aug 2020 01:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1597367498;
        bh=N3uEmB7A2AHlxG9y7QfwaVftOzRtsiFSGvURhwwdZPA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=lc8g1MbITuJ8uHkc60xvAWEaJz+ohCTddPoiyEh7JqvNWdbBgXNLXlsnk0NsBN+6P
         PIoK4K0kskd/ZVf69sjVP4ODuOnZFw079KKhVRW+EXg4r757eSUjyov2wgbbzdO5ma
         mJHKjOF4d2njGZPAkTj0+6ze5dqf5SVqiR9g7+2AqyCEIyjRpzJ+8DA1gaSgOdPvt4
         45M4lMqirBn2UtTGABE3VOjZA0d67pw6qUfZER2E98nXdXkRKhkpalf3HAPJjMZ0no
         LH8C5Y8y2rWZPfayNDvSCXp3qat2x0wrsmMxiGnHnL3AbEcMUIWhHLBQ9Hbnj2+7qs
         buiWzrLtxqk7Chqp5RydZ3EbB9XIP4MhNdbzpIIXNc9ol7oA6d8BDGA9fx27Uf2+sZ
         KU1T2U/pSATttH61sv0AKWBhYNOpps8LwnFDAceLrgeTeZI7NmsAktdNWaXqkp5zp5
         RjS9sX2I8hzaUEVxJmbJBdywURvBUfo0/QZ4e7SYiXIu0xtqezQ
Date:   Fri, 14 Aug 2020 01:11:33 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] messages: avoid SHA-1 in end-user facing messages
Message-ID: <20200814011133.GJ8085@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqy2miyr0f.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yhze8HlyfmXt1APY"
Content-Disposition: inline
In-Reply-To: <xmqqy2miyr0f.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--yhze8HlyfmXt1APY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-08-14 at 01:07:12, Junio C Hamano wrote:
> There are still a handful mentions of SHA-1 when we meant the
> (hexadecimal) object names in end-user facing messages.  Rewrite
> them.
>=20
> I was hoping that this can mostly be s/SHA-1/object name/, but
> a few messages needed rephrasing to keep the result readable.

All of these seem reasonable, and I think "object name" is fine for
this purpose.
--=20
brian m. carlson: Houston, Texas, US

--yhze8HlyfmXt1APY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXzXkxQAKCRB8DEliiIei
gVMnAP9W0rsGG8VrtS7x1xubTV/u6AojCdlV0oI+2eRa/mcX/AD/ZO2DdwUf3oRc
9wVcuZIaL9yGXMbFA9paux3Vw8pBcgo=
=SAY2
-----END PGP SIGNATURE-----

--yhze8HlyfmXt1APY--
