Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3258AC433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 22:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344427AbhK3Wke (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 17:40:34 -0500
Received: from ring.crustytoothpaste.net ([172.105.110.227]:47806 "EHLO
        ring.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344342AbhK3WkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 17:40:25 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 6D1385CBB3;
        Tue, 30 Nov 2021 22:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1638311823;
        bh=WFioB8jv3FU/qOzWsGvpUN1Tep33q/mp7FuI5HK1YtY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=D1+ibaC/Xb4F5vQuCHiobXvFztAXUb7ToEBZqC0BhoE2OFE4tgO1UKmquhy+Acl2t
         QxaNKc5+2TCL1TKb4X7gqUM1xYK0wvHuYxnFwN6iEVFJ9EsF7KkoDRXgYMV6qzm3CZ
         XZ3VqkWsHpAyaKLy/0+gk1L5LJ6i1dBvGWtYT3wUYkcWyM+QvJIGEtxyEbmSdM3Czb
         /cuWXczybKf81FSjXZlOBHGCI04KskRfv2KIYkbkTBZOpnHWIDIe50OlAZTWdXb2MR
         u4hHxeaZyubWiJZW3x62hmMfpGoCSzixXxCkP9ONe/sz8jYrQ2xfR4/xop0WoX/ZCv
         4YAnyDyhiXIzv8R5dYIYvrn8q5y+ipxHIDYa4ElxjB+1IU0JGBhJTQCqywmpHM43tI
         gaGkt4e1xUcVgLxYdDuzmB7jDaXBbozPOhtPENVrGVPOcQeD7e2E6PIPwScPEhpOvC
         XNBCKOY+ZVa8k4f4AhPGE3UZMBzbPnpQsHZZDWH18p5eA28r6O2
Date:   Tue, 30 Nov 2021 22:37:01 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Microsoft's C language policy (was: [PATCH 0/1] Add a test
 balloon for C99)
Message-ID: <YaanjQgqb6riZGh8@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
References: <20211114212437.1466695-1-sandals@crustytoothpaste.net>
 <211130.86o861cqnu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="26CJArrRHOkR1Cle"
Content-Disposition: inline
In-Reply-To: <211130.86o861cqnu.gmgdl@evledraar.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--26CJArrRHOkR1Cle
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-11-30 at 20:43:15, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> I hadn't seen that blog post before I'd read it when going over your
> series. I'd assumed that Microsoft was just dragging their feed on C
> language support, but that post indicates (from what seems to be as
> official of a source as anyone's going to get) that they're intending to
> not support C at all, but just some pseudo-C that happens to be a
> convenient subset of C++.
>=20
> However that post is from 2012, and you indicate that they've since
> added (full?) support for C11 and C17.
>
> So is this "policy" of supporting some arbitrary subset of C++ at all
> current as far as MSVC today goes?

No, it is not.  MSVC should have full C11 and C17 support, at least
according to the documentation I've seen.  They seem to have changed
their mind (maybe the Windows kernel developers complained).
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--26CJArrRHOkR1Cle
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYaanjAAKCRB8DEliiIei
ge7EAQDvPOliRk7Ht2uVwyNHt7qSxbP5jiKwrnvQgANkXc8MfQEAzSVnI/tuq6fh
rAIy1KumxqIO2jG3R4UgLxeysnRcOQ4=
=eSiQ
-----END PGP SIGNATURE-----

--26CJArrRHOkR1Cle--
