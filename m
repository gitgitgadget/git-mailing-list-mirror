Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE715C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 18:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C9E0600EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 18:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238704AbhJ0S6r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 14:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhJ0S6q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 14:58:46 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B26C061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 11:56:21 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id r5so2674474pls.1
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 11:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RDBS8vKi73ejSxWxZbzelwTTZCjaBNJZSCaq4rPzQPA=;
        b=FCaRFXdk1qm/3TN7yxRehtdNo23cjnyzHU59iVvrdzgbj2vQKs59iKwa17zCU5PO80
         7TPM10u9x+UY5HftqAWy/kMdhNMsCuLO3sGQ4ILGrWkH9nfN7c6s+AyNOOJCx0ilNrKG
         Y6Ql+F5/VP3/Z9qbCth9U8C6bEbDsKOzdoOwHJauxRVUQzqpq+Ed5ris0yWuCSENPU38
         TrTFwSYItlRZ9BS7DpVdnk9nWlNK2TSdIBGKFIBfOdybQ3jcQAWWA+LVDqUrHpQIOFcW
         b+gB0u+dDPID1crCnlEadOVb6+cCbd+R4B0y2K99EWimuMTaRcd11zR4wp65EpMpaNys
         YD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RDBS8vKi73ejSxWxZbzelwTTZCjaBNJZSCaq4rPzQPA=;
        b=cZYtLFBYJ7P2LcPLjMYaNNjbHlWZnpGBk5MPg0gcg+qZ2/A2dErma0DkuomgGOyzVr
         rNDJVqN3Jslkrsrrpg9z7+EdjXe6nlyIxj0koU7JnIJcX0eaLnodOxGAinafidjeOP7j
         9B2Cu5V9WspgLrDfV+UQ0+XIBEHjvzautAeP9yjljln/3+mgwko5SbOojp/XvkbLskgX
         EO82azxO3hUNBC1QZChl93lCfOkjdVQJn5xKAyO7cvegrHnztqZPr8rO4uHNfiaK/wvN
         eO8zjr3f207pFIYo3QruCcP4Ws24OtKFYygSNF7Mi/WKEzjAjZnUnE/brWnB6Tndi+3k
         QGXg==
X-Gm-Message-State: AOAM532nDhXVNN8UBLEmRVbuSlYZ1BUhhb8GE5IUaoUJjYL+d3K5H1ds
        VYCkepMtaNazmwV5cwv5CWj6otWCXiGz+AIVNxY=
X-Google-Smtp-Source: ABdhPJy+4lRLnA07XE5Jg9s4OE7RAZSCz8SPeQTh4uZTl1vLeP28eXgHWKPaeTWmqMbF+70uU0Y/164g53MmcyeUnQ0=
X-Received: by 2002:a17:90a:430d:: with SMTP id q13mr7765987pjg.112.1635360980682;
 Wed, 27 Oct 2021 11:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
In-Reply-To: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 27 Oct 2021 20:56:07 +0200
Message-ID: <CAN0heSpRZy3+jyc09NEj4NJk4zN4X_RyVk33F5c6tyUE2qMGzQ@mail.gmail.com>
Subject: Re: [PATCH] doc: fix grammar rules in commands'syntax
To:     =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 26 Oct 2021 at 21:35, Jean-No=C3=ABl Avila via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> --- a/Documentation/git-archimport.txt
> +++ b/Documentation/git-archimport.txt
> @@ -9,8 +9,8 @@ git-archimport - Import a GNU Arch repository into Git
>  SYNOPSIS
>  --------
>  [verse]
> -'git archimport' [-h] [-v] [-o] [-a] [-f] [-T] [-D depth] [-t tempdir]
> -               <archive/branch>[:<git-branch>] ...
> +'git archimport' [-h] [-v] [-o] [-a] [-f] [-T] [-D <depth>] [-t <tempdir=
>]
> +              <archive>/<branch>[:<git-branch>]...

Your rewrite makes it seem like one would write, e.g., "myarch/master"
with a literal slash, whereas my initial thought was that the original
tried to express something like "(<archive> | <branch>)". But I have
zero experience with "GNU Arch" and git-archimport, so I can't really
tell whether your rewrite is for the better or not. :-)

In any case, this document goes on to write "<archive/branch>" several
times. Supposedly, they would all want to be changed as well. There's
also an instance of "Archive/branch identifier ..." to maybe look into.

> --- a/Documentation/git-cvsimport.txt
> +++ b/Documentation/git-cvsimport.txt
> @@ -9,11 +9,11 @@ git-cvsimport - Salvage your data out of another SCM pe=
ople love to hate
>  SYNOPSIS
>  --------
>  [verse]
> -'git cvsimport' [-o <branch-for-HEAD>] [-h] [-v] [-d <CVSROOT>]
> +'git cvsimport' [-o <branch-for-HEAD>] [-h] [-v] [-d <cvsroot>]

> -<CVS_module>::
> +<CVS-module>::
>         The CVS module you want to import. Relative to <CVSROOT>.

Here's another "<CVSROOT>".

> --- a/Documentation/git-http-push.txt
> +++ b/Documentation/git-http-push.txt
> @@ -63,16 +63,15 @@ of such patterns separated by a colon ":" (this means=
 that a ref name

> -Each pattern pair consists of the source side (before the colon)
> -and the destination side (after the colon).  The ref to be
> -pushed is determined by finding a match that matches the source
> -side, and where it is pushed is determined by using the
> -destination side.
> +Each pattern pair '<src>:<dst>' consists of the source side (before
> +the colon) and the destination side (after the colon).  The ref to be
> +pushed is determined by finding a match that matches the source side,
> +and where it is pushed is determined by using the destination side.

This looks like the insertion of "'<src>:<dst>' early on, where the rest
of the changes are just follow-on line-wrapping.

I wonder if this patch could benefit from being broken into smaller
pieces. Maybe a few preliminaries like "change <foo|bar|baz> to
(foo|bar|baz)" and the like, then even if the final patch is "large", it
will not be *as large*? But there are clearly sub-topics here, such as
"change <some_arg> to <some-arg>" and "change arg to <arg>". Or maybe
this doesn't make sense as an approach to cutting this patch into
smaller pieces, but I thought I'd mention it.

> - - It is an error if <src> does not match exactly one of the
> + - It is an error if '<src>' does not match exactly one of the
>     local refs.
>
> - - If <dst> does not match any remote ref, either
> + - If '<dst>' does not match any remote ref, either

I believe these match Junio's preference, so ok. But again, this looks
like it could go in a separate patch from a lot of these other changes
as a way of keeping to somewhat focused changes.

> -               (--[cached|deleted|others|ignored|stage|unmerged|killed|m=
odified])*
> -               (-[c|d|o|i|s|u|k|m])*
> +               [--(cached|deleted|others|ignored|stage|unmerged|killed|m=
odified)...]
> +               [-(c|d|o|i|s|u|k|m)...]

Sort of cute how this saves on repeating the "--" by pulling it out.
Anyway, nothing new in your patch. :-)

Thanks for unifying these things.

Martin
