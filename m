Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C10491F42D
	for <e@80x24.org>; Thu, 17 May 2018 10:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751839AbeEQK3O (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 06:29:14 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39453 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbeEQK3M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 06:29:12 -0400
Received: by mail-pf0-f194.google.com with SMTP id a22-v6so1885103pfn.6
        for <git@vger.kernel.org>; Thu, 17 May 2018 03:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=nWPOQ82jZO5Flc+/MqWObu/UUm6d7+4NbkuAtcaf9wU=;
        b=NNM771CyeF+onedH4Ur+Ob4NAtdS/erVak3tjpNc2/lVwL/66iM9k1Wfp8oZ9KHyiR
         5GnnDRiX2c4n8WTQahea96nzOhVuBBwfJssPZoxNf1jzqBlD+JaS2/G9aeTF7P6bR+ii
         MahJIRwJFX16O9TwIPcq/b8J6R+8uTRSzLux+MVzrt2AAv1MMESWvQ/L1A5n7sQtT1RD
         lhWq1LobizR775fGmqJBvrx1aJzgSPRhsHTKNYBGOHekTzDUh6BwKwRhaJbVRFUC2T5C
         jDADRCcSd5LbIcuyv3BTvevaYbdPGhxJwyE3W0k7vTUL/LSPQL5hVQdFflBSWOpzoO6q
         EZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=nWPOQ82jZO5Flc+/MqWObu/UUm6d7+4NbkuAtcaf9wU=;
        b=KrbH+6PUF6VG6XHpAas9hd2dE3po9OG7Dd9D6d4yV3HI3+49r3qyvqKLHYjtfPf9/Z
         aYn1cijA62PoHVOKurC5oH4zZRZNqWmDAoConHTzj6xlby0OWnrOvKKAMkj7Oi6N4T40
         mqcN4UsFbKoRRbt7/IFInHr70g+M58V1l+auC05odHK2C9lAX7EE8/Mm9hakv6wnWQE7
         qMNbbiqe3cXvqH6WdZh+M7me7SNtishObGlf+KdErpOvq7J0O/bejpvgijJ9TC06CQ5L
         HVaeM32mkEW9Ys1Yt+yB4BK7Lw10Ry0RoHv4T8SKZcmfwrqKPdupq2LUnawvipxJgZoP
         r22A==
X-Gm-Message-State: ALKqPwdzJxtS/7AD+gJidEJKZsVpMSf3+8qlui7LWzcUEy9bvBvFMtFx
        Sf2cHBe6pqyBE4I++SfTvssQw4p5
X-Google-Smtp-Source: AB8JxZoc5e25saGcTCBnyvWOElSsYuqJjzKj5R1/pNDdN+MnP1G0/05qvA21SJGNdNXyiVRBkTm2Mg==
X-Received: by 2002:a65:665a:: with SMTP id z26-v6mr1438748pgv.302.1526552951306;
        Thu, 17 May 2018 03:29:11 -0700 (PDT)
Received: from [192.168.206.100] ([117.246.69.1])
        by smtp.gmail.com with ESMTPSA id u14-v6sm10006579pfa.101.2018.05.17.03.29.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 May 2018 03:29:10 -0700 (PDT)
Subject: Re: [GSoC] A blog about 'git stash' project
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <67e6d306-0885-9340-13c8-3e3d4333dc20@gmail.com>
 <ef15b063-c0e3-a5e9-7418-35d2d6b954f3@gmail.com>
 <e8a81d38-57d7-2974-b5c7-3489e8ceb1fc@gmail.com>
 <68b913de-8f4a-9203-1d63-32104a35628b@gmail.com>
 <be353b0e-1cba-3765-b920-f7307f9b7d40@gmail.com>
 <nycvar.QRO.7.76.6.1805171106370.77@tvgsbejvaqbjf.bet>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kaartic.sivaraam@gmail.com; prefer-encrypt=mutual; keydata=
 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
 IZ7P/DJ/
Message-ID: <1729567e-3b95-ab37-d845-1980795542b0@gmail.com>
Date:   Thu, 17 May 2018 15:59:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1805171106370.77@tvgsbejvaqbjf.bet>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DvjBnpSiSfBt8fYUJeKYiinNW52vcMEkn"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DvjBnpSiSfBt8fYUJeKYiinNW52vcMEkn
Content-Type: multipart/mixed; boundary="uXGasJpoSXtozttroCemOA2KLIbRIbgHO";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
 Git Mailing List <git@vger.kernel.org>
Message-ID: <1729567e-3b95-ab37-d845-1980795542b0@gmail.com>
Subject: Re: [GSoC] A blog about 'git stash' project
References: <67e6d306-0885-9340-13c8-3e3d4333dc20@gmail.com>
 <ef15b063-c0e3-a5e9-7418-35d2d6b954f3@gmail.com>
 <e8a81d38-57d7-2974-b5c7-3489e8ceb1fc@gmail.com>
 <68b913de-8f4a-9203-1d63-32104a35628b@gmail.com>
 <be353b0e-1cba-3765-b920-f7307f9b7d40@gmail.com>
 <nycvar.QRO.7.76.6.1805171106370.77@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1805171106370.77@tvgsbejvaqbjf.bet>

--uXGasJpoSXtozttroCemOA2KLIbRIbgHO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On Thursday 17 May 2018 02:39 PM, Johannes Schindelin wrote:
> I have great empathy for the desire to see these bugs fixed. The
> conversion must come first, though, and in the interest of making it
> easier on me and other reviewers, I must insist on keeping the conversi=
on
> free of any changes, much in the way as we try to avoid evil merges (i.=
e.
> merge commits that introduce changes that were not present in any of th=
eir
> parents).
>=20

Of course, the conversion should be separate from the bug fixes :-)

When I mentioned "while porting it to C", I actually meant the "thought
process of creating a foundation for `git-stash` in C". I thought
hinting at some of the existing and unsolved `git-stash` bugs would
allow the person who would be doing the port of `git-stash` to C to
consider how to avoid this while implementing the basic foundation. I
should have been more explicit about this in my previous mails.


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


--uXGasJpoSXtozttroCemOA2KLIbRIbgHO--

--DvjBnpSiSfBt8fYUJeKYiinNW52vcMEkn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlr9WW4ACgkQveda2sPW
GWlHfw//USq4QHov0YUtD/Nkr20NGUA8AX0sbwaIZi8OhIL1N535zyCqA4bxKdIW
fYX8CBac1kpFBgTqOhnLnKEYCeJD2Eya80iqmJ8LhKlCwPxeWmNjiQHVTVTT4iZU
fa4HHTyEELdbCgZ1Z/J1JTL/mHLpvr16v30SiSaRibg8sP/fIxtLu5Pjr+kkylrc
l40v4KmK26kFefeWJ+Zs80D2TvBQCo4aa6FfeIX7iIJ9+mtQVFwjrJ4Ghwvi6aRu
6gcOBzn/3Ce6uLGmJ0LSq6dsUa0MHsAaJ64285Mz0b1Zr/U9mL3yh65WKLRlbbrc
xNnGt1VVE1G5paSB7P+5ITMFhaVIdFpant3Og0pHVpj3cQ8tacncqK4zrnzGN7DY
dmgYs9nXvXxRK60iW9ZNs38Vzz+pScRDkMDAD+6/N0NnvuFC2n0e7I/cOv9Aa5FK
cNhEu2ti1J6FVCltH6VkH4R66ABYFifVrCqR41NCnrsdx++WgRp0uZuU5ws5acNe
ebKHECbCWj3H+hXGVf4a+xrK6Ziu0yb9WlPRzZ0pOMD7ARMk8dsrhI1g+7Kel/nW
iv2Mk/0uxSNmZ/sqhzXlieL367d2acE/Bk9qMAPqPUyATrQ8qPP8aJRFBj80s9YV
2zsZWPWtK5NoJWi2Cxm2ctMywYnngj/hHawh6Ngtu89VRNILabo=
=Jwij
-----END PGP SIGNATURE-----

--DvjBnpSiSfBt8fYUJeKYiinNW52vcMEkn--
