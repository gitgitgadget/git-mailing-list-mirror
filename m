Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 917C81FADF
	for <e@80x24.org>; Fri, 19 Jan 2018 03:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755398AbeASDke (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 22:40:34 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58106 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755055AbeASDkc (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 18 Jan 2018 22:40:32 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0877D6052F;
        Fri, 19 Jan 2018 03:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1516333231;
        bh=mrf4dFw+m3ZOx3WnTR5zucZrPCiybzNn4UO6KRr14uo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=GUJM5D5HzutVg9R/xEJAJKSowQZf9EYXUmbaoT1hcP44gRb+/hZzTxJ+e9BQytZ+W
         D3WeP1C/VaFcfhF3XdXdi3CwzMLR+w3RIVJ6c4H0Xc3UxUOh5TQ7gYEYylA6XbSHhp
         AVIGYCcy8Yiu02iVeT2JMI8U0H/bw6A0Juh0z4s3anXsa2UEDMUJ2rHE+QwvhZcdn4
         Ls/8pv4sifW7CSwnsvxcd58P4vA39ibtYv3CDeWp/W1gfZHZ/oaSycB2o95NOQQmx0
         jZBEh9N14CmQuNuZ/JvXLn1fpbONM14iy+YLODJLGYoOPsoD8/YEg5FtM+rlXWe7vD
         sAYkiBSDdupmpo+YLBWwn+RRCB6Gw1qWHXOxkosup4kfxmVar9Ya+BPHBvdNntTNRj
         ueUy3r/C8zTH9FFgs7Mmgzfnqi1AJ+51Kizhleq+qASh5hlsK9BRmG+5Y1ZNQ85jc9
         oexOwnsWfk6cm6HUw2WFYgogLzXmMqQJyfO1KEe+3lu09T5Bd0O
Date:   Fri, 19 Jan 2018 03:40:25 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCR0YPQu9Cw0LXQsg==?= 
        <aleks.bulaev@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: git 2.16.0 segfaults on clone of specific repo
Message-ID: <20180119034025.GB222163@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCR0YPQu9Cw0LXQsg==?= <aleks.bulaev@gmail.com>,
        Git List <git@vger.kernel.org>
References: <CALwADsGfB10f5+nOFN-pHCt4z1SkWMcvSHn8KokcyCM0V6K-BA@mail.gmail.com>
 <CAPig+cTkBEGyoS93GYCtoDgccTF_UixqBkVTExg7Zf0M1J7KRQ@mail.gmail.com>
 <20180119024738.GA222163@genre.crustytoothpaste.net>
 <CAPig+cSbbzKV0GttLjHCyY3CNcJO0bdP3Mp4pT+3waUTMAQ8kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
In-Reply-To: <CAPig+cSbbzKV0GttLjHCyY3CNcJO0bdP3Mp4pT+3waUTMAQ8kg@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.14.0-3-amd64)
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 10:06:10PM -0500, Eric Sunshine wrote:
> > I have a guess about what the problem might be.  Can you try this patch
> > and see if it fixes things?
>=20
> That does fix the crash. Thanks for the quick diagnosis.
>=20
> Can the commit message go into more detail as to why this was crashing
> (or your speculation about why)? Perhaps give more detail about what
> 'clone' is doing that led to the crash.

Sure.  I ran into this as I was expanding the hash structure abstraction
into my next series.  I'll send a follow-up patch with a more
descriptive answer.

I'm still extremely puzzled as to why this doesn't fail on Linux.  If
it's failing in this case, it should very, very clearly fail all the
time we access an empty blob or an empty tree.  I've tried with gcc and
two versions of clang, using -fno-lto, with address sanitizer, with -O0,
and so on.  I'd really like to catch this kind of issue sooner in the
future if I can figure out how to reproduce it.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlphaKkACgkQv1NdgR9S
9oublxAAnKDXZI4mlQF5aGloJxQ0bL9rLtvk3BaboHmyNk5kGM2mXRX+oTigPffB
qLiJzRoCPWzekJHllq2AgBkw5BVfzpdVd9YxkBInTtZJo1GkqIBJ2ZyWQ85PjeRD
H1utGRn7IycRBeqsLRUGHfHNPDA52by1Ez7EyMxrk2KmPBTuqtI2TWP1LszOp2da
s24WoM7DyVszevluWNCfjyQBnXuEPkL3+NDEw5jEGDKXaX1AFXkyeh7homvKAwcG
3bf8+zt+wzWP21IPSjFgHi6gFNybOWjINwgO6ZoGnBwlFvUPUPUcf5uSdwAXS2ks
W99s/4NDJc+7oSHiOq5gbN7+5+arEc1Hyo3k2XVc8GitQSoSB5ql0q7QYb7VUicC
fQfmDDyK+EmuFjRnogyvK9pZJrZ0c7IfOkP+zMcyfdzQ3A/8REOLXlnqQ2P43NzO
AFnmmoLBGMA8OpEvxSincufekcOscE4n+CGH7uIF7wicavIi4DonO+QBK2hRmjqx
evv1RrM5qoVCRruqvvibkCN58MGB+U0cF0bFGRx0ZVmfokrwbx2c/PB/X7l2NV/Z
M5C4ccG38ddHkQIqPWBNgrx2PG3aVOASU2hFfzRhp0L0ohfxKOV/BZoWNUeFVuK3
H9Kd/YPFIEMMwPwinOreR11qZEaymX+pa27dWZ+v9FhY92g6WUY=
=f268
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
