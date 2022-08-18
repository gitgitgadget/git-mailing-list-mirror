Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E238C32772
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 17:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345193AbiHRRAy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 13:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345271AbiHRRAO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 13:00:14 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FCDBA9D0
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 10:00:10 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [104.129.158.24])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 3AD445A29B;
        Thu, 18 Aug 2022 17:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1660842009;
        bh=D9XzTkz2BDSOZ3p74KrX0mx+OEXAvffxLFGZ8uDLXJs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=wFt1cKGdt/I8pUOwxVoSM0XGu0qzYfJyD+QVYo9uK0qYN3beFg9jlh7ITGwcS2eyG
         LBGRgrHwzQq3Ar1LpRSiTiUANTfB89o2UdQ19qQmT7FhbpuQc3lwrayPqpIQp23P0W
         16Dl/6MhLJ6DV+k1RT1vuPT8hxnCt8FJ7apd8Tt6MEjblUCX/RqRIBYlbZNk/aZcsc
         3kVEvqPbzeR7xNczuMT6xV2hMjlrm8VK57MeQuY9fDhkHVzlbLd0hECuB/9CxQTKTB
         u3PhlCdTP4e5O1mD7noT+KlbbT6xQDkcE17X5iOcSShYPPfPw8xHVTNO0BsJ8AN6u5
         v0+YJFpYFtsnn4nJghuXito1ZjaqCPZxYRRASaIXOiBgXDBu+Z2MquU9Fak0RFgtnX
         +V6yFIVpcgivlcFxFnrofxlem8lRZc+8NPikXPF85BbqsDjbSZOOjXfx3gnj8GMzhG
         AdjKO/AhvHhYRAggwqzyjfI463Xz9aykyTdx4Z6UoQ6WjNusAJl
Date:   Thu, 18 Aug 2022 17:00:07 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Sergio via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Sergei Krivonos <sergeikrivonos@gmail.com>
Subject: Re: [PATCH 2/2] Add Eclipse project settings files to .gitignore
Message-ID: <Yv5wF0DxVe38ygap@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Sergio via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Sergei Krivonos <sergeikrivonos@gmail.com>
References: <pull.1307.git.git.1660831231.gitgitgadget@gmail.com>
 <106a0563cfc29b75dbdbd54ce55140762e133539.1660831231.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aX47IbAj1HC1xKH3"
Content-Disposition: inline
In-Reply-To: <106a0563cfc29b75dbdbd54ce55140762e133539.1660831231.git.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--aX47IbAj1HC1xKH3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-08-18 at 14:00:31, Sergio via GitGitGadget wrote:
> From: Sergio <sergeikrivonos@gmail.com>
>=20
> Signed-off-by: Sergio <sergeikrivonos@gmail.com>
> ---
>  .gitignore | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/.gitignore b/.gitignore
> index 42fd7253b44..13755c31caf 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -246,3 +246,5 @@ Release/
>  /git.VC.db
>  *.dSYM
>  /contrib/buildsystems/out
> +/.cproject
> +/.project

I have no strong opinion on this change, but typically, to avoid a
proliferation of patterns with everyone's favourite editor settings, it
can be useful if each individual user sets their own editor files in
~/.config/git/ignore (or core.excludesFile, if you prefer a different
location).  For example, I do this with Vim-related files, and it
applies to all repos on my system, such that other developers don't have
to care what editor I use.

However, Eclipse is a popular editor, so it may be that Junio really
likes this change since it will benefit many people.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--aX47IbAj1HC1xKH3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.35 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYv5wFgAKCRB8DEliiIei
gTB/AP9KBA2TYshK6WBf2s/smGxS5c8VEvqp4ccuLevn10631gEAte3K0AZ4gJlA
RuxYr5Y1VLk6p/Cz/2RnalMauD2nDQ4=
=XApo
-----END PGP SIGNATURE-----

--aX47IbAj1HC1xKH3--
