Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88F681F404
	for <e@80x24.org>; Thu, 13 Sep 2018 04:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbeIMJY6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 05:24:58 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54306 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726364AbeIMJY6 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Sep 2018 05:24:58 -0400
Received: from genre.crustytoothpaste.net (108-60-118-130.static.wiline.com [108.60.118.130])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9FBE66046C;
        Thu, 13 Sep 2018 04:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1536812234;
        bh=EDy9k+CTBZENL4pqPu/snjluNX+NVUfy/FGG+p4tbtM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=s4tZ49bw+3IMsJt5UUg/QHs7KyUbYYou8Kb4TaBf9LjGDte9y6xDUGjPrUqvUqG5c
         NRj8KptyKTBVgOaH2TXcPG0YkfnehCAmfPOsBgmMcdq3L/vYN9wWKDaJbC3jHo9cQB
         PIZJXk15fQUb4qXcDKD0CbtwsVwdFnpJhq7AG45FHu3exWAECNQyHvgagyeQrZi3l5
         TfkuFfso97GTQIanGkuVlqX8X+5CL5xkTEftc3fkFvKdEYjCShlt5uyaEAsfIPZv9a
         nKXTE99M/GK7A3NmqabfxZpOJcqylld0hQ3M1mJaJqIaI78hOCoF/VoHV/gC6E/4sc
         piTQkxa1AHMEs0iSAXsooLdk7sHA0WM73cddgZBm4PTHVBifDJrjiAqZVHHFW8k7hG
         cNTY27sfCcBXHIS8oqNe9Rea2+bU397ZSRSrtcpXhcw8c22iUPpLWYJoCt+PU2PmNZ
         1xRrxKwA6G4p5XAciNrIjbeHJTHo3gy8BmPzHwezraYxswf28Jt
Date:   Thu, 13 Sep 2018 04:17:08 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Sergei Haller <sergei@sergei-haller.de>
Cc:     git@vger.kernel.org
Subject: Re: Multiple GIT Accounts & HTTPS Client Certificates - Config
Message-ID: <20180913041708.GT432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Sergei Haller <sergei@sergei-haller.de>, git@vger.kernel.org
References: <CAPO0KtU=do8nmJggP4-k1BingdseZUuRjWraGjuN01VoEYU=1Q@mail.gmail.com>
 <CAPO0KtU5YHtuTEzSAZ8sbtuUuZ_0EV4_LyQdWcDJgH6N05TN+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HKOZ/JADkehwFk9I"
Content-Disposition: inline
In-Reply-To: <CAPO0KtU5YHtuTEzSAZ8sbtuUuZ_0EV4_LyQdWcDJgH6N05TN+g@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--HKOZ/JADkehwFk9I
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 11, 2018 at 09:42:35AM +0200, Sergei Haller wrote:
> PS: while I was trying to send the mail to this mailing list, there is
> some update from the stack overflow side:
>=20
> * I am using sslBackend schannel
> * the private key of my client certificate can be provided by using
> the http.sslKey config option
> * the private key is on a smart card, so there is no way I can copy it
> over to a file and use the openssl backend (at least no way that I am
> aware of :)
>=20
> so basically this pins down to the fact that schannel implementation
> is picking the wrong key.

Git doesn't provide an option to query a smartcard outside of what your
typical TLS implementation provides by default.  Not being a Windows
user, I don't know if Schannel provides a way to automatically select
the right private key based on which certificate is used, or if that's
outside its capability.

> PS: the recent realization makes me believe this is a window specific
> problem. I think I have read somewhere
> about a separate windows mailing list (but not sure where I saw it)

If you're talking about Git for Windows, yes, this is probably better
addressed as an issue there: https://github.com/git-for-windows/git.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--HKOZ/JADkehwFk9I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAluZ5MQACgkQv1NdgR9S
9oudFBAAs4WZj/nq9BJpHTitZJ4ssCZLxAw/xxDpGYt7r8HMHimsb6P1PM2voihC
ueDYfFijwO4h16eoCvz2M8mofMlPoH/DKmYftwWV4Bj0yiNsKgNrzsYojla7W5pm
YdD6AQNqnXNHusAqfmMP84dIWmibgHHHMfzfTLzc3FqarYsmD8Om8t7bqCCVM/p3
13AySpTUMDE0HwIkxmekfgbe3uvmE/wajNO79LebWQb1KyBvQKX9PxyrH+BjWvUx
mPB8RdHVSKcTvVncQg1xmA2XVZ5IBZLYhNpslidYNtlmF5cBXFywGYQhn4E0MoAl
NpsHDeLlLa1gjw40xt5mW6q7xHrxHzXJfeaNyuwi/hz9jg5HOZ5L4QrS4QRWsQIa
No5gwtkpp4slRmbWsWfkoyIWgVlwjYTK+0pVk/nDc3INknBMa2MRSFaZK6IEX4YX
c12mP7ft0tREBEW2rBbz+F2ZthgfiWt16pNukBuFTi/pSVZ9hjRS+uOmwnuWpWAy
8Tj4Oz0Ih/ejaxb/2E12jQPN99JtEEe1XJZUu2/ttPqTZsQiyAprmO8jmMKmfArM
X2t8oBPK26Dubl5wOvRkUOWzv2wzXCL5IRAwi3z0nj/QHz4OS+tpshj1f/TzMDXJ
hkXothx+buRDVo/4Shr1w7POvzmR/RAR899hebcvQ1kcA4QgA+Q=
=mHNd
-----END PGP SIGNATURE-----

--HKOZ/JADkehwFk9I--
