Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF6FC433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 01:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbiCJB12 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 20:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238308AbiCJB1W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 20:27:22 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B4AB10A4
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 17:26:22 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 6F8395A3B8;
        Thu, 10 Mar 2022 01:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1646875581;
        bh=phkWOEF1h4GyNoRExC35FIhsMDbhY61Nwryr+Ouv7Cw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=wRUZLdddjV+f3WHUVon8KmCufqZDbluu/i4uJNyVtFziZcI0kuDM20a51uCPSRB48
         hb3Mf9XSP+KuloPCP8/iA/W58Ycj9f5Dif0qc9G9z+zXcFp1a68A6ZoTEQeQabcKeb
         p80kQ6fMQN6PyJ6Xnq9af7yhSsuW5arHnn4GDNe9xYI0yH6dk02zbAcate3JUXTpzb
         2Jp/QgEc4CWOHYvh9Ods58HRrEIc/KPFglCzH/ZVhsjqWcHCwqFg81ZGM39wxeLeNU
         c80gsdl8DqngVL48SbXOmFEzl5UUGdn6PWxtSMgz4pptJhXVeWCylZY5vRpxqxfrQx
         kZLw8dXYSGoqvJNVrEwA3Xdimt138vWEzyAN0vX+S/cPxhbyy9dZzBRqDDfk8kDoxm
         3l2CqRjjWWiD21TDj/SdqDvq/mMMJnr+y5f5ysomOswdWZK00zP1gqNyX7j/JlXI1k
         hpVnMgNFMhb62hyT9YqvsmDETlwZaS2Wg2ZaEXz2uYLjSJNAcDT
Date:   Thu, 10 Mar 2022 01:26:18 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, rsbecker@nexbridge.com, bagasdotme@gmail.com,
        newren@gmail.com, avarab@gmail.com, nksingh85@gmail.com, ps@pks.im,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v5 1/5] wrapper: move inclusion of CSPRNG headers the
 wrapper.c file
Message-ID: <YilTug0iH/N2Fbpb@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, rsbecker@nexbridge.com, bagasdotme@gmail.com,
        newren@gmail.com, avarab@gmail.com, nksingh85@gmail.com, ps@pks.im,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
References: <pull.1093.v4.git.1643686424.gitgitgadget@gmail.com>
 <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
 <685b1db888079c83573cfd984ae64f46284544af.1646866998.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Dg9UVDuoQ6aynRb9"
Content-Disposition: inline
In-Reply-To: <685b1db888079c83573cfd984ae64f46284544af.1646866998.git.gitgitgadget@gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Dg9UVDuoQ6aynRb9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-03-09 at 23:03:14, Neeraj Singh via GitGitGadget wrote:
> From: Neeraj Singh <neerajsi@microsoft.com>
>=20
> Including NTSecAPI.h in git-compat-util.h causes build errors in any
> other file that includes winternl.h. That file was included in order to
> get access to the RtlGenRandom cryptographically secure PRNG. This
> change scopes the inclusion of all PRNG headers to just the wrapper.c
> file, which is the only place it is really needed.

We generally prefer to do system includes in git-compat-util.h because
it allows us to paper over platform incompatibilities in one place and
to deal with the various ordering problems that can happen on certain
systems.

It may be that Windows needs additional help here; I don't know, because
I don't use Windows.  I personally find it unsavoury that Windows ships
with multiple incompatible header files like this, since such problems
are typically avoided by suitable include guards, whose utility has been
well known for several decades.  However, if that's the case, let's move
only the Windows changes there, and leave the Unix systems, which lack
this problem, alone.

It would also be helpful to explain the problem that Windows has in more
detail here, including any references to documentation that explains
this incompatibility, so those of us who are not Windows users can more
accurately reason about why we need to be so careful when including
header files there and why this is the best solution (and not, say,
providing our own include guards in a compat file).
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Dg9UVDuoQ6aynRb9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYilTuQAKCRB8DEliiIei
gfupAP9IwuJsq+bkOaNTDQUDUEimXfBMea3IGXR6qxDhlN4w1AEAx5OhmMsJcwlJ
jsfz54Ssp0CGkyLxVgxo08qYvVF0GAA=
=7Zca
-----END PGP SIGNATURE-----

--Dg9UVDuoQ6aynRb9--
