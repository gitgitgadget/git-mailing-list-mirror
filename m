Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD0041F790
	for <e@80x24.org>; Tue,  2 May 2017 18:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751387AbdEBSwn (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 14:52:43 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:37753 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750770AbdEBSwm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 14:52:42 -0400
Received: by mail-it0-f49.google.com with SMTP id x188so21791081itb.0
        for <git@vger.kernel.org>; Tue, 02 May 2017 11:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hd2JWH+CA+XebPwkP4gOk1PqZ8FEx6gQ2/yCHZSSno0=;
        b=tE90Ll50W778wPLIFN6ZaFNflWY7Xa2u9aKcUBVMmPfFaHgE+RE/XRDVIZ3JNwXZrF
         +WSGUuJO2EwbzpBPmGIXje/TSG5ZTBpneLLLODg8vUuD8muPvr5BcJy1Y2uThvpRz3SA
         kaCXhNLrIN+RZlLWE4uxkK7ucUxKXxOtZzeS1xW+yW9aDQT0Htze+0Z+5+TuxG8DCfaq
         n2KUs3kD+XXdyl38G3uMzh9icYJQcxIK9pzDpqSOj/LXGmJ68tZhmppWlQ7uisJOQZmZ
         JWKOCk450l4rbVEwXfWUlVtz6HgOhJHcl17vj5sfhXON6N6MPQRM/LZmFDdm2fkM6Qzy
         ahAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hd2JWH+CA+XebPwkP4gOk1PqZ8FEx6gQ2/yCHZSSno0=;
        b=SMQ95vL01hwX01vPt0piIcU30ts41IbnAl46WIzgl33IjXAF2RmAaN0/i2CJjQceEl
         8PwzR2WPBmA+aGDvFX6EqlnLRDgWp8JrtfXJFTn2IHt46GpiSenCrK7zSSBFJy5ExUrl
         M0Q1GHV7eQrW1UpQfaOchc2vKbp4OJR7h9CNtrTI/LkU7N/3HvpV478AR7na3f0rP2+9
         OF34/qMnudRZGQurq84JoCOT7Li0eBwEkJGG/4vBHxvHCn6ywGvrC2sKTRcaPiZYu6hi
         y6MPJH0LsaQUnLhVDGjEpsdHAKNrbIROozDQvbUStVrr0GAoDFrV3hifQeFfiLRS5NGO
         nDKA==
X-Gm-Message-State: AN3rC/5BRGZ6e4YUTeK+5IPoR9h6Akog08RlhUk1WnRzs3127U1scbo7
        uAuvjipnHX2x1bgAfHL1N9sCI0h7y8Dl8R0=
X-Received: by 10.36.124.129 with SMTP id a123mr4927064itd.66.1493751161749;
 Tue, 02 May 2017 11:52:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Tue, 2 May 2017 11:52:21 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1705021756530.3480@virtualbox>
References: <xmqqefw9gmvq.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1705021406510.3480@virtualbox>
 <CACBZZX5M1Pnvw01wP8id75Ja9NJ3nwVfydsX6g0Ys_QD72r6dQ@mail.gmail.com> <alpine.DEB.2.20.1705021756530.3480@virtualbox>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 2 May 2017 20:52:21 +0200
Message-ID: <CACBZZX6-qZLEGob6CEwpJ7jtEBG6WLPdHQsO4DsbkNZ8di5mjg@mail.gmail.com>
Subject: Re: PCRE v2 compile error, was Re: What's cooking in git.git (May
 2017, #01; Mon, 1)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 2, 2017 at 6:05 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi =C3=86var,
>
> On Tue, 2 May 2017, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Tue, May 2, 2017 at 2:09 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
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
> Let me put it this way: Installing PCRE v1 in MSYS2 is as easy as
>
>         pacman -Sy mingw-w64-x86_64-pcre
>
> To install PCRE v2, you would have to copy-edit
> https://github.com/Alexpux/MINGW-packages/blob/master/mingw-w64-pcre/PKGB=
UILD,
> make sure that it builds by running it through
>
>         makepkg-mingw -s
>
> possibly initializing a Git repository in the
> mingw-w64-pcre/src/${_realname}-${pkgver}/ directory, patching the source
> until it builds, committing the changes, adding them as patch files to th=
e
> same directory as the new PKGBUILD, adjusting the PKGBUILD file to list
> the patch files with their checksums and to add the commands to apply
> them.
>
> Then (and this is a one time cost, fortunately) initializing two packages
> on BinTray (which we use to serve the Pacman packages of Git for Windows)=
,
> then build and upload the packages.
>
> In short, PCRE v2 would be slightly (ahem, ahem) more involved than PCRE
> v1.
>
> I cannot imagine that MSYS2 is the only environment with that issue.

I think it's worth it to copy/paste the commit message where I made
this change, since we're having this discussion in this thread:

    Makefile & configure: make PCRE v2 the default PCRE implementation

    Change the USE_LIBPCRE=3DYesPlease & --with-libpcre flags to the
    Makefile & configure script, respectively, to mean use PCRE v2, not
    PCRE v1.

    The legacy library previously available via those options is still
    available on request via USE_LIBPCRE1=3DYesPlease or
    --with-libpcre1. The existing USE_LIBPCRE2=3DYesPlease & --with-libpcre=
2
    still explicitly ask for v2.

    The v2 PCRE is stable & end-user compatible, all this change does is
    change the default. Someone building a new git is likely to also have
    packaged PCRE v2 sometime in the last 2 years since it was released.
    If not they can choose to use the legacy v2 library by making the
    trivial s/USE_LIBPCRE/USE_LIBPCRE1/ change, or package up PCRE v2.

    New releases of PCRE v2 are already faster than PCRE v1, and not only
    is all significant development is happening on v2, but bugs in
    reported against v1 have started getting WONTFIX'd asking users to
    just upgrade to v2.

    So it makes sense to give our downstream distributors a nudge to
    switch over to it.

So that's why I did it. I also looked at several Linux distros & BSDs
/ Solaris and they have it packaged, although some not for their
current stable release but for their "next" release, but that's likely
what they're going to be building a new git for.

But, problems with this:

 * Debian testing has ~600 projects that rdepend on pcre1, with ~15
that rdepend on pcre2. Git would definitely be the most prominent
project using pcre2, it seems 2 years after release few have bothered
to switch over.

  Thus even though it came out 2 years ago it's likely that a few
platforms like MSYS2 simply haven't bothered to package it yet
(although packaging it is trivial if you already have a recipe for
v1).

 * There's no set of compilation flags that work before & after my
patch to request v1. I.e. before we only have v1 via USE_LIBPCRE=3D1,
now we have USE_LIBPCRE1=3D1 for v1, and either (or both) USE_LIBPCRE=3D1
& USE_LIBPCRE2=3D1 for v2.

  I can't think of a good way out of this that doesn't both make sense
Makefile UI-wise and allows the same CI script to Just Work as this
change migrates from pu->next->master.

 * Due to the bizarro existing semantics of the configure script noted
upthread if you have a git build script that does --with-libpcre & you
have libpcre1 installed, it'll link to it, but now since
--with-libpcre defaults to libpcre2 it'll silently skip linking to it
if you don't have it installed.

  Arguably the first part of this series should be to change this
behavior so we don't silently subject distributors to this bad
behavior when and if we migrate to v2 by default, i.e. we should
detect & use a PCRE we find if it's there, and if the user explicitly
asks for --with-libpcre and we can't find whatever the default is we
should error out.
