Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE9221F453
	for <e@80x24.org>; Fri, 22 Feb 2019 10:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfBVKGY (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 05:06:24 -0500
Received: from mail-it1-f179.google.com ([209.85.166.179]:53987 "EHLO
        mail-it1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfBVKGY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 05:06:24 -0500
Received: by mail-it1-f179.google.com with SMTP id x131so2179904itc.3
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 02:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qVCWo9aYGU5iGZRbGU74REyP9LxKxqADphAtbAqLcdI=;
        b=BxMxZAAm4aCU/DKr8iYk+G3IxVXn+ppBQgyxOSOPnlivDfNWB3bAmbjoLD0sQP9yYv
         aMELfZRfsGYM1++kW+IZqIgRkZcYUtwvT++5BHztibliauq2EvmDvnyTG4dJQzKP6NPt
         BzmCqEVWQTaWlBGFdfp3XrIs/RCHyRuEoKeqDFdhq1cc9bvra6dXD57JiDnge1rKx5MI
         uGMqG9UsTXytqH2q/PgIT4lGy7R7ItbT95l/BO8u2qalSPiewn/rFvdX9OhNZ8qtzUXH
         TAeENK4m+/pOBaLeLkTptRWbwZUb6f5MCh1autRKl/CFh7TxmbqaKSrwmGOdRDRj2hh3
         OX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qVCWo9aYGU5iGZRbGU74REyP9LxKxqADphAtbAqLcdI=;
        b=E188ewurf2MSe+Chb7nY6ww5TU2v62sOTqyCRkc16xmhJ4Ks4V2xGLWKwzSH9RNPUF
         iQ2uzd/tC+HC/lmzZPBjPtCkXZvXFGKqRdPOwsC9S8OOiTYmRKXapf9GrgcQkN4MgmZJ
         /pJg1XNoVFz/5aSjPJWqaeiycAgZUlnTEeTIKaG8S7oH4j6xNAqKoS+guQ1BgEjnVfnW
         FGcXyi1QsLQLj8dTOS7j2MD/gCBJ81+NR9HT1UngUJUTXNDGnPVhVOOUEdbd4BwBi5no
         AT+pCR480bDKMl4QOxM7bqBEy0D4E4rmbUKbmX7CVCbmfZXaUgyoCxtxmPgrh9zBSGmJ
         B64A==
X-Gm-Message-State: AHQUAuZADD28PjmUQBSLywNrLgB1Vl8KlZmajeYUmZUYQgBb43ipwwjK
        8aFoLveF+NhrFanKsHLUI2TZ1T7Ex/mPn8gHTOc=
X-Google-Smtp-Source: AHgI3IZKWN307eTt1e0oi8vZjxqgi4q/dtXMOS9GhzRzXVXEnoSzDSheXdkMRzoGZdLvcJm11FWI1Pww/jpnYC/F9K0=
X-Received: by 2002:a24:c056:: with SMTP id u83mr1540251itf.10.1550829983119;
 Fri, 22 Feb 2019 02:06:23 -0800 (PST)
MIME-Version: 1.0
References: <20190125095122.28719-1-pclouds@gmail.com> <875ztc5evt.fsf@evledraar.gmail.com>
In-Reply-To: <875ztc5evt.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 22 Feb 2019 17:05:56 +0700
Message-ID: <CACsJy8DJvxuhVJBpgTNiFHt+0ZOFqm4agvxrJfa2D1jvDojaRQ@mail.gmail.com>
Subject: Re: Ideas for even more compact fetch.output=compact output
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 22, 2019 at 4:52 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Just using this as a bounce-off point for a related discussion, one case
> where I still see duplicates is things like:
>
>     From github.com:git/git
>        a7da99ff1b..28d0017056  next                -> origin/*
>      + e911e946c2...9cc6aca6e9 pu                  -> origin/*  (forced u=
pdate)
>        a7da99ff1b..28d0017056  refs/pull/412/head  -> origin/pull/412/hea=
d
>      + 1dbcd06490...6b1f08d3ef refs/pull/412/merge -> origin/pull/412/mer=
ge  (forced update)
>      + e911e946c2...9cc6aca6e9 refs/pull/444/head  -> origin/pull/444/hea=
d  (forced update)
>      + 8131760e3b...ed5bbbbcec refs/pull/444/merge -> origin/pull/444/mer=
ge  (forced update)
>
> I.e. the duplicate strings for the "pull" namespace I'm fetching.
>
> Now, there's no room with the current syntax to represent that
> unambiguously, I started to patch it, but wasn't sure I liked the syntax
> I came up with.
>
> This is also one of the rare cases where bikeshedding the idea can
> productively done without a patch so I thought I'd start that discussion
> first.
>
> If we had this:
>
>     From github.com:git/git
>        a7da99ff1b..28d0017056  next                -> origin/*
>      + e911e946c2...9cc6aca6e9 pu                  -> origin/*  (forced u=
pdate)
>        a7da99ff1b..28d0017056  refs/[pull/412/head]  -> origin/*
>      + 1dbcd06490...6b1f08d3ef refs/[pull/412/merge] -> origin/*  (forced=
 update)
>      + e911e946c2...9cc6aca6e9 refs/[pull/444/head]  -> origin/*  (forced=
 update)
>      + 8131760e3b...ed5bbbbcec refs/[pull/444/merge] -> origin/*  (forced=
 update)
>
> We could de-duplicate such output. I.e. used [] as "capture" delimiters
> for the subsequent "*" since "[" and "]" aren't valid in ref names (but
> "()" and "{}" are!).

First impression, I think the square brackets makes it harder to read
the left column.

I was going to suggest coloring, which could be used to highlight the
common parts. But I think that would mess it up even more because it
kinda steals focus.

Another option is simply display refspec on the right hand side, e.g.

 refs/pull/412/merge -> refs/*:origin/*  (forced update)
 refs/pull/444/head  -> refs/*:origin/*  (forced update)
 refs/pull/444/merge -> refs/*:origin/*  (forced update)

This keeps the right column boring and mostly the same without losing
meaning, while the left column is left untouched. It does make you
think a bit to find out what the actual ref on the right hand side is
though.

> Or maybe more generally using it consistently throughout, also for next/p=
u:
>
>     From github.com:git/git
>        a7da99ff1b..28d0017056  [next]                -> origin/*
>      + e911e946c2...9cc6aca6e9 [pu]                  -> origin/*  (forced=
 update)
>        a7da99ff1b..28d0017056  refs/[pull/412/head]  -> origin/*
>     [...]
>
> The things that suck the most about this are that you can no longer
> copy/paste the ref on the LHS as-is, and that it'll only show up in rare
> cases, so it'll probably confuse even experienced users.
>
> What do you think?



--=20
Duy
