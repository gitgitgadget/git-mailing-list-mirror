Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEA641F406
	for <e@80x24.org>; Tue, 12 Dec 2017 21:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752566AbdLLVHD (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 16:07:03 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:45684 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752415AbdLLVHD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 16:07:03 -0500
Received: by mail-io0-f196.google.com with SMTP id e204so490504iof.12
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 13:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t+0gq2tIAr4Wmnwd4oY4L+H5WZVe9OzyNE4JG4e1O9o=;
        b=msNrjmk7fMnHedr8snTlBL2CyktsArPqhYdUYaFVMNS8Iku1Zm1T18Z9oCbSE8Dady
         1RCEcNa7wcgeGAX5arBY+hzk9jLtl42/Rh2ELo13UPcXGCKHyNk3u/pzBT/a0saZIR/e
         fAIeIq7AzHCpIWX20gis15Ibg9Z9ry8OL/Z7UPUMbQuC/NAuIqTZyvVF+3elgj1+HVx6
         c/QHQVgOeqnkIEKjGAA8PW2SRErCfwzOqgA7931qlSx4DM5hkrMWdH9RzPskX18LSlBT
         svfaUO6zUGESXiQP4dEO1TTyHp16Wzj7Th0iiHUWFIf0+bh88yPUbW0MHXqQsjtolqyE
         HMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t+0gq2tIAr4Wmnwd4oY4L+H5WZVe9OzyNE4JG4e1O9o=;
        b=Jp5QIUHuqzy8wS7/rLbGNpjzRC8M3oJOjs5OwHZVBYW9sSEnDNQ6xd5w9Q3L2kdaxF
         U01U849UE4QlCPR2jk422KqHvBpDd8TGWN/qudLTqTKb01/IWIUXxxu5u4ZBhVAdiLdR
         1Gqsg71T0rLg9WIq7Jdtb3Wz+/7dy4Z1BYcBvJKAk0by0aGV6ocQhZdR+tmDkaoO25ht
         bwTZYE8A6sodcryvTHXbfo/ECgeCn7CF7brTzUGU8nJW11/6tnaQs/29CMreWxW0mDbo
         jqKh4TXcezmA2ZDwKJPy1PD9oeO2MITXH/nS4cyZ475Oy3qKkidRQpBzgyyuBiELpuqx
         MP0Q==
X-Gm-Message-State: AKGB3mKzNCanUW4Q13k1llWTSSwsrIbVtPNSga4iJhTIQEjOiax4zp2P
        B+Da4PGWF5dz1lWLqTSfCCinGYhTqTv3kP2Lsygegg==
X-Google-Smtp-Source: ACJfBovRiVoPd+iVk0N82vVX+VWJniTsEUqKoqtYcxx4TL+7dzGuhArkjj0u+VFYa8VuRjVebF9nZIgs3hlvzEmgmwk=
X-Received: by 10.107.107.23 with SMTP id g23mr252463ioc.283.1513112822411;
 Tue, 12 Dec 2017 13:07:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.19.167 with HTTP; Tue, 12 Dec 2017 13:06:41 -0800 (PST)
In-Reply-To: <xmqqk1xr204t.fsf@gitster.mtv.corp.google.com>
References: <7272c221-c1b6-ca41-3be4-329275e94b8a@ramsayjones.plus.com> <xmqqk1xr204t.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 12 Dec 2017 22:06:41 +0100
Message-ID: <CACBZZX4DFXYNZyU-QPrun2g4zTpt8u6yE6DsEGsQvOEhUNRd8Q@mail.gmail.com>
Subject: Re: [PATCH] Makefile: allow NO_DC_SHA1_SUBMODULE to be set in config.mak
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 12, 2017 at 8:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>>
>> Hi Junio,
>>
>> Could you please add (or squash) this on top of the 'ab/sha1dc-build'
>> branch, so that I can build with NO_DC_SHA1_SUBMODULE=3DNoThanks in my
>> config.mak.
>
> Makes sense.  The patch looks scary by appearing to move the
> includes far to the front of the Makefile, but it in fact is moving
> the NO_DC_SHA1_SUBMODULE block slightly down and it is a sensible
> and safe move.
>
> I actually think that the block can go even further down, perhaps
> close to the run of choices "what variant are we building?" we make
> at around we have "ifdef NO_CURL".
>
> =C3=86var?

Makes sense to me, do you want to squash this + your proposed edit &
I'll pick it up if there's another version, or I can re-submit.

>> diff --git a/Makefile b/Makefile
>> index 929b49b04..91bbb0ed8 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1042,6 +1042,10 @@ EXTLIBS =3D
>>
>>  GIT_USER_AGENT =3D git/$(GIT_VERSION)
>>
>> +include config.mak.uname
>> +-include config.mak.autogen
>> +-include config.mak
>> +
>>  ifndef NO_DC_SHA1_SUBMODULE
>>       ifndef DC_SHA1_EXTERNAL
>>               ifneq ($(wildcard sha1collisiondetection/lib/sha1.h),sha1c=
ollisiondetection/lib/sha1.h)
>> @@ -1053,10 +1057,6 @@ whatever reason define NO_DC_SHA1_SUBMODULE=3DNoT=
hanks)
>>       endif
>>  endif
>>
>> -include config.mak.uname
>> --include config.mak.autogen
>> --include config.mak
>> -
>>  ifdef DEVELOPER
>>  CFLAGS +=3D $(DEVELOPER_CFLAGS)
>>  endif
