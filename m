Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE75C433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 22:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351692AbiA1Wbt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 17:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351661AbiA1Wbr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 17:31:47 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F8CC061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 14:31:47 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id B72FA5D4C6;
        Fri, 28 Jan 2022 22:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1643409106;
        bh=naUbK85eQSb9Y3YvfS0e6WszhqX9DOYis3MjQOGT4Xs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=IaTOnCsBIc2NqS6Tpog+hDcBe9KYRNgYNuo5fwzoNpHERidNztMpbtyxIhIWllReP
         SMnjnLY/OZYvL5ktwk7BgjUgn7dl5prHx8eTCG4ZR533eTZ1uuKNZp5fgcL9hp4w7t
         oV0pkMG2+JFbCKFdhyZ+uCaFOM2nlt/tKpBejbaQdyVMGy3Ruu+tzVhZiw1X9IxVwY
         Ixoyke7l1Ty8JolFeOxHA6VZDvGlyY8x6ZxfjORBvsB+kRUdcJCw+uWnB3dbPuNU8+
         UQBYPehdcRzCxMiaLhwGVglRkj2TrFVWOL7fCph2PI+hypPi1PAiLuBJ1bO8O0lbAi
         IyAZmiocswLsp4/KKtPss6giZpOoPcwXzeTuOLs4Rlvacz7pXcbff2aEurknBC2yXp
         f7ubT8eoHEnsKS6V9lh3Wz1ANuDOlPQJkSilJOVdvV4sWmowiSFa+b3qBdrgvpdc7D
         091v3bmjFVw49P5u73S0neEfw1ISawpyNbN8RimgFCVeOIJz/49
Date:   Fri, 28 Jan 2022 22:31:44 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2022, #07; Mon, 24)
Message-ID: <YfRu0G9aNQxT3vtl@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq35lc53e9.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ukANNsAITtloUtwq"
Content-Disposition: inline
In-Reply-To: <xmqq35lc53e9.fsf@gitster.g>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ukANNsAITtloUtwq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-01-24 at 19:39:58, Junio C Hamano wrote:
> * bc/clarify-eol-attr (2022-01-12) 2 commits
>  - docs: correct documentation about eol attribute
>  - t0027: add tests for eol without text in .gitattributes
>=20
>  Doc and test update around the eol attribute.
>  source: <20220111021507.531736-1-sandals@crustytoothpaste.net>

I'll try to take a look at the feedback here and possibly send another
round.

> * bc/csprng-mktemps (2022-01-17) 2 commits
>  - wrapper: use a CSPRNG to generate random file names
>  - wrapper: add a helper to generate numbers from a CSPRNG
>=20
>  Pick a better random number generator and use it when we prepare
>  temporary filenames.
>=20
>  Are we solving the right problem?
>  cf. <220118.86zgntpegy.gmgdl@evledraar.gmail.com>
>  source: <20220117215617.843190-1-sandals@crustytoothpaste.net>

It sounds like folks would prefer we drop this series.  I'm not planning
to send an alternate approach here.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--ukANNsAITtloUtwq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYfRu0AAKCRB8DEliiIei
gSlXAQC4qWhatu+o/0ChTjryifFk7nu20diihmFOvvaU0CsVbAEA2zwNoY4qX/l9
RzHNfSLapoHJ73HGCRrqUUoZTRFtBgg=
=YOTE
-----END PGP SIGNATURE-----

--ukANNsAITtloUtwq--
