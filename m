Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 477F21F404
	for <e@80x24.org>; Sun, 28 Jan 2018 19:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752350AbeA1TQM (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 14:16:12 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58460 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752328AbeA1TQM (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Jan 2018 14:16:12 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B13AE60402;
        Sun, 28 Jan 2018 19:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517166971;
        bh=4ClVKxxp/TXcrpuj045M3DhJ9N8Qjxp1B6SVHSVth7o=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=QHNoNmFMp6xgvuXoSq8HFoaRsalHQMJSWZ4SWLvutdyDOqf+i2MH2lFeOTpZ2V/U4
         SwHXfPbkrlmgDfmSnIN0jsRkssSjkPgqrZScITgqNSCQfA4jRlm1Y8Nnv7rzdlu8e7
         THjcRTREHqUJ2Dj9iS8Bo90O5yBljgwoOsnG7vGDkRLzUdSU4L3LrPgMiZMCTy133v
         QPDWnenLcDqmDNvpjlfCwqpj0kc6dRisAIgO4zKR+zqbgZ2V0EhGSpfiX7uNwihJGj
         JC9xxr3Cq4WK5cucAz2S518Ew+Z7GLFm754QNPTgwzP47/4RgqlnIZCeGAxOyY0/Mf
         UZvYE9RMnfgefjjv7hK+1v1+efA3xXP6PtKYiu5XDZSeGmIZJXnWmn1xg/R1x4IMOf
         rTSBGMeiPQIr2AUkThYXphlFqTscTumTqFGyVtYjcvbYcjqeXGWSYjbDV5mgiNCvee
         cs4Wblh6Vz75H/W2RDlBZHgkClhM4EvWkqlS6Q7JOzbGCDru+FW
Date:   Sun, 28 Jan 2018 19:16:06 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH 0/2] alternate hash test
Message-ID: <20180128191605.GI431130@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20180128170639.216397-1-sandals@crustytoothpaste.net>
 <CACBZZX4TRuPV8j9XV=8gAMirQNTpEJBO8bmE9KBnnmoJ7b_m1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a7XSrSxqzVsaECgU"
Content-Disposition: inline
In-Reply-To: <CACBZZX4TRuPV8j9XV=8gAMirQNTpEJBO8bmE9KBnnmoJ7b_m1g@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-rc8-amd64)
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--a7XSrSxqzVsaECgU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2018 at 07:58:10PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason wrote:
> On Sun, Jan 28, 2018 at 6:06 PM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> If the goal is to smoke out hardcoded SHA1s in tests, isn't it easier
> to instrument SHA-1 (e.g. our blk_sha1 copy, or our wrappers) to
> pretend that whenever we ask for the hash for STRING to pretend we
> asked for SOME_PREFIX + STRING?
>=20
> Such an approach would have the advantage of being more portable
> (easier to run these mock test), and also that if we ever move to
> NewHash we could still test for this, we'd just always set the prefix
> to compilation time(), and could thus guarantee that the hashes would
> change every time git was built.

That's certainly a possibility.  We could simply call the update
function from the init function and prepend a NUL byte or something like
that, which would definitely produce different results.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--a7XSrSxqzVsaECgU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlpuIXUACgkQv1NdgR9S
9ot0HxAAgP31HlPYNd5LzE8+LMylDZDD+7XlQWSRMvqSzfnjrBc1VAsN3S4y03SC
cYsso7VkCzKkQ59IifAXwpissxqNbvjw0t3QhHRdWgoJlEwPh0rAMHcxgcyCovbz
4eA+bd6TogFM+6AwQIK0/Lyh8cWPdNuguYogIq5zjORbPoxA1kt/aIN+4hYaTSMq
qgS5kxQalx0rDgR8nry9vUqgbWmjQV5iVmerVZytFE8iCL3Ozl1YFPb5dkE4aEYQ
6cuzBYUXK6gPQqkpFqAY57iUTlZ7SX/i5cT5xEg1wPZpP361OADeAV8V0byhlcpY
md7KJPb98j4vd1bfVaCdXq7jg9V/P0qirs0Q9XYN8XF0NtRNi/Z3fFtIvl1WkCgu
AR2eENYItxkvvp8cvCDStBn2goI5VClg+b+6uKCNCtzjRQfrAmHYwFUcflbLQYsu
V7+wbYZlIgg+1h2S9Ks+UbV9gyRIHpSsd5K2YhozYybfw1C+dgOU1LDkPZewANKh
b6uNAM1MtCEc/kXGA3ZS5Aqzp4pFHAsl0kZJCwbz7B/MtCo9PVHUHaFDmj6/T5LK
3soKJdn36z+q1wQN+Y67uIa2KrdQudLmWT8z88+S2RrZ//mteTVTSu1HtjkfMyW+
cRz9cFW4wDY1ngClJcbzO068/QU5n8OqS1O/s6IT2iMlNrcSWW4=
=IjzW
-----END PGP SIGNATURE-----

--a7XSrSxqzVsaECgU--
