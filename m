Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C06181F419
	for <e@80x24.org>; Fri, 15 Dec 2017 17:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755554AbdLORcO (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 12:32:14 -0500
Received: from mail-it0-f53.google.com ([209.85.214.53]:46815 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755504AbdLORcN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 12:32:13 -0500
Received: by mail-it0-f53.google.com with SMTP id t1so21173428ite.5
        for <git@vger.kernel.org>; Fri, 15 Dec 2017 09:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uq14GtcvLa2Emt8GCYWLBWjm4Epyi4dLZOIZdxbeQkU=;
        b=O5Dyn0ewFqpwuJP9C4/xqSX0+KCeasgQVRMfYvAs9GLLB+YVM4WLm4qvFnOy9XagfN
         GzmiBCYpjsfsF74jpA6ArjQoCe1QxHEQztpXwHnMu+JATRJy7Dj/fKZ9LVV7+mgTDfb9
         1gPGJ5bb5MXowVLtSMVQ7eGTtpwQWUW3JSzl05eHu691r5Zi2KRbRq7+qo1JmbIS12R7
         mYla22+9hZiFne+QCXuxGfcHp5BImb8nUifPlJP1KAqNs9frtkg8/YZaqfX3WkZdyDMT
         AK4YYGQ+UaJG+Gge9rrhDwhXmsZA7TnlPv46m4kBFJ1Vr/NmvanCgGzE5rRs4Tm66YFk
         xm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uq14GtcvLa2Emt8GCYWLBWjm4Epyi4dLZOIZdxbeQkU=;
        b=kUrbpA23SPlzdU4qzmU1PQMPaLEVJQXF/hrqaVpe5CNvuOO02dSpH7frgOvZnL3nnL
         oaxegMb72k2ed9eEWI/7eZj+m476VVDLl2VsusXitoRAHdP0FIuGFCtYMHiGQg+mEyJS
         CqDzGMkOdJWLJheSYkMsq1+YJ6WXzV8vFFRT8I3du/U00Q44ya0/3VtpvX0SkRiPbCio
         VWLIw+6R8d4VT5nq24KhflJ/K9kL3iocv6bD2zqXLAK91Wl3jklV5Bjs1VsKFXFvxOiC
         H7N5Wzhn/yTTNzW5zVSf6XnSJxGfXulUij7JSRbsGC3i/nbX4ML7PCMeFjciiZAHAm2e
         eRHg==
X-Gm-Message-State: AKGB3mJrQo0siGuNDHWcUqsc+YQPDWZLpT/2MecvOEUOAKr5jo7tuYGa
        DpJxEEmZP2548+1jC4abFdIXNMoqPwDWcM5eyMyAjA==
X-Google-Smtp-Source: ACJfBou9QHNWqQuSa1hMkZ6owxKLSJijjoHiRcOyRglWgam0uA67lhZzNAIM5lUPIRETCucj01AM8vXS2h+2oVoaYA4=
X-Received: by 10.36.175.17 with SMTP id t17mr10078237ite.66.1513359132601;
 Fri, 15 Dec 2017 09:32:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.19.167 with HTTP; Fri, 15 Dec 2017 09:31:51 -0800 (PST)
In-Reply-To: <b8b4534f-1eda-ee52-faed-ec5188c2ad35@grubix.eu>
References: <20171129195430.10069-1-avarab@gmail.com> <20171210211333.9820-1-avarab@gmail.com>
 <003f01d37390$ed0e0440$c72a0cc0$@nexbridge.com> <87a7ynd1ml.fsf@evledraar.gmail.com>
 <b8b4534f-1eda-ee52-faed-ec5188c2ad35@grubix.eu>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 15 Dec 2017 18:31:51 +0100
Message-ID: <CACBZZX4ZqVm2HnAbKjdZV=95gq4s7b=gycH3x-sd+zJiWEgDfg@mail.gmail.com>
Subject: Re: [PATCH v3] Makefile: replace perl/Makefile.PL with simple make rules
To:     Michael J Gruber <git@grubix.eu>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Alex Riesen <alexander.riesen@cetitec.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Casey <drafnel@gmail.com>, Petr Baudis <pasky@ucw.cz>,
        Gerrit Pape <pape@smarden.org>,
        "martin f . krafft" <madduck@madduck.net>, Eric Wong <e@80x24.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Joachim Schmitz <jojo@schmitz-digital.de>,
        Bill Honaker <bhonaker@xid.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 15, 2017 at 11:35 AM, Michael J Gruber <git@grubix.eu> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason venit, vidit, dixit 12.12.2017 23:=
26:
>>
>> On Tue, Dec 12 2017, Randall S. Becker jotted:
>>
>>> -----Original Message-----
>>> On December 10, 2017 4:14 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wr=
ote:
>>> Subject: [PATCH v3] Makefile: replace perl/Makefile.PL with simple make=
 rules
>>>
>>>> Replace the perl/Makefile.PL and the fallback perl/Makefile used under=
 NO_PERL_MAKEMAKER=3DNoThanks with a much simpler implementation heavily in=
spired by how the i18n infrastructure's build process works[1].
>>>> The reason for having the Makefile.PL in the first place is that it wa=
s initially[2] building a perl C binding to interface with libgit, this fun=
ctionality, that was removed[3] before Git.pm ever made it to the master br=
anch.
>>> <big snip>
>>>
>>> I would like to request that the we be careful that the git builds do n=
ot introduce arbitrary dependencies to CPAN. Some platforms (I can think of=
 one off the top, being NonStop) does not provide for arbitrary additions t=
o the supplied perl implementation as of yet. The assumption about being ab=
le to add CPAN modules may apply on some platforms but is not a general cap=
ability. I am humbly requesting that caution be used when adding dependenci=
es. Being non-$DAYJOB responsible for the git port for NonStop, this scares=
 me a bit, but I and my group can help validate the available modules used =
for builds.
>>>
>>> Note: we do not yet have CPAN's SCM so can't and don't use perl for acc=
ess to git anyway - much that I've tried to change that.
>>>
>>> Please keep build dependencies to a minimum.
>>>
>>> Thanks for my and my whole team.
>>
>> I think you should be happy with this patch then, and it doesn't add any
>> more CPAN dependency than before, and sets up a framework (as discussed
>> in [1]) where we can use more CPAN modules while not requiring packagers
>> such as yourself to package CPAN modules.
>>
>> However, it doesn't sound believable to me that even on NonStop you
>> can't install any CPAN modules whatsoever.
>>
>> That would also mean that this patch doesn't work for you, because it
>> means that you either don't have anything resembling a hierarchical
>> filesystem on which git can be installed in the first place (in which
>> case it wouldn't work), or perl doesn't have an @INC to search through
>> perl libs on on NonStop. What does:
>>
>>     perl -V
>>
>> Return for you on that system?
>>
>> If this patch works, and if at the bottom of `perl -V` you see some
>> directories which you could write a package to drop some static *.pm
>> files, then you can grab a *.tar.gz from CPAN such as the one for
>> Error.pm[2] and arrange for the *.pm files contained within its lib/
>> directory to be dropped into one of those @INC directories.
>>
>> It may be that some aspect of the CPAN toolchain is broken for you, or
>> even ExtUtils::MakeMaker, but you typically don't need that to package
>> non-XS perl modules, certainly not any of the ones we've discussed
>> possibly bundling up in git.git on-list recently. As a (very occasional)
>> contributor to perl.git I'd be interested to know if that's what you
>> mean is broken, and if so see if it could be fixed for you.
>>
>> 1. <CACBZZX58KpQ7=3DV8GUFfxuMQq_Ar6cmmoXyPx_umUTbU19+0LCw@mail.gmail.com=
>
>>    -- https://public-inbox.org/git/CACBZZX58KpQ7=3DV8GUFfxuMQq_Ar6cmmoXy=
Px_umUTbU19+0LCw@mail.gmail.com/
>>
>> 2. https://cpan.metacpan.org/authors/id/S/SH/SHLOMIF/Error-0.17025.tar.g=
z
>>
>
> This patch (currently in origin/next) makes a ton of tests from our test
> suite fail for me on pretty standard systems (Fedora 27, CentOS 7.4.1708)=
.
>
> Is there anything I'm supposed to do differently now to make our test
> suite run? If yes then a clear and short hint in the patch description
> would me more than approriate.

This is a bug in my patch, I can reproduce it on CO7. Will figure out
what's going on there...
