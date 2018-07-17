Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95AA91F597
	for <e@80x24.org>; Tue, 17 Jul 2018 17:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbeGQSGW (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 14:06:22 -0400
Received: from kitenet.net ([66.228.36.95]:55174 "EHLO kitenet.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729713AbeGQSGW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 14:06:22 -0400
X-Question: 42
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1531848753; bh=HWMToYkcyAGXTHX/kRKRxFOrElvlVMs6EpPRV+9/jrE=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=bc2hvwWxKkOn49LEgvluwnQC1fNuCV68oZrnbua9obi9TL3JZmO8DASY1yVe+9xL8
         dp7FDbOhQ52Frl1gjMMiqudTp7mSdV9e2V1c1uwVs8LL35cGGmoi3zv9WyHIrgVYA7
         zshj4SUpSrZHtT0qk3D9rjHV3Qed49frk59kbDFI=
Date:   Tue, 17 Jul 2018 13:32:33 -0400
From:   Joey Hess <id@joeyh.name>
To:     git@vger.kernel.org
Subject: Re: clean filter run in top of repo with wrong GIT_WORK_TREE
Message-ID: <20180717173233.GA15251@kitenet.net>
References: <20180717165834.GA5615@kitenet.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20180717165834.GA5615@kitenet.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The clean filter can work around this problem by chdir GIT_PREFIX,
but needing to do this in unusual cases seems to be asking for bugs.

--=20
see shy jo

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEKKUAw1IH6rcvbA8l2xLbD/BfjzgFAltOKDEACgkQ2xLbD/Bf
jzg7yQ/9FK6YVwtkoym2e1R7lV1ik2iJvlhlW0SGl7aucnvqmE78tgBYRcroNxIB
lcyvr0Qzs1/fdHE44zbB3g7FQ5rYrmPrfXIXaCprvLhfdLl/LL4WLPGKFFeph7j4
uHjwcMeTqRFzS1JbdfzqZiH90gXqWCRPupRp6qq7/jIucg7NGYSbQiFpLc7gYfml
1wbqw8z3D0ZNYbo6MO4JlESTRuiuSJLvF+t2ELQ7hoZHecQ6NaBM7tf/qf+dkJGJ
K65HcwVq8x/9B1IcF/6nmRppSt5En387tkX+rZSrt5nzFLOPKFHSt2tlJeIUSPQw
C5m+HMl8XB2wwUYb2lYiobsOh+zMFNkhZVQpfSeuJ38tjEodJ0/yYw/AT0QoqaBH
JDAsr6H+tQm8KT3xgKs1BrCnbvwKK60rpl8+peHK3cP8xWMuRTqt0Z9Ur96etKId
Lz019kWWDst+ce+VlQZ49X7QLey+qAhPOwHhEOTiXJDxJTGqCqwOy5KAy0RE/LIY
BQCzRIvDgvZxJjVqMHa8CJ295pT08Wea+f9odhq432j5pg++GoSa3Zb8dpw/LL6M
EgLIOmawByYyEAU3YSj5udlMYHVGQcj4wCT4I4o6Ma/27aZ9mmYWjsqwSXXWQMhl
0awrfhrpPzP4PgVbxa/m+5rUNOoNz32IX7iOBdwlDhNZ7BV7/+A=
=CgWC
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
