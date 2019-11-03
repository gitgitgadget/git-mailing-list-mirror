Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC7FA1F454
	for <e@80x24.org>; Sun,  3 Nov 2019 19:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfKCTX6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Nov 2019 14:23:58 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59896 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727913AbfKCTX6 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 3 Nov 2019 14:23:58 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 747DC60458;
        Sun,  3 Nov 2019 19:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1572809036;
        bh=9hYHM4Q+LuhX77gE4KYosqgVQW6B8OJgP5he2OwvHGY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=CREM+qkCxHsn8vqeUsw0xhDxXYAi0obHiXNUfnf8pVXTeSyuTxG2fPlM46bKBqmST
         EgDGAfB1As3EX7eVfuGrNY+HtjnBria8AlRx7HBbQyf/G7YMzPFDi/IFHX8M9mY9jQ
         jdAwh+bCt54jt8ukYFuqW3acjoyt9CRsBHb8H3zTu6WBZpbQ2K+jeMWPQojkS3N0Qw
         5NuydlVpU9TO6kSbEAXGuZtAd4D57Hy553FM2GhiZsPSbGEbvr/aNH0sgD2Dsct9TJ
         Mk0ebbnbsmHu1j2czMCEk1e6BCEqW818Amnu5c2HvMRK10OVsuUbKhQvg+JrgnTAIK
         y3SpFrqCX7qbG0cAM/MoiRbK939QIQh3sJe9mHrvidBpDqPCAusts8iSOwRTSQaKPk
         4q9aRivBR6uzke54dZtZlaIBiDRP6pz3pehZSnocFYUWtTLXVcxhIQLLOKnfyaQia4
         enlPrVYUxdlrb7Qul51HqV9LvD2aIr+RFD83KDJ/VzGtjwHXn0g
Date:   Sun, 3 Nov 2019 19:23:52 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/4] doc: provide guidance on user.name format
Message-ID: <20191103192352.GB32531@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <20191102192615.10013-1-sandals@crustytoothpaste.net>
 <20191102192615.10013-3-sandals@crustytoothpaste.net>
 <86pni9hzl6.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Content-Disposition: inline
In-Reply-To: <86pni9hzl6.fsf@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-1-amd64)
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-11-03 at 13:13:57, Jakub Narebski wrote:
> This reminds me of "Personal names around the world" by W3C
> https://www.w3.org/International/questions/qa-personal-names

I hadn't read that document before, but it's definitely the approach I
was going for.  People all over the world use Git, and we should make it
as usable for all of those people as we can.

> Minor nit: should this be one paragraph or two - the linebreak after "of
> a personal name." looks a bit strange?
>=20
> No need for a change: just idly wondering.

Good question.  I had explained this in my original patch but had to
reformat the patch and forgot to include this.

The existing text uses a line break after each sentence, and in AsciiDoc
that doesn't introduce a new paragraph; only a blank line does that.  I
opted to keep this consistent with the rest of the description of this
item.

> Just ensuring that I understand it correctly: by "constraints" you mean
> stripping of "<", ">" and "\n" (and by implication "\0")?

Yes, that's correct.

> Should we say anything about encoding?

I don't think it's necessary; since we told people that arbitrary
Unicode is permitted, hopefully they will determine that they should use
UTF-8, or, for Windows environment variables, UTF-16.  Unfortunately,
there's not a good way to get UTF-8 environment variables in Windows, so
"Unicode" is the best we can do there.

I'm happy to gloss over the fact that they can use something else
because (a) while they can, they should not and (b) if they do, they'll
know that they're obviously restricted to that subset of Unicode.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl2/KUgACgkQv1NdgR9S
9ouH7hAAi1o/DKVFxgEn7P85YLW69ZUPFAbQXcwQzLACApPd/ix3Dw4GLUqiWi6Y
kyVRxvsVSWtKdnghCUifhn+0ON1kQcHTuUPBuGrI9sTVgqy1F7WPohmN9sFU0/xL
tqkdtuEcBSq8dJmaUwvNwSiMjXTUJQhTgU9ej703llN7sRiBKjEQ5YDILZIpjwO9
AsOySqPYuTkdnEhn0zUVhbpYDeZTiB9V/8b9eB38FJhzkrCwPVB+ulZe9kUk/miu
XD92tVnRDHE0ZbwZbtytnDv1FX84iLBdS8Ilg3fxlAM9ejzR/RpuxD7HHjVaq9lT
hiQJ4QfD4IoB83m1wke0JheTsDHtmRpm366VkqtBwyF7XCyCqnawdX9Xrgedfd+X
BNyQbYyiaM/NJJBzuGwihuC+DuLMZ2/Pb4pa0UTp/eJxPOlp2V++wrEcMmsA/DFN
hgoAZaDX/6Xhd2ih5rh1EgHL7+L4dArUgqqCovkksodjtSXqIeetsdzVSJZrbXuT
u2Lw/Af+V66Nl0fW5yiJFhlvT6AtAaZ/FruvTnXWuLfdFuPrqBXQEhQIh7BK0SvD
C/cWDHLJpmar9PHKeUpeDEtp8PED7NqnXTuYBsXGHApbKB3CnjSl9iKhJSqmipd8
Z92UorDw/tWrjVoigqXsB3gXx6rrkStqPQsUpGDspYKSvzRJfPM=
=miMJ
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--
