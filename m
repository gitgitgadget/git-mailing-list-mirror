Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 606C51F406
	for <e@80x24.org>; Tue,  9 Jan 2018 19:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935466AbeAITag (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 14:30:36 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:46651 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933868AbeAITaf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 14:30:35 -0500
Received: by mail-pg0-f43.google.com with SMTP id r2so8656601pgq.13
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 11:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=S1jj+LZ/bBGKTll+VUSe2gkDWQceC9l6n2NWY/rFflU=;
        b=L7jlXGuTQPszLvqpaWyPjqknHpcG2jBp//GYIXAVFyl490/uQfmyhS6VV3BxsJvNBJ
         /FWLhlcay4iiiKdBNb8OuNIDNeQ7L1ol+7v9BFPDzlT41i2S/IcCPQd1DDd43Ex7+9Tq
         DpBWXHTGsz3WdtI14sq0pp7bJ2Dyunc80gTY5cVZpjk9k2tX5RXS0y9tkLSPY0gfDAIY
         jCTCbf/zo27S1Tf3hHtDvtUxZj+L7f17A0H/7Skpul6+Ko2D3wpjWlz1OtTKFPo39FU9
         euS32jNc/gI2qwCWBI3bewkBXcUVnK2BPUj7oBFSxligXhm233FbHlX0BF0RFlx3YIXY
         ZG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=S1jj+LZ/bBGKTll+VUSe2gkDWQceC9l6n2NWY/rFflU=;
        b=rxnxOSs5m25oAgepI8NZlgqorCRqgKlC+jNi+VuaXuEhK9P16L+HJI8N3JDc4EYD/j
         Mw5zpS3EIyNUp+B5sM/8eWYTOH0+h1mOQQFikjNOXiyxUHMamSGUuTTo6BIIoJCfGf0q
         93IIj5LNoSZrgajORv/2A3QYvDssZgLY4kqMvq+1UPGI4fuY7sL2ksQsJDQr8FTaLSzT
         XNZEQ20AjPLLV5O8m2gehzpgPDhh4WiRmH98NvuRCVG9mnM3yIu068hYwgHCMcp4gAQP
         e0uCFK41TNHDu5qGQwCt3z40BMlZNeDy67u1v+PWAYSZrG+UAMt8n6pwZsrtgZg8151j
         APEA==
X-Gm-Message-State: AKGB3mIZKWHqJZgQddAzw0PMaZW/PL/xdfsTuvZpcripu5dp5v5QeUYX
        sks0IgqpCJVHU/U3ISdtptknxX4C
X-Google-Smtp-Source: ACJfBotG8l+03/afamyMGERMFYkFqR22JD8JJzCHxJUczMYUtO0WqPn593ZPAx8jnGy8TLBzHZyfFA==
X-Received: by 10.159.207.135 with SMTP id z7mr16255638plo.395.1515526235015;
        Tue, 09 Jan 2018 11:30:35 -0800 (PST)
Received: from [192.168.206.100] ([117.209.190.40])
        by smtp.gmail.com with ESMTPSA id k12sm27113737pgc.29.2018.01.09.11.30.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jan 2018 11:30:33 -0800 (PST)
Subject: Re: [PATCH 3/8] Doc/gitsubmodules: specify how submodules help in
 reduced size
To:     Stefan Beller <sbeller@google.com>
Cc:     Git mailing list <git@vger.kernel.org>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
 <20180106184614.20115-4-kaartic.sivaraam@gmail.com>
 <CAGZ79kYrp_DAaiDzpiWbTSvsfud=JHSO+NX3UaC4osAE3dYmmQ@mail.gmail.com>
 <3d85256e-4f19-b9d6-323a-d683dbfd8cf7@gmail.com>
 <CAGZ79kZkM1jEg4qcTz9CCkOzUx-PX5BOyeprWOht6_hNfYvkjg@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <e1d93f61-b58e-4155-1431-56e51c69b29d@gmail.com>
Date:   Wed, 10 Jan 2018 01:00:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZkM1jEg4qcTz9CCkOzUx-PX5BOyeprWOht6_hNfYvkjg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PT1QFFRShChfy8BJd4A7Zn3c0r7OWIOYv"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PT1QFFRShChfy8BJd4A7Zn3c0r7OWIOYv
Content-Type: multipart/mixed; boundary="GhBNIpeG9IYGgb4tqpasaiWy7IaBBBNCI";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Stefan Beller <sbeller@google.com>
Cc: Git mailing list <git@vger.kernel.org>
Message-ID: <e1d93f61-b58e-4155-1431-56e51c69b29d@gmail.com>
Subject: Re: [PATCH 3/8] Doc/gitsubmodules: specify how submodules help in
 reduced size
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
 <20180106184614.20115-4-kaartic.sivaraam@gmail.com>
 <CAGZ79kYrp_DAaiDzpiWbTSvsfud=JHSO+NX3UaC4osAE3dYmmQ@mail.gmail.com>
 <3d85256e-4f19-b9d6-323a-d683dbfd8cf7@gmail.com>
 <CAGZ79kZkM1jEg4qcTz9CCkOzUx-PX5BOyeprWOht6_hNfYvkjg@mail.gmail.com>
In-Reply-To: <CAGZ79kZkM1jEg4qcTz9CCkOzUx-PX5BOyeprWOht6_hNfYvkjg@mail.gmail.com>

--GhBNIpeG9IYGgb4tqpasaiWy7IaBBBNCI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On Wednesday 10 January 2018 12:31 AM, Stefan Beller wrote:
> On Tue, Jan 9, 2018 at 8:01 AM, Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
>> On Tuesday 09 January 2018 12:08 AM, Stefan Beller wrote:
>>>> diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubm=
odules.txt
>>>> index cb795c6b6..3f73983d5 100644
>>>> --- a/Documentation/gitsubmodules.txt
>>>> +++ b/Documentation/gitsubmodules.txt
>>>> @@ -63,6 +63,9 @@ Submodules can be used for at least two different =
use cases:
>>>>      * Transfer size:
>>>>        In its current form Git requires the whole working tree prese=
nt. It
>>>>        does not allow partial trees to be transferred in fetch or cl=
one.
>>>> +      If you have your project as multiple repositories tied togeth=
er as
>>>> +      submodules in a superproject, you can avoid fetching the work=
ing
>>>> +      trees of the repositories you are not interested in.
>>>
>>> You do not fetch a working tree, but a whole repository?
>>>
>>
>> Maybe I misunderstood submodules when I wrote that example. Could you
>> help out with a better and precise replacement?
>=20
> If your project consists of multiple repositories tied together, some s=
ubmodules
> may not be of interest for all users, who do not need to fetch such sub=
module
> repositories.
>=20

OK, now I get why I couldn't get your point. I actually was thinking of
the version of the message I had tweaked for v2 when reading your
message. It doesn't have the confusing meaning. It actually reads,

   ...
   If the project you work on consists of multiple repositories tied
   together as submodules in a superproject, you can avoid fetching the
   working trees of the repositories you are not interested in.

So, my version takes the perspective of the person who gains the
advantage of having to clone unnecessary repos. And yours, the
perspective of the person who gives the consumer of the repo that
advantage. Both sound nice to me. But if mine doesn't sound nice to you,
let me know so that I could replace it with your version.


>> Just putting in some context as to why I did this change, I thought th=
is
>> was the only thing that lacked an example and wanted to make it consis=
tent.
>=20
> Oh, sure I like the example; I was just worried about the wording, as a=
 worktree
> is part of a repository, and the repository is the whole thing. In the
> current situation
> you can only fetch all-or-nothing, specifically you cannot fetch "just
> the worktree"
> (a shallow clone/fetch is the closest to that, but that still has the
> same amount of
> information the .git dir, than in the working tree)
>=20

I get that!


--GhBNIpeG9IYGgb4tqpasaiWy7IaBBBNCI--

--PT1QFFRShChfy8BJd4A7Zn3c0r7OWIOYv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCAA5FiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlpVGFUbHGthYXJ0aWMu
c2l2YXJhYW1AZ21haWwuY29tAAoJEL3nWtrD1hlpMxYP/RkJfs0eKNJwWGdc7Nyq
IyUJJE40o3wgCqDNF3yS17bWOTKuhV/HQTBqdu+FyTSAJHqFrEL5B/5YMmF7zcLy
0IITZwDWgDw8xQZgNvdptaog/2CvHPRYc+Leq830K/LLzEBRInjeiydUrQw5f2Hi
6d0GUOqyVP6klHo5Zo10+j6gFc9v7AqnWpUpxLrF0+PZ1BuyL0cxprJUocgPAEIL
WYfOasaAjSJe+IjYwNnFx0KcmbDIDRMFRgnv4I/i8Fhy4oGpgO9iKnYosrRnD95p
s4uJeIvLEcNGHXRQvdVysh+dyiD5vFmNfgW/4WWWyyYBb5EUyVUvV9gKeqPizreh
ZDcb4IRLQ8rTGFQO93V/+ePOheOKhFvJSZ6PVJP5+BBXQlcJbWPVIb/2gGkk/Unk
0nj25YfFzYb01JM5Iv87sjNrghvMWsukVse0HEZHY+FN6dsTKoVJALAsbRiwdyye
qRPstEVVdf0CYr6mjlG1stQLvfStcTxxpwwdFvpLp6J9kcV3IPZFIP1AlLITVTpC
4tWrjIpzTurG3cljeHvXNQa+MYyySFuUh+F4S0+i8L/tmIRPfyvU1CWucKey8z/O
VXNIKOnGawp2BJbJP2hPfyfKOb1dUy8a5YPYujkbRwuUzqQ74T1HFN+0oEdj9Di6
XI6MJPtr0Ci5CCkEsihjR9Lj
=VX5S
-----END PGP SIGNATURE-----

--PT1QFFRShChfy8BJd4A7Zn3c0r7OWIOYv--
