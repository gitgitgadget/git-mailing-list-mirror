Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B43A1F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 22:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbfJ1WLF (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 18:11:05 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35897 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJ1WLF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 18:11:05 -0400
Received: by mail-lf1-f67.google.com with SMTP id u16so8993591lfq.3
        for <git@vger.kernel.org>; Mon, 28 Oct 2019 15:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y3r6jmp+ucRO5FoL120Q89H/I1j8D6LGxYzxZJS9i+8=;
        b=Q67d8JROaQTr+yxz4ggqffH7MK2NnJqCDFxWkTxMER/6STnz2wL265CbPqme9a132t
         sCag39K3xhNo61NRcuDO3wUgyMnoDY1T6jOIGKQnRZuY4X0Hnckvty3buKl1xchApOqI
         fpoi8x6N1Quxd+x9dq4xOsgxJMz6kWQDUImmEG/4l8lSl49OXd1Bdb2omi76nRNCNjwu
         KOvBM06eVJDVaetpvHQvIw69DfVcy/izxLgUU9aHpbQBqmqMvz+v8aRI0J2C2UmhjmOO
         9dYFoWnL82qLXG9cD6JpERoYyY1YBMUB8kdJ3m2fXjMscOsDCdZmBb2e9gTEWc1A3X1r
         t6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y3r6jmp+ucRO5FoL120Q89H/I1j8D6LGxYzxZJS9i+8=;
        b=Mp4q+fr1kWedXVbF3L7pqZoaoy99SiQtTF7UJO4fxnMOr9diPp+s7c5GJYnOAQ4Je/
         dlXSxpl9i1ZGQCiUVhw/DNuAZBELYu0go9iG1ZqHQ2IVy6kTeJ5wnkLsP9kuTnU2wz4h
         SKaGK0MUnRjq1pqZgSZsZJNX9gEwu0AQn4rUTc8F6M28E4HgqxE0MaO3qotQwWzf1Btq
         M4C86sLFNIM8XlLoTX3kWl79JKaznSBcPXPQfUHrmfSWRH8FV31WPFxZi0cM96WmZJ86
         0cjKjlWy3Qb2hYTg/VQQ5bK/fgZ3aapCPQ8HBYLpgipYB2UJn5P5NEvpQtBVuGuCDn7+
         /3+g==
X-Gm-Message-State: APjAAAVEHVrZ9c0qMvHvsW99LnmW76Sqgx+UNHJo3xKI+qcfH4Ch4eog
        gszdjSKXHt/lEtUEHYSoAr29ryrBZI37eJjE42g=
X-Google-Smtp-Source: APXvYqwAY1W1vMCubLPx5807ux3LmQPGtwU2T9cR+Rs07ffIRdQG8i3jL/pd3q/cBXEa7+DuNcZtQqqLKfjSLDwKgjE=
X-Received: by 2002:ac2:5dc1:: with SMTP id x1mr64269lfq.177.1572300662909;
 Mon, 28 Oct 2019 15:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191025222032.3399-1-m.atanassov92@gmail.com>
 <20191026022655.GF39574@google.com> <CALs020+0E=7wy-N46BRLrBcKmMSTpcMyZ9WybmgTzb60aCo5PQ@mail.gmail.com>
In-Reply-To: <CALs020+0E=7wy-N46BRLrBcKmMSTpcMyZ9WybmgTzb60aCo5PQ@mail.gmail.com>
From:   Mihail Atanassov <m.atanassov92@gmail.com>
Date:   Mon, 28 Oct 2019 22:10:51 +0000
Message-ID: <CALs020KFKOp4mFnY_2Mg5_H8Jc6PPV56O=1S66mriZA+XWd1Hg@mail.gmail.com>
Subject: Re: [PATCH] Documentation/git-bisect.txt: add --no-ff to merge command
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Cc git@vger.kernel.org)

On Mon, 28 Oct 2019 at 21:51, Mihail Atanassov <m.atanassov92@gmail.com> wrote:
>
> Hi Jonathan,
>
> Thanks for the quick turnaround! And apologies in advance for the delayed
> and potentially mangled response, I can't get into my gmail account from
> a sensible MUA...
>
> On Sat, 26 Oct 2019 at 03:26, Jonathan Nieder <jrnieder@gmail.com> wrote:
> >
> > Hi,
> >
> > Mihail Atanassov wrote:
> >
> > > The hotfix application example uses `git merge --no-commit` to apply
> > > temporary changes to the working tree during a bisect operation. In some
> > > situations this can be a fast-forward and `merge` will apply the hotfix
> > > branch's commits regardless of `--no-commit` (as documented in the `git
> > > merge` manual).
> > >
> > > In the pathological case this will make a `git bisect
> > > run` invocation to loop indefinitely between the first bisect step and
> > > the fast-forwarded post-merge HEAD.
> > >
> > > Add `--no-ff` to the merge command to avoid this issue, and make a note
> > > of it for the reader.
> > >
> > > Signed-off-by: Mihail Atanassov <m.atanassov92@gmail.com>
> > > ---
> > >  Documentation/git-bisect.txt | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > Good catch.  Thanks for fixing it.
> >
> > > diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
> > > index 4b45d837a7..58b5585874 100644
> > > --- a/Documentation/git-bisect.txt
> > > +++ b/Documentation/git-bisect.txt
> > > @@ -412,8 +412,10 @@ $ cat ~/test.sh
> > >  #!/bin/sh
> > >
> > >  # tweak the working tree by merging the hot-fix branch
> > > -# and then attempt a build
> > > +# and then attempt a build. Note the `--no-ff`: `git merge`
> > > +# will otherwise still apply commits if the current HEAD can be
> > > +# fast-forwarded to the hot-fix branch.
> >
> > Hmm.  I think the comment might put a bit too much emphasis on the
> > "how" instead of the "why".  Is it necessary to describe why --no-ff
> > is used at all here?  After all, a reader wondering about it is likely
> > to check "git help merge", which says
> >
> >         Fast-forward updates do not create a merge commit and
> >         therefore there is no way to stop those merges with
> >         --no-commit.  Thus, if you want to ensure your branch is not
> >         changed or updated by the merge command, use --no-ff with
> >         --no-commit.
> >
> > So I'd be tempted to leave the comment ending with "and then attempt a
> > build".
>
> Fair point, I actually did spend a bit of time on the fence between your
> suggestion and what I ultimately submitted. I ended up expanding on it
> precisely because the '--no-ff' seems a bit arbitrary to the casual observer
> and requires cross-referencing other documentation (which is how I figured
> out I ought to produce this patch :)).
>
> I can't think of any wording that would be any better, so I'll push a v2 with
> no comment changes, and leave it to the reader's curiosity (or lack thereof).
>
> On a related note, if the user reads all the docs fully, they'll know to use a
> suitable merge-base for the hotfix branch and they won't get into the
> predicament in the first place. So this patch is hiding the underlying issue
> slightly. I'd still prefer to have that failsafe in there, though, for the cases
> where going into an infinite loop is costly (e.g. unattended bisect with
> long-running tests).
>
> >
> > Alternatively: the wording says "will still apply commits", but the
> > reader might not think of a merge as applying patches (that's closer
> > to what cherry-pick does.  Is there some alternative wording that
> > would convey the intent more clearly?
> >
> > > -if   git merge --no-commit hot-fix &&
> > > +if   git merge --no-commit --no-ff hot-fix &&
> >
> > Good.
> >
> > Thanks and hope that helps,
> > Jonathan
>
> --
> Mihail

-- 
Mihail
