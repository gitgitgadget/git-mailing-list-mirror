Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 143A01F453
	for <e@80x24.org>; Fri,  8 Feb 2019 22:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfBHWSm (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 17:18:42 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33944 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726788AbfBHWSl (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Feb 2019 17:18:41 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:d42:63e7:5548:1ee8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5B74B60737;
        Fri,  8 Feb 2019 22:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549664319;
        bh=ARixF0cIkQ8yXYyAVfBusTb+BGIQ7ib0QBuEGSuNF3U=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=cNbaX0wsBWDCcAdLKkQzp1NSt17DVTYWGBxcjt8Nsce9bft9dCVrrBTuYJvRa4+n0
         v6+a33Lj5Skft0siM/Jtg2jBkr9zAxaOUezIvpcHtnjwYBQ5hPW8DSSlZD99pC/Thi
         fO6LT8Ns7T37E8czE8ea8dSS3d2La6UHQKofHWtXSbsjPxtn9niuT4OYSUSBYcnvXe
         nm1L4c4qWJrFwR+SrIYCEYvK3jUnmZEjSbiBw65Z8FJnfTbrucjw2ECAntVdujLXq8
         PaPWGtZOWyR8GOBZGOzJXTPg9MvTMWXseOCdtZWEFtD/CRIMDIuRZTAZ4/PUKk2BOi
         Ba6A9VkKWux97qFdzRQJrA7r+rVLlXt9SsIjwkJ1SXp41XpaCA3k0y53w59tqHSyf5
         hEHqbfO+Nj+KMuMD/1fSehGrIBY4DDDa141X80Qva0BZBTKmH/+UZuTcqOM/SzRQi2
         H6nOKxCyRchwlwknpnejB6wrAgESxnYJmTeXL5CjGE5N7C7iBiu
Date:   Fri, 8 Feb 2019 22:18:35 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Jeff King' <peff@peff.net>, 'Junio C Hamano' <gitster@pobox.com>,
        git@vger.kernel.org, 'Linux Kernel' <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [Breakage] Git v2.21.0-rc0 - t5318 (NonStop)
Message-ID: <20190208221835.GH11927@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Jeff King' <peff@peff.net>, 'Junio C Hamano' <gitster@pobox.com>,
        git@vger.kernel.org, 'Linux Kernel' <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
References: <000f01d4bf9e$a508eab0$ef1ac010$@nexbridge.com>
 <20190208165052.GC23461@sigill.intra.peff.net>
 <001101d4bfd6$b9430230$2bc90690$@nexbridge.com>
 <20190208180321.GB27673@sigill.intra.peff.net>
 <002501d4bfde$b26e6050$174b20f0$@nexbridge.com>
 <20190208191519.GF27673@sigill.intra.peff.net>
 <002b01d4bfe4$2d617f40$88247dc0$@nexbridge.com>
 <20190208193157.GA30952@sigill.intra.peff.net>
 <20190208220714.GG11927@genre.crustytoothpaste.net>
 <005901d4bffb$6d0c34c0$47249e40$@nexbridge.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KscVNZbUup0vZz0f"
Content-Disposition: inline
In-Reply-To: <005901d4bffb$6d0c34c0$47249e40$@nexbridge.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--KscVNZbUup0vZz0f
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 08, 2019 at 05:12:43PM -0500, Randall S. Becker wrote:
> I'm happy to modify the test (it is in one spot), to make a decision base=
d on:
> a) whether /dev/zero exists
> b) whether the system is a NonStop
> c) something else
>=20
> What would you all prefer? It doesn't matter to me one way or another, as=
 long as I can get the dependency to /dev/zero removed so tests will run he=
re.

My preference is that we wrap the yes/tr invocation into a function
(maybe "infinite_nul") and use that where we currently require
/dev/zero.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--KscVNZbUup0vZz0f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxeADoACgkQv1NdgR9S
9osZSg//QkKj6S1GiL4MVZLB5Rqb0Qvd0NFmejDRnfP5uE1A4076j+huhpi7kQ1Z
E0vJFVZECz3wXAEMR2I7nL5tJbPmbdCs3cenl0PME6HE1/3HKCz45kjve7lMY7zB
sa9tnVnFzqUUNGhFx+Rvflwhu+d9oklWnqP3nTF5AqD26Fgf8N3evbcqnbjSS4wi
lUnwGj6mkY/jwR67d0mtKcVd7Kk3leSkczmHAQhgQ6lBlts1DQ3Xu/W10sz8KBcC
zyIT+1qYcHE+KZV01CSFbxvKjom5HifgAHi9K+7K3JK0s6BQ+fXB8zvYxU2SXqmv
aE+Ro1oXAECLEiyYnFULSkmiIJxuYtRxoBFSQKw5liZRAMuPGvWqtM88sBL+jVaQ
4ta/jnAU2KeOYgtVndo6StD4hhxsaENPiYp1h7/jC/MZU1i3fDqsl+nZz6dFEq2a
9ydZYT60yXEvMzHwKt9Hp9ZIqMcib2KofUTbPj9uHiIPXMY9v5TAhLvymEHwQXW9
L8+9uAK6LJqyIvVkTdjJmNdSZz2WIjIUzUy/urN+fRvVE9gxymQo6zav1Hb8uOnB
p7pUU+giETGwqg+zIxbA04WIdvGLQ18b5LMeHTW1eSWgPjQNxylwLdQTB39g26iN
cfawpyqWozEnwqEKolA4/2mLt964lvWM+FrcoKgPxr80eWZw6CY=
=BJgl
-----END PGP SIGNATURE-----

--KscVNZbUup0vZz0f--
