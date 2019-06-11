Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D0F71F462
	for <e@80x24.org>; Tue, 11 Jun 2019 23:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407356AbfFKXks (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 19:40:48 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60034 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406131AbfFKXks (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 Jun 2019 19:40:48 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:4429:e8a6:430:6b59])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2233E60427;
        Tue, 11 Jun 2019 23:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1560296446;
        bh=GxLpehDy+cT/9H5EJuhpU1SZki1hY8OFPtw6SI5Wqio=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=G+i2pum0XJj9pUR+N7nGdl2o7TXXFmEf0+8tJmD6Hr2ZYCwTv2+Ij8IVzjYG4AWrz
         Y55pMSYh7pzTm8ZWEwKJf2Nmpuoj/E1JUN9LCmZf4W3uhR0qDkEq1aR3yeI9/n+9ub
         9//VgpnCQxP1cIEI/6JEFj2F5tCcrLqQZq18uBuQ3tIdDCC1xF6Z3iu5HTFpZ6M45I
         Gp/ZSz5M5JadY5ztR24mEk/BfO7RyNv+WbgZPyf/l2GZ+eR8hETCms4un6ixwBQ0V+
         qGpQnwATXuT2RLic8TSdt/SO/PhSY7h0XdLnp8vdjZZL4m/zvU2O9sVSbwdwNLV5zG
         Mk3Ge2mnPSBCtkktJK/v81s+U8np0wfTvARblGReJpPBXg/iSBLB46zZMagyUytUOr
         1JcRpMPLoOER33NJLgHA5uPW8Ay/89+A8rSVleFVLwdTXDX1APoVlO3RsrZuYexQOK
         SDcrwA68xQMSrnfqSVa/DoN7P41xyfzPIuFE/otTA/CPd52ULuH
Date:   Tue, 11 Jun 2019 23:40:42 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 03/10] t1450: make hash size independent
Message-ID: <20190611234041.GA8616@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Git List <git@vger.kernel.org>
References: <20190609224400.41557-4-sandals@crustytoothpaste.net>
 <20190611230255.146381-1-jonathantanmy@google.com>
 <CAPig+cT-N6=-9CJR1ugQnrksy-Zfx7bqnppsEdpiX8qaG-7_Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ytgo/kJyDF3J5kSH"
Content-Disposition: inline
In-Reply-To: <CAPig+cT-N6=-9CJR1ugQnrksy-Zfx7bqnppsEdpiX8qaG-7_Hg@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Ytgo/kJyDF3J5kSH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-06-11 at 23:20:31, Eric Sunshine wrote:
> On Tue, Jun 11, 2019 at 7:03 PM Jonathan Tan <jonathantanmy@google.com> w=
rote:
> > >  test_expect_success 'alternate objects are correctly blamed' '
> > >       test_when_finished "rm -rf alt.git .git/objects/info/alternates=
" &&
> > > +     path=3D$(test_oid numeric) &&
> > > +     path=3D$(test_oid_to_path "$path") &&
> >
> > Double assignment to path?
>=20
> I tripped over this, as well, when reading the patch, but if you look
> closely, the second assignment is "refining" a value computed in first
> assignment. It would have been clearer if written as:
>=20
>     name=3D$(test_oid numeric) &&
>     path=3D$(test_oid_to_path "$name") &&
>=20
> or:
>=20
>     path=3D$(test_oid_to_path $(test_oid numeric))

I think in general people have discouraged the latter form because it
doesn't fail predictably if the inner command substitution fails. I'll
rename the first variable so that it's less surprising.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Ytgo/kJyDF3J5kSH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl0AO/kACgkQv1NdgR9S
9ou4NxAAtpFokEn7VjhZCqKBG4rUK7b7T5gxz5kGCB59Xmx4klMA8dxwXmB+SdTF
OaBA/WOvIIahgUnrcUX0Vc0f/JCBTWLVsvtp+Buq3+kI5q82kzU7+oOahgmVWied
PRc9l+GYX5jWDfUg/0tR13RUNgGangZsLV2ZQ/sFL9gkb8gFveu0hQ6EUqVI/k0u
4RNP9BYA83lCsRXggrAHElaEgESUbvPn2zP24ChD0mmtl9LAW5UIuXe5au6Fno0m
6klO9f0n4aTOOy9B9xehRrIpl4zft4IpsClEz4nQMQvUKmRjiwWNKfpI1duL1ebB
d2fHmb8SH4O+2jEG6ZOjxthdmS6JgFXrLBSgG3HOg6Ji+HgJPlR3qmJUQx9n09QS
7FUM3kkB2KefLXOfnYlL6epwsGVNWIgYx0y9oAKCg+u3V4OGSNaN981GuqbbQ+De
BnHmDhL3KJO4rfjI+Cn9UuBOfPbIUWlRULm4VMdnSsQ/xeQqAWloKFdmMec8xQZg
dDoJlEiT7BtPOts3FWdRxffF5iRc2Nqr6v3A0Aa9icZxw3kPNeDH3Qv5kmW3AbhQ
gV2laZ2C16/mRyx5qctvJaJiPhxE3ht0x7uloWkt1VCPvJ6YFshKVrmFYGMjd+cb
1arO5oANkE7ZWtGVXluobhxiXK2h628t9rem7u24q8k/b0altbA=
=wUf8
-----END PGP SIGNATURE-----

--Ytgo/kJyDF3J5kSH--
