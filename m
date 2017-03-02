Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 819FD2013E
	for <e@80x24.org>; Fri,  3 Mar 2017 00:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751862AbdCCAdL (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 19:33:11 -0500
Received: from kitenet.net ([66.228.36.95]:36572 "EHLO kitenet.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751123AbdCCAdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 19:33:09 -0500
X-Question: 42
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1488491704; bh=qqLORf0Z/Q05yv4c2ydJkwPhKF8oa6EMus+ObW600pQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jqdnuqbXsQKwY9P6RBI0AJ6YAaObr6W9Jl1bddW6BJgVFuTDO4SEGz5THiDnGiRct
         2FC4ECfrpqarMwu+y/kCRNmk+WdyC1c6aqrYMZuOp2vEv95VRB3iz6NKLntTkm+1bW
         DxrUm8YFExIYyhRs1cR6CrtQBZROIw3W6GSgSt3E=
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1488491697; bh=qqLORf0Z/Q05yv4c2ydJkwPhKF8oa6EMus+ObW600pQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hFV50aFqI4EpRRGvD+8p0Gnvb90AATaglUYEkMlsvTnb5lYlsstjT3CuROmCfONtb
         TWQc0R2BoBsAz5+ukeRP86aDCRWuTb6SN5xxidLdhU16B8Mr0Nk4JNrxu1qwcbhvr3
         85ufA+oWf6h74MDk4xlVzZuHTptEPtjp6MEXcTBo=
Date:   Thu, 2 Mar 2017 17:54:57 -0400
From:   Joey Hess <id@joeyh.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
Message-ID: <20170302215457.l2zhxgnvhulw2hl5@kitenet.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <22704.19873.860148.22472@chiark.greenend.org.uk>
 <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com>
 <20170224233929.p2yckbc6ksyox5nu@sigill.intra.peff.net>
 <CA+55aFw6BLjPK-F0RGd9LT7X5xosKOXOxuhmKX65ZHn09r1xow@mail.gmail.com>
 <CA+55aFwXaSAMF41Dz3u3nS+2S24umdUFv0+k+s18UyPoj+v31g@mail.gmail.com>
 <xmqqk287be9l.fsf@gitster.mtv.corp.google.com>
 <CA+55aFziZRA29foAMbM-HS5fiup7T0TuYf4XQ1kNT_SR7FfSgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4y6ifvsrq6fm7s4o"
Content-Disposition: inline
In-Reply-To: <CA+55aFziZRA29foAMbM-HS5fiup7T0TuYf4XQ1kNT_SR7FfSgw@mail.gmail.com>
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4y6ifvsrq6fm7s4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus Torvalds wrote:
> So you'd have to be able to attack both the full SHA1, _and_ whatever
> other different good hash to 128 bits.

There's a surprising result of combining iterated hash functions, that
the combination is no more difficult to attack than the strongest hash
function used.

https://www.iacr.org/cryptodb/archive/2004/CRYPTO/1472/1472.pdf

Perhaps you already knew about this, but I had only heard rumors
that was the case, until I found that reference recently.

--=20
see shy jo

--4y6ifvsrq6fm7s4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE6FpfY7MdJMHr8NgcyRDZIiUS48cFAli4lLEACgkQyRDZIiUS
48cU/A//YvaXFIAumeXWKOWDaCgWBLIsGfVj2IitLbR6dO2Lpq/CnqkTVZBaLdQR
KJZF6NldPeCVqK68e5cmpqANbd4mz5fh1X/oU2QPl5w1jK7Rqb/szswAqXhguZ0z
pBhYuDc5e8AQCJmBeB0Fu2GBkXSQyihFN005klyeoPSDSV87PKkaTKs55jvSkuWr
fAfavI3kbu3Vz7DrxJuR1+QlJngBQ6fSiduFWY8Srt1UpzgHNGuHNzXjDj6zQGC0
rN1hn9crYcYdrmeBKlk1Ec0hej7z6h7QOIlqNX5JO+aZPor1HktDqUf036E7hZlq
BVr4IuqaLAeAHelEekR1O19tSfOr0DRUAau0jRf/2CvkTi5xHmJEX4Ufosj9ShZ6
RZB9Wnu2hVZ+W3/EQFVwwKVfs7BmLHfmAefbQK3JIFeYyBx6F2Ei6DpHXUcQM84/
32QkIM9eGptJbYxKFaUYyVvibeMBA3WjF/wueutocNAMIPpMX1ell1i9OOj0M/PJ
7I3sX3rPDnHQO4wHripHBGkMn8INAAGuM3LveZv3Ojv/9hmTlTpm9DfwTj+HET6N
kDAzI/nhaEkDwY/r4r2p56TdJd73Sdn8vO+Pn826LkdZ1jymEO7OzdtiiiM5iIJr
9DJ/oAenqjFkP5lRSoIweBX0YTlAOynO9o2U2eGllUIFv9ssAoc=
=EdNx
-----END PGP SIGNATURE-----

--4y6ifvsrq6fm7s4o--
