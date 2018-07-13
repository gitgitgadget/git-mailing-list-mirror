Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0D321F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 23:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbeGMXWi (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 19:22:38 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57512 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727506AbeGMXWi (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Jul 2018 19:22:38 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EF36660102;
        Fri, 13 Jul 2018 23:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531523154;
        bh=OFRD5X7TJW2vlBsAEGQuQiQUz+qxGAykOQDqV2V8vQE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=LENuWVX/0fU589A8kZiIZPiCO9hNcQkQxG5NQIm0TiVDuRtnN7edRqoXU3WKMJwuw
         SS1dMIgW6cnWHcNR84vIfMVGOlkHuazJCOeFpHK5gUqS7s/Ex8Zq0t1l/usgJf7J1o
         fJyh2jUoQvrBZDC4d4wIZsMJI2WbxViez0IIX5BR7crYoqfw4QjVvDB3TlSPTUFc2C
         UzUlv5z1AE2ZntftmYRLp9L2fT9X2ESCFWu1GpNNLO2JMUt8rHAq+fbfvMj5kCfNcV
         hfNcgJYX2YiBRwSiXwKWyrPfr4pbkexZFfJYzqNSMJOwLXVeW6dJclQ/oZ/nHjO40U
         Ozl+hOIFgH1qpLhoNQYQKr/fEl8e9rxLe+riugunvw0eNBNhy1079CEuo7i/VsbDSm
         +yRF0DwkaviqwpF5MUgGZd+5dpeOKcH5EUQuH3CUaFpAxVKWNSPt9+fzBjKLbAoks+
         x8cSed+hziVO6b/O20Ptnk4jScSL1EoGf7cgu48n54eLO8SsGjt
Date:   Fri, 13 Jul 2018 23:05:49 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Vitali Lovich <vlovich@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: rev-parse --show-toplevel broken during exec'ed rebase?
Message-ID: <20180713230548.GC1042117@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Vitali Lovich <vlovich@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jacob Keller <jacob.keller@gmail.com>
References: <CAF8PYMjub1KK_ZK0hijTNBACSa6SaFyu1dJgrXd5fJU5Hc_dhg@mail.gmail.com>
 <xmqq7em01ns9.fsf@gitster-ct.c.googlers.com>
 <20180713184732.GC968742@genre.crustytoothpaste.net>
 <20180713201949.GA17670@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4ZLFUWh1odzi/v6L"
Content-Disposition: inline
In-Reply-To: <20180713201949.GA17670@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 13, 2018 at 04:19:49PM -0400, Jeff King wrote:
> Just reading over this thread, I suspect the simplest fix is to pass
> GIT_DIR and GIT_WORK_TREE together, which is almost always the right
> thing to do.

I agree.  I'll write up a patch.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltJMEwACgkQv1NdgR9S
9ot2Zg/+IwGS33qOq2JfwgxHedYA80O9sgJ6joTAaT33s1Cr0UyOaineRowhsOoj
WgvjiXr6Vjj4N6f7HG5igZZgiSzD03VyerypMvRWMvf0wnbkCEWu2IPZUKz0jDTs
nuH58RBhql6GN96CMhkK7yIS6L/6+glUhy93U6GuAc8URD8pmwQwtgk7ZXWKAnsY
saskALf8SMfFtGvw2bc0fQvsApEgthlsLYWjLMRZOjfeQsuVaHY/SgWNHIXU6ei5
MRivbezU63SSclEsC6eimR67wV/uymraBtxILPod8FhzZZSgFjjXTpCq1QEXNrIn
XZZVA0FdNv4RwoXMkvEKo8zUjb9DiQHEGcDunxQkf/TBdJYavZ2PJPuCls04msHu
yoHIRVybeEZ4V81ReCv3Bq82SGmTd4pyFaMGf5Rv8BkymgdAGFTPTXgokdAEGO01
CpvttEd3KlVlvCnwfbIf9JmCeICLwfOYLXzdLn+V0YZsOolvQCeHgQ/4ODkz3acM
qdlvoHqKFdQcv5eLM4Cdhi9mA5DdCC4OyVieLl1uifTRG6STK01xa6RXB5buAr4X
SRQCr7Ma2S9+X+KSDYhKcofX3Y0WLEHpjsj7+9KwmY+0khFXhqIERDCbgovedySD
AAS23E4Bra9T+KC4ziwWyVWzP2PmAX24Z65zGQY4f2ya5CEyyA8=
=Lson
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--
