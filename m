Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2806200B9
	for <e@80x24.org>; Tue,  8 May 2018 05:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753939AbeEHFFM (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 01:05:12 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:40820 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753848AbeEHFFG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 01:05:06 -0400
Received: by mail-pg0-f67.google.com with SMTP id l2-v6so20629609pgc.7
        for <git@vger.kernel.org>; Mon, 07 May 2018 22:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=n/1ZBJROTuZ/FmLF/+f6GGpEtkPx8HPKDBxVyPOV2W0=;
        b=sAqRe/DD6XtFh7AtkQ+AENOz9HfZhgf7gP/g7ucQHnALIp/Q1Lssr+kwsdeJLP90z1
         0pY8bY7dcUS26e2068zqNaUsGcmXObo24s56eLylfkA1iqJF8swFumwLZmpko5btlEtY
         rYCxPCgvEDkv2dLI5VTQvfGxb4buZ2xhw93YsHopo25m+QKDK6470oLe69fM/I60yjZk
         QzkMtBtjvGFs164r09unJw7hnKCpif0odSzInKH9zJFW2uJ09ixhujWeHLuKSAxUccyG
         GYKoLVu0QOVdrpLaQxDYhvZx++KSANXdRodTwbTmYMWxt54I12bRfTpADOJrZoCSlUcW
         QTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=n/1ZBJROTuZ/FmLF/+f6GGpEtkPx8HPKDBxVyPOV2W0=;
        b=eL7KVVARvj5hZLnb04g185cAhQV1RK129An4Fj8FmR1JY+vCxh2ASobDMBy5F2ogdb
         nZXIjWihbcodlEKhEQ5AatQbq54ydO9kvss2BK8N9SiSbjdBBCeO1hvrY3lRby+Fff1v
         Dzpk5/KNTiLE3WZumSzgyeHvYKE7PercnGtHMgR0SgRT6TSVSnt14FHElGYirrYdEqu+
         /hKZpLEyYOh2JdjX5obeAc6resKrhPG3oVf/lV9ye3LiabEJk7YDcgScWCng6pbMIEqI
         y+iD9jbv6kZAFFvk4PH7/yRK8MxGT6lfXKZW+rVhy4JVuF0uVrgy6Uz/21qmjl5DBafd
         quqg==
X-Gm-Message-State: ALQs6tBE1FdnhFVnLYSyxVr87mAOEPotPL83GfsIY+Z4hpHHDeQ0TONm
        oXcSV/HkzN+AE4p+CUK4ja27Vysv
X-Google-Smtp-Source: AB8JxZrfE9hmMVps6xtsoYxMCW9yOmA0GbOj6ipXSC1g/+b854/Jw5D83lkNOhTDzxmBqybZQdx3TQ==
X-Received: by 2002:a63:790e:: with SMTP id u14-v6mr32029772pgc.445.1525755905839;
        Mon, 07 May 2018 22:05:05 -0700 (PDT)
Received: from [192.168.206.100] ([117.243.25.220])
        by smtp.gmail.com with ESMTPSA id c28sm63063875pfe.27.2018.05.07.22.05.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 May 2018 22:05:03 -0700 (PDT)
Subject: Re: [PATCH v2] mailmap: update brian m. carlson's email address
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20180506232421.975789-1-sandals@crustytoothpaste.net>
 <20180508015845.268572-1-sandals@crustytoothpaste.net>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kaartic.sivaraam@gmail.com; prefer-encrypt=mutual; keydata=
 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
 IZ7P/DJ/
Message-ID: <184451b4-1b34-c1f7-f9b1-0dfa63ab9506@gmail.com>
Date:   Tue, 8 May 2018 10:34:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508015845.268572-1-sandals@crustytoothpaste.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wZ2qVbTa332xpn4sDOcayF8nOGrXoeHv1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wZ2qVbTa332xpn4sDOcayF8nOGrXoeHv1
Content-Type: multipart/mixed; boundary="ipeSsosZ9zliCNQQ6cqBZhvwo8sfgymTI";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-ID: <184451b4-1b34-c1f7-f9b1-0dfa63ab9506@gmail.com>
Subject: Re: [PATCH v2] mailmap: update brian m. carlson's email address
References: <20180506232421.975789-1-sandals@crustytoothpaste.net>
 <20180508015845.268572-1-sandals@crustytoothpaste.net>
In-Reply-To: <20180508015845.268572-1-sandals@crustytoothpaste.net>

--ipeSsosZ9zliCNQQ6cqBZhvwo8sfgymTI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On Tuesday 08 May 2018 07:28 AM, brian m. carlson wrote:
> An earlier change, cdb6b5ac (".mailmap: Combine more (name, email) to
> individual persons", 2013-08-12), noted that there were two name
> spellings and two email addresses and mapped the crustytoothpaste.net
> address to the crustytoothpaste.ath.cx address.  The latter is an older=
,
> obsolete address, while the former is current, so switch the order of
> the addresses so that git log displays the correct address.
>=20
Just to be sure, you're meaning the use of `git log --use-mailmap` when
you mean `git log` in the log message. Am I right? Or did you mean `git
shortlog` ?

I'm asking this because I think the `git log` output doesn't consider
the mailmap file by default.

--=20
Sivaraam

QUOTE:

=E2=80=9CThe most valuable person on any team is the person who makes eve=
ryone
else on the team more valuable, not the person who knows the most.=E2=80=9D=


      - Joel Spolsky


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


--ipeSsosZ9zliCNQQ6cqBZhvwo8sfgymTI--

--wZ2qVbTa332xpn4sDOcayF8nOGrXoeHv1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlrxL/oACgkQveda2sPW
GWkC7BAAjMKl8SPz5gqFpDOAiEEO72lt3k7mszTLGAQbc33oW3WE2+6h+kz8uT02
haE9Dfau0z6FRo0q1dRKGQkRlju5W1mD/1sXcluvKan4Bn/raSmbDGxAFxlQ85C9
/ZD7FWnLNLw3Yv61HaIoqeYWQk96akpZhrVk18tQ9ds2wDrPvx78U6fLHl4nU6Vh
m0J6RLyUNmccED5LfcTsYKdQRYhwzZuzVzi62YEXDw9SKut7UbqH16clbkYgAm9j
E83Ex2iXa0rgbjQI5Vur5O2hSVsTCAmVRkoMfGs1TkD+CGqBe/ww+HENLstH1icn
GAkI0NLlOS1EPdZdvvQCltqY+lib9HWURmxtO8fjlneWEtcQKGoUgsEtoyxQv24G
oXgKqmZlziYj8tGNZCQDRqj5zJ6fCPlDXkeJ6xG9xCr1h9XGC5YYpgkKnn+u2Ajn
VKfE6PaS4cggTxeM+hgLVcjn32d99paaJXNhD+ISAbW1d8PNXxgo21PoypwIokaD
U1+IDdItK7vpwJxFb4cV1wKNqVbD3mDfgGRWS9XYgPoAuGS7lRL+py/tOWNxq9WK
LNR/bR9FpDYEmyZ00eHSpY+jVRFfsq0c21HOH7VP3r/BAgvIXP7YwpXxNOXL60BF
5928fuzMNSGSVPwnpwNxTQxJTQJfbJr39xChf4YxHv5KaWKPzyc=
=AKPE
-----END PGP SIGNATURE-----

--wZ2qVbTa332xpn4sDOcayF8nOGrXoeHv1--
