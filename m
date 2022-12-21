Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21FAC4332F
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 22:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbiLUWJd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Dec 2022 17:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiLUWJc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2022 17:09:32 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A996A1A38F
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 14:09:27 -0800 (PST)
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id C972F5A20E;
        Wed, 21 Dec 2022 22:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1671660566;
        bh=a4dtreWVRjI+0uWQrrJE2T2tDMAb60Jo1rawaa/R0nY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ULbPu9HH4qSXqIapO0z/dHIgiqDU9ijONDjTtJo9xw9r2OPZnaOK18ZLmKel3E5gN
         x0vc/ukPdGTNSWdTh9pPqa8/pl3ZEFRIx2omsBRgu8lJ3/GhruksJY7rxSupz6JRC8
         +DkfgohHzJjJdNOBwganz3k94LWc+NFZ2p2GdKtEll4Gy5IeWi32sVwu0Zypya79Vl
         2yBRz15+dR5gQCOe3c/EKfNsemY0UNmCu6eAmqhy6xvZGKSi5Se2py51aT807XwVnw
         O+6ZhK+ZJTK0c2cxeWF7HFO0T+X7jNYX4O5uwKVuJ07x8OHn7Ah1CJs4qnyr2+KjxT
         acydG0Aiq+hrkJwibzqlnABb9JikD2TnYC7fcnoIBf+a8/AZxM3fO+LpD97NLCNlYd
         Gh9m1K0CMY/SwphvLsC8bWSDbIt3WIRzk89ehRG+hqyp+fHWhxtDFLErthFEjwiHSd
         pMxmKriCuR+iLXIikOsji7RHdpQrThJZwRZEUEMIHC34nRB4t/I
Date:   Wed, 21 Dec 2022 22:09:25 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH] Documentation: clarify that cache forgets credentials if
 the system restarts
Message-ID: <Y6OEFQs2OphhhuhB@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>
References: <pull.1447.git.1671610994375.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8atU0X5i0xXvvptR"
Content-Disposition: inline
In-Reply-To: <pull.1447.git.1671610994375.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--8atU0X5i0xXvvptR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-12-21 at 08:23:14, M Hickford via GitGitGadget wrote:
> From: M Hickford <mirth.hickford@gmail.com>
>=20
> Make it obvious to readers unfamiliar with Unix sockets.
>=20
> Signed-off-by: M Hickford <mirth.hickford@gmail.com>
> ---
>     Documentation: clarify that cache forgets credentials if the system
>     restarts
>    =20
>     Make it obvious to readers unfamiliar with Unix sockets.
>    =20
>     Signed-off-by: M Hickford mirth.hickford@gmail.com
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1447%2F=
hickford%2Fpatch-2-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1447/hickf=
ord/patch-2-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1447
>=20
>  Documentation/git-credential-cache.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/git-credential-cache.txt b/Documentation/git-c=
redential-cache.txt
> index 432e159d952..83fb4d4c4dc 100644
> --- a/Documentation/git-credential-cache.txt
> +++ b/Documentation/git-credential-cache.txt
> @@ -16,7 +16,8 @@ DESCRIPTION
> =20
>  This command caches credentials in memory for use by future Git
>  programs. The stored credentials never touch the disk, and are forgotten
> -after a configurable timeout.  The cache is accessible over a Unix
> +after a configurable timeout.  Credentials are forgotten sooner if you
> +log out or the system restarts.  The cache is accessible over a Unix
>  domain socket, restricted to the current user by filesystem permissions.

I don't think it's accurate to say that the credentials are forgotten
sooner if you log out.  That may be the case on Windows, or it may be
the case if you or your distro have configured systemd to gratuitously
murder all your local processes when your session exits[0], but it
hasn't traditionally been the case on Unix that processes exit when your
session or shell exits.  For example, I don't believe that the statement
is accurate on Debian, Ubuntu, or the BSDs by default, which constitute
a substantial number of deployed Unix systems.

[0] Such as with KillUserProcesses=3Dyes.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--8atU0X5i0xXvvptR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY6OEFQAKCRB8DEliiIei
gXu2AQD0ssy/kMmdVxu+4HXimTyma5dCFqeEt38BPMkUfKS/9wEApVr/90RteQ8g
16HDt5aw+YljFO7HXS4t93rWaK6y8Ao=
=k4Sc
-----END PGP SIGNATURE-----

--8atU0X5i0xXvvptR--
