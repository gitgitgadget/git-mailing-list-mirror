Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8979C77B7C
	for <git@archiver.kernel.org>; Tue,  9 May 2023 21:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235508AbjEIVIx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 17:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjEIVIv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 17:08:51 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB202718
        for <git@vger.kernel.org>; Tue,  9 May 2023 14:08:49 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50dba8a52dcso8146a12.0
        for <git@vger.kernel.org>; Tue, 09 May 2023 14:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683666527; x=1686258527;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zoGqVboLMXKtrB/XqohADXMkXWA1rNJABNVcj2s0ev8=;
        b=QU+sKvf1Pi9euFwKIQ55t/o1REqhPNU5+iYVVijnJBi3W7WS4pYzVpanOmgabf+FRv
         CgVgkMjN3n6ejqblJTrCQghfUZGyfogyLKfvGeedjVvOpNJLVQ8ikHwTMY6tDue8W3zA
         6H6vJvwCiGe48zoy/KMUIufiwWkvVhJsNRTv4Dr9v0T5MqGVj2cb+FzNoFAJhrCaLNas
         MD77BfyVKKHLb8orhwACmZd64bxGBNZTcw9HTWOrHmqsNn6mMAFPtBvwoKwBH6uG879H
         lXjw10MXqVFDSX0rQg9grjeZJO8Qm4aQWjyDQ8OEz13pOW0PT6j3VpPndwf9qWT41uEH
         80PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683666527; x=1686258527;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zoGqVboLMXKtrB/XqohADXMkXWA1rNJABNVcj2s0ev8=;
        b=RSVgjbFSXI+9Nk3zzMrjEGqCGMSJOgYtKgNSIGkPT2QQhK9YHJeYRdPugNcNtIRQYG
         pgLim5RNMZidUFExTLuppok8s6OdTln1YFZH0bmVf8e5Scm8SRRPoGlHSxlEcDCzfx2o
         0cH+4cz9kCx0NgnZpRxkMlokzscfE/qbOV6nmh5UBcLvEvxR/RzSUDH94Rw102MlZI3I
         NqpPIfyFjpXvdhDgjpKIGn9BkQLAdsFYw9fqeWUyLfAmfmVUJvnCIVo8chfHtrxS9iDE
         BhAgo1dnXtIqG+qlY2b3MJEDiteXpQHPETe3wdvtNdg8kLAKrAbTGhkRc3rSBnGTJoQ3
         0IGg==
X-Gm-Message-State: AC+VfDwFLFx3Z7AwbJsCKFCw1JrEDbFwAiVcsSqvXHsR13/g0Fwva1Fp
        mnmlP6K98C9YOyoJeh1I5Z7jMwfPkHCoGEv2SpFfGQDPkGBAtElwI/vH7dBM
X-Google-Smtp-Source: ACHHUZ4oidzSrSxtWl/ovh68REsqUQwK5Q/k1Ykl6QRk2/zkKvfqY5pXLoVsHep8bwmNjIxjCx5CWFHAuM3Gjk3nmxs=
X-Received: by 2002:a50:8e58:0:b0:4bc:dee8:94ca with SMTP id
 24-20020a508e58000000b004bcdee894camr11edx.7.1683666527132; Tue, 09 May 2023
 14:08:47 -0700 (PDT)
MIME-Version: 1.0
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Tue, 9 May 2023 14:08:35 -0700
Message-ID: <CAJoAoZmNsqhNkSv+B071S3r-hfMbZa_Sd-SJAT09-BeDbG9cRQ@mail.gmail.com>
Subject: Video conference libification eng discussion, this Thursday 16:30 UTC
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello folks,

Google is hosting a standing engineering discussion about libifying
Git, for contributors interested in participating in or hearing about
the progress of this effort. Expect this discussion to be free-form
and casual - no powerpoints here!

We're hoping to hold this meeting every Thursday at 9:30am Pacific
(16:30 UTC) via Google Meet.

To get an invite to the video conference and the notes document,
please reply to this email. Please also add points to the agenda
(template follows) if you want to raise awareness of them.

We'll choose a topic to discuss at the beginning of the meeting, and
I'll reply afterwards with the notes.

 - (asynchronous) What's cooking in libification?
   - Patches we sent regarding libification
   - Patches for review related to the libification effort
 - (asynchronous) What happened in the past 1-2 weeks that interested
parties or intermittent contributors need to know?
 - (asynchronous) Where are you stuck? What eng discussions do we want
to have? (We'll choose a topic from this list at the beginning of the
meeting.)
 - Session topic: <TBD>

The notes from last week follow - my bad for not getting them out sooner.

 - What's cooking in libification?
   - Patches we sent regarding libification
*   Strbuf cleanups (all except patch 7/7 has been merged):
https://lore.kernel.org/git/CAFySSZAOqX0pESfJ-7bYg9iR2RDB9PL6sC4Kcvr\_zitdQ=
1kD\_g@mail.gmail.com/T/
   - Patches for review related to the libification effort
 - (asynchronous) What happened in the past 1-2 weeks that interested
parties or intermittent contributors need to know?
 - Where are you stuck? What eng discussions do we want to have?
(We'll choose a topic from this list at the beginning of the meeting.)
*   Calvin: cleaning up git-compat-util. Git-compat-util contains the follo=
wing:
    *   Includes for standard and external libraries
    *   Includes for internal headers (wildmatch.h, banned.h)
        *   Elijah: I've got a patch removing wildmatch.h - is Calvin
already working on it?
            *   Calvin: Nope, please send, this is out of scope of
what I was looking at so happy to see your patch removing it
    *   Declarations for functions in usage.c, wrapper.c, and various
other files
    *   Conditionally defined includes, functions, variables, macros
    *   Unconditionally defined includes, functions, variables, macros
        *   Some of the macros are for allocing arrays. Alloc.h also
contains ALLOC\_GROW and ALLOC\_GROW\_BY. Should those macros be moved
into a header file like alloc-ll.h or a common.h? I originally thought
alloc-ll.h made a lot of sense, but then then are macros like
COPY\_ARRAY and MOVE\_ARRAY that wouldn=E2=80=99t fit in there
            *   Emily: Would these 4 macros make sense in something
like array.h, instead of packed up with alloc? Does it help at all to
separate this way instead?
            *   Jonathan: Deciding how to slice it is pretty
subjective, better to focus on what users need to include in order to
use the libraries..?
            *   But then, moving stuff from usage/wrapper into their
own headers might be a good idea.
            *   Better to focus on "we need to move it for $REASON"
than for organizational purposes?
            *   Randall: Historically, the purpose of
git-compat-util.h is to allow all the platform-specific stuff to be in
one place. If we're moving alloc stuff away from there, the alloc
stuff is platform-specific, so it might add some complexity, right?
            *   Calvin: alloc has #ifdef alloc\_h, i'd like to leave
those platform-specific ifdef'd stuff in git-compat-util, but the
unconditional platform-agnostic stuff might make more sense to stand
alone and reduce the volume of git-compat-util.
            *   Randall: Yes, having git-compat-util contain only
platform-dependent things.
            *   Elijah: banned.h is maybe an exception, because it's
required everywhere just like git-compat-util is=E2=80=A6?
            *   Calvin: see point below about git-common-header.h
*   I want to lessen the scope of git-compat-util to the following
    *   Includes for standard and external libraries
    *   Conditionally defined includes, functions, variables, macros
        *   Unconditionally defined includes that are directly used by
conditional includes can still be left in here
*   Which means the other items belong in different files. I propose:
    *   common.h
        *   Unconditionally defined includes, functions, variables, macros
    *   usage.h, wrapper.h, etc.
        *   Declarations for functions in usage.c, wrapper.c, and
various other files
    *   git-common-header.h
        *   #include "git-compat-util.h"
        *   #include "usage.h"
        *   #include "common.h"
        *   #include "wrapper.h"
        *   #include "banned.h"
        *   This will be included by all files instead of
git-compat-util.h (or we could and move git-compat-util.h to a
different file and rename this file to git-compat-util.h)
        *   Elijah: is wrapper.h/usage.h really needed by everyone?
Otherwise LGTM
        *   Calvin: usage.h doesn't quite exist, proposing to create
it and start to remove it
        *   Jonathan: usage.h also has die()
        *   Emily: +1
*   Elijah: next series is basically ready to send, no more cache.h
>:) moves all the header decls into relevant files instead, so there's
nothing left.
    *   =E2=80=A6and there was much rejoicing
*   Emily: Josh Steadmon will be joining us working on unit testing
into CI etc, looking forward to it
    *   Randall: Can share how we run Git suite on NonStop if that's
helpful, since any libification stuff needs to work there
    *   Emily: Good idea to take a look at Calvin's c-tap-harness RFC,
seems like platform compatibility will be a decision point about how
to make sure unit tests are working on "exotic" platforms
        *   https://lore.kernel.org/git/20230427175007.902278-1-calvinwan@g=
oogle.com/
    *   Elijah: For c-tap-harness, if the unit tests are quite small,
then outputting "test OK" for every test becomes a performance
bottleneck. Are we batching those test plan outputs somehow? Some
other performance thing?
        *   Emily: benefit of having a source fork is that we can fix it
        *   Randall: c-tap-harness uses autoconf that's beyond what
NonStop can support. Major issue for NonStop on other projects
        *   Elijah: but if we're bringing it in as a source dep then
we don't use autoconf and we can just build it with make, right?
        *   Randall: also isn't it in cpp? Will we be able to use it?
        *   Calvin: I compiled it as C in the RFC so I think we will be ok
        *   Randall: oh, yeah, it's C89 so it will be OK for us since
we guarantee C99
        *   Calvin: no fork up on GH or something, but you should be
able to apply those rfc patches to master and try it out
