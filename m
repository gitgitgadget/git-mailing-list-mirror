Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E8341F404
	for <e@80x24.org>; Mon,  9 Apr 2018 17:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752202AbeDIR6B (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 13:58:01 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:36358 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751549AbeDIR6A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 13:58:00 -0400
Received: by mail-io0-f170.google.com with SMTP id o4so10657889iod.3
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 10:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=ZMVvJQxipEUr1YOC8RWDjIkPMeapXBogotjvFdHYhIs=;
        b=YCGgKbjTjL8q8uauRA9UwVdCkm6CgUwxuQYcrAsKULpqs1zbxNRo5YGMa3HYgyHlcc
         LPuKKU2PLkuBvzOx4BiciCM5Hjgx2i4uP1RwlFcHt6DZDSnAiLAYnrqfNqefan7VkF++
         ktMoeDJQ5nX8AUFZAek93OJVs8b0z4TaUSYkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=ZMVvJQxipEUr1YOC8RWDjIkPMeapXBogotjvFdHYhIs=;
        b=HobiAYXYeMu58R/pzl4E4A/naEqaINWRWCgBPmr06Odqs+AmtKqNW1/X5S23mucqsi
         a4cvIecHq47QXv3FhXjV1FRHEgapNwuBWuCY1aDvx/SCly0QNyIInWoG0k4fl5hd522q
         pJ5U4IZe5McMWAnqyehqRLJfrU7ISpCwQIF48K0JGZu46rDMlU1xehCRLu6JKhfc1l4U
         q0rBBhBVDGC8ah46XO2ab8CMpispr45x5b+YnFmD8VdBqhBKcDDmbkMFkIj6wInkUFdW
         LAtfjOo3WrL/iZ/A3NrwB3R2Rvs2+MDEPt4tnU3sJZQEyR/9b/IZUbhnQOaUZ5J30wOw
         T+TA==
X-Gm-Message-State: ALQs6tCXhry7wfBLWFPo8wJhisAszOo9hqjDlGS8MSGK6sHN6fsP75/7
        /Y8LmVaZekrOHCCbuTk0/9+C33TGHkA=
X-Google-Smtp-Source: AIpwx4+/80ht/2CRgQrBv0DSCg9NgIS1nEMVbhWwTI/rH+6Rm/Hn+nD3kYwvW5yaTzJUfa2oJdUYyg==
X-Received: by 10.107.173.230 with SMTP id m99mr22318037ioo.121.1523296679283;
        Mon, 09 Apr 2018 10:57:59 -0700 (PDT)
Received: from [10.137.0.22] ([184.75.214.131])
        by smtp.gmail.com with ESMTPSA id s128-v6sm690422itb.39.2018.04.09.10.57.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Apr 2018 10:57:58 -0700 (PDT)
Subject: Re: Is offloading to GPU a worthwhile feature?
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     git@vger.kernel.org
References: <efc4af6b-53c9-bd02-65f6-9de517f6868e@linuxfoundation.org>
 <86k1thdck7.fsf@gmail.com>
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Organization: The Linux Foundation
Message-ID: <57c33d0a-458e-f591-164d-33f8257d3972@linuxfoundation.org>
Date:   Mon, 9 Apr 2018 13:57:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <86k1thdck7.fsf@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VfQTfxtYL7JtZuhnCSsmoJLd6UddnqG7P"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VfQTfxtYL7JtZuhnCSsmoJLd6UddnqG7P
Content-Type: multipart/mixed; boundary="88mSN6Slxqow0Z2OXlYu5at7heUqEuA66";
 protected-headers="v1"
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Jakub Narebski <jnareb@gmail.com>
Cc: git@vger.kernel.org
Message-ID: <57c33d0a-458e-f591-164d-33f8257d3972@linuxfoundation.org>
Subject: Re: Is offloading to GPU a worthwhile feature?
References: <efc4af6b-53c9-bd02-65f6-9de517f6868e@linuxfoundation.org>
 <86k1thdck7.fsf@gmail.com>
In-Reply-To: <86k1thdck7.fsf@gmail.com>

--88mSN6Slxqow0Z2OXlYu5at7heUqEuA66
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable

On 04/08/18 09:59, Jakub Narebski wrote:
>> This is an entirely idle pondering kind of question, but I wanted to
>> ask. I recently discovered that some edge providers are starting to
>> offer systems with GPU cards in them -- primarily for clients that nee=
d
>> to provide streaming video content, I guess. As someone who needs to r=
un
>> a distributed network of edge nodes for a fairly popular git server, I=

>> wondered if git could at all benefit from utilizing a GPU card for
>> something like delta calculations or compression offload, or if benefi=
ts
>> would be negligible.
>=20
> The problem is that you need to transfer the data from the main memory
> (host memory) geared towards low-latency thanks to cache hierarchy, to
> the GPU memory (device memory) geared towards bandwidth and parallel
> access, and back again.  So to make sense the time for copying data plu=
s
> the time to perform calculations on GPU (and not all kinds of
> computations can be speed up on GPU -- you need fine-grained massively
> data-parallel task) must be less than time to perform calculations on
> CPU (with multi-threading).

Would something like this be well-suited for tasks like routine fsck,
repacking and bitmap generation? That's the kind of workloads I was
imagining it would be most well-suited for.

> Also you would need to keep non-GPU and GPGPU code in sync.  Some parts=

> of code do not change much; and there also solutions to generate dual
> code from one source.
>=20
> Still, it might be good idea,

I'm still totally the wrong person to be implementing this, but I do
have access to Packet.net's edge systems which carry powerful GPUs for
projects that might be needing these for video streaming services. It
seems a shame to have them sitting idle if I can offload some of the
RAM- and CPU-hungry tasks like repacking to be running there.

Best,
--=20
Konstantin Ryabitsev
Director, IT Infrastructure Security
The Linux Foundation


--88mSN6Slxqow0Z2OXlYu5at7heUqEuA66--

--VfQTfxtYL7JtZuhnCSsmoJLd6UddnqG7P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQR2vl2yUnHhSB5njDW2xBzjVmSZbAUCWsupowAKCRC2xBzjVmSZ
bPLzAP9q31T/aRiYWbKcGWKThOVe63KN1yzQ8jFGPDYI1N3e3wEAkRoOuNauiwA9
vbNw8Ig1JYGxaBvv4qVCh7KLMPaPtAI=
=h2Yn
-----END PGP SIGNATURE-----

--VfQTfxtYL7JtZuhnCSsmoJLd6UddnqG7P--
