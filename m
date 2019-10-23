Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 934491F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 04:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733222AbfJWEzZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 00:55:25 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46501 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733196AbfJWEzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 00:55:25 -0400
Received: by mail-ed1-f67.google.com with SMTP id r18so14648388eds.13
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 21:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xu1u/V2d6cq8kPfctR0fVpHYng4RNCLrdcRzot4vz+4=;
        b=Xkn4TSr0LiobnnC4Ge7X8s0LHMoGWjZyz0qXu1hARzSaMYMQM62VgH5pFW7eGla7rd
         Lr1uJ4us6vVqt8ve9JPyWUkTJTDxAy9NHgI9+OIz/M5nj8J29nJMq3+gYMoGY+tnZUxt
         khw1dgvkr2rkdAgvnnAx12I4FK5xgs8bE5nXLKqQ4bJ0HP6J6SF4/zT69EQXi03JO4MT
         3cdx7ErY0gCm6AZAdt23gfMTuHJZ/+nxCUhJ54zRICqVJYB2An742aW6jOE3si8sPH9/
         2zsEjYfANd+4fV5/Ill+sMsBucV2p+hFsSZGVXd50B36WxBZQOwTVV7QS4klv7mknFE2
         f8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xu1u/V2d6cq8kPfctR0fVpHYng4RNCLrdcRzot4vz+4=;
        b=HwDABBAy04Q341Onyo0MwVdL47Mc3jqrb45T21fYdyLRbEKwRqBJunWJE+6HVGWwqP
         i1Ta3rQk9jmPGQ78VTLXlnAKRWkO8QpkkGLQIgeYKQsrqftps4p7/QuhVW1oPfqpyhe6
         4mOKa5MDCKkRMP43/X+btelxkjTu3EuBBRvwJVHRLWR3tLvgAcklnmqUr3Eh4FyDpzwe
         BJdoMR3anw5NMoBXnMvO33x3U8kvikjaNK9KgsDHoLL9gSu/driLqAteA1GqE7YnSKoH
         m51xFAImeCKgk68JT9S7YoFSnJ7CMbDWOhio5iRoKo6rKOunGWpwwWYiZT7aU0xM9fjF
         UObg==
X-Gm-Message-State: APjAAAXbG/s6lCzNhM8HHJ13KRBB+Kj9Vdged21FVJeDLGFE6SDi9ym6
        Jsc9DhOJLkM/l8CCIhPVjDOgEjykKo3GQyxS66I=
X-Google-Smtp-Source: APXvYqwa9FmjR8kKQUjk2T2pQYvWjvA1UpmKMerK1DFCe1zLLnslg7NGLR1Vjx83djU/Tm3zLI4yP6gTSMJ6slqMAW8=
X-Received: by 2002:a17:906:7c57:: with SMTP id g23mr30966530ejp.116.1571806523886;
 Tue, 22 Oct 2019 21:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <pull.405.git.1571357219.gitgitgadget@gmail.com>
 <pull.405.v2.git.1571727906.gitgitgadget@gmail.com> <1a9aa33b4649e2b723a6107520c2b5ad70774714.1571727906.git.gitgitgadget@gmail.com>
 <20191022205941.GD9323@google.com>
In-Reply-To: <20191022205941.GD9323@google.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Wed, 23 Oct 2019 17:55:12 +1300
Message-ID: <CACg5j275CdwQcj1RvjtYNQpWPdtkTAT1WX6X12_cKwFH11JTQQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] config: move documentation to config.h
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 23, 2019 at 9:59 AM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> On Tue, Oct 22, 2019 at 07:05:06AM +0000, Heba Waly via GitGitGadget wrote:
> > From: Heba Waly <heba.waly@gmail.com>
> >
> > Move the documentation from Documentation/technical/api-config.txt into
> > config.h
>
> This is still a little thin for what we usually want from commit
> messages. Try to imagine that five years from now, you find this commit
> by running `git blame` on config.h and then examining the commit which
> introduced all these comments with `git show <commit-id>` - what would
> you want to know?
>
> Typically we want to know "why" the change was made, because the diff
> shows "what". We can see from the diff that you're moving comments from
> A to B, but if you explain why you did so (not "because my Outreachy
> mentor told me to" ;) but "because it is useful to see usage information
> next to code" or "this is best practice as described by blah blah") - I
> wouldn't be able to know that reasoning just from looking at your diff.
Ok, got it.

>
> > diff --git a/config.h b/config.h
> > index f0ed464004..02f78ffc2b 100644
> > --- a/config.h
> > +++ b/config.h
> > @@ -4,6 +4,23 @@
> >  #include "hashmap.h"
> >  #include "string-list.h"
> >
> > +
> > +/**
> > + * The config API gives callers a way to access Git configuration files
> > + * (and files which have the same syntax). See linkgit:git-config[1] for a
>
> Ah, here's another place where the Asciidoc link isn't going to do
> anything anymore.
yep!
> Otherwise I didn't still see anything jumping out. When the commit
> message is cleaned up I'm ready to add my Reviewed-by line.
great!

>  - Emily

Thanks :)
