Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FABD1F424
	for <e@80x24.org>; Mon, 18 Dec 2017 22:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936203AbdLRWRn (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 17:17:43 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45485 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933147AbdLRWRm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 17:17:42 -0500
Received: by mail-wr0-f193.google.com with SMTP id h1so15867357wre.12
        for <git@vger.kernel.org>; Mon, 18 Dec 2017 14:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+ywtyOXBF/0uVucDEh1+aUHfSWt80r3r6HAXBJS8O24=;
        b=uMEU4+4rzJmgkD93oxrHzDYBwyPTA/ZIQIt1LcWIpKDpD6E6oppU/xVAayVGqZqswe
         xGMQOBZuB60Bl5znq7zN5xXpOtZSbe6DUUdmb+wKJq5ikeOSVMODpWZWmHL7fRGsBD+H
         JJ3m25jYeVtPbD6tRYwSLzEOmJABZcTVUpf7qHEcqFvc8JxbFzoXi5Zkef4nzKvaGvgW
         Y0qK6h5SEk07+RQql31eHyKMl+aJeiOzc6lC49Ha0YFNH9tLbT91jHQXfPPmZ6hp2awU
         2KmCOI8TU5QRMKGBR2kRrlyUQtc11akRir3Vunw44aS0x2Hoia973zXredAq7hmXVr91
         e+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+ywtyOXBF/0uVucDEh1+aUHfSWt80r3r6HAXBJS8O24=;
        b=qZwzt7+0c3G+bMAb7IbI2HlScksh75uY+eUizd6NAYa7tfHVtV0Wg45rLQC3+z5Le2
         0/5s7fXtA8J3CHAJC+VCOzgqDsafWm1q8UdFEMe3symVo31DsvyjdcWtCGSjHt2K6974
         Orhcg5g9HC5V+U/jpPrL8qdfCceaWrwyZ5GNEqyWbrfqjapSFqghgsA079OITXG70Hob
         WBfirKoBeLzZVT8oMISAzIuhz/jNOOeKAdEumxQBeKW8BffV4bIb9uFjGZuHtkYN0Er0
         MFWpJZm+XOsCor2m6PDF4E/G24D3Saiqn+d9Zp+DyaLGIfj9oWmbbq1NS0U5R+QbZhS6
         5Rxg==
X-Gm-Message-State: AKGB3mLNmg1CNsmHQGiNItz7h3c1qsCjm8dtsh2E+G2rWzpuH+DA6odB
        beVcxZqI0AAcFVqSRXjH5js=
X-Google-Smtp-Source: ACJfBosVE+KnVgrgABPLF6s9XA7Are8x3EmxvFNXx1GWKPl4jssaG87FpHoQ2tsWHLVJH/K68Ty4AA==
X-Received: by 10.223.151.40 with SMTP id r37mr1790225wrb.164.1513635461130;
        Mon, 18 Dec 2017 14:17:41 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5261.dip0.t-ipconnect.de. [93.219.82.97])
        by smtp.gmail.com with ESMTPSA id v195sm265544wmf.25.2017.12.18.14.17.40
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Dec 2017 14:17:40 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 6/8] travis-ci: don't install 'language-pack-is' package
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAM0VKj=xVfCd5qR4jXwFGDxSABgyAeZY5qJxUP3GHvUE7gjw6A@mail.gmail.com>
Date:   Mon, 18 Dec 2017 23:17:39 +0100
Cc:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AB053B56-5318-47D4-8ADE-0A72B9860BED@gmail.com>
References: <20171216125418.10743-2-szeder.dev@gmail.com> <20171216125758.11120-1-szeder.dev@gmail.com> <8F53EF33-6FDA-484C-91A4-49CF24C0B417@gmail.com> <CAM0VKj=xVfCd5qR4jXwFGDxSABgyAeZY5qJxUP3GHvUE7gjw6A@mail.gmail.com>
To:     =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 18 Dec 2017, at 23:04, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>=20
> On Mon, Dec 18, 2017 at 10:33 PM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>>=20
>>> On 16 Dec 2017, at 13:57, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>>>=20
>>> Ever since we have started to use Travis CI in 522354d70 (Add Travis
>>> CI support, 2015-11-27), our 64 bit Linux build jobs install the
>>> 'languate-pack-is' package.  That commit doesn't discuss why it was
>>> deemed necessary back then, but Travis CI can build and test Git
>>> without that package just fine, even that commit introducing Travis =
CI
>>> support.
>>=20
>> If I remember correctly then we had to install the Icelandic
>> language pack for the i18n tests (e.g. t0204):
>>=20
>> https://github.com/git/git/blob/master/t/lib-gettext.sh
>> https://packages.ubuntu.com/trusty/language-pack-is
>>=20
>> However, I checked your Travis-CI and I cannot spot any errors:
>> https://travis-ci.org/szeder/git/jobs/317494789
>=20
> Ah, now I start to understand.  I was only looking for errors, too, =
but
> there are none, because the tests requiring the language pack are
> protected by the appropriate prerequisites.  On my box, without and
> with the language pack:
>=20
>  $ ./t0204-gettext-reencode-sanity.sh
>  # lib-gettext: No is_IS UTF-8 locale available
>  # lib-gettext: No is_IS ISO-8859-1 locale available
>  ok 1 # skip gettext: Emitting UTF-8 from our UTF-8 *.mo files /
> Icelandic (missing GETTEXT_LOCALE)
>  ok 2 # skip gettext: Emitting UTF-8 from our UTF-8 *.mo files /
> Runes (missing GETTEXT_LOCALE)
>  ok 3 # skip gettext: Emitting ISO-8859-1 from our UTF-8 *.mo files /
> Icelandic (missing GETTEXT_ISO_LOCALE)
>  ok 4 # skip gettext: impossible ISO-8859-1 output (missing =
GETTEXT_ISO_LOCALE)
>  ok 5 # skip gettext: Fetching a UTF-8 msgid -> UTF-8 (missing =
GETTEXT_LOCALE)
>  ok 6 # skip gettext: Fetching a UTF-8 msgid -> ISO-8859-1 (missing
> GETTEXT_ISO_LOCALE)
>  ok 7 # skip gettext.c: git init UTF-8 -> UTF-8 (missing =
GETTEXT_LOCALE)
>  ok 8 # skip gettext.c: git init UTF-8 -> ISO-8859-1 (missing
> GETTEXT_ISO_LOCALE)
>  # passed all 8 test(s)
>=20
>  $ sudo apt-get install language-pack-is
>  [...]
>  $ ./t0204-gettext-reencode-sanity.sh
>  # lib-gettext: Found 'is_IS.utf8' as an is_IS UTF-8 locale
>  # lib-gettext: No is_IS ISO-8859-1 locale available
>  ok 1 - gettext: Emitting UTF-8 from our UTF-8 *.mo files / Icelandic
>  ok 2 - gettext: Emitting UTF-8 from our UTF-8 *.mo files / Runes
>  ok 3 # skip gettext: Emitting ISO-8859-1 from our UTF-8 *.mo files /
> Icelandic (missing GETTEXT_ISO_LOCALE)
>  ok 4 # skip gettext: impossible ISO-8859-1 output (missing =
GETTEXT_ISO_LOCALE)
>  ok 5 - gettext: Fetching a UTF-8 msgid -> UTF-8
>  ok 6 # skip gettext: Fetching a UTF-8 msgid -> ISO-8859-1 (missing
> GETTEXT_ISO_LOCALE)
>  ok 7 - gettext.c: git init UTF-8 -> UTF-8
>  ok 8 # skip gettext.c: git init UTF-8 -> ISO-8859-1 (missing
> GETTEXT_ISO_LOCALE)
>  # passed all 8 test(s)
>  1..8
>=20
> I'd expect something like this in the Travis CI build jobs as well, =
but
> prove hides the detailed output.

Ahh. That explains it!


> It seems we would loose coverage with this patch, so it should be
> dropped.

Yeah. I think we should add a comment to the travis.yml to avoid
future confusion. I'll do it unless you beat me to it with a re-roll.


- Lars

>=20
>> I am a bit puzzled. Maybe the Icelandic language pack was not part
>> of the Ubuntu image that was used when we introduced Travis CI?
>>=20
>> The Ubuntu default image was 12.04 back then:
>> https://travis-ci.org/git/git/jobs/100241871
>>=20
>> Nowadays it is 14.04.
>>=20
>> @Avar:
>> Do you know what kind of errors we should expect if the language
>> pack is not installed?
>>=20
>> Thanks,
>> Lars
>>=20
>>>=20
>>> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>>> ---
>>> .travis.yml | 1 -
>>> 1 file changed, 1 deletion(-)
>>>=20
>>> diff --git a/.travis.yml b/.travis.yml
>>> index 4684b3f4f..ea11b5af6 100644
>>> --- a/.travis.yml
>>> +++ b/.travis.yml
>>> @@ -17,7 +17,6 @@ compiler:
>>> addons:
>>>  apt:
>>>    packages:
>>> -    - language-pack-is
>>>    - git-svn
>>>    - apache2
>>>=20
>>> --
>>> 2.15.1.429.ga000dd9c7

