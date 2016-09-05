Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC9541FBB0
	for <e@80x24.org>; Mon,  5 Sep 2016 19:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754788AbcIETlZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 15:41:25 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:42922 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754360AbcIETlY (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Sep 2016 15:41:24 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id D01BB280A6;
        Mon,  5 Sep 2016 19:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1473104481;
        bh=WIbcUlFgssBCciHCaURY2pcSjbS6dzY0QIWlAWrKmDI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CX3o3+u0MI2TUkqZ4hYOHJpvetQm9NEGSDE1P/y6OcuZYvc4zxXIymSx7SMyJS+hy
         Njpj3/i+Nackwbn84G5BgNlplMewG+9pn71aEJUkKctv3cw5zhKmbd2XLzJxrCZKOQ
         bZ32gAIGwJUmlygLoasPy54IYu5K1bptbSZGpAV/hIzZ0W2G05JRBIw5l9+9T8C6wj
         l4GrIbvrQ2yxY//Tud4wdHk0NUcoGCqPGagxQ8+Aj/IcvZYVrDCBNNveL0x1cx1dIG
         zIJGNKwtg9idswaXrxb1ekCZd+MYK/Yk/3M8lRiVhsjekEcbo3nOKQpSMKqRzMIdvH
         S4zArFQsECnxNwp3/jCEWt/gfWaybB+AjrEOkRNOEs26bA8oysHaNT9Oh8tpuouv7P
         qET9I34hjiRZNgdIyHHhW9frhgPVOmCLMKWj+msARiMADJ7j9+oaqDIdhB8v8qux6m
         v2MDVAHmf9QVzBU90AJUAyKZCYUzC3Kc7v6TC2hwxqtvY/wBcZi
Date:   Mon, 5 Sep 2016 19:41:15 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     iblis <iblis@hs.ntnu.edu.tw>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Avoid hard-coded perl path in sha-bang
Message-ID: <20160905194115.wn7uo2fnzolms6uy@vauxhall.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        iblis <iblis@hs.ntnu.edu.tw>, git@vger.kernel.org
References: <01020156faf163db-3a2e9796-3b12-43d2-90dd-2b843896a5b7-000000@eu-west-1.amazonses.com>
 <ddf84da5-036f-6e4f-839d-cef1f7ede4be@hs.ntnu.edu.tw>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hpky7qxsvtxw6n7s"
Content-Disposition: inline
In-Reply-To: <ddf84da5-036f-6e4f-839d-cef1f7ede4be@hs.ntnu.edu.tw>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.7.0-1-amd64)
User-Agent: NeoMutt/ (1.7.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hpky7qxsvtxw6n7s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 05, 2016 at 11:28:18PM +0800, iblis wrote:
> Signed-off-by: Iblis Lin <iblis@hs.ntnu.edu.tw>
>=20
> ---
>  contrib/diff-highlight/diff-highlight | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlig=
ht/diff-highlight
> index ffefc31..b57b0fd 100755
> --- a/contrib/diff-highlight/diff-highlight
> +++ b/contrib/diff-highlight/diff-highlight
> @@ -1,4 +1,4 @@
> -#!/usr/bin/perl
> +#!/usr/bin/env perl
>  use 5.008;
>  use warnings FATAL =3D> 'all';

This isn't consistent with what the other contrib scripts do, and
/usr/bin/env perl isn't always the right perl for all situations.  What
you probably want is to do something like this, which is listed in the
Makefile.

# Individual rules to allow e.g.
# "make -C ../.. SCRIPT_PERL=3Dcontrib/foo/bar.perl build-perl-script"
# from subdirectories like contrib/*/
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--hpky7qxsvtxw6n7s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.15 (GNU/Linux)

iQIcBAEBCgAGBQJXzcpbAAoJEL9TXYEfUvaLN5UP/i8WyJuLnO0OzL5VGIo2hV9C
ehNWZkRV15kULZrQfkU6FPnhuEGoep4/8z9VQhPlPoQNbQrSe4VCLrWl/DYiRdtO
9vmGHbov8RHZYvZDRg9uL4lNZ9x2klv9qT0VtSf5uXrgi7Vd6RXltEaUMoOh1gjd
0zF3Boled8ag+5h6Q+3YJmQQ7Bp9vgPaeMhd5DT0HGkQ271U2SOJvEKQIcjwfdT3
5vWP7W84tPd2+yJ63i9H8Qc1IjiXNmXwb4HqbwC6cDrsSufjyMId7XLM+wH1kBNF
IOHDNF6zL+KryL+Z4mOwlL0VxoqpKAQZD/la8FPX//D3TjC4bT8WMbdYcVGHWTcw
ybRm5JBkHrnBpO3S91HA/jlnpQ0yzxOohWlC14zy3Wl0gw4+E+bXm00r/eMA6bR4
e4qw3SBM/nzMjDktY/3KmuQRXw7y/eHZXJcMIJ3JnOJGmYdtL2hcEi3ZBzd1TJhO
nFqvBkb+DJZIkG6qxYq/ZczOQEWU3Qmnk1/JotPQOMrcQ59GsTppJHayeoGNoZEb
+Ce0OMci/yTzohe8E51Am6UFQfOMiIQ3tBLVQDEQSjk5TcQBENtBPak+Qg9Imr5/
y4nDgimDQ8xIWfonb83evrql7brvL+JTIksEOqb9KDZt/UMcMS6im/fPq8c8nY97
ADQet4Y4c40hp5hbEikd
=sZ/w
-----END PGP SIGNATURE-----

--hpky7qxsvtxw6n7s--
