Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 376BB1F406
	for <e@80x24.org>; Tue,  9 Jan 2018 16:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933819AbeAIQG7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 11:06:59 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:44744 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932898AbeAIQG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 11:06:56 -0500
Received: by mail-pg0-f43.google.com with SMTP id i5so8263515pgq.11
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 08:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=NI3wLkM65tffahr0ICwFzMnwObFdrC7M4ABDf14Co3c=;
        b=r+4bBCMif3aJcZZAysplY1NeeWFHDW54mQ4ah6JCpyeQGTN/chKN/Jt62Ko4Y3MOvY
         XoDNk47CYmGr8FaKDXhBqCYN0EhT913eAUB+I1oPqLb9L786H6zxAYIteirRKtgtStOm
         zKDxM/YJv4MR4flh4nuWsH+pVRWZ27J8pObHOkYiWa8/baJ4pmMfi62mEB9xWD+y80hj
         lq7+471G4jXTRgFfpMTnHkgYiQTiniQBkv6JXzLoucmyJ9jP8tOxqOA3jJIR6oDWvkSM
         YDMIsb7S3q/aawOBm18gdVd5xuOqjvJ0VDqBe+tEOoC6Ld2sgObAyvfAm7rkaMDhiJGD
         bbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=NI3wLkM65tffahr0ICwFzMnwObFdrC7M4ABDf14Co3c=;
        b=Ta5ZMxrGLE9kbTfYkMrNOkZorFvihoPeBxO3ReMIPhAstONAEypyJ26E+/BW6vMaTB
         +XXvCk4rV8ONdiY6qq5HswmvDTK9N1YUui2cqBokeIlouWEPCN0sAKbQ3F6/99utXwM8
         2ny7P/MqXB6dgjZMFiT5yfqBE6UYp9I4O1AhZ1OzgPv8RHzX9AUM+uOTututAOcFAXkR
         CspX01TGXA+WFrUp/oqY+YZQcXIWMxOB5Tik6xwgSyCqpTiu7IVTsKtJZzmWGaq7H/FK
         HchOMpaW4Rbq0amOkzeTehYPLm9njZkr9eZWVwQZegZ+Ny4NicorcaP9XCLFHp8VLizh
         RSTg==
X-Gm-Message-State: AKGB3mIjTFIEceCjQ3WbqTk5lhCK4zKALDDmC7AaY7BdS/+fRg6ug0nT
        Fc95bebVHXv0b4iiGqTSwfSfo+jb
X-Google-Smtp-Source: ACJfBovCBJB5seOFT5Kjan/FywYIXT/Tn6TXkEkbsJm8UR1rslonT8R8Bl3U9b2WfH9Pc8IdIOL8Sw==
X-Received: by 10.99.174.10 with SMTP id q10mr12581932pgf.440.1515514015614;
        Tue, 09 Jan 2018 08:06:55 -0800 (PST)
Received: from [192.168.206.100] ([117.242.90.141])
        by smtp.gmail.com with ESMTPSA id 67sm27161257pgg.50.2018.01.09.08.06.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jan 2018 08:06:54 -0800 (PST)
Subject: Re: [PATCH 4/8] Doc/gitsubmodules: avoid abbreviations
To:     Stefan Beller <sbeller@google.com>
Cc:     Git mailing list <git@vger.kernel.org>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
 <20180106184614.20115-5-kaartic.sivaraam@gmail.com>
 <CAGZ79kZZf=zSfqFr9EV_Q408mG4cHTEQSOAMC7n_35oKgHJp2A@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <b59bd56a-f88b-a65a-263f-2b6d2f57dd99@gmail.com>
Date:   Tue, 9 Jan 2018 21:36:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZZf=zSfqFr9EV_Q408mG4cHTEQSOAMC7n_35oKgHJp2A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4kjLouwDA0P9bjuX0qXACNNeW4x2AYtar"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4kjLouwDA0P9bjuX0qXACNNeW4x2AYtar
Content-Type: multipart/mixed; boundary="HL2RdeJSCAqTj2JD05Avunvu28IP7XaJH";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Stefan Beller <sbeller@google.com>
Cc: Git mailing list <git@vger.kernel.org>
Message-ID: <b59bd56a-f88b-a65a-263f-2b6d2f57dd99@gmail.com>
Subject: Re: [PATCH 4/8] Doc/gitsubmodules: avoid abbreviations
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
 <20180106184614.20115-5-kaartic.sivaraam@gmail.com>
 <CAGZ79kZZf=zSfqFr9EV_Q408mG4cHTEQSOAMC7n_35oKgHJp2A@mail.gmail.com>
In-Reply-To: <CAGZ79kZZf=zSfqFr9EV_Q408mG4cHTEQSOAMC7n_35oKgHJp2A@mail.gmail.com>

--HL2RdeJSCAqTj2JD05Avunvu28IP7XaJH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On Tuesday 09 January 2018 12:15 AM, Stefan Beller wrote:
>>
>> - * The command line for those commands that support taking submodule =
specs.
>=20
> ++ The command line for those commands that support taking submodules
> as part of their pathspecs[1].
> ++
> ++[1] pathspec is an official term according to `man gitglossary`.
>=20
> Maybe?
>=20

Yeah, I actually did think 'specification' wasn't a the best fit for
this (should have mentioned that somewhere) Now, the real term came out :=
)

Just to be sure, that "[1] pathspec ..." part goes to the end of the
document doesn't it?


>> -   Most commands have a boolean flag '--recurse-submodules' whether t=
o
>> -   recurse into submodules. Examples are `ls-files` or `checkout`.
>> + * The command line for those commands that support taking submodule
>> +   specifications. Most commands have a boolean flag '--recurse-submo=
dules
>> +   whether to recurse into submodules. Examples are `ls-files` or `ch=
eckout`.
>>     Some commands take enums, such as `fetch` and `push`, where you ca=
n
>>     specify how submodules are affected.
>>
>> --
>> 2.16.0.rc0.223.g4a4ac8367
>>



--HL2RdeJSCAqTj2JD05Avunvu28IP7XaJH--

--4kjLouwDA0P9bjuX0qXACNNeW4x2AYtar
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCAA5FiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlpU6I4bHGthYXJ0aWMu
c2l2YXJhYW1AZ21haWwuY29tAAoJEL3nWtrD1hlppl8P/iMwjw949UrlpfNwiIiQ
xp9+XYYbUK8rFNQLhANpU0SbCfeiNXjMalV9Z1Gz3eiDkdmmyS66rCrhowI5QEW2
3r3F4RnR59Nmpp5Hik20LM1tbTOp+CWRAmc5bKHInRgwkVrJbisly+CHdEytgw67
9fcYlYi4BsxEgMpTcH9X6IvuNw+WeP3nWcpaHKf0QhYj9dRJ850TZbUcAmtABi9J
uTGFK20hDc7ahxh6YZDJb+CRZKz+jDa2YbNM+B5SIytkON2EwB7XmbVFJu/C82BT
UgfwVlEjXLTxW362IcWat+9PurQHxVMalBkkCWeOqhDUa6JcU/1wzvyWDwbGEIWd
qaZXLwXT6UJzi02CwUL9uhMh2e5K8oEltDpkvQaca9vIBO0eIlPmk5KpRO9D3cI0
O+wr8BerPvBYui1heJze+Ew/V02VKcLAxq6SZvdQJbWNBn6QF+Ye+2JrZdIfoe7y
+SZf5kZMA8JnYR37/o9couJjorap8JTOU/oZcbd5tBKZ4RzsutwOiJldnG9CfRMm
V1tnCxTaqSKnK3eKhTgH/vMZj826Di7fY/OpyAB8ewI9aItfUGygVSaBXthCt7Sp
5lpXr1Bkz9spdgEd1Xzo7Mb2WstWGCFktN/QUz4CzrqJ8f2vtsc/A97UfmDn4iaS
Ap6NwShgelUUE/W5pj3ETGjS
=6jvN
-----END PGP SIGNATURE-----

--4kjLouwDA0P9bjuX0qXACNNeW4x2AYtar--
