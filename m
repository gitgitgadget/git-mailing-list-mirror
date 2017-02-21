Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DF36201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 00:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750977AbdBUAZ0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 19:25:26 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:38894 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750922AbdBUAZ0 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Feb 2017 19:25:26 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4BD9A280AD;
        Tue, 21 Feb 2017 00:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487636723;
        bh=XekGqL7CQxla+1hASJcqCxZ07vqLBDkmr0IAOIj7eNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=De/t54diI+oJN+XUf9Sq1uNqfWU0jR8aXbG6rKujqCjEOJBRbaA85b6r5x4HnSoEl
         f/YdHTfvcpvOu7XjxaDEGhQzzOAThuLK6JXAJWFU1vX4NdC9sm3yWkyZ500KxboDqY
         G9P3MIXuZOl1RlxSvVfTpneYtJ7JfzdXXKw0qNI4vy6WPdCUn/rphGh+btw1lN2p8L
         XXB1MSa42lwWq+iiNceEwSwVBD49bsNUsJwHA6ZAeLdLNe1aDExv7VBa11w54SnGlf
         fx8RQPOLHbpenocHoLIECcQeYvSGWyd9k2j9wtddxklfJ+85X5HrD1bflNcUYabkP3
         nkEEZbaf5HMLeVOiideNkdQYJQS0tzuvVMdGKfyrw5G2yUes0VPvo1Bvq9B7wUk/6M
         y7nLwGjfWy4wiLoarFHg4gQukMslMPjM8lB3/tZZrUw/OMy4lm6oLIDfHTwmiJSoxh
         9McKNrb+28rBAYm3SR4dEjwQZnI1seC9EFsbvur8fg+r2P00biJ
Date:   Tue, 21 Feb 2017 00:25:19 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 03/19] builtin/diff-tree: convert to struct object_id
Message-ID: <20170221002519.55d4mlljia3mposi@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <20170220001031.559931-1-sandals@crustytoothpaste.net>
 <20170220001031.559931-4-sandals@crustytoothpaste.net>
 <20170220080902.vkexezd5solnhrhb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mdvato5dggruwize"
Content-Disposition: inline
In-Reply-To: <20170220080902.vkexezd5solnhrhb@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-1-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--mdvato5dggruwize
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 03:09:02AM -0500, Jeff King wrote:
> It's a little disturbing that we do not seem to have even a basic test
> of:
>=20
>   git rev-list --parents HEAD | git diff-tree --stdin
>=20
> which would exercise this code.

I'm unsure, so I'll add a test.  The only way to know if it works is to
test it.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--mdvato5dggruwize
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAliriO8ACgkQv1NdgR9S
9oslMw//TnvEoexrfIOYZWt5lhs//FUryK51lyiW0rZXzc2LpiUJ9VvHVPkyIHhe
MUIHQ9duG6q++vVzHbE+6/5MKBs4Dsekb3rR1VGdhr/PhaLqtkQVy+AQiPdEcGVx
QxpPJW2kV6uq2WDX2J0xCwF8pI7xQilKStFO6Sffofd0F6D4ekKfa6iByVJbOibn
KDHwdDHq3eGtwywvmdGYmowETXj+w1nkmdLcUPJZaQjChJhRQauBBOhNMlwaH8ze
PeMlKPhwtWkFYTFoz0YpcWN9l9WevY7Xopuq/rchfREKy58cByMFM5QPF9CeL66o
zjCU1cQmKt0SgCIT+FLLFIKnc3cD2lKnBvkcvogE+FnPK2gGEBQWCHYZuPG6oxky
w++gputSdYvXlXkgeWBGafG/Dp/odtlUgIf+HKCeWDG3i5HTb/0SYorkrTr0CdYT
dqNeS4U3RLYkKMA9GH1J/J1xxyAUM4braguz32ayTgNKflJIDJlGxqGqUWbVum+9
fNPp81N3r1dbBIE57BxoMi1UL5BPJ9vMgXsBzwruU9UI+IQJ/cBNXHxWquy2GpNw
LPI7Zf+q4+33xUWtKiZ+xS1QJ4kxW0J/IxLlHHes1xeWsdMK/Otj9f0qxRFPyP7l
Gc8fm6KcHiTw3tOnrMXHA+1invMfW7OCVSMNwo4CvGj+73z+VSI=
=5MN9
-----END PGP SIGNATURE-----

--mdvato5dggruwize--
