Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D31D61F453
	for <e@80x24.org>; Mon, 15 Oct 2018 15:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbeJOXN0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 19:13:26 -0400
Received: from mail-it1-f177.google.com ([209.85.166.177]:40195 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeJOXN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 19:13:26 -0400
Received: by mail-it1-f177.google.com with SMTP id i191-v6so28260139iti.5
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 08:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DG7DxP/EHc0Nb4iUT9mYBQ2o60NJWUWd865XzGMljy4=;
        b=cZRYMw0PjURSdLK7CtVWoZfOucjI9+7ZmXtuKNEu5dnO2nUuhb+wupRgbZQXkAFyrK
         2XCs5fLI6BCsqQZie3HAfogILa7vH7mEbRTfZMqAKhhEWnlxtpS/3QzhwGGhaDEK1eCR
         YV3vOpeaKnwfzJ/RnyL2s8TVnlxtnEgs4vF1ZFORG6d2cGG8ZtvvbA6kN1hwzm6sX910
         Uo+C2LSDtXcxP0D4BKRq0XEI6cR/71epZ74xUOTtM2ydraiclQA/Jj1Y051dI3tPCbi4
         CPB29zK3+XZwsTf7rNDMpKTB/Z8AlLTRIjCqwUef7HbanZO5+kdrblhMPbrwGcEza5aq
         y0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DG7DxP/EHc0Nb4iUT9mYBQ2o60NJWUWd865XzGMljy4=;
        b=J6RPRvSue/uSfXvgWc4yNOib3MaIxAZ1fEmuK4P7Iu7mrCXQ2w7Hh9oxgEd62U/MHt
         2ts368a0Sj1fPeHXjOcI6jorVFtaZXYFfJqvKBCh+N3NwltaQZd/5+1+8pmtxa1At8T2
         x30Ab2Ys6afbYOLp0cOxtE0hvhoRgAsv2IN4+7E5boW1nkIYbt4nhMTYQFjd5/kvsRLB
         9yA7DLyleMHDp1GGhx2dHq1nLh2onAIJi//C3ngjHbJvEGCf4+V12EgU3PrC/oLkKKt8
         rcCmcQ4xwyoG4Y5hmqh2j0tSRiAH8PEUrH8WiAWvuwPNlSg272FQ/y4G7BV05lmky3NN
         agbw==
X-Gm-Message-State: ABuFfohCzYyMf9tYPAYB5A6QgOqLkI5gGPguYuiKx6Op/NuQ1CldRC1a
        9NVFJ/9kijD0wMgNxNpIIMCtlttAMp+AB0Ices4=
X-Google-Smtp-Source: ACcGV62KYdYHTsFLUtm1SIBlZC6AuecCbw7ZOAyz8tzt8WfCLbO2AAu+RHsL17ukPUkLPLQmWTwyE03LN51ZHIwAZNY=
X-Received: by 2002:a24:cd02:: with SMTP id l2-v6mr13122475itg.70.1539617261866;
 Mon, 15 Oct 2018 08:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <C16A9F17-0375-42F9-90A9-A92C9F3D8BBA@dana.is> <87bm80eo6h.fsf@evledraar.gmail.com>
 <CACsJy8DVSu2Sh34UG4P9aqqEMsY5zOGc61tEizo=0sG4BoSgkw@mail.gmail.com> <xmqqk1mk87d0.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk1mk87d0.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 15 Oct 2018 17:27:15 +0200
Message-ID: <CACsJy8CeD_PtmYoQL-qccHoTg-GaGk0ATMoBUqyi=ER7By+2Rw@mail.gmail.com>
Subject: Re: [BUG] gitignore documentation inconsistent with actual behaviour
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        dana geier <dana@dana.is>,
        Git Mailing List <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 15, 2018 at 12:57 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Duy Nguyen <pclouds@gmail.com> writes:
>
> >> Our matching function comes from rsync originally, whose manpage says:
> >>
> >>     use =E2=80=99**=E2=80=99 to match anything, including slashes.
> >>
> >> I believe this is accurate as far as the implementation goes.
> >
> > No. "**" semantics is not the same as from rsync. The three cases
> > "**/", "/**/" and "/**" were requested by Junio if I remember
> > correctly. You can search the mail archive for more information.
>
> Perhaps spelling the rules out would be more benefitial for the
> purpose of this thread?  I do not recall what I requested, but let

OK I gave you too much credit. You pointed out semantics problem with
rsync "**" [1] and gently pushed me to implement a safer subset ;-)

[1] https://public-inbox.org/git/7vbogj5sji.fsf@alter.siamese.dyndns.org/

> me throw out my guesses (i.e. what I would have wished if I were
> making a request to implement something) to keep the thread alive,
> you can correct me, and people can take it from there to update the
> docs ;-)
>
>     A double-asterisk, both of whose ends are adjacent to a
>     directory boundary (i.e. the beginning of the pattern, the end
>     of the pattern or a slash) macthes 0 or more levels of
>     directories.  e.g. **/a/b would match a/b, x/a/b, x/y/a/b, but
>     not z-a/b.  a/**/b would match a/b, a/x/b, but not a/z-b or
>     a-z-b.
>
> What a double-asterisk that does not sit on a directory boundary,
> e.g. "a**b", "a**/b", "a/**b", or "**a/b", matches, as far as I am
> concerned, is undefined, meaning that (1) I do not care all that
> much what the code actually do when a pattern like that is given as
> long as it does not segfault, and (2) I do not think I would mind
> changing the behaviour as a "bugfix", if their current behaviour
> does not make sense and we can come up with a saner alternative.

I think the document describes more or less what you wrote above in
the indented paragraph (but maybe less clear, patches are of course
welcome). It's the last paragraph that is problematic. It right now
says "invalid" which could be interpreted as "bad pattern, rejected"
but we in fact accept these "*" are regular ones.

There are not many alternatives we could do though. Erroring out could
really flood the stderr because we match these patterns zillions of
time and traditionally fnmatch gracefully accepts bad patterns, trying
to make the best of of them. So keeping undefined "**" as two "*"
sounds good enough.

But of course I'm open for saner alternatives if people find any.
--=20
Duy
