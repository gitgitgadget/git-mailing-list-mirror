Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C50F71F461
	for <e@80x24.org>; Tue, 20 Aug 2019 22:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfHTW4T (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 18:56:19 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58160 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726229AbfHTW4T (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 20 Aug 2019 18:56:19 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EA1D96047B;
        Tue, 20 Aug 2019 22:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566341778;
        bh=SVLdHjWvcEuypYi+eiXEtOdYl6c+x8lw4yTox8lYdTQ=;
        h=Date:From:To:Cc:Subject:Content-Type:Content-Disposition:From:
         Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
         Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
        b=tFQSTsqLLOC7zrl2FOpoaqTq5/noeGecuYnko7qD4bewOoNAIbDkv5aeoPqLEVXoV
         b2hjLGZW1gRqWGqMuMqLBZXGkNUD9W0ipZG8325KQ7QyHrO/8WvGcdF2BB1FUDySSC
         +RkMUAEWivV/VRubJa2OXdHzf4lNqFhCUIv/p/WbCznupqrlegfzuj/DHVkpUbApFm
         JakRSxnbNZtmdL4KSbZFeoNVNqs7NdOBTLbaSU0rwDuwimIAksH8+yrB25j88vKlBt
         cRw03o2ei0t44pd1AzuvNVdYNl++0RpbtQPbztovqCUn5BHoz0QnplWvt1yITOzZSc
         E1uTg5v/L78R6hguGwfz0w4MmQCP0L95FmduuGsFm207g+0SFr5v4JmkbGE9pUPN3L
         IWfZuaqNNJZBOD2I4GtpNOTBvz2yQvdIa6hXmZBSYSJUmZJacyMEUasLvSpyhkutee
         Z5jv9QvfckrWkVrBL3HCijpfb2RUwpg5inf3iZTX5xbS7r42p+K
Date:   Tue, 20 Aug 2019 22:56:13 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>
Subject: Feedback on git switch and git restore
Message-ID: <20190820225613.GK365197@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5VuzLDXibKSJvVYD"
Content-Disposition: inline
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 5.2.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5VuzLDXibKSJvVYD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I just wanted to let folks know that I've seen multiple positive
comments on Twitter today (at least 3) about "git switch" and "git
restore".  Folks seem to really like these new commands and are excited
about the improved UI.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--5VuzLDXibKSJvVYD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1ceowACgkQv1NdgR9S
9otohg/7BA7LhSBO9fVniZgVUNL1aIorHmiWnmzMCHf7jzsypLEymuMhURY/So0N
HHHKTrrac5R2GJXVYRYh6RqtWRwu30v93COPGw0JbO1WMs/fNEBzSfhKx0P3t0d/
DGoF54i/m8LGNAk7CJfEqLAO1X6LNfttSwcdnXJG97cOw5dZOF47zPpaccwnyBr9
9XcmNY8bTwVOFbrX3ArGwMuM5L5oc9uEmb0KGnM7+zSzKe0zvv/6udNdXJBsJBDV
RUhiHzoxGIiOZpz2o0mH6s0A8SaHd/t3NUAAcDLbwM7RbW190YeJPWMS0cXPRdGV
6dEoQZA5fqMx++QAi63H+kk96R3xUDnDN9p0KFazRd8VaD1u753rWTMekBd8dovf
37K6S84ZTaSleXfaJsOhV2uu6CdlERbLB+50S3UAhvHP3EXvgQVXzxiXtFlKRsQU
SO23kO4Mn/LV3+tmPFf73CBfnSSi0heHOpl5XhdoW+QsFi0SWa9M1kC/SoIZHWxI
hLbNClZhelUujiWQyTUQtTzhsWIigxhwfUVhOAhMPGkEvUWWB1bhQKNZvIgvGx7x
2oCa/IZ6jEk43exZLPauUKEzun3KdjfawU5vEfCPbjYmoHN9JlYLcit9GVVEgBdC
9gNQyvvA4KBhQwR8VoWEm8pY0QilxOHcujcNfjlgjqMLZD6EZuQ=
=eGMv
-----END PGP SIGNATURE-----

--5VuzLDXibKSJvVYD--
