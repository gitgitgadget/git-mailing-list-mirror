Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6B6C1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 22:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964862AbeFNWUH (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 18:20:07 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39434 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S936073AbeFNWUG (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 14 Jun 2018 18:20:06 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b0c3:20dd:704c:b59d])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 678A46046C;
        Thu, 14 Jun 2018 22:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1529014805;
        bh=3Tov7de6F1vkBzFKMntsEGXygFld5+shDjqkmDpsPwA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=eS3ltfWRX5FWRBu0dYAIu+Ip2Sm3vEQTWUjeu+6j3RQhmKoY3wNcmZxXWajGhx/Hc
         3yZinlaw750Odln3tHTZtin5wEJx7lSrYFzj+TJ/b9syANBMny/VSVhDI7fIpu7XcL
         ohLFHXzNsv9rVJQAesjy+rSsdCTaTg6kbnaB+gbTujUtQmB6CSt1t5IAuB85LcUvdd
         +q5jtNWFlqIG+0/e0QkoyCF4uU63WqOZ/+PlDfaB7gEuFRbLcb4oIgSUFJnVqTOOvt
         n1jlNudb5otdrgUJ0iqPiAKzF1QyDBEZZUYm8xk1C9nnBvcj6v18z4+ZSJXAvH1ixs
         GQsWrBN6f0oxgIRgj27Ok5BdTbp4x9Je1ygp9PbhoLuEaTAGzbwTeRkiokwRsp3TSF
         ui1Wh4DC3FdBHhbHlaMR7/zoKfqAoXm5tZG+xkMLsNdqElbq9Pq2YbVFiB9xUtPIWN
         p9qCc/z+LpAREgBHukBGeDWR/Pjme/6hp4IyTM7Rb16xOxM9hGs
Date:   Thu, 14 Jun 2018 22:20:00 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Christian Halstrick <christian.halstrick@gmail.com>,
        Git <git@vger.kernel.org>
Subject: Re: OAuth2 support in git?
Message-ID: <20180614222000.GA622873@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Christian Halstrick <christian.halstrick@gmail.com>,
        Git <git@vger.kernel.org>
References: <CAENte7iUYcLX1ym1rdiYT2L8yLSWforf8kUvfHKLvhi_GhKQvg@mail.gmail.com>
 <20180614101342.GO38834@genre.crustytoothpaste.net>
 <20180614151507.GA6933@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <20180614151507.GA6933@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-2-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2018 at 11:15:07AM -0400, Jeff King wrote:
> On Thu, Jun 14, 2018 at 10:13:42AM +0000, brian m. carlson wrote:
> > There isn't any support for Bearer authentication in Git.  For HTTP, we
> > use libcurl, which doesn't provide this natively.  While it could in
> > theory be added, it would require some reworking of the auth code.
> >=20
> > You are, of course, welcome to send a patch.
>=20
> If it's just a custom Authorization header, we should be able to support
> it with existing curl versions without _too_ much effort.

It shouldn't be too difficult, but we have some fallback among various
authentication types that would need reworking.

> I think there are probably two possible directions:
>=20
>  1. add a special "bearer" command line option, etc, as a string
>=20
>  2. add a boolean option to send the existing "password" field as a
>     "bearer" header
>=20
> I suspect (2) would fit in with the existing code better, as the special
> case would mostly be limited to the manner in which we feed the
> credential to curl. And you could probably just set a config option for
> "this url's auth will be oauth2", and use the existing mechanisms for
> providing the password.

I agree option (2) would be better.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlsi6hAACgkQv1NdgR9S
9osGVA/7BmpFRT2oHLCsFPaXaXlZzOB49x7d0gnttBmw/M6jRqZg6y6WuHvq40oM
ikx0pCx7oz24zclpfXEFOH/2/CNg9YWPUQnbrHGHbHTXTowSAjZd5ureC1Sfy/ME
MxpAjlOs2Wv26In+P1EL2jmx7PJ9vVO5UeJx7ppZAXUXCPDX2+qVkyyDR5a5Qq6X
OBjl9KCdjRn9w8ouRLNl8mRNCJpCOzeHsBryqqls/bLq775vr6MDEIyl9Oyu7tym
qE7gGYbH2ghqbnlWHBqLFJHJijAHrhOwgnu0UDv3Z4PxoXq4vt1N+X1C5IgeHArT
1K6gqMkKytqPiOKsqg8bI+vptf3wUJy0cglc7cx/RS58nsRZpq/9nFoROHYDe0zT
p6Y18LguKc1kuN4jhYHtS56+bGvP5s10p8x86gsjX57j8NUpUMRvOpbllZcEM/BT
RVTyGO7+UgaSL9T90E4EocPgQfDhS/k2FW3u6UkOj3bL88YBZtPAyld4j0y75bJF
1pR0Hnk942Cre+Z1IAqygC01YULk2y5t2N9K+MYQmM6AAVMxCc2QM06BqYz56vG8
1VdMgoMtJNvbnoPZp5HTkd+2aLnkQ50eqtkdVia5VkdV5l2QgCc7pKYxRTm/LdVh
lJlH0VQsZWcJwDFEISlQmjRrB7JwWowtT7yfchjngt0vRudFdIk=
=zlhv
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
