Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0167A1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 20:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933357AbeGIUiV (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 16:38:21 -0400
Received: from mout.gmx.net ([212.227.17.20]:51295 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933306AbeGIUiU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 16:38:20 -0400
Received: from MININT-6BKU6QN ([89.204.155.168]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LeiJ8-1gRgmT0Qow-00qReH; Mon, 09
 Jul 2018 22:38:11 +0200
Date:   Mon, 9 Jul 2018 22:38:09 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 17/20] range-diff: add a man page
In-Reply-To: <CAGZ79kZHcRNLh2M0oCKkUPqmzGfRczNdG=xYuyZRZ0ORd5i_zQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807092233220.75@tvgsbejvaqbjf.bet>
References: <cover.1525448066.git.johannes.schindelin@gmx.de> <pull.1.v3.git.gitgitgadget@gmail.com> <799da25ef35d2b23dc0df1e6af0772e634f39f19.1530617166.git.gitgitgadget@gmail.com> <CAGZ79ka9kjnu=taVBnkTicZBGZo-EbPOkzRxXihH8Y=Fcn5+-g@mail.gmail.com>
 <nycvar.QRO.7.76.6.1807092132040.75@tvgsbejvaqbjf.bet> <CAGZ79kZHcRNLh2M0oCKkUPqmzGfRczNdG=xYuyZRZ0ORd5i_zQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:16xRdZquprV6uAYZBzJnXInBuOWQlX5gKkBNmvAgXHDUQ2LQTPo
 Fc8GoFyKXlKfBh+7mVjCqFuvJjbCh6vkpkmqAoT2oAH5tZJuiTGOIOjrzd+6v1qnCXG9Fbq
 PR+R9pOAdK/T06/kAfEN4N1wQxZXzWqLHK5nF9HUu/O6j7pRsQ1LsT7sqBhZeVg3Q1sH0YK
 HS1pQnieWzfP25bmEcDXA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BXx1VTX/MNI=:vuAr7ftzGukORw5wtRu5Ca
 d9XWJPmBnZRE6WKEPJIj+uW/KRKT49K/akanPa4EbBGOuWzE3lZIf2WqFI70w3LSV2k65+2Wd
 VKFoHslUml+ne8778gAPuEQa+tIIacr7/8gF3ijxba7ThsERHtpGO9BAwSuDgl11fOhgk3Gkt
 euBE98qWZmaC9m0rsDkXDVxqpejPAXwPyrsXYii5bfpJHofK5+E7dMMvk98DZjhUnd2RMgbYs
 Q9TyCdAF1qC2HL8838kdztHsmarPCbxa4/0x4IRIg6PQ97W/yS7C/bKU217x3zHU40EZNPOMd
 GuZN90KATEn6E1orYzwhuPASscTIGQWn45SgeDPnpLnC6fDiS+qwsds7bCqyOCA3FZhumAVJi
 IrleANq3mV5FNaOTIBmpdvdVzRrZxLb8QJXjdWtc9uNMMd55uXaEy3btu8ojJJl4GSclNjWXv
 Gvos2cpGjCek9W81JRDee8B8rjzAZ2OSUpwQnj/h1I9CsFJtK/JCgN+SKh6IlkDRP7TnfCW8E
 A8C3+IK/upOvwXx0n1pkAATpjNHKKgYiHhyqCD9hdy4MBUdvt/vviXCW3RVSipL+zhMatxUT3
 5W4EWnQOm6/S6PXSHJJHRb6x3Kf1iQcMnhFkX6FssCrZJRNLxv1FRcds/k6G+6Kv7TU6GzYSs
 snQ0ZXw6/ICM5q4c+2qTOB+7j4pQAfIR518aqCHt8HTP9Q2JvWFm17qrQW96E48C+o+wQ5dZl
 S0dcNJVeAlUJ73RNMZbzbluwuJrDQg43d9LyhOZNFIy5/OVY6d9fjiGHI+WMRBH4ADOQraY7I
 v2evIWU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Mon, 9 Jul 2018, Stefan Beller wrote:

> On Mon, Jul 9, 2018 at 1:00 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Mon, 9 Jul 2018, Stefan Beller wrote:
> >
> > > On Tue, Jul 3, 2018 at 4:26 AM Johannes Schindelin via GitGitGadget
> > > <gitgitgadget@gmail.com> wrote:
> > >
> > > > +'git range-diff' [--color=[<when>]] [--no-color] [<diff-options>]
> > > > +       [--dual-color] [--creation-factor=<factor>]
> > > > +       ( <range1> <range2> | <rev1>...<rev2> | <base> <rev1> <rev2> )
> > > > +
> > > > +DESCRIPTION
> > > > +-----------
> > > > +
> > > > +This command shows the differences between two versions of a patch
> > > > +series, or more generally, two commit ranges (ignoring merges).
> > >
> > > Does it completely ignore merges or does it die("not supported"), how is
> > > the user expected to cope with the accidental merge in the given range?
> >
> > It ignores merges. It does not reject them. It simply ignores them and
> > won't talk about them as a consequence.
> >
> > Could you suggest an improved way to say that?
> 
> Well that is what the patch said already; I was just dense in reading.
> I just tested it, and the commit with more than one parent itself is
> ignored (not showing up in the output), but the commits that are merged
> in are still considered.

So a more accurate wording would be "ignoring merge commits" rather than
"ignoring merges".

Makes sense?

> So giving range1 as f7761a5a065..0a5677f6f68 with
> 
>   0a5677f6f68 (Merge branch 'js/branch-diff' into pu, 2018-07-06)
>   f7761a5a065 (Merge branch 'jk/fsck-gitmodules-gently' into jch, 2018-07-06)
> 
> still produces cool output and with --word-diff it is even more amazing, as it
> just tells me a large part was s/branch-diff/range-diff/ :-)

I never thought about using `--word-diff` with `range-diff`.

Sadly, for me it gives rather stupid output, e.g.

4:  6927c11a311 ! 4:  ebf3fea2517 range-diff: make --dual-color the default mode
    @@ -14,6 +14,15 @@
    diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
    --- a/Documentation/git-range-diff.txt
    +++ b/Documentation/git-range-diff.txt
    {+@@+}
    {+ --------+}
    {+ [verse]+}
    {+ 'git range-diff' [--color=[<when>]] [--no-color] [<diff-options>]+}
    {+- [--dual-color] [--creation-factor=<factor>]+}
    {++ [--no-dual-color] [--creation-factor=<factor>]+}
    {+  ( <range1> <range2> | <rev1>...<rev2> | <base> <rev1> <rev2> )+}
    {+ +}
    {+ DESCRIPTION+}
    @@

     OPTIONS

> > > > +Algorithm
> > > > +---------
> > > > +
> > > > +The general idea is this: we generate a cost matrix between the commits
> > > > +in both commit ranges, then solve the least-cost assignment.
> > >
> > > Can you say more about the generation of the cost matrix?
> > > I assume that it counts the number of lines added/deleted to make
> > > one patch into the other patch.
> >
> > I think that is correct.
> >
> > *reading the patch*
> >
> > Actually, no, I was wrong. For the cost matrix, the *length* of the diff
> > *of the diffs* is computed. Think of it as
> >
> >         git diff --no-index <(git diff A^!) <(git diff B^!) | wc -l
> 
> So the matching is based only on diffs, but the output still takes
> the commit messages into account. So when diffing my series to the
> series that Junio applies, (merely adding his sign off,) would be a
> "cost of 0" in this context, but I still have output.

Exactly.

> > > Another spot to look at is further metadata, such as author and
> > > author-date, which are kept the same in a rebase workflow.
> >
> > I encourage you to offer that as an add-on patch series. Because what you
> > suggest is not necessary for my use cases, so I'd rather not spend time on
> > it.
> 
> Makes sense. When I stumble about this yet theoretical problem to
> materialize in practice I will send a patch. In my mind this is not
> another use case, but just an improved matching, with the matching that
> this series provides being good enough for now.

Sure.

Ciao,
Dscho
