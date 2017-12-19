Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C51731F406
	for <e@80x24.org>; Tue, 19 Dec 2017 12:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751797AbdLSMWq (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 07:22:46 -0500
Received: from mail-vk0-f53.google.com ([209.85.213.53]:45802 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751753AbdLSMWo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 07:22:44 -0500
Received: by mail-vk0-f53.google.com with SMTP id o16so11339245vke.12
        for <git@vger.kernel.org>; Tue, 19 Dec 2017 04:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V8C0PPlYx3vmIE9vz6ep4K/84LV+m5gx8k3whqdlwaE=;
        b=ez9maNgfoyoRLyqHrqvOrOBqfQxRaYunn3C6iBoCVXCiDuTyMMy4fjofyeSP/NnJWR
         SJlRwxbQKBLRbkpl1YEHS9+HX5rWnm5Z1pPflWQs7pgdjaDAqKxiBF8iSv2Ag5oKPNHb
         1KtyzKSVKacvroLvfxn0pfHVayovVAl/9cWcqwTJRL4/WRPbgoRXiMz/w04kBk8AEIhE
         9SgrqnkiSOaud7+HNLyp8YCvki5dnx1Lr4qNpOU048Vgw7vpwsUOvHexlutUIAVsshG5
         HZjt6Maw4obMHjeAWaZuOhO2ePiWqrBMSKwuk3xBeJMgzPLxLCnhMYyg0Vr0wwFmg1kc
         JJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V8C0PPlYx3vmIE9vz6ep4K/84LV+m5gx8k3whqdlwaE=;
        b=Saje/YP03d9pw+sL4+5sZycgxBo3/56ri9EVhMDz1qFEA6hq4vrTXM3k65RrHqt+wl
         kqaCte0JgdTxcTISmTHI5VZVj0VAfuI/2MUFjWS44PYGFTiJWHgjtw6E/RBDS7humHRL
         CuXd0tQJsGVQMZA8/b60vOvHkpXX7TrMozUSpNwvrb0rrCOnGirpatLKGr1ZyPquXosG
         j+gr6CFztYSmQs+VyDdpLxmOxrGMwQzGwuU/Ir0onPxdo4sO0RLBj6rK/qV3Jm2kIBUV
         RBKqym+EhLb+75DKzNog/9YNasebik3364jnU8/CK0QYd+YUpjXE7JTzxO6bdwUuSVmI
         IjvQ==
X-Gm-Message-State: AKGB3mIV/sQb9cduqBjQNd1FF4V8upKy7CBhonmP4apNoMwQ+EybsYF9
        zseIO3vPP0HbYnoJ6NAUfERESI5fRaBAiNgrQZk=
X-Google-Smtp-Source: ACJfBoubv14GcYu6jMp40PnQVEZLqI9ObixPAC4gyQewagRpNQ6s5590aRqd6SECw1lpLHJB6e5kQ6E/q4rf5tOGW+4=
X-Received: by 10.31.139.201 with SMTP id n192mr3049998vkd.132.1513686163321;
 Tue, 19 Dec 2017 04:22:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.73.240 with HTTP; Tue, 19 Dec 2017 04:22:42 -0800 (PST)
In-Reply-To: <CAM0VKj=xVfCd5qR4jXwFGDxSABgyAeZY5qJxUP3GHvUE7gjw6A@mail.gmail.com>
References: <20171216125418.10743-2-szeder.dev@gmail.com> <20171216125758.11120-1-szeder.dev@gmail.com>
 <8F53EF33-6FDA-484C-91A4-49CF24C0B417@gmail.com> <CAM0VKj=xVfCd5qR4jXwFGDxSABgyAeZY5qJxUP3GHvUE7gjw6A@mail.gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Tue, 19 Dec 2017 13:22:42 +0100
Message-ID: <CAM0VKjnctWRatbjB7EPHH+5zLjZLY+1umgFwz=bcV=g25eTD4w@mail.gmail.com>
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

On Mon, Dec 18, 2017 at 11:04 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:

>   $ sudo apt-get install language-pack-is
>   [...]
>   $ ./t0204-gettext-reencode-sanity.sh
>   # lib-gettext: Found 'is_IS.utf8' as an is_IS UTF-8 locale
>   # lib-gettext: No is_IS ISO-8859-1 locale available
>   ok 1 - gettext: Emitting UTF-8 from our UTF-8 *.mo files / Icelandic
>   ok 2 - gettext: Emitting UTF-8 from our UTF-8 *.mo files / Runes
>   ok 3 # skip gettext: Emitting ISO-8859-1 from our UTF-8 *.mo files /
> Icelandic (missing GETTEXT_ISO_LOCALE)
>   ok 4 # skip gettext: impossible ISO-8859-1 output (missing GETTEXT_ISO_=
LOCALE)
>   ok 5 - gettext: Fetching a UTF-8 msgid -> UTF-8
>   ok 6 # skip gettext: Fetching a UTF-8 msgid -> ISO-8859-1 (missing
> GETTEXT_ISO_LOCALE)
>   ok 7 - gettext.c: git init UTF-8 -> UTF-8
>   ok 8 # skip gettext.c: git init UTF-8 -> ISO-8859-1 (missing
> GETTEXT_ISO_LOCALE)
>   # passed all 8 test(s)
>   1..8
>
> I'd expect something like this in the Travis CI build jobs as well, but
> prove hides the detailed output.
>
> It seems we would loose coverage with this patch, so it should be
> dropped.

Not so fast!

Notice how there are still a few tests skipped above, because of missing
GETTEXT_ISO_LOCALE.

  # grep is_IS /etc/locale.gen
  # is_IS ISO-8859-1
  # is_IS.UTF-8 UTF-8
  # sed -i -e 's/^# is_IS/is_IS/' /etc/locale.gen
  # locale-gen
  Generating locales (this might take a while)...
  [...]
  is_IS.ISO-8859-1... done
  is_IS.UTF-8... done
  Generation complete.

Both UTF-8 and ISO Icelandic locales are generated, good.

  $ $ ./t0204-gettext-reencode-sanity.sh
  # lib-gettext: Found 'is_IS.utf8' as an is_IS UTF-8 locale
  # lib-gettext: Found 'is_IS.iso88591' as an is_IS ISO-8859-1 locale
  ok 1 - gettext: Emitting UTF-8 from our UTF-8 *.mo files / Icelandic
  ok 2 - gettext: Emitting UTF-8 from our UTF-8 *.mo files / Runes
  ok 3 - gettext: Emitting ISO-8859-1 from our UTF-8 *.mo files / Icelandic
  ok 4 - gettext: impossible ISO-8859-1 output
  ok 5 - gettext: Fetching a UTF-8 msgid -> UTF-8
  ok 6 - gettext: Fetching a UTF-8 msgid -> ISO-8859-1
  ok 7 - gettext.c: git init UTF-8 -> UTF-8
  ok 8 - gettext.c: git init UTF-8 -> ISO-8859-1
  # passed all 8 test(s)

And now all those tests are run, great!
But look what happens without the language pack:

  # dpkg -P language-pack-is{,-base}
  [...]
  # grep is_IS /etc/locale.gen
  is_IS ISO-8859-1
  is_IS.UTF-8 UTF-8
  buzz ~# locale-gen
  Generating locales (this might take a while)...
  [...]
  is_IS.ISO-8859-1... done
  is_IS.UTF-8... done
  Generation complete.

Still both Icelandic locales are generated.

  $ ./t0204-gettext-reencode-sanity.sh
  # lib-gettext: Found 'is_IS.utf8' as an is_IS UTF-8 locale
  # lib-gettext: Found 'is_IS.iso88591' as an is_IS ISO-8859-1 locale
  ok 1 - gettext: Emitting UTF-8 from our UTF-8 *.mo files / Icelandic
  ok 2 - gettext: Emitting UTF-8 from our UTF-8 *.mo files / Runes
  ok 3 - gettext: Emitting ISO-8859-1 from our UTF-8 *.mo files / Icelandic
  ok 4 - gettext: impossible ISO-8859-1 output
  ok 5 - gettext: Fetching a UTF-8 msgid -> UTF-8
  ok 6 - gettext: Fetching a UTF-8 msgid -> ISO-8859-1
  ok 7 - gettext.c: git init UTF-8 -> UTF-8
  ok 8 - gettext.c: git init UTF-8 -> ISO-8859-1
  # passed all 8 test(s)

And still all those tests are run!

I did run all test scripts sourcing 'lib-gettext.sh' with both locales
generated and didn't see any errors, independently from whether the
language pack was installed or not.  I still have a few skipped tests
(because of no GETTEXT_POISON and something PCRE-related), but those,
too, are independent from the language pack.

So it seems that we don't need 'language-pack-is' after all; what we do
need are the ISO and UTF-8 Icelandic locales.  Not sure we can modify
/etc/locale.gen without sudo in the Travis CI build job, though, and
I've run out of time to try.


G=C3=A1bor
