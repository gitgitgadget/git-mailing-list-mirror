Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F28C433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F17220771
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="rh3sk13G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgHNUYX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:24:23 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41554 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726213AbgHNUYX (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Aug 2020 16:24:23 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EEE7760456;
        Fri, 14 Aug 2020 20:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1597436632;
        bh=QyDSVEMEKg1a4u34D8QvVuRUx7oSPv1OIiLkH/8OkT8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=rh3sk13GRNt0CeNIyN2tOYxIlOjKfsquinJ4SPstvxWtD2fZtjovQG8qHnL6JRXnl
         loTSUF1fBRaX0OwjUGtK0xwvEH8BK0bEhre6U5EJgeT3dQ4PxdYCJTFR0Aw67KOwVq
         DfKtzWLXZFjyiv1fiwfX7uBS4YUMAmG5db6wxEhUWPynFVkDpoKQPp7/7K37GiNJMt
         /leFNWsBg+lrV8vghAksqSb7Hey6j1Floth5X6TSEG6I7XTFpSP63ROeM4yubmtvk4
         6lQhkfVIUjLBM7KXr0Q1ahrRyT8BKD1UH0P7NAZjBdBN3cfqqx2qC8J2pmA+7npwbH
         TloT31b3s1V/fZhH+QD/RHr83kXSUFKe+jk/dx5u6EbvVhBkEvRqEaym8glBT6fCW5
         p8ZNDycvN+MZlTHJQcTjf4nu75mwCY9U/sn285Cj/7uoZugzu2aK3SfpCHHFb/jbwF
         jTs1Unom60FOpAKG+2kbWsY9L2r3IufLmA2R58gNHj5QjgDASzD
Date:   Fri, 14 Aug 2020 20:23:47 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/5] http-protocol.txt: document SHA-256 "want"/"have"
 format
Message-ID: <20200814202347.GN8085@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
References: <20200813224901.2652387-1-sandals@crustytoothpaste.net>
 <cover.1597406877.git.martin.agren@gmail.com>
 <5590a68c5ba7081cd7e64c708b5c25db23f5e95b.1597406877.git.martin.agren@gmail.com>
 <xmqqk0y1xhl0.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VnOTrGv5LmZxna7m"
Content-Disposition: inline
In-Reply-To: <xmqqk0y1xhl0.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--VnOTrGv5LmZxna7m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-08-14 at 17:28:27, Junio C Hamano wrote:
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>=20
> > Document that in SHA-1 repositories, we use SHA-1 for "want"s and
> > "have"s, and in SHA-256 repositories, we use SHA-256.
>=20
> Ehh, doesn't this directly contradict the transition plan of "on the
> wire everything will use SHA-1 version for now?"

SHA-256 repositories interoperate currently using SHA-256 object IDs.
It was originally intended that we wouldn't update the protocol, but
that leads to much of the testsuite failing since it's impossible to
move objects from one place to another.

If we wanted to be more pedantically correct and optimize for the
future, we could say that the values use the format negotiated by the
"object-format" protocol extension and SHA-1 otherwise.
--=20
brian m. carlson: Houston, Texas, US

--VnOTrGv5LmZxna7m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXzby0wAKCRB8DEliiIei
gc6IAP4gSRkkB+/QSkA+dcThrCAAS2pQgFbDfw+C1jOS5omldAEA3AkcxES8sYPr
C2L5z7D3/4gy8GoUC31wixWiK9J/ZAc=
=bfYs
-----END PGP SIGNATURE-----

--VnOTrGv5LmZxna7m--
