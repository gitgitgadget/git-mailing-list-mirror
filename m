Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 459D31F406
	for <e@80x24.org>; Tue,  9 Jan 2018 19:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935471AbeAITcO (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 14:32:14 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:40559 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933771AbeAITcO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 14:32:14 -0500
Received: by mail-pg0-f44.google.com with SMTP id q12so8659755pgt.7
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 11:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=YldzVCMSg9+4Gv867q9hJOKo3GhTLst1IhH6V6QDuKE=;
        b=JsWdqs7P2P/EwRfVIhhLXDe534/ij/9anlPTfBlUwh8eySXBPR2IB9l9Eoa6WgqeLe
         LpmbDmDm1zwO6vLhKIHfJ4999KtB9Xl+QoVEIw66JUGzYcX3Zr+MKu6n2Rqk1EojnY7Z
         nxN9rdYNNpcV4GK74cgKFaRGv/SWBUYGXSQA71hsYTBx+fsWS1Aay8A8vhJcv0UHhgfM
         qypLsPQLynwSeK2hxtkWdAb+x2doRqvQ/jCVLPFygbX78V+fQtSN5pzIJXgQKfazZITN
         I/Cr0ccUMFGXR1MqXn6RrhXORd1hPFkII1ZeoHAMnKi7mIzAaV5kK/QNca7VMLzIW8ix
         AjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=YldzVCMSg9+4Gv867q9hJOKo3GhTLst1IhH6V6QDuKE=;
        b=VaVEMPeRX45VHHmH5bxwTMgNDo3wdvG9TT0hc+U+ggzexE5i4SMk60KCXoHtk0MGyl
         rXc9HNTJbPFaso9SqXCM+ZdlGMGe5p7i+tTG+8v/LQT/3efuaTuPbh90ub+smfobG6qc
         zhG9lklRZamn1d5V6i2YgiDn9zG/SyjAps3pgjNNIDkcI7J/cbXDctPD1d0TaX39hmBQ
         /7L6/ydSpwvYPQHIIAKsNKo8Z6OHv4X7HOnSALEghnOkIIArXMTAPhOPZLEC3l6xCR0z
         Xy7Vcx9xUSTGYyPFL6wKg1ntz5GOfOHlfvGcdC7ODFk7U1t92AYKVkqA2GQje02tz0+A
         769A==
X-Gm-Message-State: AKGB3mKm9U1MxVLanmPjU6EpnAjgQdo4FefljPQOAIaVROGp5NO40qY0
        +PVHjYbbVi46w+mKYJ889hB2swb6
X-Google-Smtp-Source: ACJfBot79SY4tMqmgV/1MGfUi3P6vjIUlzzaJkipMA6GyMQ7wxuvwW9dnEqGX2JZ6FDx6LL4Rb+LGw==
X-Received: by 10.98.16.132 with SMTP id 4mr7458626pfq.42.1515526333243;
        Tue, 09 Jan 2018 11:32:13 -0800 (PST)
Received: from [192.168.206.100] ([117.209.190.40])
        by smtp.gmail.com with ESMTPSA id e190sm30436392pfe.15.2018.01.09.11.32.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jan 2018 11:32:12 -0800 (PST)
Subject: Re: [PATCH 4/8] Doc/gitsubmodules: avoid abbreviations
To:     Stefan Beller <sbeller@google.com>
Cc:     Git mailing list <git@vger.kernel.org>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
 <20180106184614.20115-5-kaartic.sivaraam@gmail.com>
 <CAGZ79kZZf=zSfqFr9EV_Q408mG4cHTEQSOAMC7n_35oKgHJp2A@mail.gmail.com>
 <b59bd56a-f88b-a65a-263f-2b6d2f57dd99@gmail.com>
 <CAGZ79kZKMKZGWSvPMPHWJ9SeNQSegeiZ3SvMtK+gEYp1dFxYyA@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <0236169c-daa8-c3ed-ab2e-27a7d7d88328@gmail.com>
Date:   Wed, 10 Jan 2018 01:02:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZKMKZGWSvPMPHWJ9SeNQSegeiZ3SvMtK+gEYp1dFxYyA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ipUE8KTNdAD6HlMbJBbqLAhehM9P0xnoL"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ipUE8KTNdAD6HlMbJBbqLAhehM9P0xnoL
Content-Type: multipart/mixed; boundary="oTjZ8CSa9PJItdowGbOsTHopQ51eddUsy";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Stefan Beller <sbeller@google.com>
Cc: Git mailing list <git@vger.kernel.org>
Message-ID: <0236169c-daa8-c3ed-ab2e-27a7d7d88328@gmail.com>
Subject: Re: [PATCH 4/8] Doc/gitsubmodules: avoid abbreviations
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
 <20180106184614.20115-5-kaartic.sivaraam@gmail.com>
 <CAGZ79kZZf=zSfqFr9EV_Q408mG4cHTEQSOAMC7n_35oKgHJp2A@mail.gmail.com>
 <b59bd56a-f88b-a65a-263f-2b6d2f57dd99@gmail.com>
 <CAGZ79kZKMKZGWSvPMPHWJ9SeNQSegeiZ3SvMtK+gEYp1dFxYyA@mail.gmail.com>
In-Reply-To: <CAGZ79kZKMKZGWSvPMPHWJ9SeNQSegeiZ3SvMtK+gEYp1dFxYyA@mail.gmail.com>

--oTjZ8CSa9PJItdowGbOsTHopQ51eddUsy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On Wednesday 10 January 2018 12:56 AM, Stefan Beller wrote:
> On Tue, Jan 9, 2018 at 8:06 AM, Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
>> On Tuesday 09 January 2018 12:15 AM, Stefan Beller wrote:
>>>>
>>>> - * The command line for those commands that support taking submodul=
e specs.
>>>
>>> ++ The command line for those commands that support taking submodules=

>>> as part of their pathspecs[1].
>>> ++
>>> ++[1] pathspec is an official term according to `man gitglossary`.
>>>
>>> Maybe?
>>>
>>
>> Yeah, I actually did think 'specification' wasn't a the best fit for
>> this (should have mentioned that somewhere) Now, the real term came ou=
t :)
>>
>> Just to be sure, that "[1] pathspec ..." part goes to the end of the
>> document doesn't it?
>=20
> The [1] part was just to highlight it for the sake of this discussion;
> I would not include it into the man page.
>=20

That '++' before it made me think otherwise :)


--oTjZ8CSa9PJItdowGbOsTHopQ51eddUsy--

--ipUE8KTNdAD6HlMbJBbqLAhehM9P0xnoL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJOBAEBCAA5FiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlpVGLcbHGthYXJ0aWMu
c2l2YXJhYW1AZ21haWwuY29tAAoJEL3nWtrD1hlpy80P+InxSzu2PT0P/f9zPMj2
OQdQiG2xt4UItQcW7A/Ph3c9vA0nZ8PtHOuMBiJ0A0LEzWP31v5TsR7H5/+CS2FM
InosMm+pCKDwW0XnMM0EuzczMzfafMlwjPjhs+l4BVTsrBYafSTKML0OVvb235gS
1e5JUuEN0fSz54pe3yRKnKq3OfuzvN3fltdnfqooWi/ekKEuGOfx/Uq37MElwgYs
lbb+gBlKGpCv8S6dfS7oUGSZPISFOqigq43XHuYehBp1p3KnNEbj6AkAKWygt10i
Dd5x2bS2zOpuitl5bQa4EEFcZnPL/BNjIwUW7c21v26/A1I0tHbyfBqU5eI07o20
nQd7UCcCh2TAy9DnJi3ADhqz1lvH09Tr0ILqDyMizoYdXt+8x6ZLlnQ6vFYgqoSl
lkS4vsSjMS/6CyEnvsYSISMoEorIBPIZ6vx7B27UnDaD/rzYRpkaK74YV7Zi2GLI
CcLjzRx7KO+jH2jiFdIwl5CNdUuMEjdpHaVGzkvuUuhMWT8kmRwChME9g22SSfKb
2hYckhQZdIpfGVMdzyZZstc843eeAIeoohqzYbFFiTtw4YL6uw86jWoITJURHL1W
+VXRxLvxtHvfIqhaftcE4fIUlpEgGe0wEyyDxjc8wh/wwgBxbZ5DIJS+4qiadHEM
rpWjLWlHYj3Htw1dhh90o/c=
=RSN5
-----END PGP SIGNATURE-----

--ipUE8KTNdAD6HlMbJBbqLAhehM9P0xnoL--
