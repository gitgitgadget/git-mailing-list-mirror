Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DC3F1F404
	for <e@80x24.org>; Sat, 11 Aug 2018 09:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbeHKLde (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Aug 2018 07:33:34 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:34997 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbeHKLde (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Aug 2018 07:33:34 -0400
Received: by mail-ua1-f67.google.com with SMTP id q12-v6so4403642ual.2
        for <git@vger.kernel.org>; Sat, 11 Aug 2018 02:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6PcfItYY16RVYhMqNb0M1O6UFLwpZmRaZvUJufJ1UnE=;
        b=U25XB+mdLBQplASIP3FhTQBy8s0lKhuWUrXuQPKM5OAUy89IdbSpy/OeBmldbZZ47Q
         kxJAuX73xqqV6i3Rmky+R8Ffu0G6Fn9mnIO1iz0w0envK7bEK85eS8rpoTOsUdjsmb9k
         1Ym25Hdfoh8foDei8C3IRrKJ78Pln3hPGEzgE2NKwxbTB8rvk99PX6g4tz+prY6c1SaR
         Aq+uIrSgGzWPqNT75+MBzAYsqGzSThleLc24wKiNdYaZXrzQgi4yE+i4VgJ8472KIDDA
         8PR+jYAytD1ChEkL6g4grVfuWxUZkCn89atEerWFP7bt7CCF2jxsr6YJW2r68FQhOrtu
         MUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6PcfItYY16RVYhMqNb0M1O6UFLwpZmRaZvUJufJ1UnE=;
        b=TiGHCgrPqoxXj4bZIexOMVxnTy32/7P82dY0ogLwE0Q8Gma12lD1hmWymgLrPOPs55
         Gi712bTWMnNbvvG3kiUAgdGb0NmtYslw7PRVtSwPsoI97n//+d521QjU2yHU7xBOC/LF
         gBj61And682/SLMw+OW81Zkfs0QI3aL+/hGHbAEr0KBmDi9J3BCBBdN6zzvQVkRh0TUN
         t9j1toCbSWwAcTi03RleL2j4KenQQEC8o3VlFJWCkXmRHtck+4CoWpAXOhfbl8l9Cts7
         AxFs27Ez/ahkBOWENG/HOxi7gRYCbFqoTdWMFyyc1EHhkVcPiJE7pEtmz9CLLdfD7ALC
         iJbQ==
X-Gm-Message-State: AOUpUlFu7Fn4fDUaA2oWyVGU8wJPJ2lyLPKTjy5q/sTDZWoUafUxWZK0
        w/47XoBX3/zowThwid/fZIDRS1a8+1PFI0m+lSY=
X-Google-Smtp-Source: AA+uWPwj9AKQCdoURWsvpaiazqG0Z0imYBXZB5rL9sPItvmjdkTeLu8rNClf6FDYtQlAyt+SJv8SfXYgJoMs++UKBo4=
X-Received: by 2002:a1f:207:: with SMTP id 7-v6mr6239334vkc.0.1533978002089;
 Sat, 11 Aug 2018 02:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180811043218.31456-1-newren@gmail.com> <87mutts3sz.fsf@evledraar.gmail.com>
In-Reply-To: <87mutts3sz.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 11 Aug 2018 01:59:50 -0700
Message-ID: <CABPp-BEADR15gOrH+GBQxKLZR2fCQwhaPWgf3VS--Z0bTNP0rA@mail.gmail.com>
Subject: Re: [PATCH 0/9] Add missing includes and forward declares
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, danshu@microsoft.com,
        marc@marc-stevens.nl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 11, 2018 at 1:30 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <ava=
rab@gmail.com> wrote
> On Sat, Aug 11 2018, Elijah Newren wrote:
>
> [CC'd sha1dc maintainers, for context the relevent patch is
> https://public-inbox.org/git/20180811043218.31456-8-newren@gmail.com/T/#u=
]
>
> >   * Patches 6-8: These patches might need to be submitted to separate
> >     projects elsewhere.  Let me know if so.
>
> Yes, for sha1dc (your 7/9) it's much better if we submit patches to
> upstream and then submit a patch to git.git to update from upstream, as
> my 23e37f8e9d ("sha1dc: update from upstream", 2018-08-02) sitting in
> 'next' does.
>
> When we build that library we define SHA1DC_NO_STANDARD_INCLUDES, so we
> don't use the codepath you patched, so your description of "I was bit
> yet again by compilation errors[...]" doesn't add up in that case. I
> assume you just started adding stdlib.h where you could grep for
> stdint.h.

The part of my story you snipped in the ellipsis is kind of important,
though: "...and decided to determine which header files were missing
their own necessary #include's and forward declarations."  The way I
did so was making a simple one-line .c file that included exactly one
header, and checked to see if I could compile it (without any special
defines), fixed it up as necessary, then repeated that process for
every toplevel header.

Most of the stdlib.h additions were for the definition of size_t,
sha1dc/sha1.h was no different; without my patch:

In file included from nukeme.c:1:0:
sha1dc/sha1.h:96:43: error: unknown type name =E2=80=98size_t=E2=80=99
 void SHA1DCUpdate(SHA1_CTX*, const char*, size_t);

Your point that we use SHA1DC_NO_STANDARD_INCLUDES normally when
compiling within git, though, does mean my patch #7 is kind of useless
to git.

> When I check out sha1collisiondetection.git stand-alone (which will use
> that path) and compile it, it works fine for me. This is on GCC 8.1.0 on
> Debian, so perhaps that patch isn't needed in that case.

I never said git or its subprojects failed to compile.  I said when I
added another #include of some header to some existing or new files, I
sometimes saw unknown symbol errors.  It's happened before, it
happened again today, and I got annoyed, so I set out to address it.
Sorry if that wasn't clear.
