Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEE161F406
	for <e@80x24.org>; Tue,  9 Jan 2018 19:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759624AbeAIT5s (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 14:57:48 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36865 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754326AbeAIT5r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 14:57:47 -0500
Received: by mail-pg0-f49.google.com with SMTP id z17so2772192pgc.4
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 11:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=16QMtrBrnMKPeKekuGtWO04nbbxfGjTM3YjOkBO+R+k=;
        b=c0wfLy9Y2/tRQ0KmF6tbexfR3JFStl60WizsA6vP/GnmpHQfZAS6uKxD2jZH72OXN/
         92Zl/VfCu4WOQF+yiw2IwZ92EZlwJpPk44TgOGmLzviI6Xu0hxP/3egt4brekQKElsIo
         8gX8szRtohdA5d3isepOAc1KmwAiFBgCpij8if8rFB1UCW5zlfVbPJQGyp2hnNBZnaSr
         AkdWXKXftKyC61BEOctC6ntk2TZKuAGwihHf/am+bXoN6LP3S2PBhiFOKisqqYOvNzWg
         zwyxhYzSFphSc2qRDARbzyN2fD1hxurLU0nBCJoMqm8TX0IGdn4VEwodSvTkl8akezRD
         bksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=16QMtrBrnMKPeKekuGtWO04nbbxfGjTM3YjOkBO+R+k=;
        b=G4XhHCXYQuIu/rMY7d1G2Vrqh4vPOMRLjzxZRLmgpU1ZwtMfrqQ3M+0DuqHZC7jxwb
         oCvYL6OB8821pzk4thuWDYTazRSgeAKZLYo/O1GTF7a086sPbsmg4i1ymicmtV5QDvOL
         wRAynZwbVVI0NfF7Ea0esHwYsEpes4fqOCTXY2BiOgry/OMm8T49cKx9TgtoZs5L2Lnw
         heMTTIigLiUTlRj3lfmgL39q3Xaue8AIMGu63SsylCRs0QcrWZ9pmUdRsb/TnSfwKLyG
         o+XDlW+foH43baTqMIWP698w92mN7xRe1iBse9/rkO2WFAyww71eSNOqxC4TA9/ZTX7o
         dlJA==
X-Gm-Message-State: AKGB3mLbtORHqB+6rIOaL1W/5s+ByALtXWLjmdlGHV9CW2knST5HuxXp
        RTSpJToXBKI0/zo2IayE5Ty5dAty
X-Google-Smtp-Source: ACJfBosZahdF/4uDZFcuEJsxVBxrTAeCiTDDitibtxbYD82w6InuT2LdwQF+euE46HjYXzGVnn4RZQ==
X-Received: by 10.84.248.135 with SMTP id q7mr16256758pll.159.1515527866916;
        Tue, 09 Jan 2018 11:57:46 -0800 (PST)
Received: from [192.168.206.100] ([117.209.190.40])
        by smtp.gmail.com with ESMTPSA id 186sm16544453pgi.34.2018.01.09.11.57.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jan 2018 11:57:45 -0800 (PST)
Subject: Re: [PATCH 6/8] Doc/gitsubmodules: improve readability of certain
 lines
To:     Stefan Beller <sbeller@google.com>
Cc:     Git mailing list <git@vger.kernel.org>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
 <20180106184614.20115-7-kaartic.sivaraam@gmail.com>
 <CAGZ79kYPcx39VqWLAxRCQgO16=Yegq6XeCVUmX7shYomF6sz=g@mail.gmail.com>
 <f82949ed-5dbd-eab4-d917-8fe675b1c517@gmail.com>
 <CAGZ79kbQoLCodgR+JGXf_K1kS2Orjzp3W+7ZQBM0gX9je6d3Rg@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <f2753a3f-3e9c-b653-c29b-3399160c5e22@gmail.com>
Date:   Wed, 10 Jan 2018 01:27:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAGZ79kbQoLCodgR+JGXf_K1kS2Orjzp3W+7ZQBM0gX9je6d3Rg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OysdXfdaFXjENRVyQ7irylznj44ybOa98"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OysdXfdaFXjENRVyQ7irylznj44ybOa98
Content-Type: multipart/mixed; boundary="SHU98iFhXQHG5u9RehHw9tMKGdI1utSch";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Stefan Beller <sbeller@google.com>
Cc: Git mailing list <git@vger.kernel.org>
Message-ID: <f2753a3f-3e9c-b653-c29b-3399160c5e22@gmail.com>
Subject: Re: [PATCH 6/8] Doc/gitsubmodules: improve readability of certain
 lines
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
 <20180106184614.20115-7-kaartic.sivaraam@gmail.com>
 <CAGZ79kYPcx39VqWLAxRCQgO16=Yegq6XeCVUmX7shYomF6sz=g@mail.gmail.com>
 <f82949ed-5dbd-eab4-d917-8fe675b1c517@gmail.com>
 <CAGZ79kbQoLCodgR+JGXf_K1kS2Orjzp3W+7ZQBM0gX9je6d3Rg@mail.gmail.com>
In-Reply-To: <CAGZ79kbQoLCodgR+JGXf_K1kS2Orjzp3W+7ZQBM0gX9je6d3Rg@mail.gmail.com>

--SHU98iFhXQHG5u9RehHw9tMKGdI1utSch
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On Wednesday 10 January 2018 01:01 AM, Stefan Beller wrote:
>>>>  The submodule's `$GIT_DIR/config` file would come into play when ru=
nning
>>>>  `git push --recurse-submodules=3Dcheck` in the superproject, as thi=
s would
>>>> @@ -107,13 +108,13 @@ If the submodule is not yet initialized, then =
the configuration
>>>>  inside the submodule does not exist yet, so configuration where to
>>>>  obtain the submodule from is configured here for example.
>>>>
>>
>> I caught this in the context while replying. "so configuration where t=
o
>> obtain the submodule from is configured here for example." doesn't see=
m
>> to read well. Maybe removing configuration from the sentence will make=

>> it sound better?
>>

I'm going to make this change.


>>
>>>> - * the `.gitmodules` file inside the superproject. Additionally to =
the
>>>> -   required mapping between submodule's name and path, a project us=
ually
>>>> + * The `.gitmodules` file inside the superproject. Additionally, if=
 mapping
>>>> +   is required between a submodule's name and its path, a project u=
sually
>>>
>>> This changes meaning, originally it tries to say:
>>>
>>> * it requires mapping path <-> names.
>>
>> I get this ...
>>
>>> * but there can be more.
>>
>> ... but not this. Did the previous version really try to say this?
>> Anyways how does this sound?
>=20
> Well that was me being very sloppy trying to say that there might be
> submodule.<name>.{url, ignored, shallow} settings which just happen to
> be there.
>=20
>>   * The `.gitmodules` file inside the superproject. A project usually
>>     uses this file to suggest defaults for the upstream collection
>>     of repositories for the mapping that is required between a
>>     submodule's name and its path.
>>
>> I think it conveys the "it requires mapping path <-> names." correctly=

>> but doesn't convey the "but there can be more." part. I'm not sure how=

>> to get that into the sentence, correctly.
>=20
> I did not consider that part the important part, hence my sloppiness.
> Sorry for the confusion.
>=20
> My main point was to say that the mapping is the important part and
> must be found in the .gitmodules file, otherwise we do not consider
> it a submodule (for whatever "it" is, maybe a gitlink at a path=3Dname)=
=2E
>=20

So, I'm going to use the version that I specified above as I think it
seems to convey that clearly (at least to me),

    The `.gitmodules` file inside the superproject. A project usually
    uses this file to suggest defaults for the upstream collection
    of repositories for the mapping that is required between a
    submodule's name and its path.

Let me know, if there are issues.

Thanks,
Kaartic


--SHU98iFhXQHG5u9RehHw9tMKGdI1utSch--

--OysdXfdaFXjENRVyQ7irylznj44ybOa98
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCAA5FiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlpVHrAbHGthYXJ0aWMu
c2l2YXJhYW1AZ21haWwuY29tAAoJEL3nWtrD1hlpCdcP/2/Q5ko6LlQk5pZY6xcM
lbBJeWi5ajujgwnu1DVnbkx6woBBKiDo05BRG89JCeblZ54VcNbVLNZx5Xer7U+O
dZzEkRMetXQu0lOfLQ9L3EEGpRkQJqpyoSZF44vJ6gBHnV+MAZbWhDwBoTckLHpP
OnuvNatDnZ8/LJ1rA4JG7itL7/RGIhB7QE9TgELVSbMBQGKap2UI4HpKo/YmjgUo
qE7TUT7O5tfdWm09OeMcw0V0BzqXsaIoLsTsXC6emahGRQb/zgV3y3NrN5qrY60f
zpAVpbY7nCavC1j5ymjraWcC+CQ/3lH+TEJk5XuumMlOgl3ziGtx44ppmzYgbkz4
KtXXhePszjaO7YN2zjXP5Nx3TKfiMyDNWR5/aXN1uydejEKkNv+a2CwxUgrp4DH/
85n+AR0nlshl2AvMFVO1uZ6XaEbO43Jho95OivdnlGnFJUysPIa3c5PRZXkMkvoh
SALOPOyTf3s/as07aDDiSqZSozSvwotDMm2psZBpXs9xvH8rqXpsiAXkpGZKBeHf
xuq8ysIlFGZpN5uGrwzzFUAVqYW4Fm4yGOMenZHea26b8juHDU45+EkCQs6dRtb+
dk1qlOhBnqJYRO/cO2PUc8j3x1Cfs6A+H5Cj/gbHiBIMyNiWXMfBz2kP/dDBg5MX
TNlgLMU70j6s7f6kZtR75Oo1
=uVdZ
-----END PGP SIGNATURE-----

--OysdXfdaFXjENRVyQ7irylznj44ybOa98--
