Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC354C33C99
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 02:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F52A2087F
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 02:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="OOf5t2JY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgAHCrh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 21:47:37 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33298 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725812AbgAHCrh (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Jan 2020 21:47:37 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8AB5060482;
        Wed,  8 Jan 2020 02:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578451656;
        bh=gSYcFQuAmHochhcPoKjpBC6Rw8m1Z6rih2lpyVD7C9Y=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=OOf5t2JYkv6oPO80hS4RMU338Jw91minx/lM9udigQMcyeejMSPIa9HzqNTmt/DRL
         2ulN569cchHkxuCFgriRB7zjTqjVjpJp50KdwCYCsSSV3YdW6TYMUnFZP4q/M8LJQZ
         L6b1maNBlGb8jvl7c36jjf5z0HrHKeLWVdzC6KckElPwscKPocAXffFZfCqeSUHdIC
         ljl1eLvej4+Pp+hqqi6Fd5obALqIy2znWnETpB4z4ZVQVW5jxGzIP3ejkPBbwOioEb
         SgHhzXyjgmXY9lyc+A18MYIv8Rgyrxe+216+z7c0wCM/gIiEObcc2uVWdBxKsbS5Jt
         EcYpiWKm1vkfnEHUxxgdtf8ZAFwUELMiLkkzVCk6sJIKS4vYgoPQvXNLnNVx1kekAd
         /LkV4RbShmEtpREoWdxnYanz60q/NZoL6qKjOEtks6AWWEICxAapUFPufYrinwBldc
         Ip9ur9biI3VmwtnAC09o/I+BB5Rsw1CR8eqx3uDqameEcNkdjld
Date:   Wed, 8 Jan 2020 02:47:32 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "Miriam R." <mirucam@gmail.com>
Subject: Re: [PATCH] run-command: avoid undefined behavior in exists_in_PATH
Message-ID: <20200108024732.GL6570@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>, "Miriam R." <mirucam@gmail.com>
References: <20200107013640.1821227-1-sandals@crustytoothpaste.net>
 <20200107110145.GA1073219@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sWvRP97dwRHm9fX+"
Content-Disposition: inline
In-Reply-To: <20200107110145.GA1073219@coredump.intra.peff.net>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--sWvRP97dwRHm9fX+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-07 at 11:01:45, Jeff King wrote:
> > Noticed-by: Miriam R. <mirucam@gmail.com>
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
>=20
> I think Miriam actually posted the same patch in her initial email:
>=20
>   https://lore.kernel.org/git/CAN7CjDDBA0ZoCG9aaQf5rg3gxqny=3DEjR6v6jE1mn=
xvUJQSF_0Q@mail.gmail.com/
>=20
> I don't know how we want to handle authorship.

I don't feel strongly about holding authorship; I'm happy to have her
name on it instead of mine since she did propose a solution.  I just
care that we fix it.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--sWvRP97dwRHm9fX+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4VQsMACgkQv1NdgR9S
9osX7hAAoA9x6phpQrLmSV6GvmK4KbyvI6dBwM6NWVqo7NQcsL71i9hd1ZGMzhjs
vu1chIyFy2NOx5am2J057k/MkSC7mAxicLgL90EJ3RxtKr8jc+UGguntkFmHYTdV
YRRgQvhKHAi5UNuUNMlPIYPKanrTfoDDfnpWM7SGEzlteoWdSskyLufy5auBFOsD
J35jKGgvQN+B0uxF2YqIAGLdLiZrz2w5reev443KPTTufe/1sldITolKycnQ7w9b
J7JUr5gVmOSrlc2ylhP8LaHdIg3uUmCkojtoDSNubh/neRqWBry/3YvgQki3apir
JPAfChqUmDC+qQpe7t7nHIa9Dq5FTHuxcGZ5JxioNdluY5nTRxxBLvZHaASGVtK4
EJWqkZDSKN9QgvPek+cQCVobozf/22uDjftDu2tUvwojURJs2jj8LETqNgukn1s4
XMe6gEXEhR01fdPV51hQ6QY/AkHLIdgqpCLGa1Qd8tUq/dnGqgZAVaMCNlTTGn8D
mVDpL7KqcQu0elyrzCkboZWrWN2qgM/7dXIRspEEYScXduWJLTXMThyt/Bj9pvT1
KYVPNvYeKsHYyde/qpC4ELwpqfmHsjYfxy91bnXUlS+/UT909zwbKV7cwGFfROFM
X4i2ATZAZNyz801Ax/rpT5yFlbuWI00pvPMhrDGZAaTiUXW7Xgs=
=4mOQ
-----END PGP SIGNATURE-----

--sWvRP97dwRHm9fX+--
