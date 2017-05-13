Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A714E201A7
	for <e@80x24.org>; Sat, 13 May 2017 02:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750822AbdEMClt (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 22:41:49 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:39520 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750734AbdEMCls (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 12 May 2017 22:41:48 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 225B2280AD;
        Sat, 13 May 2017 02:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1494643307;
        bh=PJzTgr8pGoU+uhwS9r8vCo/1WHraFB93mo20E83mKrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dm8JUWQn0C0aSWHLV6foP3cPyFXujhcc3DqZ27TaVG7W/gFWJs9HcbyPYCfEHX8q6
         UMdbx9OfEdZWYd7bTSHjNyEr358IQ1X5mNmj0A/B2CUXB6TwOnNPPI+me7cwjzoTg5
         Q7PJq24r00pfhZYYHXfoz/CpaEgJbMWjRXSx5JfAhMFe1b3f9auxbxv6E/Ur8BIeyu
         sQI3EGSrFrsPt8tV+1DngNA0yBGL5cTxn4NwEL0qLy7U2VI9i011HAgvw5BTDei0am
         tzwxspDIySfKYk16GPAY/UlvOCGIGGak65uX/CKjdIM0eWVxl9pCrUCA4cmk1e51SK
         t9qQ/OCekjef2UZkPPqhTjYXHCZFTT3DX/sqz9EXi+muRX3L36/grs7cmfS1CYwAiX
         rIEU3kjVLCrmR+12nOVxPwi/dGXBG5o7H3ucTiRBViSS8tSNGZqv4Be9KL1gbdh66M
         IcITXxLjhP458IGepCj5eOYD2+xbCFzt9kB9KPpjzupXhrnJqbA
Date:   Sat, 13 May 2017 02:41:41 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] builtin/log: honor log.decorate
Message-ID: <20170513024141.52nazwvnqsvj2af7@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20170512220704.txmdk45s66aqhexi@genre.crustytoothpaste.net>
 <20170512221221.406645-1-sandals@crustytoothpaste.net>
 <20170512233214.GE27400@aiede.svl.corp.google.com>
 <20170512233753.rz2g7quews4ny5iq@genre.crustytoothpaste.net>
 <20170512234814.GG27400@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sugy42ednyj2eebs"
Content-Disposition: inline
In-Reply-To: <20170512234814.GG27400@aiede.svl.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-3-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--sugy42ednyj2eebs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 12, 2017 at 04:48:14PM -0700, Jonathan Nieder wrote:
> Hi,
>=20
> brian m. carlson wrote:
>=20
> > Does anyone else have views on whether this is good thing to test for?
>=20
> I know you don't mean to be rude, but this comes across as a bit of
> a dismissive question.

Sorry, that wasn't my intention, but I see how it could have come off
that way.  I was trying to solicit other opinions, but did a bad job and
implied yours wasn't valuable.  I apologize.

> > On Fri, May 12, 2017 at 04:32:14PM -0700, Jonathan Nieder wrote:
>=20
> In my humble opinion, the bug being subtle makes it especially useful
> to have a test that describes that bug.  That way, if someone is
> refactoring this code later then they know what to watch out for not
> reintroducing.

Okay.  I'll reroll with a patch to the tests.  I agree that this is
rather subtle.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--sugy42ednyj2eebs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.20 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlkWcmUACgkQv1NdgR9S
9ouyZRAAouM5zz4/i+uskQKH5R0Zlu3lJxSywFeH/ZV2QdFeEVhYbZ4MB0yELLbS
yzn12jfVw+MP+XsvJueG7ivip3MgO8VZUcUlpXkA/nHXGlnDmrZ0Je02+ik6B73u
3r6Q4zhw5f3xDn9Dfo8RX1HOpNhRyAgNw1lylPmGA0yvFqnH9+dWyM0SKUfpP4Ma
ywLAoFFk6V+KTwzQ3XhVh0Yutp/fOpZJ8L01TseOfIsUZwfFIgLncvpb3kZ2dcqy
6NDgvSbwcjiTeAvD0TjDXAz1bYwWLJY7bxgO0rMP6Kj5+4WoP36KSMQ2Sf92CcNq
Oq7pjHbJ63Jzf+PbA0bW9sQvwd2+8KuzzK87mUylHaSFXfpLtAyvbYXw4elj2JNF
zlVKnCyE6FEAm3OU0A+tC5Zf6N3AZqRN/46U9+yeCA3YkbLg/ZZ3uZKE1Mf1wTS/
yLwzek/znv+3etQ2wC1ptVXcUXpZbbZ95KVK3pV6VdRUz+srI7r8ZOMuKOTTLvx2
jC4ZXFQPUibnDsbt5vLcO4kvaoPQXusCFaqmxcRXkAP3fAX3S/JAwDb3gs48x5CK
fOLw8+5pDv2E/bAYph1JrP5XHlZSPMJ3GhUf614qQd07I7H/+6wIHESmXHaXZzTU
mFCL3Quq+oE3kkMpkjuCzeqIAbf/uN7jnV4fobv6KXfj2ZD2Lzc=
=1zDV
-----END PGP SIGNATURE-----

--sugy42ednyj2eebs--
