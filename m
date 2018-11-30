Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 106FF211B3
	for <e@80x24.org>; Fri, 30 Nov 2018 12:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbeK3XTy (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 18:19:54 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:41641 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbeK3XTy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 18:19:54 -0500
Received: by mail-io1-f67.google.com with SMTP id s22so4312551ioc.8
        for <git@vger.kernel.org>; Fri, 30 Nov 2018 04:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vCyUweFqpMja6NDyq3Y/JYGMhv4LLe7bV85YW5jONOo=;
        b=SxdbRug+WGP7aUB85npmNwx8dMVTYzeGYV31V2bHcPVMi0w1HI/h+u3nJldI5oeR03
         7hOFx8gEM6BonW+Bl/QaZNSRFm1d4YY7bv/BPTwO6xzKNoWpYUYfcVw3frnv9tx1Nerg
         QppWlTG+pZm2y+at8Bm8pFoWsZ8XV2KFgUqht28pjGgKW5go/hKw0L1XqsHlAyLLE8As
         rAnVVQPZ8681Jycl+dG3MJFeE0JnzN9GTCsUZuJmrkUwYeLjwZLFOrazlmF54ebaAt9G
         OKRafRgbFv9chw5yS3ejMW1z8h4s/jSulPJcX0kQQNW5tskJpE1saAnGy2TKTUwf+f8/
         YfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vCyUweFqpMja6NDyq3Y/JYGMhv4LLe7bV85YW5jONOo=;
        b=ffC+6ZQ5AkWwfG9lND4c/0h9OZMXl1XfPjVv8yucwaRvL40Lj1Wdf440FTuVCdVHxB
         zLwplzKL+NZF/rNHhxZ5f6EKB1eEa1S2+4hjjGgJKEvgkW4VE7/GzGz+kdr3fNQMINCD
         djhZsCSs/JNroAPpDWHpxBvFJV3KrZKRYS9lnkABCrqGwcs1xt8Or+zZF8CrGAZu14/2
         +jfwui3PZux9m4JeoDm6MAiU3DF6bpzUCISlRIZ4bB0Lj5OdjIbJAWr6RxnCn/2jprpp
         OdFN0ply/3y+0JOn2t4VObz00IQCAUTTC9P7ix+S8IbnPmI4FuYrck7rnK4GcLtDfFE+
         kleA==
X-Gm-Message-State: AA+aEWadqMoNcTXdHyD/SAUOQ9+3RNf4H/PGpgV1OlsfMKVvKe5z7Oax
        s0roqEaG/auAmgua7Qs2XpIZZmiH5k/Htmo03Dca1A==
X-Google-Smtp-Source: AFSGD/WVpHSjyw2sIsLB5e8brnW3fUzwPhfrlM7wD/hH0SUNSVEjJzzAQ3/iyScUjZJrKDLDdabn5q/0NiNnIF4LxkQ=
X-Received: by 2002:a6b:6f18:: with SMTP id k24mr3730132ioc.236.1543579849611;
 Fri, 30 Nov 2018 04:10:49 -0800 (PST)
MIME-Version: 1.0
References: <20181127165211.24763-1-pclouds@gmail.com> <20181129215850.7278-1-pclouds@gmail.com>
 <87pnunxz5i.fsf@evledraar.gmail.com> <CACsJy8DCKQctO+rf=xP5gVVUy9XBq35Z1xSbfwB30nDJMMJsrA@mail.gmail.com>
 <87zhtqvm66.fsf@evledraar.gmail.com>
In-Reply-To: <87zhtqvm66.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 30 Nov 2018 13:10:23 +0100
Message-ID: <CACsJy8Cd6OVn9MpcTB=sePZUV-a_h45jkbuTSrS-jasG=2oT4g@mail.gmail.com>
Subject: Re: [PATCH/RFC v3 00/14] Introduce new commands switch-branch and restore-files
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Stefan Xenos <sxenos@google.com>,
        Elijah Newren <newren@gmail.com>, dan@fabulich.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 30, 2018 at 12:29 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Fri, Nov 30 2018, Duy Nguyen wrote:
>
> > On Fri, Nov 30, 2018 at 12:05 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> >> Assuming greenfield development (which we definitely don't have), I
> >> don't like the "restore-files" name, but the alternative that makes
> >> sense is "checkout". Then this "--from" argument could become "git
> >> checkout-tree <treeish> -- <pathspec>", and we'd have:
> >>
> >>     git switch <branchish>
> >>     git checkout <pathspec>
> >>     git checkout-tree <treeish> -- <pathspec>
> >>
> >> Or maybe that sucks, anyway what I was going to suggest is *if* others
> >> think that made sense as a "if we designed git today" endgame whether =
we
> >> could have an opt-in setting where you set e.g. core.uiVersion=3D3 (in
> >> anticipation of Git 3.0) and you'd get that behavior. There could be
> >> some other setting where core.uiVersion would use the old behavior (or
> >> with another setting, only warn) if we weren't connected to a terminal=
.
> >
> > core.uiVersion is a big no no to me. I don't want to go to someone's
> > terminal, type something and have a total surprise because they set
> > different ui version. If you want a total UI redesign, go with a new
> > prefix, like "ng" (for new git) or something instead of "git".
>
> I don't think that's a viable way forward. First, we're not talking
> about a total change of the UI. Most the main porcelain will stay the
> same. So we'd have a "ng" that's >98% the same UI, and then if we
> discover warts in in 10 years we'd like to fix then what do wo do? Ship
> "nng" and so forth?

Yes. So think it through and try not to do it often.

> We already have this UI problem with various config variables that
> change things. I think we should just solve this general issue by a
> combination of:
>
>  a) Accepting that over the long term we will have Git's UI changing,
>     sometimes in breaking ways (with sensible phase-in), hopefully for
>     the better. E.g. we had this with "git-init" v.s. "git init". This
>     is similar, there'd be an error due to ambiguity with a "hint"
>     saying use the new thing if you e.g. feed "git checkout" a branch
>     name.

And I hate adding a zillion of config keys to change little things
like this. Now you use this to change bigger behavior. No.
--=20
Duy
