Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09CFE1F404
	for <e@80x24.org>; Fri, 19 Jan 2018 22:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756663AbeASWbj (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 17:31:39 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58128 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756582AbeASWbi (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jan 2018 17:31:38 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6881F6052F;
        Fri, 19 Jan 2018 22:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1516401095;
        bh=+UEfVIp2XD9qIJSm4pAC1lFd+a764znrKLNCm2TXolc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=oq1pdvw/elw2lA8cxqVMnLn0ANwAwMj+15tLxk6B/UpKMvTqImd4NYV91NBj9OSK0
         oC7q9jtcVfihFHdpK7yTtGWIz8EFCxnvr8gLSEd26GSuMdkf5TBdJeKxzk7LQA2S6C
         39B/2cIPbA1PomZQptyohXfJ21OVLUUyFtLXy3si9oZeItsdXcnWcR22odNiDdyy2J
         JaUMmmZ6rBuywsT2ysZo14sW4MODZcX3syZVtdrswPr5XBcwOeVjUl777VkifFTu3z
         irwHKuUHmhR2zJwRD4mCtD9R9WIBjoUho4rwoziEWisV37MtOhX104A3gM9cmzRVw+
         tcuzdYIr0HKW06dNEmZWca2rphhcGhq29aUTv5h73sw1N68SXXTsOtn3USysFlwTPA
         MuIXRN5PtkGMprowdWylFEF9XFNbEZm2u7zF+vgKFbRcu0Dui3A2vTYsyIYZvPNTZu
         k/nY6KgnRNd3vdHFP1dsV0QW1J3fxgjdlXRAG3SGhf8Xcvp3DkA
Date:   Fri, 19 Jan 2018 22:31:30 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCR0YPQu9Cw0LXQsg==?= 
        <aleks.bulaev@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: git 2.16.0 segfaults on clone of specific repo
Message-ID: <20180119223130.GC222163@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCR0YPQu9Cw0LXQsg==?= <aleks.bulaev@gmail.com>,
        Git List <git@vger.kernel.org>
References: <CALwADsGfB10f5+nOFN-pHCt4z1SkWMcvSHn8KokcyCM0V6K-BA@mail.gmail.com>
 <CAPig+cTkBEGyoS93GYCtoDgccTF_UixqBkVTExg7Zf0M1J7KRQ@mail.gmail.com>
 <20180119024738.GA222163@genre.crustytoothpaste.net>
 <CAPig+cSbbzKV0GttLjHCyY3CNcJO0bdP3Mp4pT+3waUTMAQ8kg@mail.gmail.com>
 <20180119034025.GB222163@genre.crustytoothpaste.net>
 <CACsJy8BTFm_0sv=roL1OKKW=1DyU3vqD50NKyHg3KQ7G+mAepQ@mail.gmail.com>
 <20180119074001.GA55929@flurp.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
Content-Disposition: inline
In-Reply-To: <20180119074001.GA55929@flurp.local>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.14.0-3-amd64)
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2018 at 02:40:02AM -0500, Eric Sunshine wrote:
> Nice detective work. This particular manifestation is caught by the
> following test which fails without brian's patch on MacOS (and
> presumably Windows) and succeeds with it. On Linux and BSD, it will of
> course succeed always, so I'm not sure how much practical value it
> has.
>=20
> --- >8 ---
> hex2oct() {
> 	perl -ne 'printf "\\%03o", hex for /../g'
> }
>=20
> test_expect_success 'clone on case-insensitive fs' '
> 	o=3D$(git hash-object -w --stdin </dev/null | hex2oct) &&
> 	t=3D$(printf "100644 X\0${o}100644 x\0${o}" |
> 		   git hash-object -w -t tree --stdin) &&
> 	c=3D$(git commit-tree -m bogus $t) &&
> 	git update-ref refs/heads/bogus $c &&
> 	git clone -b bogus . bogus
> '
> --- >8 ---

I'd argue that it's a worthwhile test to have, since it will fail on
those systems where it's going to be a problem.  Furthermore, people do
run the tests (as does Travis) on case-insensitive file systems during
the development cycle, so if we break something in the future, someone
will notice while we're still in the development cycle.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlpiccEACgkQv1NdgR9S
9ovaVA//arO1zd1PSsf4cY+vY/UDtUiHSpT1E684ks5XEYFKRukeD1O6OYD7/wa5
cgxCEyDHD4wOkfWjp95HaboprfOPfhpl/uyJuXADXE8SWe7SnVBZ1DUu1sy7HM22
5ZoWsu28vbBTDFPLZ9aQEyTbxpsgLmm15euqequaZwJN4odx8N0ufqkQkV3aJifJ
C68ejtSQEvfJBiYR4nuAtt7hvBL/t9AYRWZNvBYvpBlfLFjDj2oVlR4d0ljKWS7w
nRv9mvvUGzwLCQI1a7kNnYUYLc+sWI1ZYjLKQuLMMOw3hFeKZUwUCBzX3dd6uN/1
xa8WGMHfWqsVOY7vBCiMl6d34LyJ9dqHyIhy+fSk2Qskemqt2CAbyPEaDYySBNq8
7BRvZqoSZSmQqwRIGHROJOM4/syc7emIkQRuu49CBxSaS29KavHxf0IWXJm5njPq
LxpRWLuRGtIW65oFkIyrGf3Quxl4mQaP7r/Nm9nPXzXLvlJYZ2MydNFGKcwLo7Tt
Fms0oJ9KfbDFbeN/psbP8aViuhudV4vp/cGLxi1zI4M84J3/u0UXouqoP3GiyvWU
lU8xPfROlmiH5Z6x2lKd5aLtuFZ6o/fRmXzEfRBXeDx+VmpGt+cB1uqnaghm5RpK
uQ61KHl4vO2nu0y29NapP1qW4WZFOpev3KsyNKnlSe8p3DOKiEo=
=E50D
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--
