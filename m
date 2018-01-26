Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF4F81F404
	for <e@80x24.org>; Fri, 26 Jan 2018 23:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752452AbeAZXOQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 18:14:16 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58310 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752205AbeAZXOP (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 26 Jan 2018 18:14:15 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0A44160402;
        Fri, 26 Jan 2018 23:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517008451;
        bh=3z3s/STvnb7pW8u139itw1JG/ZtbJl08vAiIQSKwook=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=NXmrIJpQE0LoZnZIiIDcl113KV42OdfDFxUEZqSGKlY6WO/SuVfpHvu7cy+CExNkA
         gKNNa3gxVljDm6sg7SqaJuqVDy/iJXk8R8MznOFdtp03X78kaPb3rQ9LelZBDAhmMi
         F1tTlrivG9U1Nfl69QaHt/fKbzkjqTpTybQ5fTfgPntmPMyeNCV+qwifzNlYTtUW9M
         3zWvN0LIYA9qiqS1UE0c6HpcrYuLYotBDbj79HRwomXBuuP8HysE2DWNYFg7oqOVMf
         KMEXQ1lPQRchjTRuTcTAOgAGxuy01MiQ2PjopXXnlSl8J7msS5ssQ/pfzrzu+dOHmM
         tIDzAPqvo25SfiCGwRx+YuQFPJW8GvNJyUQy7EI5fOuxpL0mWWxLs8fNPwSWIXm41f
         fVb0lhey0RREX7WKCmUnwciEwCGz5IpWZVELm0Fkah4gBLcR5ieNUBSTPtV+Jxdc6D
         Mf7TkE61sQZwhNFo3W8hGJHKASimhZ+EYycErehRs1EOlSyM3OP
Date:   Fri, 26 Jan 2018 23:14:05 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 13/14] sha1_file: convert write_loose_object to
 object_id
Message-ID: <20180126231405.GC431130@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Patryk Obara <patryk.obara@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <cover.1516790478.git.patryk.obara@gmail.com>
 <6e4c38ccef5fd1cc5fd57b6894e0d9fb4d0f012e.1516790478.git.patryk.obara@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Content-Disposition: inline
In-Reply-To: <6e4c38ccef5fd1cc5fd57b6894e0d9fb4d0f012e.1516790478.git.patryk.obara@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-rc8-amd64)
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2018 at 12:12:05PM +0100, Patryk Obara wrote:
> Convert the definition and declaration of statis write_loose_object

s/statis/static/
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlprtj0ACgkQv1NdgR9S
9ovn0A//QrVCPW9bJvQ0eOEJch/6d1qGaNBJlICpcYhTlpBdys4dKrUIRZYrr6lE
dAJD6XUgdo0rt5By+KbDRp0QgTfhnsVfwQDYoKFWw52psb7Mie0cbrNZ4chTljLA
NOZPea0tHAiX/CRSgvZ9e2EbeiJRMKfW0HYVrMalit34sivdRv5ktMNplu92MxsD
98D1O8BAW4ey0rNWstIbMe9nXu8ihnPrkB0jX++SW0K1d0B/6ptNqYMVFFlcB9R5
G0H19hr1KIQ9GCKP+IqIWe0YONj9/hV97oMsheqJr0Y0ftsnKxnXF+f3RlOc7mRi
YRTHd28x5yzf7V8ydgGxMoPwLmgV/SQoo7iIXDed1o+lR1RgvXX4wkSqf6xSBM1X
ZxMtnVcm7g6gHoCeldM1mDnGNyjhDdKOQ/41ryyEZjVc8l4koiGFkQmJKlkDlc4I
OVmg0ff5gUyC73GH5Irp0a9SpyQbpCDdU43630FTpBK4IHvfpMWfsprjiI6LMhuT
8bPINpQ+SD6OPAmUAAi+L3mscKqKDkxAQ33vu//4DBd0I9OwWzj/TzaDlnQJfGk0
SB2VdYXQ/7oijjy/V2WzrldZEvr3LfnbEvDCju+6yiUCEhoSOpsYJ19wOX64Sszp
jpHA0S0rUGZnfIflkstuxamM4Fi9TNxg8hHoEX07c89LfoFmRaU=
=ZM8M
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--
