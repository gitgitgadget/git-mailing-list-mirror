Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1ED8200B9
	for <e@80x24.org>; Tue,  8 May 2018 01:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753697AbeEHBvh (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 21:51:37 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42066 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751828AbeEHBvg (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 7 May 2018 21:51:36 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4EC0860444;
        Tue,  8 May 2018 01:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525744295;
        bh=IES4NUGHbuoSivZlVtfmRUEbkmBUTBRixXrr2PHbwMQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=QqjJnoZMvsst/jonQM++S9k8KVG9ckZwx7Ga7LxQ7yHUcjVg1wVEsu4TxlX354bKP
         0nebT3YD55TVip2z1ZZtv9YULb8rEzypwnauom5jsj238/LBZTdW9miNpvF7DdnS5P
         9cQEJ6x6DJoIknwJk+ukNMIHRtSA/PsFgNpBGlBJCPOsuamv0yGs1Dncn5C9epCnwA
         DnqXRueka6/ajuaFwbqTk27ki/cDLcHZaDc2wif5qSS8bwQbYO0dN6SHdQ/FUapN0A
         KKRHUuBnvn90hP1f7H4klkBPBHmjJc7mlLDMLp0109r0qMD/NFcLRv6NJfc3t+dsq0
         ErLCWYE/uu41MNaqHfLgD6wKEQDYhqjs1w0UwxI2VLS7uI9fp7gcZywzeYPliZPHNx
         7TlX6sF7HJGB0YyWMF9MHmEulw/g1cqLZwhX6yvx894iVyfC0SxohlkjwL0Wr+O4JN
         P1IoW0spu9T6IUiLPLaq/m6s4Pih30v5fXs4P7CFvAEBofWLXae
Date:   Tue, 8 May 2018 01:51:30 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>
Subject: Re: main url for linking to git source?
Message-ID: <20180508015130.GN953644@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        git <git@vger.kernel.org>
References: <20180507063713.GA28961@sigill.intra.peff.net>
 <CAGZ79kZVdiEOO+b_Ygrfw1D9uV1T5TYBS580zPaZeYoMRfNuUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ABYnUdqoGSokwVM+"
Content-Disposition: inline
In-Reply-To: <CAGZ79kZVdiEOO+b_Ygrfw1D9uV1T5TYBS580zPaZeYoMRfNuUQ@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ABYnUdqoGSokwVM+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 07, 2018 at 11:15:46AM -0700, Stefan Beller wrote:
> There I would try to mirror Junios list of "public repositories"
> https://git-blame.blogspot.com/p/git-public-repositories.html
> without officially endorsing one over another.

I think I would also prefer a list of available repositories over a
hard-coded choice.  It may be that some places (say, Australia) have
better bandwidth to one over the other, and users will be able to have a
better experience with certain mirrors.

While I'm sympathetic to the idea of referring to kernel.org because
it's open-source and non-profit, users outside of North America are
likely to have a less stellar experience with its mirrors, since they're
all in North America.

I would suggest that whatever option we choose, we only specify HTTPS or
SSH (i.e., encrypted) protocols.  Encryption is cheap, and we have lots
of options meeting that criterion.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--ABYnUdqoGSokwVM+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrxAqIACgkQv1NdgR9S
9otb0Q//aQPg03Pi5r/XyHZmg/e5tISCyh4yOJTFNwYL/ftOierRGLnoBiMCJbA5
t8QimVJZW1YElIum+Z3yhwUlDolKGE2VI2qEg6r8O/mHky/8nGRkXjkHQFl/J+Oe
imBceDH138jALdj2NGOya5TiqocII/IhVPhx99xyyMYD2k8H8S+HxCw7eQiyIWOq
u3Mbm/VRqmnTwvdHRBu1lIU3qh2A3vf2ZzVcE0xDlebdaQZICCVwATmofIqWpkTP
iKX+X+wu6qLysV1mEbSQzY/BxKDNXR9DRrC8zAPrF4IpEnRi8SSSDn++cfDd0uGz
S3/pXY+u7TK2c2wd32vx9gpXvSpzL023FDgjL7FsxqcIBmpQ1ZwnDypOlInvtEAG
WKCSRsQu0X4aPvGC4q+TAA/3wXSUVSwvtcBacoOF/eHILvsCGzNM5j45OirSXedD
NEQV7NqAstP1lehv6Qdtdr0dnQEc2HY7/yWZTfQgxIwtvISab3bjGivkmF5F5IGf
ba9+UBZm088f4TR5oqTeklvXX5JMWrKPQhccxsFABYTwr+6tdyTk70p+wS44QUuy
9PPU0OkeTQFQTSNyfSkWK3nnQKzXbcsWEdmTh3jMyAlEPGQxN51EbJcuCEwMKGPa
BDMJcjTQF0Fs6AdNhbfRb/yipdwhQP1QaYPNGcq1BoxvYpVsp+Q=
=qXtX
-----END PGP SIGNATURE-----

--ABYnUdqoGSokwVM+--
