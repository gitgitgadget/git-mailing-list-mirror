Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E355E1F403
	for <e@80x24.org>; Sun, 17 Jun 2018 08:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932891AbeFQIxj (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Jun 2018 04:53:39 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45362 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932478AbeFQIxg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jun 2018 04:53:36 -0400
Received: by mail-pg0-f67.google.com with SMTP id z1-v6so6196402pgv.12
        for <git@vger.kernel.org>; Sun, 17 Jun 2018 01:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=hpgW+iTa0GSXR3WCUI0SkeXruwWzVu8sYd6GZA/hC+I=;
        b=fprPJGGngcQsW8ANFyR5WGJCdn1Txr59P1QwkJ2nOLDZqRd3hBzOzlcNfSAz9nCLZS
         sXmmuT41pXNB1ZrAx2trPG6At3m7qiPvASzOkDieZPfxtLH55Xarr6h8Oa+hDPN4D3Nt
         AIiWRLB6mmaUTAlsIceo0LC9DzG6A9ofU/EW6jQoGt6VUtmDUtum4f7dSeLtSJ2uMcRX
         fZOuiSZoys48UDffgSBWyqYCto2SbGFlSb+lEOHQ+8lj/2ygBV5QFnwDf0VF4geyNAs+
         DzZSCkmnauBaRzGHe8GbXSscNeI4JVMcDyBXw1MKDyh00D+7zkvgq9aF9nUTQ1RUOz9W
         MKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=hpgW+iTa0GSXR3WCUI0SkeXruwWzVu8sYd6GZA/hC+I=;
        b=cHTZsbWzY390u/I9VJLh2ewrfvTFIBBXAOLUpjJNOjTfevbD2cLF7XqaahraZ+cj7s
         LCKzYrexUz7X+tBSOw15H8XUvyOnAhG4yCWCsY3xlPP1EYyw9AHZSHd95+jSD4H+Uiqc
         gQgeQL6zMtBLomo0zoqXIM0SCz7Fn9BBVChlKS373jCOLdZmjm17oHPzUU8Sjn8wACm3
         FKa2dWEEf/nQe0v5jG6fOMWXi65t+GP6QZd5xf0eLHMOa7pmypkKXznctMkGMkyrI+kG
         mBuc07I6W4XafvIP04hZm3T2JkehCYGwfxweGhrO8nAi4nLrXrtdpTvmU21mPzFx39j5
         MQyg==
X-Gm-Message-State: APt69E2RIran4UOB5hWg9fAX8HlkED0vYbAVLElZJI3cWciDX8SnpaC3
        O0X3m7ubQWBo3/2lPCFJYI0=
X-Google-Smtp-Source: ADUXVKJYQylhA6jO4tokX14HC/wIHcyqA4HcpYRLuybGlbdZ+8JW39ENOHsqzkUpzmFcgMxavexhlQ==
X-Received: by 2002:a63:24c4:: with SMTP id k187-v6mr7281251pgk.434.1529225615582;
        Sun, 17 Jun 2018 01:53:35 -0700 (PDT)
Received: from [192.168.206.102] ([117.246.87.93])
        by smtp.gmail.com with ESMTPSA id n10-v6sm22848811pfb.27.2018.06.17.01.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jun 2018 01:53:34 -0700 (PDT)
Subject: Re: [PATCH] t3200: clarify description of --set-upstream test
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        "Robert P . J . Day" <rpjday@crashcourse.ca>
References: <20180605112446.17016-1-szeder.dev@gmail.com>
 <20180614140641.13752-1-kaartic.sivaraam@gmail.com>
 <xmqqin6l461s.fsf@gitster-ct.c.googlers.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kaartic.sivaraam@gmail.com; prefer-encrypt=mutual; keydata=
 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
 IZ7P/DJ/
Message-ID: <d009c6e5-884c-cac0-3c36-110fad3e802d@gmail.com>
Date:   Sun, 17 Jun 2018 14:23:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqin6l461s.fsf@gitster-ct.c.googlers.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6UfHoCspangxoljlIU9UYD4lUjMFypgxA"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6UfHoCspangxoljlIU9UYD4lUjMFypgxA
Content-Type: multipart/mixed; boundary="SlglJHTaoId6NM6DTM6rz2yIkG3NRrJCN";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Git mailing list <git@vger.kernel.org>,
 =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
 "Robert P . J . Day" <rpjday@crashcourse.ca>
Message-ID: <d009c6e5-884c-cac0-3c36-110fad3e802d@gmail.com>
Subject: Re: [PATCH] t3200: clarify description of --set-upstream test
References: <20180605112446.17016-1-szeder.dev@gmail.com>
 <20180614140641.13752-1-kaartic.sivaraam@gmail.com>
 <xmqqin6l461s.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqin6l461s.fsf@gitster-ct.c.googlers.com>

--SlglJHTaoId6NM6DTM6rz2yIkG3NRrJCN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On Thursday 14 June 2018 11:13 PM, Junio C Hamano wrote:
> It is technically correct to call --set-upstream "unsupported", but
> the reason why we want to see it fail is not because it is
> unsupported, but because we actively interfere with the usual
> "unique prefix" logic parse-options API gives its users and make it
> not to trigger the longer-and-unique --set-upstream-to logic.
>=20

That sounds right.


>> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
>> index 6c0b7ea4a..d14de82ba 100755
>> --- a/t/t3200-branch.sh
>> +++ b/t/t3200-branch.sh
>> @@ -884,7 +884,7 @@ test_expect_success 'test --unset-upstream on a pa=
rticular branch' '
>>  	test_must_fail git config branch.my14.merge
>>  '
>> =20
>> -test_expect_success '--set-upstream fails' '
>> +test_expect_success 'unsupported option --set-upstream fails' '
>=20
> In other words, I am wondering if s/unsupported/disabled/ makes it
> even more clear what is going on here.
>

I guess it would :-) Thanks for the better wording. I actually thought
of asking for a better wording for the test message while sending the
patch but somehow forgot to mention it. It seems I've got better
wordings, regardless.

I'll send a v2 with the correction. I'm still open to an alternative
test description in case that make things even more clearer :-)


Thanks,
Sivaraam

QUOTE:

=E2=80=9CThe three principal virtues of a programmer are Laziness, Impati=
ence,
and Hubris.=E2=80=9D

	- Camel book

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


--SlglJHTaoId6NM6DTM6rz2yIkG3NRrJCN--

--6UfHoCspangxoljlIU9UYD4lUjMFypgxA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlsmIYcACgkQveda2sPW
GWlZDA//cF1/mB9IxyiCUIQPYw5jDy1sxXCtI3sJYwDpATC4loFKUxPKfBgHFFMZ
meKZ9s2ckneW7+dK3UqAN3zmos8cfzinSlBNvMhycYqIeKVJU0ex8rkwySxdW+7B
TK8eKFsjcbrIFywlH1i30IwexxXZrcy4iRfnqcbXmWxSZFgnFene6tn0TO2rCMPM
i0cY/+A7kr8XMn5TZFpQDm7+xYeae3vYD/STHN7Ne1eidLHYbqb2NmxFUeE7j2Yd
Yvqi+v1euvqdmxFERFrpXFZ+ZXGVd8DjPq9VBw9IKgGoyIkMNTuCUjl6Dsrw2i3q
aN/pKxuOWtdJrhGJBZT8ebjRtXX0jIobVBIqK0/EopuqDUBIkRhKzWbgfHJ3MrHu
GEUBIrXtUN7TGjEymRNIRUDtDmuEocqTAIdSn343pcUi8s60ODimxOXzcOaRuyLA
NornPkj1s1Lo3t3YwQom9cH5Q3CdlibO2aPF+bBhQAhqigx9rJC8shWcTq3hXriW
uR3/U3zzIlJNTcfpcgpIDPPgfIPuQT0EIxfHOiU4yiBGrCziI4o8ZXO+WRkh9n34
EOswO5SfWkScF+xo8otR7QywacdJV29qAjvWoNUPETHkbh1aML++vNaxEVbWOCSE
KPq58nhSNx3t5NprAxke+tWD4MmBvl+N4fHhadMj2kWiAaiQ5sc=
=YrZZ
-----END PGP SIGNATURE-----

--6UfHoCspangxoljlIU9UYD4lUjMFypgxA--
