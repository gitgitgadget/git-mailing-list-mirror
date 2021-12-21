Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E740C433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 01:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhLUBr2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 20:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhLUBr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 20:47:28 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91CBC061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 17:47:27 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 1C35C5B21C;
        Tue, 21 Dec 2021 01:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1640051247;
        bh=hfO8K5a/W1rzovCpFOeiEOU4wAshU/f33rDsr2CY4vg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=YmavyynzW3ZYpnfu+M6cFlIoPnxFgp6wb1m742zQB7j9/g1zo7X7aGnB77YpnQ/db
         c6dsO+dk5Rn0IJle4zeVAU/gJkKrop/OSfqUWbtATPpByBEilZhb9H97ue/1XPkN+P
         tPJrRzVb9bNFwIJHAXpINihMIP6bzqxPZyuR2p/ToUR3T2c7XcCmat8dkjJCAT6yTa
         qhaXjnU4XjQQEAGfwCncRSL9P8wuaHNTZiKrxRM6D0pSBEiNJvPVGCf51/MSJmdCyq
         xOgtTAgthZUg/rGTR43pEdcy66MgeFDVcvKAwS92y0vY4FYLy/o8JJOUWRpKDKUbVm
         OBh+bxLIEqWlSZ6sY/J3eYFV8ixOe7C8AoWYZWYtU+JO3sVwsmg6un3LHvJ0dV/9yL
         1n1O2XlZ2wARtqEyKHXXjUzSZJzRMHv4QP+MT9o0UvQl8/qA1TnY7HvXrs1foQu2dg
         694C79WOIPORO/1uYgF7sXVl+j5ek5nDw4ZR42pNUx931uyChe9
Date:   Tue, 21 Dec 2021 01:47:24 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        jrnieder@gmail.com, jonathantanmy@google.com, steadmon@google.com,
        chooglen@google.com, calvinwan@google.com,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        rsbecker@nexbridge.com
Subject: Re: Review process improvements
Message-ID: <YcEyLMkM3fvGYCUY@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        jrnieder@gmail.com, jonathantanmy@google.com, steadmon@google.com,
        chooglen@google.com, calvinwan@google.com,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        rsbecker@nexbridge.com
References: <YbvBvch8JcHED+A9@google.com>
 <211220.86fsqnwkzs.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pniDcuco/LQ5DOc4"
Content-Disposition: inline
In-Reply-To: <211220.86fsqnwkzs.gmgdl@evledraar.gmail.com>
User-Agent: Mutt/2.1.3 (2021-09-10)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--pniDcuco/LQ5DOc4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-12-20 at 11:22:32, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> E.g. I've often chimed in on changes to do withn how/whether something
> can/should be marked for translation. I added the i18n subsystem
> initiall, so for those cases interested parties would probably find me
> anyway, but I wouldn't mind being explicit about that. Ditto for people
> we consider the authority on certain subsystems, such as (this may not
> be any one person currently), refs, the index, SHA1<->SHA256 interop
> etc.

I have limited time for the list, but I also tend to pop in on certain
topics: the SHA-256 transition, commit and tag signing, authentication,
translations, and so on.  However, outside of the signing code, a lot of
that isn't centralized in one place.

I also wouldn't be able to commit to signing up for any subsystem in a
MAINTAINERS file, but I'm happy to be CC'd if folks think I'm
knowledgeable about something or if it's an area they think my opinion
would be valuable.

I can't speak for others, though, so I don't know if a MAINTAINERS-style
approach would be valuable for them.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--pniDcuco/LQ5DOc4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYcEyKwAKCRB8DEliiIei
gePlAP0b0QWiSXwue6gwRqHAD07pGPbF+VtRLQlxYzcW9vn/FAD+Oi3GhMuczH34
KulZ0vTtmC/8HSBa54DdQGJz53ISFQI=
=T3bz
-----END PGP SIGNATURE-----

--pniDcuco/LQ5DOc4--
