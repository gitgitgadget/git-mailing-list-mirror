Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 651F71F461
	for <e@80x24.org>; Thu, 16 May 2019 06:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfEPGjC (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 02:39:02 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:44122 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfEPGjC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 02:39:02 -0400
Received: by mail-qt1-f179.google.com with SMTP id f24so2598780qtk.11
        for <git@vger.kernel.org>; Wed, 15 May 2019 23:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x7yTi1NQauZ/MKc/M604sLpiupHC9JFIpQb3rO17wuk=;
        b=PeaW5HwM/d+Z/7QWmFeHUU+N6+/qMxVoqtPAeJtnjawCy+wpP8IQPBigZDtUr+z2df
         tgvHnwXw5jCxa/SmNbZHeXOuoVtApgdVOdcfPFe4gNO9qTV0ohShe89VSyA3CctyQQpI
         /UZmUH8Xfl5EBhX+/36DM133DuQHbM5iF+V7g2E7nuusSS+FYBsaic6w0qxH3GIp9mBx
         twBwoGYdU0x1SgFjfRe07Dk33vtqFDNfbI4JEiK4jShuJZkx1734wsI0A/A7NVS4XAZs
         ztny4PoW2xC71qPduUc46NRQ6MK0iIDbJkwfWmnkUDjYz1NGvgYlljQuIhkQSpSJlCIc
         39eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x7yTi1NQauZ/MKc/M604sLpiupHC9JFIpQb3rO17wuk=;
        b=BPRd4gDgxneC8Mnh4oHsLp/c9pu3Jh8YIb+6pt1ovL387VeVpTsi8NTk+hITHODAwK
         CjZrd5Drn29tkoaS3Wbto+V1eVRrk2GwIq5lX6EUQM2maUehLNOZztInHv7eYMjur3v4
         KhyPMGWYriQzonBLjpxAB4uSxT00XN+kqdymYa4grSjyskI6Li4VdNnBBHFchXR6L9bv
         9boI95RBX5Z3JrDS2cTkDPg2GWF2bBhy1e+KtvSqzCFUrL74MlbonCv3GaEDFURkd4/t
         fSPeeamSuj0AZXM85cF5B+oIqCTVRB6a2h3MZNZ1uS1d14Hb/L3UHYnFRffs6KU/jB6O
         9sBg==
X-Gm-Message-State: APjAAAX0MGq5NiRYz5yk0rLHfcRVuDM75Uqph1bqGWVE8qhdbE653FHc
        4K8uplivcY6/l1SMK9AFv15h2IP8APpstw71Rp8=
X-Google-Smtp-Source: APXvYqw6+gzRwezDCA4RBoBb2Fy6ZB1McNHiE4bc/QIy0BWCz8QsGu1FEvowl5K9Sr8kAqXbsAnkdvGgxFA1qJHuGEU=
X-Received: by 2002:ac8:1672:: with SMTP id x47mr38658151qtk.92.1557988740904;
 Wed, 15 May 2019 23:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAA01CsoJf+_-iowdm0EFWd52vOWE1Uo0GGZ55d3RyPJzg6gwgQ@mail.gmail.com>
 <874l5vwxhw.fsf@evledraar.gmail.com> <CABPp-BGycoHEMN27Z9rAccT5yVRf3N50o4sc3wo8uE_HLR9QbA@mail.gmail.com>
In-Reply-To: <CABPp-BGycoHEMN27Z9rAccT5yVRf3N50o4sc3wo8uE_HLR9QbA@mail.gmail.com>
From:   Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Date:   Thu, 16 May 2019 08:38:38 +0200
Message-ID: <CAA01Csqu6g0QPLNG5LOnkSzN=-De5X=KnqyDS3Bqb980+_FQ+A@mail.gmail.com>
Subject: Re: Merging (joining/stiching/rewriting) history of "unrelated" git repositories
To:     Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 15, 2019 at 10:34 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Wed, May 15, 2019 at 8:30 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
> >
> > On Wed, May 15 2019, Piotr Krukowiecki wrote:
> >
> > > Hello,
> > >
> > > I'm migrating two repositories from svn. I already did svn->git
> > > migration (git-svn clone) and now have two git repositories.
> > >
> > > I would like to merge them into 1 git repository, but to merge also
> > > history - branches and tags.
> > >
> > > The reason is that the svn repositories in fact represent one
> > > "project" - you had to download both of then, they are not useful
> > > separately. Tags were applied to both repositories, also list of
> > > branches is almost identical for both.
> > >
> > > So right now I have:
> > >
> > >     - projectA:
> > >        master: r1, r4, r5, r7
> > >        branch1: r10, r11, r13
> > >     - projectB:
> > >        master: r2, r3, r6
> > >        branch1: r12, r14
> > >
> > > The content of projectA and projectB is different (let's say projectA
> > > is in subfolder A and projectB is in subfolder B). So revisions on
> > > projectA branches have only A folder, and revisions on projectB
> > > branches have only B folder.
> > >
> > > But I would like to have:
> > >
> > >     - projectAB:
> > >        master: r1', r2', r3', r4', r5', r6', r7'
> > >        branch1: r10', r11', r12', r13', r14'
> > >
> > > Where all revisions have content from both projects. For example, the
> > > r5' should have the "A" folder content the same as r5, but also shoul=
d
> > > have "B" folder content the same as in r3 (because r3 was the last
> > > commit to projectB (date-wise) before commit r5 to projectA).
> > >
> > > There's additional difficulty of handling merges...
> > >
> > >>
> > > Any suggestions on what's the best way to do it?
> > >
> > >
> > > Currently I'm testing join-git-repos.py script
> > > (https://github.com/mbitsnbites/git-tools/blob/master/join-git-repos.=
py)
> > > but it's slow, memory inefficient and handles "master" branch only...
> > >
> > >
> > > Thanks,
> >
> > You might be able to use https://github.com/newren/git-filter-repo
>
> Splicing repos is an interesting case, but unless the history is
> linear and the branch/tag names exactly match and you are simplify
> weaving commits together based on timestamp within the same
> branch/tag, then I don't know what algorithm should be used to weave
> them together.  There are lots of choices, and "correct" may be very
> usecase-specific.
>
> That said, filter-repo was designed to be usable as a library and has
> a few simple examples of such usage, including one of splicing some
> trivial repos together.  (See
> https://github.com/newren/git-filter-repo/blob/master/t/t9391/splice_repo=
s.py
> and https://github.com/newren/git-filter-repo/blob/master/t/t9391-filter-=
repo-lib-usage.sh#L90-L121)
>  As noted there, fast-export's diff against first parent handling
> makes splicing commits into the second (or third) parent history of a
> merge problematic as new files introduced in such locations would by
> default appear to get deleted by the merge unless additional work is
> done to also insert the files there.  My example was meant as a simple
> testcase that should be easy to inspect by others, so it just worked
> with very short linear histories.
>
> Somewhat interestingly, a search on others having tried to solve this
> same problem turned up
> https://github.com/j5int/jbosstools-gitmigration, which apparently is
> based on git_fast_filter, which is the predecessor of filter-repo.
> Perhaps that tool would be useful to you as-is, though they apparently
> do ignore merges.
>
> If folks have a good idea for a weaving algorithm that appears
> generally useful rather than usecase-specific, then I may be
> interested in coding it up as a more general example of using
> filter-repo as a library.  But every time I've thought about it before
> it just sounded too hairy and too usecase specific so I've just punted
> on it.

At first I thought that joining history with branch/merge support
should be simple, but in fact it is not. At least for git repo. Now I
think it is impossible.

It should be possible for svn, or for git repo migrated from svn which
still has the git-svn-id string as part of commit message. So you know
which branch any commit belongs.

For example:

projectA:
- ra1 - ra3 - ra6 - ra9 * ra11       (master)
      |                 |
      - ra4 - ra7 - ra8 -            (branchX)

projectB:
- rb2 - rb5 - rb10 -                 (master)


Merged project AB should look like this:

project AB:
- ra1 - rb2 - ra3 - rb5 - ra6 - ra9 - rb10 * ra11       (master)
            |                              |
            - ra4 - ra7 - ra8 --------------            (branch)

Because you know that rb5 was on branch "master" (trunk) then you know
it should be applied to the same branch in projectA, but not to branch
"branchX". This information is lost in git:

projectA (git):
- ra1 - ra3 - ra6 - ra9 * ra11       (master)
      |                 |
      - ra4 - ra7 - ra8 -

You do not know which parent of ra11 represented the main "master"
branch. Should rb5 be added after between ra4 and ra7, or between ra3
and ra6?


Does it make sense?


Maybe I should look for a way to first prepare "merged" svn repo
projectAB. Maybe there's a tool which can do it. And then migrate it
to svn.

--=20
Piotr Krukowiecki
