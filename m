Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E39AC433E0
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 22:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 437C723B01
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 22:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbhAIWGX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 17:06:23 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49736 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726305AbhAIWGX (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 Jan 2021 17:06:23 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8301360781;
        Sat,  9 Jan 2021 22:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1610229941;
        bh=EKmjXVyfmvjutQiJ7U6epUK4neiArXZHTL0uYCrJ1AI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=BSpblaxZlMnTh0y3xCBHY0nQXWoL0fyYnfg1iaTCF1eKbmf/Jz4EPskV/5YRPAQ0s
         DWz7OsAu06GDoD/tt6tfXXal9aCjnzCjWUxc02QALxpac+y4bJxaoI0dcywqDcQJAJ
         2ifR4B8tFUynNrtKU4aIZwo9NYVyyelyJ8GuZ5T3How87BPC6yw4bMYhOHTQLv7NQD
         l6VLwx9EIH3Y3El6aC8d1HnI3Qg9l2FsO61eXXQ5oX6z+7wPZzf3jMXD+0FAYC2gub
         nf6gHDR1IKneyzqgvAQuhH6Y+OuA4Tqvo+6Hz+TrY78VxYWtgG/qNBDbA1M6H9fN7L
         JNStSVmuDuphL3W+JkG6ILI8izVfTgPA7KE9gb3eneCJwk76SrApy/T4xlpQ22rQCj
         k2G96sVFIbPiQWISoFVz51un6veXq9HNS9Opb4DTJmXI25gQPdltGaNxH48jNJEWOF
         ciYr8ZblL9oYXcP5hO7RikwjOi7UjLBa+9bvwpRZwuS6/Kfr3VE
Date:   Sat, 9 Jan 2021 22:05:37 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2021, #02; Fri, 8)
Message-ID: <X/oosXBJlyt/IrOr@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
References: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
 <871reu752k.fsf@evledraar.gmail.com>
 <xmqqk0slg5ph.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Pg9cHlH09oXlkmSt"
Content-Disposition: inline
In-Reply-To: <xmqqk0slg5ph.fsf@gitster.c.googlers.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Pg9cHlH09oXlkmSt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-01-09 at 21:28:58, Junio C Hamano wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> > FWIW there was since a re-roll on 2021-01-03, but the discussion is
> > sort-of outstanding, so maybe that's intentional...
>=20
> I had an impression that those 4 or 5 patches haven't gained
> concensus that they are good as-is.

There will be another reroll.  I'm hoping to get to it this weekend.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--Pg9cHlH09oXlkmSt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX/oosQAKCRB8DEliiIei
gVQmAP4jPvH8KuPAicBAHGBDW/jRdz90u8SUhiP1MiW/E5KI3wEAyfvsBAJmVhDz
/pSgUO3Ou9/eAJqIhwsKLVDy8ONHzQ8=
=mlax
-----END PGP SIGNATURE-----

--Pg9cHlH09oXlkmSt--
