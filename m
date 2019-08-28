Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2E361F461
	for <e@80x24.org>; Wed, 28 Aug 2019 19:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfH1TyB (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 15:54:01 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34744 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfH1TyB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 15:54:01 -0400
Received: by mail-pl1-f196.google.com with SMTP id d3so460681plr.1
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 12:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GkLHBi5IIqdqa7odx/xhWqi+abuLWLP4sOPeXwnBiGc=;
        b=klQBJmgWiUvMAmNhkYcJYdXK8xxZszVdfGrnvglgVtbq4a40bI2+90yyW8Dn8rzIZn
         IXUoshDLL7KSZkMKW7ktqYAeDphhFbXe5fidVEyf6BB+Eztew+l7Af+9vlxvTcmDQvfX
         0d1hNwpdKKdotjoS4vqtpNLtepRGqqz9DdONNb9pzC1B6IpiQ+xDLDn7t2vURaF2lAnZ
         lOJTFb4wwp3GkDrv/6+JJd3Y7CvWh0J6bxGOgtsKtRqSuJgqRC6rQwsYeicaJEEYfdEz
         l1b/6uWH3pJmW0PNopAKUXHv4IvdPrgozY9PBL6d21quwwlVaosgLHnWV+xAwyRqnKWa
         OpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GkLHBi5IIqdqa7odx/xhWqi+abuLWLP4sOPeXwnBiGc=;
        b=a3E9mX215QU10BpzFPWjR+EEtP7qtHUU9dqyJ1C6gANmxfpzO2+EFyxx+QN8SdHgES
         clbwxHeGqnGDvOs0b2Ijpd5y7UvKQPLKS2eyI6kM0986mAzjFVSJe0tYGZrxkIOY/zgU
         CO7O2i6q7TmDuTD8MHy6bjwjipEfSPWV4AbJyZRPsrwycP+9E0v2L956aMlDaUXpstld
         slffcgH79U2tC+Ll2M+kNDHf12CkXWoJ+G/CbnE4U0AScKMvjDNgM1s/HsVsE7RfVuyy
         Q/riu+8KRKzu7OoTfvrjAvitEDP2E+SH0iQl0wJi1t3Mnn/8CW2MAiCXilMYl710Eh+k
         v80g==
X-Gm-Message-State: APjAAAXJRmtXbfjEca28R2y2xUh3sKpFEuHWUWY95Yl1DL1A1rcrrXJo
        8tqszZ/ca5zqN1I/cTeYbDMaOSV1m+HXSRYP2oQ=
X-Google-Smtp-Source: APXvYqyd1bUfVEVxTpd0zsoA3poys5RLaWnzTx1T+hobTvjqCKSJjfr4Pk473czlrO/jyLt4/yxqh1ubiw2o1cDAWko=
X-Received: by 2002:a17:902:c9:: with SMTP id a67mr87152pla.178.1567022040408;
 Wed, 28 Aug 2019 12:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <877e6x3bjj.fsf@osv.gnss.ru> <20190828155131.29821-1-newren@gmail.com>
 <CAN0heSoqy4sCY8NUWKuEkXwe2XxnYAN6Mn2N75hYwfQ_5WGYdQ@mail.gmail.com> <87a7btqeyx.fsf@osv.gnss.ru>
In-Reply-To: <87a7btqeyx.fsf@osv.gnss.ru>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 28 Aug 2019 21:53:47 +0200
Message-ID: <CAN0heSpcFgNwBKHzUjcvb0W46LQwGoOSpihLg1arOPJJKC9PTQ@mail.gmail.com>
Subject: Re: [PATCH v2] merge-options.txt: clarify meaning of various
 ff-related options
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hiya,

On Wed, 28 Aug 2019 at 21:15, Sergey Organov <sorganov@gmail.com> wrote:
> > I was sort of expecting these to be listed in the order "--ff, --no-ff,
> > --ff-only", and I see Sergey suggested the same ordering. The way your
> > proposed text reads does make sense though... Would it read as well
> > turning it over and going through the options in the other order? That's
> > the way it is before your patch, so you could argue "but people don't
> > grok that!". What your patch does well is to offer an overview before
> > describing each option in a bit more detail. Would that work with the
> > reversed direction as well (compared to this patch)? Dunno.

> Dunno if it helps, but here is what I came up with somewhere in previous
> discussions:
>
> --ff::
> --no-ff::
> --ff-only::
>         When the merge resolves as a fast-forward, only update the
>         branch pointer (without creating a merge commit).  When a fast
>         forward update is not possible, create a merge commit.  This is
>         the default behavior, unless merging an annotated (and possibly
>         signed) tag that is not stored in its natural place in
>         'refs/tags/' hierarchy, in which case --no-ff is assumed.
> +
> With --no-ff create a merge commit even when the merge could instead
> resolve as a fast-forward.
> +
> With --ff-only resolve the merge as a fast-forward (never create a merge
> commit). When fast-forward is not possible, refuse to merge and exit
> with non-zero status.

I think this could make clear that the first paragraph talks about
`--ff`. I know that we often list `--foo` and `--no-foo`, say "This
option does bar" and leave it to the reader to figure out which is which.
Most of the time, that's fairly obvious though (foo=bar). With this
tri-state option, we might be past the point of fair obviousness.
Then again, seeing "ff" and "fast forward", it's not /that hard/ to
figure out.

Apart from that, this reads well. Of course with the usual caveat of
the topic being fresh on my mind, so in general, I'd be more likely to
understand what it is I'm reading. ;-)

Martin
