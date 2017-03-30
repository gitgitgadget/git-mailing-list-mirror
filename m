Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD03620958
	for <e@80x24.org>; Thu, 30 Mar 2017 00:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933049AbdC3ABY (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 20:01:24 -0400
Received: from mout.gmx.net ([212.227.17.20]:60762 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932757AbdC3ABX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 20:01:23 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Las1k-1cQwXH0P9M-00kOku; Thu, 30
 Mar 2017 02:01:19 +0200
Date:   Thu, 30 Mar 2017 02:01:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     "Daniel Ferreira (theiostream)" <bnmvco@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [GSoC] Proposal: turn git-add--interactive.perl into a builtin
In-Reply-To: <CAGZ79kbyW79wToWqoL_F5n+jOFwFH=z2jY3Du2YTyv9tS9L=JA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1703300142230.4068@virtualbox>
References: <CAEA2_RJEf4vjgcaux8a1KWh1-vxLLmv1--Vjf9wiEQoF+gVDtA@mail.gmail.com> <CAGZ79kbyW79wToWqoL_F5n+jOFwFH=z2jY3Du2YTyv9tS9L=JA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1870090443-1490832079=:4068"
X-Provags-ID: V03:K0:HdQolU3QUIU+IQXCJ3m1FQfRDJ1Xi3+/MlG+LqXDBFkVA5GZv/Q
 jR0Lh8e669tbFY5XUHHf9poJ8IdrxfF1a95s9WwA7fhs+MjUIbIyKqvqsVa5JObrLVdmMnd
 u0wH9/Y5nCm89rZgdPoOQ/4DhtjMiB7qm8yY0EHco+dpXPmaTTnc9FiBqpOEmx4bo65qqeH
 B8lhy/7PF/KgT0a2VkByQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZiDdObZhHgQ=:VfQe8yfoorEM099RsqIFQb
 IBRRMsqvnqhUacj5OCLFEe7rC1lQlF4Zb707nv72/rAT3j6gN0Pe7LgH7E45UVi+EVUOO45vA
 u62ppjNNRzkEBT5fvyolTbQB6XID1buUYC8sTvcbId46Hnp+T8k9E8TtKXKSOwSF2put6y8dd
 MMB/axcj5tBEJFHpFk7gFkoC5WF6V5s9O+4Ar8yd+NJfD6S5QiF/oTJDvd07IERnPeNfotngY
 is/tzwFrQSyjVqQABcs4exWgDmKEwzSMYMBD5+mJtW+N1V573MmyfPqSbAaOUEo4s8O8IcZFW
 3zGcHKxaExuFF9OgOj5mPtGHnZMbM/ImRHn3968AuimE7n13raLnDy/FLCT1SqEFUGVhRtN07
 9OWZENfF/avWklxq5R3+6yK+tbMa/7/9twOFQQQ7jMbXypntCB7xfMDDO5Vcqj/r61z+yNVBp
 hMKvkeeCGgyeFbWshqLHUFNH62W/T7bTtEbu8bHGb/gJip0ioBmfwXXu3U4BrVj0It5B08ZBH
 vqc0yKb1khVrwT2KYsAEY5RDfBC65WE4SIbDDTFvKqgfdBDt6kVD29rtd93gT7MkVZi6GEkM9
 e6WGXO+QC6XZQXEpZc8yrQaY9bdxvLnQWgJSRVcZK1PuI85ux4Gav7dc2LJ0SCiR+hY0StVvE
 z1GnyVXmonyuhgCQhY5mnOwz0J08M6VZ8dkJ9ltAE5PLhPTQijjkanilCvD7vvYRsL+pAMXfb
 BU4pAWJTwE7yrUrtMB7NakpbyXFL9shNQfMbVroOCl9pNZ2y9gOinLB02hNsZh1qqGJq6ld3q
 e9Pdl3X
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1870090443-1490832079=:4068
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Stefan & Daniel,

On Tue, 28 Mar 2017, Stefan Beller wrote:

> On Sat, Mar 25, 2017 at 8:15 PM, Daniel Ferreira (theiostream)
> <bnmvco@gmail.com> wrote:
>=20
> > SYNOPSIS
> > There are many advantages to converting parts of git that are still
> > scripts to C builtins, among which execution speed, improved
> > compatibility and code deduplication.
>=20
> agreed.

I would even add portability. But yeah, speed is a big thing. I am an
extensive user of `git add -p` (which is backed by
git-add--interactive.perl) and it is slow as molasses on Windows, just
because it is a Perl script (and the Perl interpreter needs to emulate
POSIX functionality that is frequently not even needed, such as: copying
all memory and reopening all file descriptors in a fork() call only to
exec() git.exe right away, tossing all of the diligently work into the
dustbin).

> > git-add--interactive, one of the most useful features of Git.
>=20
> knee jerk reaction: I never used it, so it cannot be that important ;)
> (I use git-gui, which is essentially the same workflow. There are tons
> of ways to accomplish a given goal using Git, so I guess we don't
> want to get in an argument here).

Well, I make up for your lack of `git add -i` usage.

Of course, since you use git-gui, you are simply using another dependency
that bloats Git for Windows: Tcl/Tk.

> > FEASIBILITY
> >
> > There was only one discussion regarding the feasibility of its porting
> > (https://public-inbox.org/git/CAP8UFD2PcBsU6=3DFK4OHVrB7E98ycohS_0pYcbC=
Bar=3Dof1HLx+Q@mail.gmail.com/).
> > It resulted in a consensus that doing it would be a task too large =E2=
=80=93
> > although interesting =E2=80=93 for GSoC 2015 based on the amount of its=
 lines
> > of code. It is, however, only a few lines larger than
> > git-rebase--interactive, which has been considered an appropriate
> > idea. As such, it looks like a possible project for three months of
> > full-time work.
>=20
> ok, it sounds a challenging project. (currently counting 1750 lines of
> code). Scrolling over the source code, there are quite a couple of
> functions, where the direct equivalent in C springs to mind.
>=20
> run_cmd_pipe -> see run-command.h
> unquote_path -> unquote_c_style ?
> refresh -> update_index_if_able()
> list_modified -> iterate over "const struct cache_entry *ce =3D active_ca=
che[i];"

Yes, I think it would be more important to acquaint oneself with the
idiosynchracies of Git's internal "API" than to get familiar with Perl:
interpreting what obscure Perl code does is something I would gladly do as
a mentor.

> > PROJECTED TIMELINE
> > - Prior to May 4
> > -- Refine my basic knowledge of Perl
> > -- Craft one or two small patches to some of Git's Perl components
> > (preferentially to git-add--interactive itself) to improve my
> > understanding of the language and of how Git's Perl scripts actually
> > work

As I mentioned above, the Perl code should be fairly intuitive for the
most part, with maybe a couple of pieces of code using more advanced Perl
techniques. Given the scope of the project, I would recommend working
closely together with the mentor(s) to clarify what those code parts do.

> > - May 4 - May 30
> > -- Clarify implementation details with my mentor, and work on a more
> > detailed roadmap for the project
> > -- Investigate roughly how to replace command invocations from the
> > script with actual builtin functions; which Git APIs in Perl already
> > have functional equivalents in C; which parts will require a full
> > rewrite.
>=20
> There are different approaches for replacing functionality in another
> language. Examples:
> * Implement the functionality in C and then have a "flag-day" commit
>   783d7e865e (builtin-am: remove redirection to git-am.sh, 2015-08-04)
>   This only works when the whole functionality was replaced in prior comm=
its
> * Implement partial functionality in C and call it via a helper function.
>   3604242f08 (submodule: port init from shell to C, 2016-04-15)
>   This works well for only partial conversions (the larger the thing to
>   convert the more appealing this is, as it gets code shipped early.)
>   When choosing this strategy, this part of the Project would be to
>   identify parts that could be ported on its own without much
>   additional glue-code.

To offer my perspective: I strongly prefer the latter approach. Not only
does it yield earlier results, it also makes it substantially easier to
handle the project even if it should turn out to be a little larger than
just 3 months.

> > - May 30 - June 30 (start of coding period)
> > -- Define the architecture of the builtin within git (which
> > functions/interfaces will it have? where will its code reside?).
> > -- Implement a small subset of the builtin (to be defined with my
> > mentor) and glue it into the existing Perl script. Present this as a
> > first patch to get feedback early regarding the implementation and
> > avoid piling up mistakes early.
> > -- Do necessary changes based on this initial review.
> > -- Have roughly 1/3 of the script's functionality ported to C.
> >
> > - June 30 - July 28
> > -- Port the remainder of the script to a builtin.
> > -- Have a weekly roadmap, sending a part of the patch every 15 days to
> > the mailing list for review and to avoid massive commits by the end of
> > GSoC.
>=20
> yeah; send early, send often. ;)

Even better: push multiple times a day to a public repository, say, on
GitHub. That allows for "Work In Progress" commits that not only serve as
a backup but also as transparent report what was done.

> > -- Apply suggestions from community reviews when possible; if not,
> > save them for doing toward the end of GSoC (see below).
>=20
> Please do not underestimate the discussion by community, finding
> consensus on list consumes a bit of time in some cases.

I agree with this statement. Ideally, the first patch series would be
ready to submit very soon into the project, something like 2 weeks (which
is another point in favor of the helper approach outlined by Stefan).

The smaller the patch series are, the more likely they will get in
quickly. And the easier is it to address reviewers' comments, because you
won't have to send out gazillion unchanged patches of a multi-dozen patch
series just to address one typo in one patch.

> > (Note: due to a previous commitment, during a five-day period of July
> > I will only be able to work part-time on GSoC. The actual week will be
> > known over the next weeks.)
>=20
> Maybe you want to shift the schedule up to here by one week then?
> (e.g. the first period would be April 27  - May 23)
>=20
> >
> > - July 28 - August 29
> > -- By the start of this period, send a patch with the builtin fully
> > implemented to the mailing list.
>=20
> /a patch/a patch series consisting of many patches/
> Experience shows that smaller patches are easier to review as
> it is more focused.

Not only that. Reviewers' time is scarce. I frequently have to triage
which mails I can read in the time I have for the mailing list. If I see a
patch series that is too large, I simply cannot review it. I gather that
is the same issue for pretty much all available reviewers.

> Consider e.g. e86ab2c1cd (wt-status: convert to struct object_id,
> 2017-02-21) and the parents leading up to this commit. They work on the
> same big topic, but focus on very regional areas to ease review.
>=20
> > -- Fix bugs, test extensively, possibly extend test coverage for
> > git-add--interactive.
>=20
> AFAICT ('$ git grep "git add -i"') there is only t3701 testing the
> interactive add. Maybe we need to add tests first to document
> current behavior, before attempting a conversion?

That should indeed be the first step, before doing much else.

However, it does look as if t3701's 40 test cases provide fairly thorough
coverage.

> This could go well into the period "May 4 - May 30", as writing
> tests would count as "Clarify implementation details".

I agree with that, too.

Thanks for working on this!
Johannes
--8323329-1870090443-1490832079=:4068--
