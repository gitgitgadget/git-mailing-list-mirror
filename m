Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D9A31F790
	for <e@80x24.org>; Tue,  2 May 2017 17:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751212AbdEBRuQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 13:50:16 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:36065 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbdEBRuP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 13:50:15 -0400
Received: by mail-it0-f54.google.com with SMTP id o5so16276593ith.1
        for <git@vger.kernel.org>; Tue, 02 May 2017 10:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ojO1irpSnY0uRN4Kbufd2NylNOfP9hJ8Myqw3Y8fawY=;
        b=KvJ0XJUoSPB5sYbV/SNde6eUbFKOXw55RLfS2uZrfiQvEfsDug5CY+977eFXYgQLwi
         gnV/o08shFGBuiWXommZiyvo6Gyq/BL8Af2XmcUWOU8c4p4Ha5TJ5v47hC3HjTmUJh02
         ib1YguEazGFNRros1UwHKNmd5fnGdv81It36y/Goo3KBHYVjp/YOmg5xcPIwhyObUKh3
         ETt2KbYL/UQ3lunclluIaoMYLflP193dYGYzXqK4Ab7fEDZnFg4QLSCnwmxWEHbOc7Km
         X06mcBmlzxJZH8BLBIZlEMPvhtjErjeZND89N33gw/bvB6zLBEw3n0PTpiTWZ737sLe/
         uepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ojO1irpSnY0uRN4Kbufd2NylNOfP9hJ8Myqw3Y8fawY=;
        b=Spmdf80Si0+sHaKwLq5v8DVN6/mzUbqVXD7bissGHVd/5XObyZVZUjITzKWVHNjwz2
         qx9bDffh+54U2TxC/S1v16WiUJ2lsmLxQZgQMZUoEX7Tt5X49vqZptZgwRWYV2M0sebB
         7YC+dKNwV4wesX397WiQYx37Qip7Dgtct7T53ew68K9DkR2ifzchnFzcA/jZvDHh0+/U
         hriKTn4a2oiOiCVYbOHFDyb7uOK715o9isMIWB3y8NWum6UC6F/Lkvywwbb90dN59iKP
         tAfyRqsRfQoDxY/RQWm1AKmONlvYU2ujg1EM6NmzKmvPXzouBzTHqOJ4YCQ/ZMg/6Yhm
         FDcg==
X-Gm-Message-State: AN3rC/5DcQpN+63KZMBxqlKsLOdvF1IJwR90eMlnH1EOm7+ON/4zZaqX
        8q7pY7E7dpRe83ugUefAu0FRNbD3aQ==
X-Received: by 10.36.124.129 with SMTP id a123mr4601007itd.66.1493747414107;
 Tue, 02 May 2017 10:50:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Tue, 2 May 2017 10:49:53 -0700 (PDT)
In-Reply-To: <20170502174329.GB181268@google.com>
References: <xmqqefw9gmvq.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1705021406510.3480@virtualbox>
 <CACBZZX5M1Pnvw01wP8id75Ja9NJ3nwVfydsX6g0Ys_QD72r6dQ@mail.gmail.com> <20170502174329.GB181268@google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 2 May 2017 19:49:53 +0200
Message-ID: <CACBZZX5_45KnU7qzW2ojJiznmfkef44YGL8-CYkHFLOvhLSASg@mail.gmail.com>
Subject: Re: PCRE v2 compile error, was Re: What's cooking in git.git (May
 2017, #01; Mon, 1)
To:     Brandon Williams <bmwill@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 2, 2017 at 7:43 PM, Brandon Williams <bmwill@google.com> wrote:
> On 05/02, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Tue, May 2, 2017 at 2:09 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> > Hi =C3=86var,
>> >
>> > On Sun, 30 Apr 2017, Junio C Hamano wrote:
>> >
>> >> * ab/grep-pcre-v2 (2017-04-25) 20 commits
>> >>  - SQUASH???
>> >>  - Makefile & configure: make PCRE v2 the default PCRE implementation
>> >>  - grep: remove support for concurrent use of both PCRE v1 & v2
>> >>  - grep: add support for PCRE v2
>> >>  - grep: add support for the PCRE v1 JIT API
>> >>  - perf: add a performance comparison test of grep -E and -P
>> >>  - grep: change the internal PCRE code & header names to be PCRE1
>> >>  - grep: change the internal PCRE macro names to be PCRE1
>> >>  - test-lib: rename the LIBPCRE prerequisite to PCRE
>> >>  - grep: make grep.patternType=3D[pcre|pcre1] a synonym for "perl"
>> >>  - grep & rev-list doc: stop promising libpcre for --perl-regexp
>> >>  - log: add -P as a synonym for --perl-regexp
>> >>  - log: add exhaustive tests for pattern style options & config
>> >>  - grep: add a test for backreferences in PCRE patterns
>> >>  - Makefile & configure: reword outdated comment about PCRE
>> >>  - grep: remove redundant `regflags &=3D ~REG_EXTENDED` assignments
>> >>  - grep: remove redundant regflags assignment under PCRE
>> >>  - grep: submodule-related case statements should die if new fields a=
re added
>> >>  - grep: add tests for grep pattern types being passed to submodules
>> >>  - grep: amend submodule recursion test in preparation for rx engine =
testing
>> >>
>> >>  PCRE2, which has an API different from and incompatible with PCRE,
>> >>  can now be chosen to support "grep -P -e '<pattern>'" and friends.
>> >
>> > FWIW for quite a couple of recent builds, `pu` fails on Windows with a
>> > variation of this error:
>> >
>> >             CC blob.o
>> >         In file included from revision.h:5:0,
>> >                          from bisect.c:4:
>> >         grep.h:16:19: fatal error: pcre2.h: No such file or directory
>> >          #include <pcre2.h>
>> >                            ^
>> >         compilation terminated.
>> >
>> > Maybe this can be fixed before hitting `next`?
>>
>> This will be due to a combination of the build machine not having pcre
>> v2 (but having v1) & my "Makefile & configure: make PCRE v2 the
>> default PCRE implementation" patch, which makes v2 the default for
>> USE_LIBPCRE=3DYesPlease.
>>
>> Is it easy to install v2 on these build machines? Alternatively that
>> patch could be ejected out of pu, or you could USE_LIBPCRE1=3DYesPlease
>> to use v1, but as explained in that commit I think it makes sense to
>> make v2 the default.
>
> Shouldn't the Makefile check for the existence of PCREv2 before making
> it the default?

We can't check for the existence of anything in the Makefile, that's
what the configure script is for.

The configure script does the "right" thing with pcre v2.

The "right" thing being the bizarro pre-existing behavior of "oh you
asked for PCRE? Well let me check if it's on the system, if it's not
I'll just silently undo what you asked for". Which is crazy, but was
there before my patches, so I didn't change it.

I.e. instead of the more sane behavior of opting the user into an
optional library if it's found on the system, and producing an error
if you supply --with-that-library but don't have thatlibrary.so.
