Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 664BA1FADF
	for <e@80x24.org>; Sun, 14 Jan 2018 14:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751402AbeANO1B (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Jan 2018 09:27:01 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39984 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750786AbeANO1A (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jan 2018 09:27:00 -0500
Received: by mail-wm0-f67.google.com with SMTP id v123so10732484wmd.5
        for <git@vger.kernel.org>; Sun, 14 Jan 2018 06:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yObm0FcyTU9PgSBX794Bk4InKDvDUwUBrKe2hLO9rb0=;
        b=CjQlzbJQizuApqgtd6QjZCgBBqeaR2Y55ys9ju1ObK/pf+tdVIln6Kc4rTfeBDYE7O
         rCyMZFf39eR+hGCQHg0LhirIdyejpVGdQlLY4aWl1YmFOCx4bUeiVudk8tDAH1Qd4OlZ
         tEGgLbpdlSRwpXAXBe+HrsUBb7XXN3rL7Yk+oEpYPtBy4EZj2sdDLRSALjFjg43UwwXA
         MkpCMepY7ngTusd6s2JJEBwfssvd0nkV8JES6TKMeHrN9+Ain6irx+d0+W371WGMrNRB
         hF/LCUL4dsNT29nq8aeGfhuduHbpPEgWJBX4Hi5710wuanRFr4iF487WWJUpP/w0RH/b
         9M/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yObm0FcyTU9PgSBX794Bk4InKDvDUwUBrKe2hLO9rb0=;
        b=pdC78PfNERAMY02jtozpNtB/lqof9/fQvARQRlTGU/IMFMz4ufG4up7Whbl95ciV46
         YZRevM3jVySumqE4pFHGCf+03fzxgJ11aWPRYsFxpHG1rlaiXLqYMvW7jTdqVNcOuCXz
         48XsKWAFdhk1lTFVJ3sWUcxCHFQ0Vmbx/93c73pmsA7j8B1G1GnGm2OEvSmYVURJ1oe6
         eHDLM3YxTlEVVvWq7xKwbCHOofKkj2nZoC/yLYpnjuCyzBy1qttXfIVIDirKgDr350KT
         e7ZKyHPKWalUm8/y3J538jf+c2OY0Fg+JESXYNzz9eIH2wqXO3MntHFf0qA76ri5ln2j
         2zlw==
X-Gm-Message-State: AKwxytdZOV4WMGp0bfNodRwzfHcxeU3/NTzAG6fbeJMlaSSa9enwi7bE
        Idgo7Wb5RP9VYpNTuG+nCIE=
X-Google-Smtp-Source: ACJfBosg24OxfM+6Tb4743Cr9+opQ/Ww9nqpjav247wjD+FrMCZK2vDMg+qy6BL9hywXh9onWwAPUw==
X-Received: by 10.28.191.135 with SMTP id o7mr8102427wmi.143.1515940018609;
        Sun, 14 Jan 2018 06:26:58 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 11sm4994614wmd.33.2018.01.14.06.26.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Jan 2018 06:26:57 -0800 (PST)
Date:   Sun, 14 Jan 2018 14:29:14 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 4/3] read-cache: don't try to write index if we can't
 write shared index
Message-ID: <20180114142914.GK2641@hank>
References: <20171217225122.28941-1-t.gummerer@gmail.com>
 <20180107223015.17720-1-t.gummerer@gmail.com>
 <20180113223715.GJ2641@hank>
 <CACsJy8A_moFProjfPAJFn2aP52w5qdYdOu4Ygox1qMMitNUHLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8A_moFProjfPAJFn2aP52w5qdYdOu4Ygox1qMMitNUHLg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/14, Duy Nguyen wrote:
> On Sun, Jan 14, 2018 at 5:37 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > In a0a967568e ("update-index --split-index: do not split if $GIT_DIR is
> > read only", 2014-06-13), we tried to make sure we can still write an
> > index, even if the shared index can not be written.
> >
> > We did so by just calling 'do_write_locked_index()' from
> > 'write_shared_index()'.  'do_write_locked_index()' always at least
> > closes the tempfile nowadays, and used to close or commit the lockfile
> > if COMMIT_LOCK or CLOSE_LOCK were given at the time this feature was
> > introduced.  COMMIT_LOCK or CLOSE_LOCK is passed in by most callers of
> > 'write_locked_index()'.
> >
> > After calling 'write_shared_index()', we call 'write_split_index()',
> > which calls 'do_write_locked_index()' again, which then tries to use the
> > closed lockfile again, but in fact fails to do so as it's already
> > closed.
> >
> > In the current version, git will in fact segfault if it can't create a
> > new file in $gitdir, and this feature seems to never have worked in the
> > first place.
> >
> > Ever since introducing the split index feature, nobody has complained
> > about this failing, and it really just papers over repositories that
> > will sooner or later need fixing anyway.
> 
> Actually there's one valid case for this: you're accessing a read-only
> $GIT_DIR (.e.g maybe from a web server cgi script which may be run by
> user nobody or something) and creating a temporary index _outside_
> $GIT_DIR. I used to do this when I wanted to do "git grep" on some
> SHA-1 a couple times. Doing "git grep <SHA-1>" directly (a couple
> times) pays full cost for walking trees. If you prepare an index
> first, you pay it only once.

Makes sense, I didn't realize that usecase, thanks!

> > Therefore just make being unable to write the split index a proper
> > error, and have users fix their repositories instead of trying (but
> > failing) to paper over the error.
> >
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >  read-cache.c | 11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)
> >
> > diff --git a/read-cache.c b/read-cache.c
> > index d13ce83794..a9c8facdfd 100644
> > --- a/read-cache.c
> > +++ b/read-cache.c
> > @@ -2471,18 +2471,15 @@ static int clean_shared_index_files(const char *current_hex)
> >         return 0;
> >  }
> >
> > -static int write_shared_index(struct index_state *istate,
> > -                             struct lock_file *lock, unsigned flags)
> > +static int write_shared_index(struct index_state *istate)
> >  {
> >         struct tempfile *temp;
> >         struct split_index *si = istate->split_index;
> >         int ret;
> >
> >         temp = mks_tempfile(git_path("sharedindex_XXXXXX"));
> > -       if (!temp) {
> > -               hashclr(si->base_sha1);
> > -               return do_write_locked_index(istate, lock, flags);
> 
> I think this code tries to do what's done near the beginning of
> write_locked_index() where we also bail out early:
> 
> -- 8< --
>         if (!si || alternate_index_output ||
>             (istate->cache_changed & ~EXTMASK)) {
>                 if (si)
>                         hashclr(si->base_sha1);
>                 ret = do_write_locked_index(istate, lock, flags);
>                 goto out;
>         }
> -- 8< --
> 
> the only difference is it does not realize that it can't do "goto
> out;" like that code unless something goes wrong. I'll try to prepare
> a patch that move tempfile creation out of write_shared_index()
> instead. Patches coming in a bit..

Thanks for fixing this in a nicer way :)

> -- 
> Duy
