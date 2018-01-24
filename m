Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEDE21F404
	for <e@80x24.org>; Wed, 24 Jan 2018 19:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932815AbeAXTjQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 14:39:16 -0500
Received: from mail-ua0-f193.google.com ([209.85.217.193]:42343 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932807AbeAXTjO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 14:39:14 -0500
Received: by mail-ua0-f193.google.com with SMTP id n2so3454145uak.9
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 11:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jC2aQgq/ONUw2cuViuZ1rYYZFRb415hMm2Yjtc+LnjA=;
        b=fdE1QsVbTSYFIGMsyMi0v5CJoftXp7WyudSHjT9Lyawjxi0aCarJQ/tlubqow9ozOX
         y+xSB8RWT26frnoDSjgoKCcjgec92+FhER9VruJugQTKkboyNMb95VsGT72CS3pa+tGq
         w1ALQvDNv92KdFqHRv2Wwkj17U56xWgPqroA0VCWtgIXC16y0yyRUV3nPG4HjHq9VNUz
         rTnk8mM6K11yN4qjpeUetCukpYqvZtDQKYnWJVX8myv5C47FnFbnjdL3gKXRI3+wWb7I
         xQkgA2cULdkPL/aYJMyEhJtrreGVmd+fJDDJrz0ZfJzcxY/EPcEiHliOLs/Z3r0Xuzjw
         ykBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jC2aQgq/ONUw2cuViuZ1rYYZFRb415hMm2Yjtc+LnjA=;
        b=K+17YFAjhta9l7IHGS4FgiTymf3MlHE8LwrWO2Lz4l8u0V9WeGZRdwiOpZ/v3z5IkJ
         CI0UKfGAjGED3Qps28ck8xzimyWUBtzMJFJQckxuTht5jj5z2lYPyEnLTwy5jUHEuTrL
         2UuEd8ZPVUz1YE1X722p8nGslpXO8XjOYAD5jDrwgrkObz2F983Bovq9xx+40dRB4lX3
         J2pgMttPKfPauvYj7EHY4JNPpnFRAXAMBTooKRbdI7G9MHY2ZGMC892CJZjgrLMAMMkD
         Hs7GSCepE/DzAcOEXuiCiqSy8LhWdpZ/cFp2dwy5x8/qHcmlZ0Z58R9q8Jyu1kD2I5f4
         E2og==
X-Gm-Message-State: AKwxytfgSh0/eZ94qUTlq0UB2B4f7JBhg+87Ve+VHgq/y1mfMK392ffv
        mvf+ANDbX5UuefJGfC2wsaZAmWC+niCgsmTB9zI=
X-Google-Smtp-Source: AH8x224SAhAfDD+WFqf/D1kF+wWA86RLwiEcG3wmDccJibgBHM6t/iTFFkbacu8ooe/M3HcgRzinOzPlIskF23VQ43U=
X-Received: by 10.176.11.138 with SMTP id c10mr5904412uak.94.1516822753172;
 Wed, 24 Jan 2018 11:39:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.32.12 with HTTP; Wed, 24 Jan 2018 11:39:12 -0800 (PST)
In-Reply-To: <20180123164605.GH13068@sigill.intra.peff.net>
References: <CAM0VKjmAjw0a2JzsY1BaAwZcCp8ge+jQaGN6L_nKTLugHeWyvQ@mail.gmail.com>
 <20180122133220.18587-1-szeder.dev@gmail.com> <20180122133220.18587-6-szeder.dev@gmail.com>
 <20180123164605.GH13068@sigill.intra.peff.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 24 Jan 2018 20:39:12 +0100
Message-ID: <CAM0VKjms5jRJj8=yD25cREkjn309tnnje4XhUAY1V1+OKWmgfg@mail.gmail.com>
Subject: Re: [PATCH 5/5] travis-ci: don't fail if user already exists on 32
 bit Linux build job
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 23, 2018 at 5:46 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Jan 22, 2018 at 02:32:20PM +0100, SZEDER G=C3=A1bor wrote:

>> diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
>> index e37e1d2d5f..13047adde3 100755
>> --- a/ci/run-linux32-build.sh
>> +++ b/ci/run-linux32-build.sh
>> @@ -33,7 +33,13 @@ then
>>       CI_USER=3Droot
>>  else
>>       CI_USER=3Dci
>> -     useradd -u $HOST_UID $CI_USER
>> +     if test "$(id -u $CI_USER)" =3D $HOST_UID
>> +     then
>> +             : # user already exists with the right ID
>> +     else
>> +             useradd -u $HOST_UID $CI_USER
>> +     fi
>
> Is it worth redirecting the stderr of "id" to avoid noise when $CI_USER
> does not yet exist at all? Or is that a useful log message? :)

I think it's worth silencing that error.  I'm not even sure it was
useful while working on this patch series, but an error message in the
middle of the log of a successful build job is surely distracting and
might raise some eyebrows (though I suspect that barely anyone looks at
logs of successful build jobs).

OTOH, I might turn that comment into an echo msg...
