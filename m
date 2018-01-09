Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A5C81F406
	for <e@80x24.org>; Tue,  9 Jan 2018 17:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759962AbeAIRGc (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 12:06:32 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:43750 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751197AbeAIRGb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 12:06:31 -0500
Received: by mail-pf0-f171.google.com with SMTP id e3so8978472pfi.10
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 09:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=ryRWI0ITBXP1l6F6wdeXk4iZX6hYGSzgfjvlHML0pac=;
        b=LhOLNIfMoVqoP+y/2FJdyYZlUfLITJJhaI28EEP3tSE4s+PG/O5xmCupp4rhU2BGMX
         WgzxNkSta67jeZWRHp9n5DNezi58qHn9X+1w+aQTT8KkyFI5DO6bCVRgVzUNdiP+XWUF
         ARbMvb5cx9qofO1pvDSHPcmKS+4Z+Yz0TSW13qQltPvV335UF1IDwYN8E0FdPOddplG4
         j1qppbRrlrPgzuBrWbEFWVdEFTuE1AWXcLctYMnKou7W1AyeZ/Z+UpADY+WGqsyr1gqV
         Wy/4cIr7W2eyT9lfmU/oCk5uRaYbDB06dYPydarRlJBqx3dIGWTvIqW+RiJt/Y4hjvMb
         yfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=ryRWI0ITBXP1l6F6wdeXk4iZX6hYGSzgfjvlHML0pac=;
        b=s2s+762sJZ8XokYo6akBdgzy5MmnnAfeBY10WEJdwOqsRjo8/tF06AMSO8OD8ZjaW2
         DJbibKIhK6Kag3v0s186Nf0TZybp1kaJ3+KBlf9pT+IHSGZwu+Y9UgNXdxj3whhS8E1T
         OpM3E6UvL9zyvjIpCxmm4RRPFYAHyoDfCKetiaFSTS6pY1Xvt3MNH/4bBEHiln2QmU1/
         96+vf9O/JeoN7Mdgs5oxFTKsR0dmXd6kzZ5/0iBPASC+KcKUV4R29VxWdZ+5Gahdfv2H
         V0YHk001oLOOQf5SfYuzxQ+TFiEVAiG1+tkSAz7C59NrHY8Ijwz/O17bprv4AEKsG8KC
         BVbA==
X-Gm-Message-State: AKGB3mI1ZfEuQ6IxYy3liGRR6kWE6SjUCrVeg70PwG13o4Nw7RJYaYcE
        r9LZIl3lnVqqk+Y1tdsPTlbEBlQ5
X-Google-Smtp-Source: ACJfBotdLNV5DKhj4cTmP8WeNSzY97XjVup944DYVd04iLNUGIsNf/TZ8b4BmLYYi/U7WTEPalMqhw==
X-Received: by 10.99.67.133 with SMTP id q127mr5476430pga.365.1515517590031;
        Tue, 09 Jan 2018 09:06:30 -0800 (PST)
Received: from [192.168.206.100] ([117.209.190.40])
        by smtp.gmail.com with ESMTPSA id d5sm4891603pfk.2.2018.01.09.09.06.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jan 2018 09:06:28 -0800 (PST)
Subject: Re: [PATCH 0/8] Doc/submodules: a few updates
To:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
Cc:     Git mailing list <git@vger.kernel.org>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
 <CAGZ79kZ-UNCyCzmg=5PQ_p5xbmCp7HUc0=TXNBxwTjZDCnJtBg@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <64503247-66ad-03cf-26ba-3383337971b5@gmail.com>
Date:   Tue, 9 Jan 2018 22:36:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZ-UNCyCzmg=5PQ_p5xbmCp7HUc0=TXNBxwTjZDCnJtBg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="x0kpWwDibN2FqPyxgyxqPZTMLDSd2FfeB"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--x0kpWwDibN2FqPyxgyxqPZTMLDSd2FfeB
Content-Type: multipart/mixed; boundary="BrNmBlBT8p2igfBYRugSqWAUDBWcaJAN9";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Stefan Beller <sbeller@google.com>, Brandon Williams <bmwill@google.com>
Cc: Git mailing list <git@vger.kernel.org>
Message-ID: <64503247-66ad-03cf-26ba-3383337971b5@gmail.com>
Subject: Re: [PATCH 0/8] Doc/submodules: a few updates
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
 <CAGZ79kZ-UNCyCzmg=5PQ_p5xbmCp7HUc0=TXNBxwTjZDCnJtBg@mail.gmail.com>
In-Reply-To: <CAGZ79kZ-UNCyCzmg=5PQ_p5xbmCp7HUc0=TXNBxwTjZDCnJtBg@mail.gmail.com>

--BrNmBlBT8p2igfBYRugSqWAUDBWcaJAN9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On Tuesday 09 January 2018 12:38 AM, Stefan Beller wrote:
> On Sat, Jan 6, 2018 at 10:46 AM, Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
>=20
> While small patches are really appreciated for code (bisect, automated
> testing, and
> the general difficulty to reason about code, as a very small change
> may affect the whole
> code base), I am not sure if they benefit in documentation.
> Documentation is a rather
> local human readable thing, so by changing one sentence we don't
> affect the understanding
> of documentation at a completely unrelated place.
>=20
> Also it helps to read more than just sentence fragments, i.e. I tried
> looking at the
> whole paragraph for review. May I suggest to squash them all and
> resend as one patch?
>=20

I wouldn't mind that. I thought it might be easy to find to find the
parts I changed when the patches are small. So, I sent them without
squashing them together. In case you feel it's not worth, let me know so
I'll squash them in.

BTW, in case I did squash them in, would it be nice to keep the commit
subjects of the current patch series as bullet points in the unified
commit message?


>=20
>>
>> I based these patches on top of 'master'.
>=20
> I am not aware of other submodule patches affecting documentation in ma=
ster..pu,
> so this should be easy to merge.
>=20
>>
>> Apart from the changes, I saw a few things that needed improvement/cla=
rification
>> but wasn't able to do that myself due to my limited knowledge of submo=
dules. They
>> are listed below. I'll add in patches for them if they are correctly c=
larified.
>>
>>
>> 1.
>>
>>  man gitsubmodules
>>
>>        =C2=B7   The configuration file $GIT_DIR/config in the superpro=
ject. Typical configuration at this place is controlling if a submodule i=
s
>>            recursed into at all via the active flag for example.
>>
>>            If the submodule is not yet initialized, then the configura=
tion inside the submodule does not exist yet, so configuration where to
>>            obtain the submodule from is configured here for example.
>>
>> What's the "active flag" mentioned above? Also I find the phrase "is r=
ecursed into at all"
>> to be a little slippery. How could it be improved?
>=20
> There are multiple ways to indicate if a submodule is "active", i.e. if=
 Git is
> supposed to pay attentio. Historically we had to set the
> submodule.<name>.url flag in the config, but last year Brandon added
> submodule.active as well as submodule.<name>.active which supersede
> the .url flag.
>=20
> (See is_submodule_active() in submodule.c to see the definitive answer =
to
> "should Git pay attention?")
> https://github.com/git/git/blob/master/submodule.c#L224
>=20

Thanks for the info!


> I wonder if this indicates a lack of documentation when the active
> flags were introduced.
> They are found in 'man git config', but maybe we need to spell them
> out explicitly
> in the submodule related docs.
>=20

Possibly. So, why not in Documentation/gitsubmodules! Here's a replaced
version of that paragraph,

    * The configuration file `$GIT_DIR/config` in the superproject.
   Typically this file is used to specify whether the submodule
   is recursed into at all via the `active` flag for example. A
   submodule is considered active if `submodule.<name>.url` is set
   or if the submodules path is present in `submodule.active` or
   if `submodule.<name>.url` is set.


>> 2.
>>
>>  man git submodule
>>
>>        update
>>            ...
>>
>>            checkout
>>                ....
>>
>>                If --force is specified, the submodule will be checked =
out (using git checkout --force if appropriate), even if the commit
>>                specified in the index of the containing repository alr=
eady matches the commit checked out in the submodule.
>>
>> I'm not sure this is conveying all the information it should be convey=
ing.
>> It seems to making the user wonder, "How at all does 'git submodule up=
date --force'
>> differs from 'git submodule update'?" also "using git checkout --force=
 if appropriate"
>> seems to be invoking all sorts confusion as "appropriate" is superfluo=
us.
>=20
> When "submodule update" is invoked with the `--force` flag, that flag i=
s passed
> on to the 'checkout' operation. If you do not give the --force, then
> the checkout
> will also be done without --force.
>=20

If that's the case then shouldn't the "if appropriate" part of "(using
git checkout --force if appropriate)" be dropped? That seems to make it
clear, at least for me. Or is intended as '--force' will not be passed
to git checkout all the time?

>>
>> How could these confusions be clarified?
>=20
> I tried giving an alternative snippet above, not sure how else to tell.=

>=20



--=20
Kaartic

Quote: "Be creative. Be adventurous. Be original. And above all else, be
young." - Wonder Woman


--BrNmBlBT8p2igfBYRugSqWAUDBWcaJAN9--

--x0kpWwDibN2FqPyxgyxqPZTMLDSd2FfeB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCAA5FiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlpU9ogbHGthYXJ0aWMu
c2l2YXJhYW1AZ21haWwuY29tAAoJEL3nWtrD1hlpKDQQAITmQzNxwLR2ASBnYA2h
4hMI0F4SmQjUCKoilUuDkUD4uJ6H3Ib2sXKpJQTvfuU100SGSJnrkVUQPQKwYpxA
aL9BBrPmH9vCVh0An55fIStLm188i8mSKQYUGMrk1k/W7Bey00YAprkDxiSODcQm
mR/JfgpNtOKLwudocMokpZ393+KfB18C3O9Hq642Ry289U91bwRbOzmbZ7TAA1TT
wXEW/GMP2DO4kkT/W+5PYXmMFt5zeDbmiNCfEesxUQWSnV6XKpSghcf5nBPPQOix
qmpgD5nngZ6NngyLPfB/nOYDl9T67VN/DQzGL7jFMBuS2XvPH++dldMxSPYrUljL
tcMba1wnr6xobOjPazaF3qwJfbkC4jJqFQX3wWULF27+R68ZyIRDNPzYbFmC/MpA
M3fqZCmPo7jCq3S6x/CqjJ63OfNG/sV9qZgdAG7ziGnj5TDsDQ4cbbukOLUo+BJ7
TpJhECEJKtEvJTUPsaGN0DEjTun7fiZ3XPlM0bJVo7/5c/ksFrj3NrJ2H4V0wKjj
RaGYLxi6MrzlUz4DkBQuVkknKw4b87itc58Hoe1qYj2xwEARpoIgnaBLH27vYivr
UnN7zPbYnrXQFxf8vksJSCnQFXCSZMbkPcg0QgwnLLtKo6GOctCCAcln5Y+vBk9m
m9vStCchS+YuhrM5ItVxlMMz
=Ihrz
-----END PGP SIGNATURE-----

--x0kpWwDibN2FqPyxgyxqPZTMLDSd2FfeB--
