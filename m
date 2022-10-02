Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD76C433FE
	for <git@archiver.kernel.org>; Sun,  2 Oct 2022 19:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiJBTLV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Oct 2022 15:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJBTLT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Oct 2022 15:11:19 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361EF3A483
        for <git@vger.kernel.org>; Sun,  2 Oct 2022 12:11:19 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 7B98E5A0E6;
        Sun,  2 Oct 2022 19:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1664737878;
        bh=bBs/xGmvtkBTySO3wbiCGDXRU7mw7sZxP7CDdc+FGek=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=wmGNsv3Gaceis+E640R6UTA+MbNcKpT3okTw0iTjT6eBFCL5PBC6OclA+D2Pl7qOI
         aTc3Xq+EvHCdkDvfWx6WS2ZTsjp5IU9hhav8cxwEpp6M6AQTujsRwsL5X9T2QCCZFH
         vex1exxPGPxH18U9cQXE2CC1+/D5e3TZnFN5dZafEuMlwapDQuFc/NJ/Ur5p0Sc5Ph
         LPzaPLXpsluJKAXNlI0FeqyHG2/DLZCwOO9XEl/LFX3TlcUg0nv1hr/tYLW8mo+tJk
         2eLEEbmq2rW3N34xq059ATmMOzLiNOSjwzGDjlw2pkw1bEseGeNlvvN68zXGdj/0PR
         Dv5DGTaWbaCgpX97XF33sDBdalFc9Xi+eWbBw2fDJIlpCLIeqvWkAEvu+ipGlqNv1U
         QwnVgNpeLts2KgJ+EwAupQnF4PEZMZfcHiK4KM20IF4tbsqx7kf7bsRUI9Tj7UIEtc
         JpYNpbi4MUS+BUL7EFBQmZDlh9nbgkG8+yW6fIV75hh6sOctj+Q
Date:   Sun, 2 Oct 2022 19:11:17 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jouke Witteveen <j.witteveen@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] send-email docs: Remove mention of discontinued gmail
 feature
Message-ID: <YzniVamA97XuwAPr@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jouke Witteveen <j.witteveen@gmail.com>, git@vger.kernel.org
References: <20221001104609.18453-1-j.witteveen@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BVlt0OU5KLML3XQy"
Content-Disposition: inline
In-Reply-To: <20221001104609.18453-1-j.witteveen@gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--BVlt0OU5KLML3XQy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-10-01 at 10:46:09, Jouke Witteveen wrote:
> Support for "less secure apps" ended May 30, 2022.
>=20
> This effectively reverts 155067a (git-send-email.txt: mention less secure
> app access with Gmail, 2021-01-08).

This seems reasonable and correct.  I remember reading that Google will
likely require 2FA for all users in the future, so at some point, we may
end up removing the "If you have multi-factor authentication=E2=80=A6" clau=
se as
well.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--BVlt0OU5KLML3XQy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.39 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYzniVQAKCRB8DEliiIei
gSzIAQCm5PTMS8fdczak2dWkGDcV70SP2Ksn/jqOsbQmt3g3NwD/ZCBOqh2Ru1yD
yeLnXCK9ipL+p+I91pegg/qhfGKnUgs=
=+54v
-----END PGP SIGNATURE-----

--BVlt0OU5KLML3XQy--
