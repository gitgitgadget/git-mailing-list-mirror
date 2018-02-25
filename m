Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECCC91F404
	for <e@80x24.org>; Sun, 25 Feb 2018 20:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeBYU22 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 15:28:28 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33802 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751826AbeBYU21 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Feb 2018 15:28:27 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2F4D76042F;
        Sun, 25 Feb 2018 20:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519590504;
        bh=nsOlA8nV2RHkyjusiZnMOKCRaSzKb/wA8EppU+husNo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=rF7Js1SYPMRD7T/iPPPv/qC+9kj3B4ZN53PfJqCNDGF6ycWEucFV1ntM04Z2fLR30
         yHgufJdxMP75UGxwhz4YQIaHpL7LJ0rVLF9cqrj87PecxaC+rYgUyv7//lXJ+s+M92
         BfwgslCm7Klp7+ik3vDscIBLOoeVc2Ouxw+sbk7mh0IEy1nWtJCZAs4A6x4InXXU3Y
         Q4IL4BZgB6c1o9OEQdttKW5/yaNX1+INZHK4V3NOtwTqlUxyugZG2LPeyZgtP20KkJ
         7+D6ld+Rddbk6GgWNq8ZaLPKbYzwqjjfwrcAU7DjkJq3GkvCEwwfcNhNLvmXdexMdq
         jSNsw3lIN350RvbZu8nNlVPNbYdOa3YBC9NSdBxAvRgkBltlBfpR33+W41ALhaEpjh
         T7Dtbykjlr76E7M/iUw39xhfnrRUnGeY4XN0N2rGBON0dlAOY5ttJlspfZeZHAZDp2
         A7BKT+BXKNBZyO2yN0/xPGS27TY5qqPtvsHdxt1WLGl3vcP6xHQ
Date:   Sun, 25 Feb 2018 20:28:16 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 5/5] Revert "repository: pre-initialize hash algo
 pointer"
Message-ID: <20180225202816.GE4620@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20180223095640.25876-1-pclouds@gmail.com>
 <20180224033429.9656-1-pclouds@gmail.com>
 <20180224033429.9656-6-pclouds@gmail.com>
 <20180224225839.GD4620@genre.crustytoothpaste.net>
 <CACsJy8BP0ro6raD-s4uYOqMg1BhSEtNdn-HCpHYDz_NHXgkRbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="idY8LE8SD6/8DnRI"
Content-Disposition: inline
In-Reply-To: <CACsJy8BP0ro6raD-s4uYOqMg1BhSEtNdn-HCpHYDz_NHXgkRbA@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-1-amd64)
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--idY8LE8SD6/8DnRI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2018 at 10:29:29AM +0700, Duy Nguyen wrote:
> When I set unknown hash algo here, I think some test failed
> mysteriously because it used rawsz field (which has value zero), it
> didn't match some expectation, the code went to the error handling
> path, which eventually failed with some error message, but it's not
> obvious that the problem was rawsz being zero and back tracking that
> took me some time.
>=20
> With NULL hash_algo, any dereferencing fails immediately with a nice
> stack trace. Another reason to push me towards NULL hash algo is, even
> if we prefer nice messages over segmentation faults, we can't avoid it
> completely anyway (empty_tree and empty_blob are still NULL in unknown
> hash algo and will cause segfaults). Might as well make things
> consistent and always segfault.

That makes sense.  Thanks for the explanation.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--idY8LE8SD6/8DnRI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlqTHGAACgkQv1NdgR9S
9ovEFA/9FmjHVJw+PUV/FL+7L5Fe8BfrES0iZmDyOdChXiKaQjNloSbxmiiEbWjD
pqg+1gs1b1/OZluAU5qaLDK+22njNKkAJnlDBr2Zd/eFAqqdTu9sgk4esu5aER2a
3O9XjadKxzj+yGZEN+b0WhYpSr+zbRUeddkqhx+I0q5tgHusdCK+5vOMlmKldQXB
J7KV+hIOm/M384vrAstgI1Vwt6Y+qB1qWh0K2OxYFve53axiNOyTPlIyTSfjhlk0
wsaSN6KZFZoMiOhgdURgE6frMdj1+H5PdeuYtZAVr/VEQ0tuIi0dwj34Oqp5Oexr
JGyQJ7elyyGKHgx9tYPB5uO0cmPUCLVfsG/iagMYNU8gDdgv69htq1bpWRkYa3T6
+J5w4P9bh37Rhdalay2bOGUys7LKrj/zHeQiOT5e/LMGh/fVIlZUrUuvdzQvc9HK
i3RyQUng7RX30lcVHpoS/Zz6Vfke7ml1wwwsd76zy44+FnSrii/cFi8KEo83rn72
qERYvAscFIBNMcL7QIcaC33Evm79+8juBK28TeLqfSkT6hGr//Fqe4c9kap34kY3
VEkFAO2+9CNQyH+EPIo/aQnseAGINWUvdg6USL6tsjnTrQ7DoFYvOLCDMB0czhnU
t5749JFEVF7EKzNMQaaURzmS0dMaiSoi5cHHrCFNiw9nSMQQrEQ=
=vOVO
-----END PGP SIGNATURE-----

--idY8LE8SD6/8DnRI--
