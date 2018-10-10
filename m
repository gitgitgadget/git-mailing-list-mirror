Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30E761F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 08:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbeJJP1z (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 11:27:55 -0400
Received: from mout.gmx.net ([212.227.17.20]:54507 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbeJJP1y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 11:27:54 -0400
Received: from DESKTOP-QUA364F ([89.204.155.81]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M24Vr-1fqZA927Jb-00u5J5; Wed, 10
 Oct 2018 10:06:50 +0200
Received: from DESKTOP-QUA364F ([89.204.155.81]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M24Vr-1fqZA927Jb-00u5J5; Wed, 10
 Oct 2018 10:06:50 +0200
Date:   Wed, 10 Oct 2018 10:06:50 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Derrick Stolee <stolee@gmail.com>,
        Ananya Krishna Maram <ananyakittu1997@gmail.com>,
        christian.couder@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH][Outreachy] remove all the inclusions of git-compat-util.h
 in header files
In-Reply-To: <xmqqd0sjpgw1.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1810100856570.2034@tvgsbejvaqbjf.bet>
References: <20181008170505.GA13134@manohar-ssh> <b1824db3-1c0d-6851-2f5a-800cc88ee50f@gmail.com> <xmqqd0sjpgw1.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:t9XihSkAcD8r1ieSqONTaBxqJOIC9tA9alcSzB8sOClGFXiY7LK
 /lqa2uXlE34NPXNI8MUMB+Var37O8f7Prr0JUUEUuHIwfSYc00hOtQpYl23pD8T8alh2Xuz
 DrMUrHjYMIWaPkpOiCp05tR9PqWf+hCwaK0jeXqPWOMSyom+wFS53ufOXqa9RsEfgpXssTO
 O1dO8SkVtwtEfxMoFkc4A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bUB4PiGgd/w=:iNjB4ri58nffu73esVhHlt
 65SCdNAEsGvROKvRDOIaWsGbL+MzVFGUBckjOXKmGMWmeA2N3RDYyqzH3Wm49UMBa6nUvrt4W
 Fu9vXIxrIEkN83G4Kw4leLx7fyirLyslZxaTQfKhwxnr8h9e7615ISFVWDCoPTmYBOVEhi+fd
 WzCI2vyIo9gakUaefcikE7jNLkYhiI4AAJPAqyFjOAgrgEJ4Zpz3pba4urNjLXz9ZSn5cARIU
 79Nm8y9RYj0UXoqs9Hup15zxBPxEooQblu9pVNMHObkXPlnFSkSSUeqTmLp3T8/pQEzeEYn87
 F02+028m017UK/MjmCqJcGpArLB/EkOZVDovQB6L0qsIfVrpbAiclmRWhK9MbqMJwf6di4lqb
 kYo4giySaUQX+WOxDAZhH2dV1ua8BiesE5Us4fat5KCDAsRv207xC8B8f1Klocvpybj2fTn8s
 sUW8FD8Tq5hP1COGYwSt7hhIL+/kdNBCb8qCLaGeSLVmBFXGIFbXkkQ0RhTJCnZlKIjuxX/4n
 TA+7zVj4vk0tfyPeW9BJJrVr9IrV6jYIIQDDUH9aDEgvNS2NQq+McjrVZGNxiarEZxfHC9k64
 VIEY/dcXQXVOgCYzquGD4bRhJbCjYIlsgJyV2pfJhJde6dIC6vVymgVluUzFeAjfh2zjbyORr
 uhNFQkNzu0isKKMO8uUj2Szdd4f/U+4ecJ50cHTGJ/EU6kN0L4DvSKmewVb5jRgEk8KdERCc8
 bhhEzbM2qkFfGztmTBKHAxkxurv/YGW/w2WpcAKiFIeArUhFMf2cigvx96diFK+SkLq/DITb2
 S4Whe1ZBuplVW9GS0AKsdriRyXjnglFD/CQ/0ZJBPj4wYAxs1Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Ananya,

Ananya, I think you did a really good job at contributing your first
patch, demonstrated by the useful comments you already received.

On Tue, 9 Oct 2018, Junio C Hamano wrote:

> Derrick Stolee <stolee@gmail.com> writes:
> 
> > On 10/8/2018 1:05 PM, Ananya Krishna Maram wrote:
> >> Hi All,
> > Hello, Ananya! Welcome.
> >
> >> I was searching through #leftovers and found this.
> >> https://public-inbox.org/git/CABPp-BGVVXcbZX44er6TO-PUsfEN_6GNYJ1U5cuoN9deaA48OQ@mail.gmail.com/
> >>
> >> This patch address the task discussed in the above link.
> > The discussion above seems to not be intended for your commit message,
> > but it does show up when I run `git am` and provide your email as
> > input. The typical way to avoid this is to place all commentary below
> > the "---" 
> > that signifies the commit message is over.
> 
> >> From: Ananya Krishan Maram <ananyakittu1997@gmail.com>
> >>
> >> skip the #include of git-compat-util.h since all .c files include it.
> >>
> >> Signed-off-by: Ananya Krishna Maram <ananyakittu1997@gmail.com>
> >> ---
> >>   advice.h             | 1 -
> >>   commit-graph.h       | 1 -
> >>   hash.h               | 1 -
> >>   pkt-line.h           | 1 -
> >>   t/helper/test-tool.h | 1 -
> >>   5 files changed, 5 deletions(-)
> >>
> >> diff --git a/advice.h b/advice.h
> >> index ab24df0fd..09148baa6 100644
> >> --- a/advice.h
> >> +++ b/advice.h
> >> @@ -1,7 +1,6 @@
> >>   #ifndef ADVICE_H
> >>   #define ADVICE_H
> >>   -#include "git-compat-util.h"
> >>     extern int advice_push_update_rejected;
> >>   extern int advice_push_non_ff_current;
> 
> The way I read the original discussion is "C source that includes
> compat-util.h shouldn't if it already includes cache.h"; advice.h is
> not C and does not (should not) include cache.h.
> 
> The "left over bits" should not be blindly trusted, and besides,
> Elijah punted to examine and think about each case and left it to
> others, so whoever is picking it up should do the thinking, not a
> blind conversion.  I am not getting a feeling that this patch was
> done with careful thinking after checking only this one.

The mistake -- if any! -- is mine: I suggested to Outreachy students to
look for the #leftoverbits needle in our mail archive haystack, and to
pick something to get a feel for contributing to Git.

Personally, I find the "whoever is picking it up should do the thinking"
much too harsh for a first-time contributor who specifically came through
the Outreachy program, i.e. expected to have a gentle introduction into
the project, and into the ways we work.

Granted, that introduction should have been performed by the potential
mentors (i.e. Chris & I, but I was out sick), but let's face it: we are an
open source project, so every single one of us should feel the call to be
a mentor, and we should certainly try to make every new contributor as
welcome as we would like to be invited into a new project.

In this context, I would think that the "do the thinking" part is
particularly hard because our rules are implicit, and inconsistent: when
do we include header files, when do we skip the include?

If in doubt, follow the age-old wisdom "when in Rome, do as the Romans
do", i.e. ignore the explicitly written-down rules, and instead imitate
what active contributors are doing.

Unfortunately, I have no easy way to suggest for mining the mailing list
for sentiments about including header files. And in any case, it would
probably boil down on personal taste, which -- let's face it -- is rather
diverse in our community... :-)

So in this case, what I would suggest is to look instead for the commit
history, where header files were added or modified. The Git command for
that is:

	git log --no-merges -p \*.h

Apart from the rather wonderful examples you see there for commit messages
(I am a big fan of commit messages that are clear and descriptive, i.e.
start by detailing the why rather than the how, with notes thrown in about
design decisions that are not obvious from the patch), this command will
lead us pretty soon to this commit, especially when looking for the search
term #include:

	https://github.com/git/git/commit/69d846f05381

In other words, we explicitly introduced an `#include "git-compat-util.h"`
in a header there.

The commit message also offers a pretty compelling rationale: it was the
most efficient way to have that header included *first thing* in all test
helpers.

Following that rationale, let's have a look at the patch we are improving
here (because that's what code review really should all be about:
improving the code, putting together all of our expertise to get the best
patch we can in a reasonable amount of time):

The first thing we can already say is that the change to
t/helper/test-tool.h would revert the commit referenced above, so I think
we should drop that change.

Next, I want to have a look at advice.h:

	git grep -O 'advice\.h'

(the backslash is necessary because this is a regular expression, and the
period character has the special meaning "any character" there, unless
escaped by a backslash)

What we can see is that indeed, every file that includes this header
already includes cache.h first. We can even see that cache.h *itself*
includes advice.h, meaning that we could add another patch that drops the
advice.h include from, say, commit.c.

At this point, this seems to become a rabbit hole: which header files are
already included in cache.h that are *also* included (unnecessarily) in .c
files that *already* included cache.h?

Ananya, it is now up to you how far you want to go down that rabbit hole
;-)

If I had the time, *I* would now be tempted to try my hand at writing a
script that analyzes our source code to ensure that:

- "cache.h" or "git-compat-util.h" is the first header included (as per
  that commit message of the commit mentioned above)
- every header that is already included in cache.h is not included by a .c
  file that already included cache.h

It is the kind of side-track I could lose days over, but I have to admit
that the benefit would probably not merit the effort ;-)

In any case, I am delighted by your first patch: you took the first hurdle
:-)

Ciao,
Johannes

P.S.: Please record your contribution on the Outreachy site, unless you
already did...
