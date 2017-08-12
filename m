Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEABD208B8
	for <e@80x24.org>; Sat, 12 Aug 2017 14:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750973AbdHLO7d (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Aug 2017 10:59:33 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:51304 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750774AbdHLO7c (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 Aug 2017 10:59:32 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 3D25A280AD;
        Sat, 12 Aug 2017 14:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1502549972;
        bh=RbuBQY0hviJAWBlMz7wbhkTH7tr/UG8qbptr3GI9Qr4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BQwBWrliKYY8GHhUnH8zUq69ikAHeHfXO0CxSe/WM+njN49tkZca8iPV9gGBGAlZn
         VRuTUhdhJHDoKrnOpfJkdIm9xvrojI4LKr43T3Gv05VXF99DZ9RtrlvGEK2sL2nRAm
         c1qXi0NbissySvRtpXH6j/wRXE/JY/XsvGn5zkb4PypLJn2EAdolt21eDcnILOnwSj
         4tCORQDO+8w5tDx63G7OQMTKNwK8kM7nEe6+mbVpxe0wQXzSLAYtkCgJ076aD7XGxb
         X+cLOadz1bzEVlA4yeXstWG6Kono4Vqjhq7rCHWJMYGncmPWKus1q/8lhWWfdOSCi9
         YWd6fjkymIWS1nPaxHZnS+I0ypTAgP73PkiatA6P/5PQuRYKW+9PPFFJzfsKO+2xC5
         G5Ts5LM70SGFaKe4JpUB0PJTccjn7RdLCzKe74efKKdKk5hWjLAwT+0/KuKaU1D/KN
         YD1vOjY0z1VQiexK5djzuyW6LRNOTe7QpFyE5SjHHSTkppiSurq
Date:   Sat, 12 Aug 2017 14:59:28 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] tree-walk: convert fill_tree_descriptor() to object_id
Message-ID: <20170812145928.jadxm3digocyejzg@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>
References: <d1e4b270-4f8b-85e4-b6fd-09657720bed2@web.de>
 <9534aa87-def3-5105-652d-f136c72902c2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nwi7kq6mby3xzdge"
Content-Disposition: inline
In-Reply-To: <9534aa87-def3-5105-652d-f136c72902c2@web.de>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.11.0-2-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--nwi7kq6mby3xzdge
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 12, 2017 at 10:32:59AM +0200, Ren=C3=A9 Scharfe wrote:
> All callers of fill_tree_descriptor() have been converted to object_id
> already, so convert that function as well.  As a nice side-effect we get
> rid of NULL checks in tree-diff.c, as fill_tree_descriptor() already
> does them for us.
>=20
> Helped-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>

This looks good to me.  I had written a very similar patch for a later
series, and they're pretty much identical.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--nwi7kq6mby3xzdge
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.22 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlmPF9AACgkQv1NdgR9S
9ovOnA/6A6CYPFDxCVGo9eQaDSNlS38TxRBwPLMVC8LLvHzqT9DsTTV0b3rzUlB1
ILgBIPjKDRdzJi2F+O0N96KpxqwKDUaVXLhhOsmuQDdOaQtLDASwXt+Trsxlyni9
8L2SFD9KngwD4lkcZTDKQuOgKh04HujthjJxQrBXUSzc+t+EKdFhwjU46RA69lhL
gWf2grzyQ/H0X8zlwgUPpwl8ZlFU4s72kbi/M9OefMgSxS46cGd+S5gMRYo+DxN+
jXsBuK/TgavHFcx7BTSe72XXlHSdzaqAQqnjKNVTM7Qz670FXJKFI4YALzcUQA4f
LQS5cDGFH9qsP/HbntjxERE6m+KqJJP/+Qe8kaAPGWYY8Bw5foyOysXJ/fKHEwY8
dwYecETlPtW6NWssLz/wFUE5cEOWvNNYGHZX0WLXpEPmjzfRiFeLhnGcSjYg0eth
YXusj3Ce3P4wqLocyQFCj4r6t030mmhYfKqfh5TY63iTRR6YwRTe7OFy+5GTn001
6a+shLnYelBjy4KHNl9HE/uyaOw4gYTaJQVab8ImvJ5LBQs577HMVsaSsZdzzUpv
JpG5t4LGvWGBx25eZa5BVK6XRABTi3qqOOMqnaM1ZZJpDOlieKrmrDvCNiwspeJY
Pd9SnNoMV1naF5HLFV3cdBLgr8CzrgswGLEkd7OcYDlgzjwoqnI=
=ghXu
-----END PGP SIGNATURE-----

--nwi7kq6mby3xzdge--
