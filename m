Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BB8D2095B
	for <e@80x24.org>; Sat, 18 Mar 2017 23:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbdCRXab (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 19:30:31 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:35115 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751045AbdCRXaa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 19:30:30 -0400
Received: by mail-vk0-f44.google.com with SMTP id x75so56258822vke.2
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 16:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=i4FqtaD2jZeF9q6T2NruEU1v4xFiT60EqACb0rfPe1s=;
        b=u3zsZBHGmnin5CLYX05aSb+N25cuODM85JE7WXPmqV3Yyug7BKOaLr2cBmh56kgo51
         fCrvoXXvXMXA9aX4H8iN/kEPlPD1fBrgQwfKbxARkJQenLcbpqE4wrMFEf90uvMgyxde
         gxUFX7z96lpJhBJ3yiS1UEUarjILYMfDp6OG48fldIGvactHMhTeEjbAGyZoZDFNexkl
         NHQYUzt7+10lxGpoSuzFrkbKQAw6tX94Hi6L8vp3cURgGg2tBX3IliUdWzg73RgwJQDr
         wznaFK9WCk17nkwzNVoMqm4ecT3rZ1jlGY0b5ZNzq+dEqv99hBsjliDMTu4WBRMfrFJU
         GpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=i4FqtaD2jZeF9q6T2NruEU1v4xFiT60EqACb0rfPe1s=;
        b=nhbZa5k2suHnx35kE2BGZdVAf/yCLqJM07VuJ/pvIgqxw2O05IQO5yFoCAFzDHB0DP
         rTxIL2kuMNRVqOIYd4Na8Tvit81fDnkiXHg4cQgoR4SjOr+kNp4EH0n2ZggdL8pvrg8t
         m8plCBm8md2D9SMHUzNlbsKjkeCCXVHl3RYsFxfcAR4LZ+9ms7NR3NuBodEFHEMAin50
         osuE4oWNNZguVdf/PfDfwmgP1CEARwYQgbFmuHL/KnUC1ew/mQ9ZyPZUIm+DvdnKcJNi
         VTHGmFbQlSfXPCcOssdvie4/IK0xwMr5AK8VKM6SDf7SNdI49MNCASgKVOyC1cR19myi
         zfbw==
X-Gm-Message-State: AFeK/H3gx/3fe4Y79QkfgO9zqclYqwfUmQsUNKYLEBOAXgWsvVRySXfet+er/TrAkTlYNlcsXgsR1Z7A3ErGcQ==
X-Received: by 10.31.1.7 with SMTP id 7mr8613235vkb.0.1489879392646; Sat, 18
 Mar 2017 16:23:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.6.199 with HTTP; Sat, 18 Mar 2017 16:22:32 -0700 (PDT)
In-Reply-To: <xmqqy3w2yybt.fsf@gitster.mtv.corp.google.com>
References: <nycvar.QRO.7.75.62.1703180724490.3797@qynat-yncgbc>
 <CACBZZX5FMdjuxxNru+XfTQdSXEQ_b0OP2rngGZLf1sSHR_D8Ng@mail.gmail.com>
 <nycvar.QRO.7.75.62.1703180750460.3797@qynat-yncgbc> <CACBZZX7G=C84kz4n26VTnWWUTKRv1rVvms=8AvELtMSCviu1kQ@mail.gmail.com>
 <xmqqzigi31fl.fsf@gitster.mtv.corp.google.com> <nycvar.QRO.7.75.62.1703181539310.3797@qynat-yncgbc>
 <xmqqy3w2yybt.fsf@gitster.mtv.corp.google.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Sat, 18 Mar 2017 18:22:32 -0500
Message-ID: <CAJZjrdVxT7G+Cn+1_vqPBCtMOALmR_542jvP7nXXuvs74ko5qg@mail.gmail.com>
Subject: Re: Is there a way to have a local version of a header file?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Lang <david@lang.hm>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Arduino is basically a simplified/streamlined cross-compilation
toolchain with very tightly coupled IDE integration.

I'd just provide a .sample and tell people what to do with it in the
README. The alternative is to provide config.h as is and tell people
to use "git update-index --assume-unchanged" immediately after cloning
to ignore changes to the file, but this is prone to people
accidentally committing credentials.

On Sat, Mar 18, 2017 at 6:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> David Lang <david@lang.hm> writes:
>
>>> Ship a config.h.sample file, have a Makefile rule that is forced to
>>> run before any compilation happens that checks if config.h exists
>>> and then created it if missing by copying config.h.sample over, and
>>> then all other source files can include config.h without having to
>>> know anything about config.h.sample's existence.
>>>
>>> Did I miss something?
>>
>> There is no makefile with the arduino IDE/build system :-(
>
> How does "the build system" you want to make it work with actually
> work?  Is it incapable of "compiling" a "source file" into an
> "object file" that happens to be a text using an arbitrary
> "compiler"?
>
> I was hoping that readers are imaginative enough to replace Makefile
> with whatever way things are normally built with when reading my
> message, and the reader can just replace "source file" with
> "config.h.sample", "compiler" with "test -f config.h || cat
> config.h.sample >config.h" and "object file" with "config.h".
