Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 214631F42E
	for <e@80x24.org>; Tue,  8 May 2018 07:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754537AbeEHH4c (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 03:56:32 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:40518 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754263AbeEHH42 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 03:56:28 -0400
Received: by mail-pg0-f54.google.com with SMTP id l2-v6so20812772pgc.7
        for <git@vger.kernel.org>; Tue, 08 May 2018 00:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=BZL/XihJeaUXeUUoey2HYFFgcORYoURiSauhO34ttNI=;
        b=Fibpb4BSduYgOtEWN/5XL5aX6MLxj+SlR2n2PApEy/t4ACWYX6206ilocEIM2gZQYl
         twVX+ueCFSiXCMuuU7Y+VgHmnYHPUAWpJ6BXttvsN0WHsLDmW14Hof0Yw/5bhUxIIWWP
         YerXVRVInBLPk5I7fthPiEqPAS3rdrCK0WxMv5SDo0EUzNyv9ABRwYr2Gh+M/NUoxvRr
         7j1OlsDsD9VDVm7ib/r62fqTIBI4r/1RsSzo+SeaH1DaqxutR86uEzu/l8bNIwgpshBC
         mPCNYcWBpZewF+r5fUduyIxfzCB8b68jiVaIplgbRmyY7yWUepndYvoIyX3MpHytf3UV
         xTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=BZL/XihJeaUXeUUoey2HYFFgcORYoURiSauhO34ttNI=;
        b=aJLT0ccrZSIdKoL0/iBtzdNKpFCsGT2V8CgdoIEze9jcZ+kph2UJzu17ClCRLfTz7j
         9NB5XdCqQKXPeUvWNbHWGPhia0JS84/f0j7cYowaRLkAItim7OffXMX5qQ92FMiys8Ha
         6RVl3C4qp/CoTpjNVkmHTL5MvtTeogHpyvrrM8cHp4gv5X4NJdsvT0WCOShpqDiELe8q
         1m2k4JML/lUAGsREBDivHFiojLMFVa6sNMb+16czXpmDO8wBDtawjnkbmEL9BtRTa5Sq
         guw2wMoRwz6epnPklCtOOUEwPoCuPxAMSQFA8tltC0+WjqdFER4IrjHsC0JE/2TEfKYX
         0HjA==
X-Gm-Message-State: ALQs6tAh+ujPIMclSHC632F5bwanh5c/6Hg1MvyhNiXWAlX/exotikBO
        pp06Vxi0kwW9lK+IGc4QI5goRCj4
X-Google-Smtp-Source: AB8JxZoNxygh7mlXg2E6cB5ys9rfeVKjHyPyM2u+LprDczJu1miamTuRPFJUiCZEUfJk2710PStZsg==
X-Received: by 2002:a63:6fc8:: with SMTP id k191-v6mr31965743pgc.330.1525766187703;
        Tue, 08 May 2018 00:56:27 -0700 (PDT)
Received: from [192.168.206.100] ([117.209.132.10])
        by smtp.gmail.com with ESMTPSA id o70sm10104250pfo.49.2018.05.08.00.56.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 May 2018 00:56:26 -0700 (PDT)
Subject: Re: Weak option parsing in `git submodule`
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing list <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>
References: <1525630243.15782.4.camel@gmail.com>
 <CAGZ79kYSanRAchMe+7uJ4spy+GaS7PyU7epPeOSCs_58RsAR8A@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kaartic.sivaraam@gmail.com; prefer-encrypt=mutual; keydata=
 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
 IZ7P/DJ/
Message-ID: <7b573a6b-0486-f9bd-4499-deb9b1394f78@gmail.com>
Date:   Tue, 8 May 2018 13:26:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYSanRAchMe+7uJ4spy+GaS7PyU7epPeOSCs_58RsAR8A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TGV18Q678qaWgTovoxBHbHkObboeLWD0H"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TGV18Q678qaWgTovoxBHbHkObboeLWD0H
Content-Type: multipart/mixed; boundary="QssBCHbu6iAkDjlsORdfg5g2pCSsEruhK";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Stefan Beller <sbeller@google.com>
Cc: Git Mailing list <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
Message-ID: <7b573a6b-0486-f9bd-4499-deb9b1394f78@gmail.com>
Subject: Re: Weak option parsing in `git submodule`
References: <1525630243.15782.4.camel@gmail.com>
 <CAGZ79kYSanRAchMe+7uJ4spy+GaS7PyU7epPeOSCs_58RsAR8A@mail.gmail.com>
In-Reply-To: <CAGZ79kYSanRAchMe+7uJ4spy+GaS7PyU7epPeOSCs_58RsAR8A@mail.gmail.com>

--QssBCHbu6iAkDjlsORdfg5g2pCSsEruhK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On Tuesday 08 May 2018 12:35 AM, Stefan Beller wrote:
>>     The lack of checking for the reason behind why `git add` fails see=
ms to
>>     be the reason behind that weird message.
>=20
> (from the man page)
> git submodule [--quiet] add [<options>] [--] <repository> [<path>]
>=20
> When options are given after <repository> or <path> we can count
> the arguments and know something is up. (The number of arguments
> must be 1 or 2. If it is 3 or above, something fishy is going on), whic=
h
> I would suggest as a first step.
>=20
>>     Ways to fix this:
>>
>>     1. Fix this particular issue by adding a '--' after the '--no-warn=
-
>>     embedded-repo' option in the above check. But that would also
>>     require that we allow other parts of the script to accept weird
>>     paths such as '--path'. Not so useful/helpful.
>>
>>     2. Check for the actual return value of `git add` in the check and=

>>     act accordingly. Also, check if there are unnecessary arguments fo=
r
>>     `submodule add`.
>=20
> The second part of this suggestion seems to me as the way to go.
> Do you want to write a patch?
>=20

Incidentally, I was writing a patch to check for the return value of
`git add` to fix the particular issue I noted in my initial message.
Then I was in a dilemma as to whether this was the right way to do it.
So, I thought it would be better to ask before continuing with the patch
and hence started this thread. I wasn't counting the arguments to `git
submodule add` at that time.

Now that I'm ensured that my initial approach is not the worst way to do
things and as I'm about to write a patch for this, I'll sum up what I'm
about to achieve in the short-term fix patch, for the sake of clarity.

	1. Check the return value of `git add ...` and throw an error
	   appropriately.

	2. Check the no. of arguments to `submodule add` and throw an
	   error if there are more arguments than there should be.

	   I require a little clarification with this. How should this
	   be done. Does checking whether the number of arguments after
	   <repository> is not more than one do the job? Or am I missing
	   something?


>>     3. Tighten option parsing in the `git-submodule` script to ensure
>>     this doesn't happen in the long term and helps users to get more
>>     relevant error messages.
>>
>>     I find 3 to be a long term solution but not sure if it's worth try=
ing
>>     as there are efforts towards porting `git submodule` to C. So, I g=
uess
>>     we should at least do 2 as a short-term solution.
>=20
> Yeah, bringing it to C, would be nice as a long term solution instead
> of piling up more and more shell features. :)
>=20

Hope the day it is brought into C comes soon.


> Thanks for such a well written bug report with suggested bug fixes. :)

You're welcome :-)


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


--QssBCHbu6iAkDjlsORdfg5g2pCSsEruhK--

--TGV18Q678qaWgTovoxBHbHkObboeLWD0H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlrxWB8ACgkQveda2sPW
GWmg3g//bTx1a+jyi4MMAV6saMDgoiG1MUla0o+b18Zb2TIEPVClN6U2vF1HPOco
uRswafA65Dz44zkkiEUyzGeHM1wZysUU6SdrBohJzMLsQG4z9+OfJPTN+Al8vS3E
zkhvTql0cSi7iCOTABIpA07WUIrbsKknlI4OJgogWgciB23gH7aOAQa+8pHl5PKg
dVHWoOoIlXcztperKbykwVBA0nqrcf6lFk4o6UxOvB3Dox27UWTsVwKFKNw4RCs0
D9qR1w8LUqGm3bAh7yE6R9bikZouFxMOh/eNlxQkj5GjAWbG+Ug9Rom5SwZOUCB5
oFqDzXhmuEKT4n0Bhg7OO2RpnHEtxEZ6s6b9rvExe31sGPAK6/tNxKUo4eLZbnir
x6dzXs7SiYj6w8NSn9Kr9NL75ObC6f6odHUgss4ArVB/lI1ry6UmUe3qP7dLb7FY
I7vLvvOcHiJfbsr6fgn0Po1KGzLlhK36FZUonnm3eLLwOjQh73d/9nqEw3S4f6Id
BTOXlLjIVqIIi7LP7kn86NSpzlN4Je0pS/1xMVlOdIuK5tSxVLK7NL7jRKn4U+P/
TC+FGRwhhCUQBsI6LyHmCdJ1stFpLyl2Yp+Clj6WSwiYs/ISeiYVG6dAYsVzAtmL
aWrPobvhDJs9sCPF4zecxSar/jXDE7yswwqrSWnP4lFN9kpr0i8=
=amqP
-----END PGP SIGNATURE-----

--TGV18Q678qaWgTovoxBHbHkObboeLWD0H--
