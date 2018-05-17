Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E1641F42D
	for <e@80x24.org>; Thu, 17 May 2018 07:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeEQHLL (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 03:11:11 -0400
Received: from mail-pl0-f44.google.com ([209.85.160.44]:39846 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751986AbeEQHLK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 03:11:10 -0400
Received: by mail-pl0-f44.google.com with SMTP id c19-v6so1962593pls.6
        for <git@vger.kernel.org>; Thu, 17 May 2018 00:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=gobrEzB/9P6/SAE8+2iu/Soamh1ri8GQV8C6sSz2D1o=;
        b=lGKzLbODZtlqrQzdRFw5GmluUJJJVFEH1IozpPyNDdiO00ealbzKmE0msYgoZ99E2C
         nJ5bm5qirptLH/HIUE3sdzxvQG/g4/uHgNU6BPUaLTTgB3M5TPyRfcZ9qmGZ8pHsdDjF
         98zRRaSj70yXE3xBl7HyVxkFz2F75Y99nQo5aMGP26rZu/wOSGBN/0+y6wlktWgYFWZm
         uRA9+OVtQLVCl6RC1IKy/SV7W2eOL7vRSLIt1EbCOKtKMn1AgWGpSG5v9VgGDgqmv0SW
         yljDs3cbI0PHwmqOiKfZYGGX3Pqv4BdirI+OhMeyYbOt8AU65yUdAc+IOfhzoZ9RZFJ0
         7iDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=gobrEzB/9P6/SAE8+2iu/Soamh1ri8GQV8C6sSz2D1o=;
        b=BVZy0vznDI4qXA8xFRQh6cbAHB42xJ0C1bm6MjeiGMPa/XDmoDZWCyNpmsXReFNg29
         hvAgWZXTMyS4JlBVss/8RYn4yyidXj/3AQm6ccIpQIkUVPgbRMxa4FtH8XCT5KaZz47Z
         yqRZr3Krj2PFduIBlT2SR1yogMDwBDzzh3Woj1LWl6JM44XLxINRyh6D1nB5TLyxdWNR
         Rm7rzSoCpsTmG8w14j2WFQn/MdpaqEBS738/5bKGcvK40xakOt12C1X97F8wCSAujrcL
         0TlKczgG++UOeEwIYvK5B/Ecc4ZmnEpl0RqU+tmL4lcUuu1f4m0pXSFrK15jAW5OP8wA
         JjyA==
X-Gm-Message-State: ALKqPwcXQB4P+6Xp903+BmJtJ6AnwcjaTp47iISAvkiETb2gn8el4JcS
        uXpgkhN3EVcEGMpfcu2VcesGCJ7j
X-Google-Smtp-Source: AB8JxZr9tLyBm9fzIk9n4BffKjhU1ZhE17v9IDBQh9nWLHmxTL0/XykbSm1rMVEPWx0N9AT3lIKtNQ==
X-Received: by 2002:a17:902:224:: with SMTP id 33-v6mr4007583plc.309.1526541069921;
        Thu, 17 May 2018 00:11:09 -0700 (PDT)
Received: from [192.168.206.100] ([117.249.233.154])
        by smtp.gmail.com with ESMTPSA id i69-v6sm8724106pfk.84.2018.05.17.00.11.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 May 2018 00:11:08 -0700 (PDT)
Subject: Re: [GSoC] A blog about 'git stash' project
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <67e6d306-0885-9340-13c8-3e3d4333dc20@gmail.com>
 <ef15b063-c0e3-a5e9-7418-35d2d6b954f3@gmail.com>
 <e8a81d38-57d7-2974-b5c7-3489e8ceb1fc@gmail.com>
 <68b913de-8f4a-9203-1d63-32104a35628b@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kaartic.sivaraam@gmail.com; prefer-encrypt=mutual; keydata=
 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
 IZ7P/DJ/
Message-ID: <be353b0e-1cba-3765-b920-f7307f9b7d40@gmail.com>
Date:   Thu, 17 May 2018 12:41:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <68b913de-8f4a-9203-1d63-32104a35628b@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="A8Fdm9mkqP5Lf0RlGN1HIRaOBsGFdAnos"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--A8Fdm9mkqP5Lf0RlGN1HIRaOBsGFdAnos
Content-Type: multipart/mixed; boundary="PZESzqneCYdSd4zWSm3lzA49QYHamSBxZ";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
 Git Mailing List <git@vger.kernel.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-ID: <be353b0e-1cba-3765-b920-f7307f9b7d40@gmail.com>
Subject: Re: [GSoC] A blog about 'git stash' project
References: <67e6d306-0885-9340-13c8-3e3d4333dc20@gmail.com>
 <ef15b063-c0e3-a5e9-7418-35d2d6b954f3@gmail.com>
 <e8a81d38-57d7-2974-b5c7-3489e8ceb1fc@gmail.com>
 <68b913de-8f4a-9203-1d63-32104a35628b@gmail.com>
In-Reply-To: <68b913de-8f4a-9203-1d63-32104a35628b@gmail.com>

--PZESzqneCYdSd4zWSm3lzA49QYHamSBxZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On Thursday 17 May 2018 12:28 PM, Kaartic Sivaraam wrote:
> Hi Sebi,
>=20
> I thought of pointing you to one of the issues with the current
> implementation of 'git stash' which you could probably fix while portin=
g
> it to C.
>
> ...
>=20

Forgot to mention about another issue, which I consider to be a bug. I
have elaborated about it in the following mailing list email.

	https://public-inbox.org/git/aa43f1ff-9095-fb4d-43bc-bf8283b7dabb@gmail.=
com/

Unfortunately, it didn't receive any replies. See, if you could do
something about it.


--=20
Sivaraam

QUOTE:

=E2=80=9CThe most valuable person on any team is the person who makes eve=
ryone
else on the team more valuable, not the person who knows the most.=E2=80=9D=


      - John Sonmez


Sivaraam?

You possibly might have noticed that my signature recently changed from
'Kaartic' to 'Sivaraam' both of which are parts of my name. I find the
new signature to be better for several reasons one of which is that the
former signature has a lot of ambiguities in the place I live as it is a
common name (NOTE: it's not a common spelling, just a common name). So,
I switched signatures before it's too late.

That said, I won't mind you calling me 'Kaartic' if you like it [of
course ;-)]. You can always call me using either of the names.


KIND NOTE TO THE NATIVE ENGLISH SPEAKER:

As I'm not a native English speaker myself, there might be mistaeks in
my usage of English. I apologise for any mistakes that I make.

It would be "helpful" if you take the time to point out the mistakes.

It would be "super helpful" if you could provide suggestions about how
to correct those mistakes.

Thanks in advance!


--PZESzqneCYdSd4zWSm3lzA49QYHamSBxZ--

--A8Fdm9mkqP5Lf0RlGN1HIRaOBsGFdAnos
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlr9KwYACgkQveda2sPW
GWn15A/7BPNxMdwyqi7MdNzRHVH61G/e1ky90xDWJV5JQxkOZagRinFoAdxFflJo
MEJG2vnveaIC5xcLvLPor51Xkx+A5gkc9WekMwsQYivTIjDxYUUsy50I11x9ApYS
s0zO/jHLuoH6morw5WcIhDnIdEKcDpHsuOIjGU8ku0tbjAPyZpktoHYQPrysfsNA
qVx4gIlqpJdvyg5p9pWTKtb7/N6OHjin5uaEC14wvjQbjktMA85PUwW6xPvRcVLV
pvUEmfNPErDlCCR0OYuksQ1uGLyFvBuPcLBaIAZ/zfMWu4D1wjN5uClcl3SEkIEZ
znvfEMeN26uhhKnywyfszWX32ucOvaufVGnuHfOsQjmvlr0eqAgjuLtRP1bdH73z
YwwWFdT8AbB7ZgzyRBSU0ozKU5WqJv3vdzT1WJyspGShtaMLb+C0YP3xhby+vNW6
rZn/BZ4lI4bhu4G+ZWEIGScdwhTctoE0sLkNIvbBQRfNYxm2e1vow87oc+ZKslKQ
LlbrBJW3KVQQjqZipYYj5Jm4Nf4EuNtBNZSxJcFmbw9RDkw8gnVQFxBo2OM42n6c
OOAeokKGzLJW5lK4BUZL5YwgORy/FWolf3BrmmBOItQr11n0+CQPbtLG8Q0ac41Q
R5qvf9gRefWbNtGvBpNYAWGbokmet2raXuVG7a5RpDX1zMg5mG4=
=Dkl7
-----END PGP SIGNATURE-----

--A8Fdm9mkqP5Lf0RlGN1HIRaOBsGFdAnos--
