Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31F5A20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 16:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbeLKQQ6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 11:16:58 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:45910 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbeLKQQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 11:16:57 -0500
Received: by mail-ua1-f68.google.com with SMTP id e16so5313197uam.12
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 08:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DVch0bZKpNf6/rEeUbHEKOOPIx9R3lNW3r+wm5tAP6I=;
        b=TN1sFr3NpUWVdTvNg4+gPERQqyVvJmMjwsw/UY5ifISZO2XXy6FVqac+wmGadgASxX
         NEy+yzwe4kUuJ1L7hKaAWN8uVhIwEPYiEwO57StuRBH+61LFVxirOBJHKzosNM1jhz9G
         cwzD4PHXgTAaVB5nhmyapVgcQI900poCSlY8vwSkJP7MzSwnBpGTz4SJV+Z6c3Ln7Yln
         A2QmRThQ1qIAZREYUurc1bp2RbFaPw1GWlGU1lxaruGzGwHO7dKCXw3EPtlXhf2i/M10
         3+pt4n6sH9nCKL+cpZ53Go3iaPUWJhatKMp/SDc7WyLUpl/xmslKmGqYpxZLSSfU/h0L
         IHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DVch0bZKpNf6/rEeUbHEKOOPIx9R3lNW3r+wm5tAP6I=;
        b=Xj3/YsRRyEz6bIXR1ANdTViI9K/cY3sGd5XH4Z51FmLKLGZLW0vhbXErWLov5EYcdh
         uLemaIGoQKhdtsAN0rCR4xXP1wSOAZGBvsATahz1tXTRO/fIQh0SXUnjnJOV1Adc6TMC
         xuiK0PoL+XjczLeclrq3fcPeyU8TeNNbkaAScKEsZ881o26eInUUuJoTYRG4wpd0ZsEq
         2LyBWYhxa1QYKoutwBbsKicOVTAuru1ItOK4FHMYI2WOOVPNeSQOUelE4SHNz2tqwvI1
         w9S4TdJfPZTEYHsF3H6rC4tlgfOJtTPhr5aBdKoNvfdnC45deICM1AWh2Kt2y/YVvfhm
         vROA==
X-Gm-Message-State: AA+aEWZ4JecgXNshmh+4cMRFpnPk5WUzqlEKpsUUXO8s7JL1NFTjpzoe
        PwzyuSwNHreExKDHOwev0tQI+OD0N0mqLmthJKo=
X-Google-Smtp-Source: AFSGD/XGjK3QzpeVIQxg8s7N16p8kq29jHqm/kCe3a+m/IzcJk0dNYkAKxOkWm5Ki6lNpsa+NJrZ/E5KmV9zEaCBUow=
X-Received: by 2002:ab0:210e:: with SMTP id d14mr7761271ual.20.1544545016404;
 Tue, 11 Dec 2018 08:16:56 -0800 (PST)
MIME-Version: 1.0
References: <pull.90.git.gitgitgadget@gmail.com> <05d8792d12e692eeefa0021e8686b7211a055593.1544468695.git.gitgitgadget@gmail.com>
 <CABPp-BGoJxKFFu+JE9n52t8Fygzf0+mpPSOo8rftR2v0_i+eZw@mail.gmail.com> <nycvar.QRO.7.76.6.1812111104561.43@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1812111104561.43@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 11 Dec 2018 08:16:43 -0800
Message-ID: <CABPp-BHENhW=uz6=_gzELNOd15JWfH1ymtxVRFMD284FLBFtKg@mail.gmail.com>
Subject: Re: [PATCH 1/3] rebase: introduce --reschedule-failed-exec
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Tue, Dec 11, 2018 at 2:14 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Mon, 10 Dec 2018, Elijah Newren wrote:
>
> > On Mon, Dec 10, 2018 at 1:18 PM Johannes Schindelin via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> > >
> > > @@ -1195,6 +1201,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> > >                 break;
> > >         }
> > >
> > > +       if (options.reschedule_failed_exec && !is_interactive(&options))
> > > +               die(_("--reschedule-failed-exec requires an interactive rebase"));
> > > +
> >
> > I was surprised at first that you checked is_interactive() rather than
> > checking for --exec being specified.  But I guess this is because users
> > can manually specify 'exec' lines.
>
> Indeed, that is exactly the reason.
>
> > What if the user specifies an implicitly interactive rebase (i.e. no
> > editing of the todo list, such as with --rebase-merges or
> > --keep-empty, or soon --strategy or --strategy-option) and also
> > doesn't specify --exec?
>
> Then the todo list won't have any `exec` lines, and the flag is irrelevant
> (but does not do any harm).
>
> ... except in the case that the rebase fails at some stage, the user edits
> the todo list with `git rebase --edit-todo` and inserts an `exec` line.

Ah, good point; hadn't thought of that case.  Thanks for explaining.
