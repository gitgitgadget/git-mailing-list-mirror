Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E24321F597
	for <e@80x24.org>; Fri, 20 Jul 2018 21:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731794AbeGTWmf (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 18:42:35 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33846 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728342AbeGTWmf (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 20 Jul 2018 18:42:35 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:f1fc:eee3:60de:bdd8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B1F5F60734;
        Fri, 20 Jul 2018 21:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1532123545;
        bh=UKOS8HfKk/8xgi52Vk0d4QurijDMMNwypAqIfZ+XOaI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=kLG8fvw5lJrz4lvRLmkJ0us0Wb7PO1eTiWycb2z6InPXODzp6AZlcoxEP19QgSvQw
         pirDznFXt85TWbhbOf9J6QBuyDiuM6NfUWkmDDrnMvbwf5aKdIXlHU8KGoK6BeLejH
         qk8rylPuxog5mjGFefIbVAWVB7AiWz3tX5AjFUVb3U8Qiiup8KGpBy367P24ic2UhL
         OjLmM/iUJ7Zwq/Nd9IhLnUanO2oqyBLgkXwoyoXnTry8deDICcn38a2ENFDzCtfQZS
         HDwdrt5k6QZ6WtjsiDWD93s/oKoP8lVrGKADdv0xPPx22niMVZelRI5CsufKNx3428
         /MkweF1L3gh7N0P4UM2wrJXCkuiKDindL2KUO4yuZYjlYF4zKmbSpkZaRPqq7oCGDP
         WUg+pqj368mKZ1ptQMUxOihxhlswKjCKiQ1eVNCdKjSO+uetr/JbKu924d+X1CGk+4
         hYfGwJJo8p7SeZsdAeKgzbD7Fjpbi06PcYlpOV5/REEzaNJ2TSd
Date:   Fri, 20 Jul 2018 21:52:20 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Adam Langley <agl@google.com>,
        The Keccak Team <keccak@noekeon.org>
Subject: Re: Hash algorithm analysis
Message-ID: <20180720215220.GB18502@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Adam Langley <agl@google.com>, The Keccak Team <keccak@noekeon.org>
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
 <20180609224913.GC38834@genre.crustytoothpaste.net>
 <20180611192942.GC20665@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline
In-Reply-To: <20180611192942.GC20665@aiede.svl.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2018 at 12:29:42PM -0700, Jonathan Nieder wrote:
> My understanding of the discussion so far:
>=20
> Keccak team encourages us[1] to consider a variant like K12 instead of
> SHA3.
>=20
> AGL explains[2] that the algorithms considered all seem like
> reasonable choices and we should decide using factors like
> implementation ease and performance.
>=20
> If we choose a Keccak-based function, AGL also[3] encourages using a
> variant like K12 instead of SHA3.
>=20
> Dscho strongly prefers[4] SHA-256, because of
> - wide implementation availability, including in future hardware
> - has been widely analyzed
> - is fast
>=20
> Yves Orton and Linus Torvalds prefer[5] SHA3 over SHA2 because of how
> it is constructed.

I know this discussion has sort of petered out, but I'd like to see if
we can revive it.  I'm writing index v3 and having a decision would help
me write tests for it.

To summarize the discussion that's been had in addition to the above,
=C3=86var has also stated a preference for SHA-256 and I would prefer BLAKE=
2b
over SHA-256 over SHA3-256, although any of them would be fine.

Are there other contributors who have a strong opinion?  Are there
things I can do to help us coalesce around an option?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltSWZMACgkQv1NdgR9S
9ouaZhAAh+e6JNTwnADiotVMIeTOTjk9OBhbO7mT0gwv/gd25OZHjGMBEuC+77Qv
uYObBG57rcXzkr2C3CrYnijbNL1u18A1mpMhTUjt/xlUy8+hYtrTOHMbl5Iq42lT
aS5mHjkFmlUdS5Cd5MVX+3XhPS7Mkb+tdQoE5qhkQLq3/zDXihQDzZyswwlofftW
FT4o/6Kpz+MQmxQ4jcQzBBAzS6KorVTde51kqEhTgzw+WttZBVkzpttKQSNG+XG3
C2o9O5FxxxVQ3pxP8cv51cEZ/quxMZVCsdk0nz3YKmFTTRuqQb6iXKVfaYSbGU0Z
zKqoa2dRwMA8OlcCjzWmviHfWeZM4x6U0GsaMqYTwE68QeAuoxpLszJupxCrcDDL
enGxnarDw6UZp/OSJHdSHNfP1RfwSza0OvDwyEoVJFA5uFafbJnWDt6QiffiJLDV
nZ71xIXoVrQpjPNzyT66qOf1+jOQrQaB0DIXDEWeIv02qqKAvFB+WNM2liJyOD3c
Vqk6g++31ekDLRmRizPuR6eby6LYLc6eca3CvWn4d8yFQcktkeeVTvoj7WTQSU2o
J5q1fVck+ywGbD/VdEZH2Eovf90aF+S8bCe5TruY1CSK8seMhga5+6Vf8u3FA0RA
Fw1xPwZ+VwpFDfsYLPGoyL2BBw0MZSJnRD+6s9LoQT+5qYwyGDI=
=e/TI
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
