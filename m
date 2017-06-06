Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2615820D0C
	for <e@80x24.org>; Tue,  6 Jun 2017 01:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751237AbdFFBL6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 21:11:58 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:50188 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751192AbdFFBL5 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Jun 2017 21:11:57 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id ADDED280AD;
        Tue,  6 Jun 2017 01:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1496711515;
        bh=uUF252w+Bc9qTVnZvHZr7Jeter6f3Od25w3OZdT/ooE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mpjb1xhmkpm56uOrqsZ1W46QeQEtk5QS+FHd8AcUH8tvveii5Qmtt7BvZrtbGPXPN
         COoa5ylfWhKU/TbGSUEUNGSlroGJZ+mJbD+sLZIO9f415GEc0MfNJg7iuN0F1NVACg
         P5tBAISJ9kbb3dpZ2Ojm1KJAPDSyx/UvL5wUKnZPQkR4oI5sJqxgUSdxwwz6ZShLyG
         SboXyA7d4WqDqo+iaMu9JjwZgr/ihVC13i6Id7FNjaDJvoErftrCoQAbZzHfCPNqAU
         +h7SdSsEQmUCMEIJZYs9c53y2cMmO3sXpLezykCTQjGPx5to3EGgL12LlolvRY3Md9
         6Zud/vcQqvuwu2fa7tZjezo32Qg2jw4VHhnVU847DI9pOkAESYlvPxfRqMkQvm/rqs
         zI/J9Ayty8mwXzs53jJvcuABf/PS+pWVMZMD36SvKvXZTJyC3o/uVFxjJI9Rd6K1TZ
         kjbsecvkOk9tsypzbSi/XqHJkfS0OgIKKk6DMLZPwcOBSSvP8OE
Date:   Tue, 6 Jun 2017 01:11:52 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What does this output of git supposed to mean ?
Message-ID: <20170606011151.qe5ycih77vqlqgme@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <1496671452.4809.2.camel@gmail.com>
 <20170605231058.pgb4fgfb4z45bzmk@genre.crustytoothpaste.net>
 <CAGZ79kYp6GepJxZjaXhosX=vCh0vwa57+zFHK2gHFociiyTnDg@mail.gmail.com>
 <xmqqd1ai9bhf.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7lda3barsvqncvyp"
Content-Disposition: inline
In-Reply-To: <xmqqd1ai9bhf.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-3-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--7lda3barsvqncvyp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 06, 2017 at 10:00:12AM +0900, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
>=20
> > On the subject: maybe we want to rename initial commit
> > to root commit? (evil-me also thinks we could name it
> > "parent-less commit", to reinforce what the lovely git man
> > page generator tries to point at.)
>=20
> Is "initial" harder to understand than "root" or "parent-less"?

I personally think that "Initial commit" is very straightforward.  If we
get more inquiries about it, we could consider changing it, but seeing
as this is the first question I've ever seen about it, I think most
people understand it pretty well.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--7lda3barsvqncvyp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.21 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlk2AVcACgkQv1NdgR9S
9ovbXQ//ZpCGjHVdP4Jns5725tkzfkGBsIfJt4TnZWRUiLmjat1voRxEjcRjsEjy
L0Ql81TAZTKKoYKNvlevX37VjEz7ETH7TCFOdq3v/pp+TQ4Yu/EkirlZbjyuG+qt
pdbvqhHGh+k10XuL5f43r5ztEsWfDCD43XJQ+bVXvs3z4jPsbaNDP3qTyZMHzIbZ
gLZvDlVHmHrJ3u73Wb0jRj+laC+qAaSUpAo8WsGem5n1D96F0wzg9Yv49R44oSws
H774Q/Qnq9BiP4rtiIfz7EuMkToPS3aOuoMiEZaoGO1XZ3JivGpdb1VFqmsQSf9P
0RbzmC1crj1BOP2h5g76QV1hZrZTwy9XCMb5ho+HC99plRLtmXwyc5I5HXoEbRrX
3unD7gm9BMti9BshHVkS/JZqFFFSwZDZ7ucTGUIYeT2M0m1rB/V8TqEQoIx+HovP
bu/2WH/0iaqZR2QzWbziKSAezv2jX+y+jWBtk3OfaMXdD7G06RpvTLevrOxiuGjh
U8ONFBhn5JmbhqcWOYiDVq8SrpjS7mFJmyU7lKBmoBNO8Cg4JBBetcXTMF11/5rT
5sAhD9SMGhmy4Ms9R5ht9V9CMfdIDlFjotKmuHIZgUunpQoZA2YLqUoJVQh3u6+H
DLh9vUYHNywlaqH37uTKzsogXOSxV/0CRmKi/NEMnY2uF8N2Kq0=
=GkAb
-----END PGP SIGNATURE-----

--7lda3barsvqncvyp--
