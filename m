Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 125131F424
	for <e@80x24.org>; Mon, 18 Dec 2017 22:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965746AbdLRWEu (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 17:04:50 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:35684 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935911AbdLRWEn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 17:04:43 -0500
Received: by mail-vk0-f68.google.com with SMTP id y187so10403174vkd.2
        for <git@vger.kernel.org>; Mon, 18 Dec 2017 14:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1Dbg3rXr3HDs6rJoygs2PeGI5TkzEA1b9OWagnqLOQ8=;
        b=CkMCqJiE3iQAqbvtBr8YEoSSMfPRsfS02IrnmOe0kaTbrfmXQ+QRhS9NpXe2yPrgAB
         BI9gnqQKN4tq8tyQUD4xnagdZunMy70hoCk0UlujEHDWfB+V8wxF+EExXwnr/Z46kNTA
         JqsQ0ErKO77afDfYkFlVZK22L8Cs2yWtOsWfPoiE4BiIW/F7sWSVubDqZwL+KPitYOJG
         G1WPapnkMO0VpQuntOSqp2a1Sr8mO1rnahdlBFYS2G7kYW4j1rHxOFZ1nKBdDk+yIsV1
         WuHAHIotnn6qHrJ2JYxiMEORQpzU1QCVuFeguPoQ4AddM1j+ZdcTqDxzx3fGO+siUWgl
         5E6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1Dbg3rXr3HDs6rJoygs2PeGI5TkzEA1b9OWagnqLOQ8=;
        b=nAlopuH2zwn8JgRSVl6wf0zm0X9jtYnRUZj6XplmohDnW0zFmb+HRZZ8xNwggHbtnD
         17z0GEiAYXLs9dKpOrxzIoneIENOqUuo243nNO2zugixN57xsepFiz8PLbgxknz2Qy/C
         uh9c83hDVXdMEhHAlbvWiCfDskxfuocLd8iXBPcUx1lzreidW5DAWKYGOh3urTWpyVm2
         kqco2ax9vD6Rvei7huLpUJqRF77IdYi2OA5WcRLmwIwItnvkESj60rdTIoe5cOfmqyqY
         pRF+bH0k5TnQIFWQf8p7sjjfe63oCi8IVuB5ROH4+nnNy1/Wzz+kQm/ibKNeFMY1ggB5
         DK/w==
X-Gm-Message-State: AKGB3mIkV5sz0GsFt35uuhMX5B1448voN9gjstYbB2v3jUe5KBIXDxMx
        C+oX9oRZaG+mEM2Xu7mOfo0RUBF+DTEHNFWxkTU=
X-Google-Smtp-Source: ACJfBoupLjkVJ/XFEwYnJMvjkIgfNkClO0CYo7/AR1SheyhmHBCgg2wSfAgyiCOH/qEk1C6KE0cHw6UXluKbb2gfdpo=
X-Received: by 10.31.195.130 with SMTP id t124mr1253180vkf.57.1513634682460;
 Mon, 18 Dec 2017 14:04:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.73.240 with HTTP; Mon, 18 Dec 2017 14:04:41 -0800 (PST)
In-Reply-To: <8F53EF33-6FDA-484C-91A4-49CF24C0B417@gmail.com>
References: <20171216125418.10743-2-szeder.dev@gmail.com> <20171216125758.11120-1-szeder.dev@gmail.com>
 <8F53EF33-6FDA-484C-91A4-49CF24C0B417@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Mon, 18 Dec 2017 23:04:41 +0100
Message-ID: <CAM0VKj=xVfCd5qR4jXwFGDxSABgyAeZY5qJxUP3GHvUE7gjw6A@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] travis-ci: don't install 'language-pack-is' package
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 18, 2017 at 10:33 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
>> On 16 Dec 2017, at 13:57, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wrote=
:
>>
>> Ever since we have started to use Travis CI in 522354d70 (Add Travis
>> CI support, 2015-11-27), our 64 bit Linux build jobs install the
>> 'languate-pack-is' package.  That commit doesn't discuss why it was
>> deemed necessary back then, but Travis CI can build and test Git
>> without that package just fine, even that commit introducing Travis CI
>> support.
>
> If I remember correctly then we had to install the Icelandic
> language pack for the i18n tests (e.g. t0204):
>
> https://github.com/git/git/blob/master/t/lib-gettext.sh
> https://packages.ubuntu.com/trusty/language-pack-is
>
> However, I checked your Travis-CI and I cannot spot any errors:
> https://travis-ci.org/szeder/git/jobs/317494789

Ah, now I start to understand.  I was only looking for errors, too, but
there are none, because the tests requiring the language pack are
protected by the appropriate prerequisites.  On my box, without and
with the language pack:

  $ ./t0204-gettext-reencode-sanity.sh
  # lib-gettext: No is_IS UTF-8 locale available
  # lib-gettext: No is_IS ISO-8859-1 locale available
  ok 1 # skip gettext: Emitting UTF-8 from our UTF-8 *.mo files /
Icelandic (missing GETTEXT_LOCALE)
  ok 2 # skip gettext: Emitting UTF-8 from our UTF-8 *.mo files /
Runes (missing GETTEXT_LOCALE)
  ok 3 # skip gettext: Emitting ISO-8859-1 from our UTF-8 *.mo files /
Icelandic (missing GETTEXT_ISO_LOCALE)
  ok 4 # skip gettext: impossible ISO-8859-1 output (missing GETTEXT_ISO_LO=
CALE)
  ok 5 # skip gettext: Fetching a UTF-8 msgid -> UTF-8 (missing GETTEXT_LOC=
ALE)
  ok 6 # skip gettext: Fetching a UTF-8 msgid -> ISO-8859-1 (missing
GETTEXT_ISO_LOCALE)
  ok 7 # skip gettext.c: git init UTF-8 -> UTF-8 (missing GETTEXT_LOCALE)
  ok 8 # skip gettext.c: git init UTF-8 -> ISO-8859-1 (missing
GETTEXT_ISO_LOCALE)
  # passed all 8 test(s)

  $ sudo apt-get install language-pack-is
  [...]
  $ ./t0204-gettext-reencode-sanity.sh
  # lib-gettext: Found 'is_IS.utf8' as an is_IS UTF-8 locale
  # lib-gettext: No is_IS ISO-8859-1 locale available
  ok 1 - gettext: Emitting UTF-8 from our UTF-8 *.mo files / Icelandic
  ok 2 - gettext: Emitting UTF-8 from our UTF-8 *.mo files / Runes
  ok 3 # skip gettext: Emitting ISO-8859-1 from our UTF-8 *.mo files /
Icelandic (missing GETTEXT_ISO_LOCALE)
  ok 4 # skip gettext: impossible ISO-8859-1 output (missing GETTEXT_ISO_LO=
CALE)
  ok 5 - gettext: Fetching a UTF-8 msgid -> UTF-8
  ok 6 # skip gettext: Fetching a UTF-8 msgid -> ISO-8859-1 (missing
GETTEXT_ISO_LOCALE)
  ok 7 - gettext.c: git init UTF-8 -> UTF-8
  ok 8 # skip gettext.c: git init UTF-8 -> ISO-8859-1 (missing
GETTEXT_ISO_LOCALE)
  # passed all 8 test(s)
  1..8

I'd expect something like this in the Travis CI build jobs as well, but
prove hides the detailed output.

It seems we would loose coverage with this patch, so it should be
dropped.

> I am a bit puzzled. Maybe the Icelandic language pack was not part
> of the Ubuntu image that was used when we introduced Travis CI?
>
> The Ubuntu default image was 12.04 back then:
> https://travis-ci.org/git/git/jobs/100241871
>
> Nowadays it is 14.04.
>
> @Avar:
> Do you know what kind of errors we should expect if the language
> pack is not installed?
>
> Thanks,
> Lars
>
>>
>> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>> ---
>> .travis.yml | 1 -
>> 1 file changed, 1 deletion(-)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index 4684b3f4f..ea11b5af6 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -17,7 +17,6 @@ compiler:
>> addons:
>>   apt:
>>     packages:
>> -    - language-pack-is
>>     - git-svn
>>     - apache2
>>
>> --
>> 2.15.1.429.ga000dd9c7
>>
>
