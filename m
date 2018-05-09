Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 657DA1F424
	for <e@80x24.org>; Wed,  9 May 2018 00:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932605AbeEIAUE (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 20:20:04 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42688 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932368AbeEIAUD (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 8 May 2018 20:20:03 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0259C6046C;
        Wed,  9 May 2018 00:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525825202;
        bh=Qn/f0hvGj0xZC+s0u8W4DkB7qVCGG5LijSzISaiojoc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=cfXsRUZJsrBJHwIapIlHmDKxf5nSGtv7SW+gmW+dXebyzrHz6INU8BXpbYq91853f
         0kDbpAaSkI7uXTN6gNRy8aOQckoM/AjucNivEVPSDTZPl0lzVS3jdxC89Tm0Ex+XIe
         vFN+JUaGi6JZcQWuHK+d39l4LrZI601+Jvac1kyTR+xuCpdNdS9VojHmT5a6Lke0TS
         PwZjNSF+357mpcIC5W3XLn3Nl1tWyUtUM9qTwlpRNVydnhYxzOZFlwFD+w+0w1gBwx
         Q7m037DDfJhmD7drpdmFGm2c6gwdgG3ntnBasVhWhWoi1euLHUfydO5IrOt/OFJeVL
         gCZ9m6PnHNI7qoI7qbJ3nZVAUH3vhX9dKfY51HE+nGzkBUKJ5ql+nvq3pUovn6AyDS
         l8o2d12XCRmSNRGySq3RJYnf9SKyGiR2gEOtAg/KY273RuB/X5TM+qgbc6mbIIZd36
         ZkyEgQ3oS9vMyofipIBvPTEu6H5AWct44w7YGrGsPPlm0gqWbWu
Date:   Wed, 9 May 2018 00:19:57 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] mailmap: update brian m. carlson's email address
Message-ID: <20180509001957.GE275488@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20180506232421.975789-1-sandals@crustytoothpaste.net>
 <20180508015845.268572-1-sandals@crustytoothpaste.net>
 <184451b4-1b34-c1f7-f9b1-0dfa63ab9506@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a+b56+3nqLzpiR9O"
Content-Disposition: inline
In-Reply-To: <184451b4-1b34-c1f7-f9b1-0dfa63ab9506@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--a+b56+3nqLzpiR9O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 08, 2018 at 10:34:58AM +0530, Kaartic Sivaraam wrote:
> Just to be sure, you're meaning the use of `git log --use-mailmap` when
> you mean `git log` in the log message. Am I right? Or did you mean `git
> shortlog` ?
>=20
> I'm asking this because I think the `git log` output doesn't consider
> the mailmap file by default.

Correct, it doesn't.  In my case, I was using --pretty=3D'%aN <%aE>',
which is how I noticed it in the first place.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--a+b56+3nqLzpiR9O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlryPq0ACgkQv1NdgR9S
9ouvdxAAktvn2CJa6LWxNu8YQuu3hUDqMBd7MR3dhTi2zB0k4Ga3Fw8Jf63CG++q
jQbYFXslf8AlRjVC+r/waePXSyfViuN24nqIZDeMi/EhFAwJlxMQskmiBZ4DZMOP
X0/7Ggag6Y8E9uw9WTIG2gXvas9v3buAglTFSsUjYRLn/hHZ8P7pfalaTuN036Ff
5XdH8dlFt09ABTvb/BlNhuCXiuogS7fPN8R5B5CQiF7fSy7hEQVydPYHQ93I6/aG
2mWhtMVlS/wtbaTuZn8x//OchGaVjYT7hbgtnrti05yaaOAwdr+GYURzKM5FwoPr
oKHkuaXQRk3RB8dOio6HSsJewDxMdQVW52hKZAtyDFEda8ecyk2ZHK0MCpoTvI+P
mpFrYEJudFQsaxcofNYzpNd4lWFnV/li/QPwjbncLk/rhJ9gVp1TYKbRufBtyLmO
TDle35LDSpSj2OYh96vGEOvDPCr5qfx22OAIO+XZNqLq+1ASiciBZj4VRlZ8XqX1
Zx3eoZJ9jf16/x0OdbflyaZMTEd2/m7ZYodW88qTlCYEhz+3ld4b6aR9ClE6JqIr
XwQD7zG6rwoL8/YFbdUEUyEwqgU4YfCPVRN7y3vbcrOH2fbG/nZURHutUXNqyS7V
mgSlChTbOWYi+EG+wRjZCqC9OM9hoKnJBRO28997ImAMdrTUDdw=
=B6Wx
-----END PGP SIGNATURE-----

--a+b56+3nqLzpiR9O--
