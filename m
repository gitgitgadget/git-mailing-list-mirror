Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F80BC433EF
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 22:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23764611CB
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 22:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhJTWVo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 18:21:44 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37704 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230325AbhJTWVn (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 20 Oct 2021 18:21:43 -0400
Received: from camp.crustytoothpaste.net (unknown [72.12.180.34])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3041660734;
        Wed, 20 Oct 2021 22:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1634768368;
        bh=PkK/VCoYceZ9IJ3X9A3ypT2GPB+wMHLD/btLi2DXVjs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=p2eqO8b5K26UewqcAmrdDnaym3H4HfT9gsmoWgrOlo5w+FWe8WSSkcuXb7uQIoIdO
         GoB2rwIOWG3KXUWxbyE0R4Qaa6u73bk0rx9cum0Vd6sK5pQ0/7XX9LAbCOZ8ObtBm4
         4whgTEuzVizRWR11phDg+vk+ipVY2PGEmu96Nybn4ZK6iVXVfjwvQp1vKJHKgB+hg7
         C+99K/AJ26+Y4UPfbmYn1+43bJV7BJ4kqOK/K9B7SJE8etbaBh9YYRMYrSdUJwkV2B
         Xaw3y78ZzNaTphXGY7pNJA7SxiwW07ygpQmm/Vf+iZQ+4P5X3HTvC/WysDhuS3vV8+
         u5XnENEZKZdwO1Sk/uR2KwRBS5XwXi2J7KMwyxFlyS1niIJ9/VRP/UgXR6V1le/yCD
         sZeYxFXxDSaqwqXd9S6Me9qjrW0Ki+Gi7g3cPumFt28aMDfNkpnFakAtn01jewiMto
         QChGIDQuNQylK9+pHVGAmbtHadARibvuEhJnkoh3uacjBMrtEHS
Date:   Wed, 20 Oct 2021 22:19:08 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/4] gitfaq: add documentation on proxies
Message-ID: <YXCV3GYpwe8uCfQo@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20211020010624.675562-1-sandals@crustytoothpaste.net>
 <20211020010624.675562-3-sandals@crustytoothpaste.net>
 <xmqqbl3jrbvf.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XCmzjup7yMOfLcJa"
Content-Disposition: inline
In-Reply-To: <xmqqbl3jrbvf.fsf@gitster.g>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--XCmzjup7yMOfLcJa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-10-20 at 14:48:04, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > Many corporate environments and local systems have proxies in use.  Note
> > the situations in which proxies can be used and how to configure them.
> > At the same time, note what standards a proxy must follow to work with
> > Git.  Explicitly call out certain classes that are known to routinely
> > have problems reported various places online, including in the Git for
> > Windows issue tracker and on Stack Overflow, and recommend against the
> > use of such software.
>=20
> The new section only talks about http(s), but I recall Peff recently
> helped folks with broken invocation of socat, a relay that does not
> handle severing connection only in one direction very well.
>=20
> I wonder if it fits in this section.

I think it does, and I'll add it in a reroll.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--XCmzjup7yMOfLcJa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYXCV3AAKCRB8DEliiIei
gYw7AP0by7o1lIgWBy/p8U5BqaOSJaJP20iBDf+/vYETYKVVMQEAx0E/Y7zhYsdv
sgonxo86l2yweIzesyYP+SFH3MIvAQE=
=M7My
-----END PGP SIGNATURE-----

--XCmzjup7yMOfLcJa--
