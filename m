Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9273F1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 18:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752626AbeCZSzo (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 14:55:44 -0400
Received: from mail-yb0-f175.google.com ([209.85.213.175]:43060 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752401AbeCZSzn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 14:55:43 -0400
Received: by mail-yb0-f175.google.com with SMTP id z5-v6so6742919ybo.10
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 11:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pf3UavO8PtVnuDSt18WCr63z1VtFU0nhwev9tJaXEwk=;
        b=lyc5WRNSW33C38JGqRgx6Fq3JUkmgrM8hfyzYKURkqN4yP408kpoDKENOBpt6RABTz
         YyY0AVwwnox/hSiv9siMOonnujTQMrgacAI+j3RXoCwCSVaFG+sEXCNPEjV+O124pTcw
         Bg2/jjUNpT1etSGP+NZumBs9kA8owdyd7qlvbIyaJS1aDpGdC8X4qiT4e0FkYnwYdq+G
         KZs65GuBjS8vjtNT7fySUBgW7MZ9T+qDviChRb9cVp0texSjn2G9uvMV06MKpE+UUI30
         F+MH3nmv3pPEU91AwxbKamAd2XppxwxCP+wLKzAUju2hnOS1zrFXzkkluPIbXKxTR/B8
         IZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pf3UavO8PtVnuDSt18WCr63z1VtFU0nhwev9tJaXEwk=;
        b=dGbrtBhCWajspvF+zRPq6eUDHyBKguATzxxZdI7GOLIWrhE+qrZYplUwXOEgjD0+L5
         iOuhatSNMlA34oReLQ9cx+Ldcw/XKpYBP9cfzVTD2n3dGGZnDYLA0000bCXDCV/4242N
         NnX/Qm809VqFClC6Sjsw3Kxy3hqMK+otTEwoNU9GBLnnj6N6+FPfe5zc92NWNXJWJ+rB
         AaeTq30RCwflhmxPC1vYxbnZBMWOxEzeP5/n88ErHXwouY+eXxLvstzro03K97lxWtA0
         yeDNb6nbonos9YiQp+De7ZMIw01UT1AfUuB0ujOwpl4rULSuMILGjFrNxWLei+xEfO1Y
         MsSA==
X-Gm-Message-State: AElRT7GKWpIENPpBoHFYDMqB4YdCJLdv17pd9I2KD0aPyV+2wdBKVtLn
        prpM5ZnBkkGhn9E13oZvRAZ1XTSEfjOt/4mDZ7ccn3JZ3MI=
X-Google-Smtp-Source: AG47ELtsV2OU/PrWNDIOnTve2A3Ed1OBIwq3/ycubJEsrUGVuJALbgys2GX2J7hm1fyK6IovMmkhX5i01A2iYZrcNgE=
X-Received: by 2002:a25:2782:: with SMTP id n124-v6mr24790169ybn.307.1522090542396;
 Mon, 26 Mar 2018 11:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAA7Y+T3OdaSBcqPmfJcVbPTjY=VFnvx9PH-rW9utQ4mXce+S8w@mail.gmail.com>
 <xmqqk1u0f6ha.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk1u0f6ha.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Mar 2018 18:55:31 +0000
Message-ID: <CAGZ79ka4Xfx3x09VtDOM9tD68et-DFPNCcSvJhB4G_Hb-+oPew@mail.gmail.com>
Subject: Re: query on git submodule (ignore)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     pashnidgunde@gmail.com, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 25, 2018 at 9:46 AM Junio C Hamano <gitster@pobox.com> wrote:

> prashant Nidgunde <pashnidgunde@gmail.com> writes:

> [cc: stefan, for his interest in improving 'git submodules']

> > Hello,
> >
> > I am new to this community ,so please ignore if I am asking anything
silly.
> >
> > Case :
> > Today when I built my submodule , and did a git status , it shows as
modified.
> >
> > After reading certain suggestions on web i found out that i can ignore
> > that adding a line in .gitmodules
> >
> > But, I had to add that line manually ( which could be errorprone
> > because of typos )
> >
> >
> > Question:
> >     1. Is it feasible to build a feature like :
> >                    git submodule "zlib" ignore dirty ( which will
> > ignore submodule zlib when its built and dirty  as it has new files in
> > its directory)

> How does it prevent you from saying

>          git submodule "glib" ignore dirty

> when you really meant "zlib"?  How is the command supposed to know
> that you did *not* mean "glib", which may currently not exist in the
> index nor in the working tree yet but you are about to create, and
> doing the "ignore dirty" configuration as an earlier step of
> multiple steps to add a submodule?

> I personally doubt that the main issue you should be concerned about
> is feasibility.  A larger issue is how it is supposed to help, iow,
> is such a "feature" useful in the first place?

> Whenever you hear yourself say "I have to do X manually, and I can
> make mistakes. Can a command do it instead?", you have to ask
> yourself: what pieces of information do you give to that command,
> and how do you ensure you do not make typos on that command line?

> Besides, the above syntax would not work.  What would a user do when
> a submodule called "add" exists, for example?

I would think this can be solved by reordering the command to be

   git submodule ignore [--option-for-granularity=dirty] [-- <path-spec>]

However for now this would be a shallow wrapper to

   name=$(git submodule--helper name <one submodule path>)
   git config submodule.$name.ignore dirty

if I understand the requested feature correctly?
Instead of coming up with each name for each submodule path
(btw name and path are most often the same any way,
just put it here for correctness), one could also use

   git submodule foreach -- \
       git -C .. config submodule.$name.ignore dirty

as the foreach already populates the $name variable.

Stefan
