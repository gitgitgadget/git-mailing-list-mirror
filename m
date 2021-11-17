Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D25C433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 01:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65A7961501
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 01:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhKQByp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 20:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbhKQByo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 20:54:44 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71743C061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 17:51:46 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id B5A9D5B482;
        Wed, 17 Nov 2021 01:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1637113905;
        bh=XqoN+md7XOIm6tO90aFeUhEhJ7Ld+oJBYPXBxoPnCXM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=zo+BVjkuxvNEWJ3z7yMSFvLdSYumTZ/7Fb90iiC1kAipJ/eNk05Vg2xoJw2wdReEU
         YJFOWORE8Z6FCLoGI868usU2yLCHoGP41WgX2cjrqblByb+sxbJHtE2BewA7cBvbjz
         Q7KiCFhteTwqQv2CeIRiyEFPFtodv4MQKfllkPlFo7KmP7Jnbyg899ajZ/Yz/JjDUw
         EkVRwKaEmmAjG+PCgzS0z7bN4c0ycmOoLwzhezuD1QkfL/s2qVFVoUiNTfcpjIAx+9
         A8pcqpTIMqgmJoijyKaYwnzup2T0ZXaUDKgjyTppQNtSS4iSoW/UDkiT/c3YuAdMHi
         prpJCMMc+AQCSrXncRaRcN/+IBMEzjk0XfxLu8SfHmo/Pfk2+9FssIP695QXxuD5SH
         +oZjr5FMou5Mzx7yUGqMWSiZ7LGe9QLqFWwaTXRUWmfTFaucSHdXrXbtTG4lND38oB
         bqK7slGIuGG17vGntxWoPUD0/1nOkLfOD6p7LFHuB3Aw0l9kGcB
Date:   Wed, 17 Nov 2021 01:51:43 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] Add a test balloon for C99
Message-ID: <YZRgL5YYm7JCQQQp@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20211114212437.1466695-1-sandals@crustytoothpaste.net>
 <xmqqy25pj43a.fsf@gitster.g>
 <YZLh/1xkxRGDn76u@camp.crustytoothpaste.net>
 <xmqqpmqzapqn.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jJhnVZrRB5/nxjg4"
Content-Disposition: inline
In-Reply-To: <xmqqpmqzapqn.fsf@gitster.g>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jJhnVZrRB5/nxjg4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-11-16 at 19:02:08, Junio C Hamano wrote:
> Windows does not need me to worry about them---they can fend for
> themselves.  I cannot tell if the original discussion behind the
> patch considered the current situation in non-mac BSD land (which I
> am not familiar with), or even less common platforms like NonStop.

Oh, I did full well consider BSD land.  They are generally up on the
latest standards, and I would even say that most proprietary Unix
systems are also far enough along from what I know of them.  I do try
specifically to support BSD systems and consider their needs to the best
of my abilities.

As for NonStop, I checked, and it already forces C99 mode because we use
enough features, like inline, that C89 doesn't support and so it needs
to do that already.

I do appreciate you looking out for them, though.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--jJhnVZrRB5/nxjg4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYZRgLwAKCRB8DEliiIei
gU2sAQCQVXZ5i6LGPgzwqAVpuzaUV3Dg5ZokmCnWgxVaxp5TVAD/VfyoPrebKULx
gS5sWj1/P27HWDRaQ+Q6Aod/xmYHhAU=
=TNR2
-----END PGP SIGNATURE-----

--jJhnVZrRB5/nxjg4--
