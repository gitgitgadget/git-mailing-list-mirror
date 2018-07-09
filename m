Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78C801F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 20:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932921AbeGIUZU (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 16:25:20 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:45651 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932686AbeGIUZS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 16:25:18 -0400
Received: by mail-yw0-f195.google.com with SMTP id 139-v6so7008410ywg.12
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 13:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B34mNWN8ZBHf+DD+5goThuhhq7cVExXk+Szt2cRMop8=;
        b=S+0utOpvk4GUqZ72oVNreaLJSUuMv0yLGqreDZGc1CiNqmv+250qge6xJzgbOHwYPb
         dUfg1zOZpaZrIp0VFJQ/bGKO1APXqzXPI0ByssM9D0PtUQnJtMtQhjdjsyky+NChGjJ9
         MByu0xYLquTqppsrpXN5sXwB48uLMTkbUjsNWdEFp6UX4roV1Tj2wZfRAi7sei/V2BAA
         T2xnmn4TbYYHZuWGreI9xgKxSQBPMIHD74ojeUTUlEYxXH0JKFKXAadCxNJ85HyjW7mq
         JlGWa/XatOV5faMG9Kg4pO5RTvcVcpAIsu9NleNJAH+b2YtOP2TNtY6uKfBhryG1CPWw
         jZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B34mNWN8ZBHf+DD+5goThuhhq7cVExXk+Szt2cRMop8=;
        b=ZkBkMVrm9XpthScbp2bJzVoyJXWA1KMUD5iFyQ10oDBQSEq3oSdI0xHkHAXhrjHUCq
         71tSnVQfB9THSlg4eLIBAhslxYpdbfwG1Yo1i4uB+dbRnv3ZOxikl/TrwWFbtYqRvt+N
         7le5yGMKCC0MnqIoH9QXGrnx4vxw7S2RhxN3SvMKTPL9Ymd/nFxIJ3a4RyjOj157qY/4
         +FAtOMeHXqsM0qKbUbUW1HIEd+tEWsffynQZKx61OB9FhpB5TnCFOOGyq19rTrAqTJpc
         VmXixwZHoXpTd9Tk3ipdU6GsoYHw1gmpmVh5pWW+UfUfOA42PatBix5QpNcxPdEK0j2F
         zGSw==
X-Gm-Message-State: APt69E061+3px9ayguriJoD17zNJV756nUgXPOUlc0r7wTW9imwxenWa
        vAytmk0s7lv2Yb+2gbXNDwAlsgWAcnpUEfPUAr69AA==
X-Google-Smtp-Source: AAOMgpcx69dZsf5ao7pgQyUv1T78mR/X6W4lE2K6D20MFm6FFyi97fNojVrNrZ2jw8qrS0kpnzJvEVcHki1yZ4VM/Ko=
X-Received: by 2002:a0d:c5c7:: with SMTP id h190-v6mr11229265ywd.421.1531167917810;
 Mon, 09 Jul 2018 13:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
 <pull.1.v3.git.gitgitgadget@gmail.com> <799da25ef35d2b23dc0df1e6af0772e634f39f19.1530617166.git.gitgitgadget@gmail.com>
 <CAGZ79ka9kjnu=taVBnkTicZBGZo-EbPOkzRxXihH8Y=Fcn5+-g@mail.gmail.com> <nycvar.QRO.7.76.6.1807092132040.75@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1807092132040.75@tvgsbejvaqbjf.bet>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 9 Jul 2018 13:25:06 -0700
Message-ID: <CAGZ79kZHcRNLh2M0oCKkUPqmzGfRczNdG=xYuyZRZ0ORd5i_zQ@mail.gmail.com>
Subject: Re: [PATCH v3 17/20] range-diff: add a man page
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 9, 2018 at 1:00 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Stefan,
>
> On Mon, 9 Jul 2018, Stefan Beller wrote:
>
> > On Tue, Jul 3, 2018 at 4:26 AM Johannes Schindelin via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >
> > > +'git range-diff' [--color=[<when>]] [--no-color] [<diff-options>]
> > > +       [--dual-color] [--creation-factor=<factor>]
> > > +       ( <range1> <range2> | <rev1>...<rev2> | <base> <rev1> <rev2> )
> > > +
> > > +DESCRIPTION
> > > +-----------
> > > +
> > > +This command shows the differences between two versions of a patch
> > > +series, or more generally, two commit ranges (ignoring merges).
> >
> > Does it completely ignore merges or does it die("not supported"), how is
> > the user expected to cope with the accidental merge in the given range?
>
> It ignores merges. It does not reject them. It simply ignores them and
> won't talk about them as a consequence.
>
> Could you suggest an improved way to say that?

Well that is what the patch said already; I was just dense in reading.
I just tested it, and the commit with more than one parent itself is
ignored (not showing up in the output), but the commits that are merged
in are still considered. So giving range1 as
f7761a5a065..0a5677f6f68 with

  0a5677f6f68 (Merge branch 'js/branch-diff' into pu, 2018-07-06)
  f7761a5a065 (Merge branch 'jk/fsck-gitmodules-gently' into jch, 2018-07-06)

still produces cool output and with --word-diff it is even more amazing, as it
just tells me a large part was s/branch-diff/range-diff/ :-)

12:  cbc752c57ce ! 12:  7273cc64797 branch-diff: use color for the commit pairs
    @@ -1,31 +1,28 @@
    Author: Johannes Schindelin <johannes.schindelin@gmx.de>

        [-branch-diff:-]{+range-diff:+} use color for the commit pairs

        Arguably the most important part of [-branch-diff's-]{+`git
range-diff`'s+} output is the
        list of commits in the two branches, together with their relationships.

        For that reason, tbdiff introduced color-coding that is pretty
        intuitive, especially for unchanged patches (all dim yellow, like the
        first line in `git show`'s output) vs modified patches (old commit is
        red, new commit is green). Let's imitate that color scheme.

    [-    While at it, also copy tbdiff's change of the fragment color
to magenta.-]

        Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    [-    Signed-off-by: Junio C Hamano <gitster@pobox.com>-]

Sorry for being offtopic here; I do not have a better suggestion than what
is already said.


> > I presume this is a boolean option, and can be turned off with
> > --no-dual-color, but not with --dual-color=no. Would it be worth to
> > give the --no-option here as well.
> > The more pressing question I had when reading this, is whether this
> > is the default.
>
> In the final patch (which I mulled about adding or not for a couple of
> weeks), the `--dual-color` mode is the default, and the man page talks
> about `--no-dual-color`.
>
> Do you want me to change this intermediate commit, even if that change
> will be reverted anyway?

No, I just wasn't aware of that part, yet, as I have seen some patch series
that add the man page/documentation as their final patch. This looked
so similar that I assumed this is the final man page. My bad!


> The coloring gives a strong hint of "pre" vs "post", i.e. old vs new: the
> changes that are only in the "old" patches are marked with a minus with a
> red background color, which only really makes sense if you think about
> these changes as "dropped" or "removed" from the "new" changes.
>
> So yes, it is really considered an older version, in my mind.
>
> Again, if you have suggestions how to improve my patch (giving rise to a
> "new" patch :-)), let's hear them.

I will send patches as I get more used to this new tool.

>
> > I think this comes from the notion of e.g. patch 4 ("range-diff: improve the
> > order of the shown commits "), that assume the user wants the range-diff
> > to be expressed with range2 as its "base range".
>
> No, it is motivated by the fact that we use -/+ markers to indicate
> differences between the "old" and the "new" patches.

And at this point in time we do not want to question the use of -/+ markers
for the next layer of abstraction. While +/- are well understood on
the patch level
we could argue for a different set of characters for diffs of diffs,
as that helps
to differentiate between the layers ("is it added in the diff or the
diff of the diff
due to e.g. different context?"), but then it would not recurse. (I am
not sure I
want to read diff of diffs of diffs)

Okay, for now I accept the terms of old and new patches, as I have no
better idea.

>
> > > +Algorithm
> > > +---------
> > > +
> > > +The general idea is this: we generate a cost matrix between the commits
> > > +in both commit ranges, then solve the least-cost assignment.
> >
> > Can you say more about the generation of the cost matrix?
> > I assume that it counts the number of lines added/deleted to make
> > one patch into the other patch.
>
> I think that is correct.
>
> *reading the patch*
>
> Actually, no, I was wrong. For the cost matrix, the *length* of the diff
> *of the diffs* is computed. Think of it as
>
>         git diff --no-index <(git diff A^!) <(git diff B^!) | wc -l

So the matching is based only on diffs, but the output still takes
the commit messages into account. So when diffing my series to the
series that Junio applies, (merely adding his sign off,) would be a
"cost of 0" in this context, but I still have output.

>
> > Another spot to look at is further metadata, such as author and
> > author-date, which are kept the same in a rebase workflow.
>
> I encourage you to offer that as an add-on patch series. Because what you
> suggest is not necessary for my use cases, so I'd rather not spend time on
> it.

Makes sense. When I stumble about this yet theoretical problem to materialize
in practice I will send a patch. In my mind this is not another use
case, but just
an improved matching, with the matching that this series provides being
good enough for now.

Thanks,
Stefan
