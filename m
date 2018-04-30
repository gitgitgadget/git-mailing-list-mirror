Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58720215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 23:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755558AbeD3X7x (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 19:59:53 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36904 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753953AbeD3X7v (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Apr 2018 19:59:51 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 02D2560129;
        Mon, 30 Apr 2018 23:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525132789;
        bh=6I3q1pIMwrhF8cT3PugzuypYmAvQ5GKvb5pZaKD1dqw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=QXcqrEwFXGgp2z8aI62/bH6FMQW5jReCJNlFnMz+W87H4MokzR9CaTZKpwYA1KDJr
         1rwCJ5lVrWHMmu0i+A4TjkSeFyaAQcVxL3p7hTfPrDpYw7sww+FQWFO0EssITV/xrp
         otckOjjib/JsHTqQKuV/od9kXZgHUE8Xb0sk7lvYxfb2uUXg7oDUfVU7De3KsupEG/
         kPC0I7SdR/tmFlbi8vJ86t3pwK/x9PlXx6TlvKhArYgqJILmDIEhjbvydMD4+UwuTW
         j0usvLlQhPkxBs8L4cgjvJ1iAzehpdk0N5MqjuTOn5xtXlTH79k5HQWyKHRno+T/QX
         vtAic4ubIvmU+NHpJXbOZ7RRHOlWKBvFm3DeMC/3Y8qF1vO3vSGEnYjvCCwqik3z6+
         FeA1okoddl+kAg9e0F+F7oPxoOyb34nt33FjP+85aZxxiMA85yJq2sGPaqASVjCexE
         y2WF1iB3QuXk3EsXNtBcS2peMyGflFdI/VHfF3P2XvPU8IW4C0t
Date:   Mon, 30 Apr 2018 23:59:43 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 00/41] object_id part 13
Message-ID: <20180430235943.GC13217@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
 <CACsJy8CX7cgd4EGSHVUtm35Aq92Us8WBA-r746vEaZiFP5Q5Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Content-Disposition: inline
In-Reply-To: <CACsJy8CX7cgd4EGSHVUtm35Aq92Us8WBA-r746vEaZiFP5Q5Lg@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 30, 2018 at 08:03:12PM +0200, Duy Nguyen wrote:
> On Tue, Apr 24, 2018 at 1:39 AM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > [0] I can synthesize blobs, trees, and commits, but things are currently
> > totally broken, which is, I suppose, to be expected.
>=20
> Yup. I was tired and bored so I went playing with the new hash.
> Writing and reading blobs (with hash-object/cat-file) were relatively
> easy after fixing up fill_sha1_path and get_oid_basic). Then I worked
> my way up to update-index/ls-files so that I could make trees with
> write-tree. And I hit the first road block: struct ondisk_cache_entry
> hard codes hash size so I would need to re-organize the code for more
> flexibility (or even redesign the file format if I want to keep byte
> alignment). Eck...
>=20
> I guess I'll be helping review this series instead :D

Yeah, I have code to fix that, but it's ugly.

You can see the work on part2 and part3 of the test fixes, plus the
fixes for all of that stuff on my object-id-part14 branch.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrnre8ACgkQv1NdgR9S
9osYZA/+MY/gxS1MZ7alJfge5Y37Rk1rxZ4xRfXz6oxW3XPd1DJD3TY6Raad6tFC
GHJ3mIyxZkv+NLwFVY7YVbG1iZeO0wYWbNz8YuPnk4L4UwnqygVWzNnFJtjtSgJr
ckN1oGUAbNWXHB/KQFJZE9IRpGufUO3v+X+plhEO4FzVQyqAhbdiyQ+/Z2XBSDV1
Ku25yZyKC3orhaRJrf8BWU0pGSvCmE+lDtmq4mRXCv2X/YSpLSVZrZi6rU+WSlD2
hMJlZNJ8GJTk9phTE2glY4sDBW3YR4rTq8kF9rnikde7nf10j+KULM9DQAqmHWuT
uhRg0f/lRLGaQ70ynLYlbTX8arW8EQ8E1RlNyDHV1S4lsNkGZ/VaRLwAW8ofopZY
46SjjB3z5hIVV7ZVZ9g369VlGgXTR+7/I6qywWm+pDn8VzqpWw27iZFG5cMRmjM9
gkmcEmzKWC0xPFg8NgVuOSR+brEktPiav/CcjWQa9r6X2ADLctNtitzyNKKJCiAL
lwO24C7c5kKGhvjS1GIhZA8tYQfzoMMskAa1KJbnGrZQQE7o3OLaDIBYwBbnOdXz
BcRkMrbTna8xvt6CFj5nj5RnnbsHsKIHwkQE/Sg8GBi/lA6XjApobjkaeUqHFRk4
kxw2RLWaH7gguVGJoWMA/TcOiIY9oHEQoH1noMCqVyssaxKFGWA=
=Szla
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--
