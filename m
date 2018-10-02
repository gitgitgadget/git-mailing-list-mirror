Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 123301F453
	for <e@80x24.org>; Tue,  2 Oct 2018 23:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeJCFzg (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 01:55:36 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:42809 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeJCFzg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 01:55:36 -0400
Received: by mail-pg1-f178.google.com with SMTP id i4-v6so630965pgq.9
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 16:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wCucTtfoh95eVcu0h2vQkvdBNJv2uaingk4CbxGp+04=;
        b=qRpvSvometwAyXF6yuXZU5xpVGX6+zU4dei0nA3L+LOhWE6oVJHwScc7YDb9Zk0WcK
         ebiWCQkjMcKM1cPVdtFep0Z7FJW46+vdgsFXs01Cgoj8dEsBh43l1GBtoPxuXWDsPsRz
         /K0EtThNtjgYZGK1+bBSNH2bNwDsjYESSx/mFOM1ap5PL6qG4AOLdn44mBlZ2397BkUc
         gdjWGZzNLeX/jtBWeSf0KwXUufwJua2pf61Xo+MUcOImMhylj7AXKvyak/BczQNFCh7r
         tJcSXsGOxxBWiSD4n0Mgy1BErlA3749xV2chOeQSQRBz1rPmOrMdm9YGXJIo4EtUK5Ul
         c3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wCucTtfoh95eVcu0h2vQkvdBNJv2uaingk4CbxGp+04=;
        b=McPGSjj9PZ8ieEidfJrkU7cwzzo9XlM+oqhNHmrp+CWKMeV0N69AK0LwyDTfVfmhmK
         d1sDZ/c1/I6xPvKVPIJEz+7uhz6PKP2MmDrcD+ZcQ+pdZGZtDCjQNhjka8G0rUZFq0RX
         raAV1cekgE0FV/KDCudJ9cuPmQ1YO5XmoM/u+hTczXXuBc9PsyALMHgcR3ol9JZVs1JZ
         SQLjmga0IOe0y1bwQJbtmj4jeEKldrQJGUZOcV0v/qqCmWNZP2eKQ0u8fmBd01+lm0R5
         VVKcfORb4yXzA6nTk51D/HenLngPiLzPku8MYPi5G3yh/lg8FuCtmpUddGyp+e8DEcMw
         f0Kg==
X-Gm-Message-State: ABuFfoghFC5vgNflJb/v2eqVgGmjc87uPG/X8TIKcPKeyU8C2x+jP64r
        1Goy3Ls05Gh8BhZb3+RATpbg6yIpE95Ujg==
X-Google-Smtp-Source: ACcGV61KxMnBtoUJraapFXL0Zg3KAlDT1CffydzxdquTzUN1GRgVDFRfHjRmBPF0DL52h3qSllzYbQ==
X-Received: by 2002:a63:5fc5:: with SMTP id t188-v6mr16113021pgb.346.1538521791270;
        Tue, 02 Oct 2018 16:09:51 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:e958:2ad1:68d0:890f])
        by smtp.gmail.com with ESMTPSA id q25-v6sm21842287pfh.113.2018.10.02.16.09.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 16:09:49 -0700 (PDT)
Date:   Tue, 2 Oct 2018 16:09:48 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Stefan Xenos <sxenos@google.com>,
        git@vger.kernel.org
Subject: Re: Git Evolve
Message-ID: <20181002230948.GB18063@syl>
References: <CAPL8ZivFmHqS2y+WmNR6faRMnuahiqwPVYsV99NiJ1QLHOs9fQ@mail.gmail.com>
 <20181002012326.GA96979@syl>
 <877ej0iuhc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877ej0iuhc.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 02, 2018 at 11:11:11AM +0200, Ævar Arnfjörð Bjarmason wrote:

You timed this email quite well ;-).

> On Tue, Oct 02 2018, Taylor Blau wrote:
>
> > Hi Stefan,
> >
> > On Sat, Sep 29, 2018 at 04:00:04PM -0700, Stefan Xenos wrote:
> >> Hello, List!
> >>
> >> I'm interested in porting something like Mercurial's evolve command to
> >> Git.
> >
> > Welcome to Git :-). I think that the discussion in this thread is good,
> > but it's not why I'm replying. I have also wanted a Mercurial feature in
> > Git, but a different one than yours.
> >
> > Specifically, I've wanted the 'hg absorb' command. My understanding of
> > the commands functionality is that it builds a sort of flamegraph-esque
> > view of the blame, and then cascades downwards parts of a change. I am
> > sure that I'm not doing the command justice, so I'll defer to [1] where
> > it is explained in more detail.
> >
> > The benefit of this command is that it gives you a way to--without
> > ambiguity--absorb changes into earlier commits, and in fact, the
> > earliest commit that they make sense to belong to.
> >
> > This would simplify my workflow greatly when re-rolling patches, as I
> > often want to rewrite a part of an earlier commit. This is certainly
> > possible by a number of different `git rebase` invocations (e.g., (1)
> > create fixup commits, and then re-order them, or (2) mark points in your
> > history as 'edit', and rewrite them in a detached state, and I'm sure
> > many more).
> >
> > I'm curious if you or anyone else has thought about how this might work
> > in Git.
>
> I've wanted a "git absorb" for a while, but have done no actual work on
> it, I just found out about it.
>
> I think a combination of these two heuristics would probably do the
> trick:
>
>  1. If a change in your "git diff" output has a hunk whose lines overlap
>     with an earlier commit in the @{u}.. range, we do the equivalent of
>     "git add -p", select that hunk, and "git commit --fixup <that
>     commit>". We fixup the most recent commit that matches (otherwise
>     commit>we'd conflict).

I had imagined this working slightly differently. I think about it in
terms of a flamegraph-shape, where each line is affected by gravity.
Consider this:

       [---------------]
  L0   L1   L2   L3   L4   L5   L6   L7

Here's a line in a diff that affects L1-L4. Were we to create a
``fixup'' to L3-L4, it would look like this:

                 [-----] --|
       [---------|-----] <-|
  L0   L1   L2   L3   L4   L5   L6   L7

The commit owning the adjacent edit hunk is the one that gets the
changes applied to it.

Consider instead the case where we have two overlapping parts of a
change:

                 [-----|----]
       [---------|-----]
  L0   L1   L2   L3   L4   L5   L6   L7

The left-hand side of the top-most hunk belongs to the hunk below it,
but the right-hand side is ``affected by gravity'' down to the base:

                 [-----|
       [---------|-----]|---]
  L0   L1   L2   L3   L4   L5   L6   L7

And thus could be reapplied anywhere. I have not spent time proving this,
but I believe that this resolves appropriate bases without ambiguity
(or, at least can detect when finding a base introduces ambiguity).

>  2. Have some mode where we fall back from #1 and consider changes to
>     entire files, if that's unambiguous.
>
> The neat thing about this would be that you could tweak how promiscuous
> #1 would be via the -U option to git-diff, and #2 would just be a
> special case of -U9999999999999 (we should really add a -Uinf...).
>
> Then once you ran this you could run "git rebase -i --autosquash" to see
> how the TODO list would look, and optionally have some "git absorb
> --now" or whatever to do the "git add -p", "git commit --fixup" and "git
> rebase --autosquash" all in one go.

That's cool. I hadn't known about '--autosquash' before, but it now
makes sense to me why I have often seen patches that begin with
"fixup!".

Another thought that I am reminded of was an off-list discussion with
Peff, where we thought that a particularly Git-like way to implement
something like this would be to generate a set of commits that would be
immediately '--autosquash'-able.

> > [1]: http://files.lihdd.net/hgabsorb-note.pdf

Thanks,
Taylor
