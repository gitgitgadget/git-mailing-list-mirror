Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2B2E20A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 21:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbeLMVH2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 16:07:28 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34868 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeLMVH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 16:07:28 -0500
Received: by mail-pf1-f194.google.com with SMTP id z9so1703682pfi.2
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 13:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iQ+uMyNYsKobMqO7lS6wyJo9an0tCXtG7AZrhh4oGQ0=;
        b=lrOpKT5zjLiTrmKQ/FzauzT6FV4kUp27FC5DNimVcr2ZcYMx8rP2s+AdSoIUfVQJmj
         +NyVhb/IbpEkMUmYpWSukFeyxNuRn4pBwQsJhkwWfi4YZCpi+If4upxI4HsTkEH9Hbd4
         XLLqdePdVwdDbEYcpd0CT1LUF29EV5DHEAkblN+05ATa6LVec0UPsxYFyg+CImVXEroA
         WJGM6S2Xdeprr5jI9cP/b5rYXf1/0si2B8RBhcKtdnZw/SybVLtXZpBReL6mJ+b6ELVj
         XWvjeQHS8sgEdtEV1fgDhV12iKEQPqPDqJ419Wu62syOcnKS4Oa6q4obWb2OG6uf7dOH
         k9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iQ+uMyNYsKobMqO7lS6wyJo9an0tCXtG7AZrhh4oGQ0=;
        b=GZZqsm4JHVBtFhsGSIu7k2Nvethi1pxxIIC4YkZNNrb0YfET09H3/bDw8uE+JrJ+MB
         hbx8V9rb+msRkkfUU1bODxkce2xOAwgVfGcDjjWEXAnkhhUIhx5Hbww3se//kov0Hx4P
         J8xN05QppYqQspLnMYjDCXyZVbDin+e6MLP0mGEUsQJiQyf+Ma18cNFw7EOs3/84uyae
         inC9IaiHpUKT9unhqPYUOKacx+6s9wmu6kuaA+Nb8PKbF2T1x18w6g5su11B6y3zVMGJ
         bRnidDZ1bFvSj+iRjX3aXAJXfSH0xA6m2J2211xHN1xTUJ3U+mN9y26zdbRQFm2vUMGH
         rcaw==
X-Gm-Message-State: AA+aEWaxhakQUUDmdHRzMF3XiG/szt4wpE2KsEXJ2GKl6tK+vy1K9qfV
        i5J06gxOy89wbN9TOVLyD4jBOmcOBylK2unZ6zYEqg==
X-Google-Smtp-Source: AFSGD/VpMBV3GDdRYp9ZybTcO8R7SxT8b64uO1fWRfFTkUzeJbYmnUbz4KfwGLguGriJvA3rlesAb35Urg/GXqeLdRw=
X-Received: by 2002:a63:6cc8:: with SMTP id h191mr317437pgc.366.1544735246970;
 Thu, 13 Dec 2018 13:07:26 -0800 (PST)
MIME-Version: 1.0
References: <pull.100.git.gitgitgadget@gmail.com> <13ee60e44f91ca06d182ff50fa4c69e137650fd2.1544730848.git.gitgitgadget@gmail.com>
 <CACsJy8AsRT+k4kdwC3gGjDOPiDn-L0GJs7-SQHb88Ra_gt4OcA@mail.gmail.com>
 <CANoM8SVMYBRg-nL4r=JJDFU_qZ=grzSmRs-B2nLYUnv5kFc00Q@mail.gmail.com> <CACsJy8Bj=8xHp3JA8dLbyM=RwJey7utMK6DTVe_0AjBNVHxJyg@mail.gmail.com>
In-Reply-To: <CACsJy8Bj=8xHp3JA8dLbyM=RwJey7utMK6DTVe_0AjBNVHxJyg@mail.gmail.com>
From:   Mike Rappazzo <rappazzo@gmail.com>
Date:   Thu, 13 Dec 2018 16:07:15 -0500
Message-ID: <CANoM8SXp7rLSEPbmDhawtYa2uH=Tn1OJKxN1KBf8Coc9Vfjkgg@mail.gmail.com>
Subject: Re: [PATCH 1/1] worktree refs: fix case sensitivity for 'head'
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Cc:     gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 13, 2018 at 3:43 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Thu, Dec 13, 2018 at 9:34 PM Mike Rappazzo <rappazzo@gmail.com> wrote:
> >
> > On Thu, Dec 13, 2018 at 3:23 PM Duy Nguyen <pclouds@gmail.com> wrote:
> > >
> > > On Thu, Dec 13, 2018 at 8:56 PM Michael Rappazzo via GitGitGadget
> > > <gitgitgadget@gmail.com> wrote:
> > > >
> > > > From: Michael Rappazzo <rappazzo@gmail.com>
> > > >
> > > > On a worktree which is not the primary, using the symbolic-ref 'head' was
> > > > incorrectly pointing to the main worktree's HEAD.  The same was true for
> > > > any other case of the word 'Head'.
> > > >
> > > > Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> > > > ---
> > > >  refs.c                   | 8 ++++----
> > > >  t/t1415-worktree-refs.sh | 9 +++++++++
> > > >  2 files changed, 13 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/refs.c b/refs.c
> > > > index f9936355cd..963e786458 100644
> > > > --- a/refs.c
> > > > +++ b/refs.c
> > > > @@ -579,7 +579,7 @@ int expand_ref(const char *str, int len, struct object_id *oid, char **ref)
> > > >                                 *ref = xstrdup(r);
> > > >                         if (!warn_ambiguous_refs)
> > > >                                 break;
> > > > -               } else if ((flag & REF_ISSYMREF) && strcmp(fullref.buf, "HEAD")) {
> > > > +               } else if ((flag & REF_ISSYMREF) && strcasecmp(fullref.buf, "HEAD")) {
> > >
> > > This is not going to work. How about ~40 other "strcmp.*HEAD"
> > > instances? All refs are case-sensitive and this probably will not
> > > change even when we introduce new ref backends.
> >
> > The current situation is definitely a problem.  If I am in a worktree,
> > using "head" should be the same as "HEAD".
>
> No "head" is not the same as "HEAD". It does not matter if you're in a
> worktree or not.

I was not aware of a difference.  Is that spelled out in the docs
somewhere?  It seems like a bad idea to have a magical symbolic ref
that _sometimes_ gives you a different answer depending on casing.
What should "head" do in a worktree?  Is it supposed to mean the HEAD
of the primary worktree?

>
> > I am not sure if you mean that the fix is too narrow or too wide.
> > Maybe it is only necessary in 'is_per_worktree_ref'.  On the other
> > side of the coin, I could change every strcmp to strcasecmp where the
> > comparison is against "HEAD".
>
> If you make "head" work like "HEAD", then it should work for _all_
> commands, not just worktree, and "MASTER" should match
> "refs/heads/master" and so on. I don't think it's as simple as
> changing strcmp to strcasecmp. You would need to make ref management
> case-insensitive (and make sure if still is case-sensitive if
> configured so). I don't think anybody has managed that.

I am all for making "head" work in all cases, not just worktree.  I
don't think that this situation applies to non-magical refs
(branches/tags).

> --
> Duy
