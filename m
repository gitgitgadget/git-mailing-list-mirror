Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFAAF1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 09:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbfA3JuO (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 04:50:14 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33640 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726713AbfA3JuO (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 Jan 2019 04:50:14 -0500
Received: from genre.crustytoothpaste.net (host-85-27-49-13.dynamic.voo.be [85.27.49.13])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B6A7060737;
        Wed, 30 Jan 2019 09:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1548841813;
        bh=BmGIb+iSq2ACAkN5YfkVJh1dIJOgbf3EpyjWEQktquY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=m5x2r0J/6iUkUfBg0h8Zt1SF6ihEdu4sqqK8WYz8icSs5EoH1LnSzWSd+WLffkvKD
         ciWkhABwhDubYyJMCTQHvCQsaxsXo2fPJsXjJd7IAHt53UyJo6ZOmqrKsgc75aNIL7
         WWAGOKsNYX9848e+YUpfif5Te/TDug0nx3+vd5PSAaF6Y6MITr75IRl3qbNG1htsfP
         u/bpBtYvMkIUVMQnzkLm+ao9Lt5tyL53tE+rYNWJZAIpYgDsPwHERwZVfAVf1pna+X
         tS/NCobzB7aoSUuQ5YS+bbNs4D1dvWQV2Hv85GzMahNHDo0JiejxcYM74Qy6xcPbkA
         4ohR18kbR1Tx4fKMRFq0gzyDjKq3JCAeyPH8/vSSAU5o/8Dj1DKT8zTTWB5T8qaxyO
         vawUdN4rpAoULDDhiUFWZRYXQo/Lcu+boMnJVypsHX3mBmRcDURjbl1v3NWozdBn9O
         cIYT2NgtJt8zM+y5fETB2uDRUP8pfvVJf7W0l3ipv5gFKirZ683
Date:   Wed, 30 Jan 2019 09:50:06 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH (Apple Git) 09/13] Use symbolic links rather than hard
 links for files in libexec
Message-ID: <20190130095006.GC24387@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeremy Huddleston Sequoia <jeremyhu@apple.com>, git@vger.kernel.org,
        peff@peff.net
References: <20190129193818.8645-1-jeremyhu@apple.com>
 <20190129193818.8645-10-jeremyhu@apple.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Content-Disposition: inline
In-Reply-To: <20190129193818.8645-10-jeremyhu@apple.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 29, 2019 at 11:38:15AM -0800, Jeremy Huddleston Sequoia wrote:
> See <rdar://problem/10573201>

It's my understanding that Radars aren't public. Could you summarize the
reasons behind this change in the commit message for those of us who
don't have access to view this issue?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxRc04ACgkQv1NdgR9S
9osPLBAAlulBlmJBZpriaYIIGpwx4fNn9IeuKQV6HMCA6N3LO+LMBAETO4iIEtg5
J35aDcXWMYJ2vbpfdMmTfE6yhz6eLNbBEx0Bjc1G7z2YG90dGAd9jNrjRF9pdFDw
shkN+wkKxJAWvfNU6mvVb4ApTlBPx1Cy5cD650DzTG7AkNoW2/dlEFZit8ixevrU
exu6x0WVaAWr/8LdIA2ybVOmmtvsR/wNTY9XtR3ZYAa1qY/OZjPHWQPWYB9zFXXZ
WsV8MdkSke9TvAjXGRO0MixefLU+Pir8AEmVlhzW7sgY0G/oa3xwFuqTUYckxKxn
0uoT7dDQWxl6M8lS2B61vcTbGqQOgfh7gNdqnllNJXeyI6+k/b237LuF2BYfMoGt
7Jz9hSRqlu2ZYiKDboFO0oYN8yyhFhmtHajic1BTdjMpOX3rSaJY3s7ew92/Vk7O
+f42Rz3EOPiYQi49a7YLYgyiiKsbA6BvFpO08tmyf/4bMhX2S9ujYViyvCieXAL+
UbULz+brqJ1EWF/nWFY+Om7lTC8dj8pstWib1GSt01HAxkbuIl8xHJ8NiP5KvHkC
wcDsUF64m2PS3sTj/iqp70+WNZ6Inwb50Z0a8B+R4eDNlD2LZbtqUhMnl/pD+UJK
TyuBhZ1UbWrQsjcKOoL3hRGoTjjLitPbMdqPe0V7CddPEqk0qlI=
=3VFL
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--
