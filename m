Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F36501F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 20:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732563AbfAPUbO (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 15:31:14 -0500
Received: from mout.gmx.net ([212.227.15.19]:58569 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732364AbfAPUbO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 15:31:14 -0500
Received: from [10.49.171.108] ([95.208.59.12]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MPlY2-1geu221fMY-0052pQ; Wed, 16
 Jan 2019 21:31:08 +0100
Date:   Wed, 16 Jan 2019 21:30:52 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] t6042: work around speed optimization on Windows
In-Reply-To: <CABPp-BHOkVKVpZy2RKj-ofoajGT0rgrb2TpQsXprk1_yZwtVfA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1901162108140.41@tvgsbejvaqbjf.bet>
References: <pull.109.git.gitgitgadget@gmail.com> <598de6652cdb19b9772f322f17600c3845f208cc.1547645839.git.gitgitgadget@gmail.com> <CABPp-BHOkVKVpZy2RKj-ofoajGT0rgrb2TpQsXprk1_yZwtVfA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Oi+61wJNI3kyfkpjs6gdnjJ1YTQeMoKDtHpQ9SZCSXfRLago/MJ
 hG04sy4PHT15Y9mc2J4ZrNe/iHuwLyma5/Mw4oZFuakb6pkcZB9vGz+uuw+FACrPqIlSn07
 i/u8RhVjXyEG6C9KMAZqxTiqk433loJSShRR6sFSA09MpCg2hwI2gZi+5r0HxxR1F8dXtDI
 rU5sKqUVqAgoHPJ9PVzAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EgkqI0mOEEk=:0U6D6OfVlrD7836/XbRR88
 Cjr1eHrMfL9d/BTTp4GUIKsh33eSVwPdv40IYpPrvr7HjXZAIyldYdJv1imdoG3z8+sCEvkWr
 6P0u13aVJA9QjqL2+XR7rlrzU5YY9l8ruK18cNAjxvY238jmZa3UvBMi7MDaj9lEJdJ2X3hmo
 OwM1DmScnnbPyLPbb5de/3kZKO6eth2SrZKS1cmCfIG7B8RdprSpaQd4W/scl1Yl2RrMyAZVE
 nQuCkyC7/d7iMHMw6qh2/JVRBFnFYD9GbyAQpmALxBZGxfV/6Errwm8pZg2+GBqQ6bCFICSWo
 Mf7oatnun3rNuuEqTmHW0y9xuxMS4cdGi10pDGVXmAsCI4ZPhWMojHrX9vvjNG5jlLaE48VV8
 aMzJygN9bgNE9MZK4I+2azzhHI6EuSBZX0M4BrEeyKsCrbAXPnztpwBqiXlh+Xhr/d4L86SBw
 +azH2APac7g3jLlgAKnSA4ED42NAda1eS0+M/1rZrMIgkZ+lYM6UcFBg2hXWHksmTX4/wpjnx
 jW3Gb4Xb74/UL4VIML4r08Loxg7+MljuChEI2gVxaRyo+hBdc7go+pPWwQeaBLUr+4tlU7C86
 piJGG3F6RPJP8E6S7Zn7i0OLIgyPYZmx27Yw1RGIXLDAD2ZvmIGb26AXPaEVn0EN0vS6z8nYH
 gSNvHhhWB4rIUyFbkmUV1MMImIxlW80D2YT+lRuXqEjelKjPWXyz7gg8i0Vs8CYYZ1NPAkpBi
 gEQaO0/Mps/91yZYrT/Hlv9ApsVg+o1NnDKGCo2E1Wzw3xcC7jWddnoDLkLnzx7j1y4KHwVlc
 q30iIXkwfCgcXmll0I3+aGGpi9t6f0PjQQMoHzIGPFSX/GKhCGb3XgAQGZj2dD92NdudABgkC
 lbz+pcmKwPA6W8HpdsY5vDizAuSE4aswSw6RVDLDd+2tUtMhMMp9pnfutQxjcc+sO2SboVEqY
 EmL6WUaJfAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Wed, 16 Jan 2019, Elijah Newren wrote:

> On Wed, Jan 16, 2019 at 5:37 AM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > When Git determines whether a file has changed, it looks at the mtime,
> > at the file size, and to detect changes even if the mtime is the same
> > (on Windows, the mtime granularity is 100ns, read: if two files are
> > written within the same 100ns time slot, they have the same mtime) and
> > even if the file size is the same, Git also looks at the inode/device
> > numbers.
> >
> > This design obviously comes from a Linux background, where `lstat()`
> > calls were designed to be cheap.
> >
> > On Windows, there is no `lstat()`. It has to be emulated. And while
> > obtaining the mtime and the file size is not all that expensive (you
> > can get both with a single `GetFileAttributesW()` call), obtaining the
> > equivalent of the inode and device numbers is very expensive (it
> > requires a call to `GetFileInformationByHandle()`, which in turn
> > requires a file handle, which is *a lot* more expensive than one might
> > imagine).
> >
> > As it is very uncommon for developers to modify files within 100ns
> > time slots, Git for Windows chooses not to fill inode/device numbers
> > properly, but simply sets them to 0.
> >
> > However, in t6042 the files file_v1 and file_v2 are typically written
> > within the same 100ns time slot, and they do not differ in file size.
> > So the minor modification is not picked up.
> >
> > Let's work around this issue by avoiding the `git mv` calls in the
> > 'mod6-setup: chains of rename/rename(1to2) and rename/rename(2to1)'
> > test case. The target files are overwritten anyway, so it is not like
> > we really rename those files. This fixes the issue because `git add`
> > will now add the files as new files (as opposed to existing, just
> > renamed files).
> 
> I actually read this before the cover letter (just responded in opposite
> order), and the last paragraph alarmed me at first, because it made it
> sound like it was dispensing with the need for rename detection and thus
> breaking the intent of the testcase.

Right, the cover letter has the benefit of being written last (so I have
thought about the issue the longest before casting my thoughts into
words while writing it, longer than when I come up with the commit
message, which is typically even before I test things thoroughly).

> Granted, looking at the code it becomes clear you're not changing the
> intent of the testcase at all, just transforming the setup steps
> slightly.  In your cover letter, you made this clear by stating that you
> were replacing
>     git mv <old> <new> && mv <file> <new> && git add <new>`
> by
>     git rm <old> && mv <file> <new> && git add <new>`
> Perhaps something like that could be added here or other wording to
> clarify that it's just an innocuous transformation of the setup steps?

Sure. I added this paragraph:

	Functionally, we do not change anything because we replace two
	`git mv <old> <new>` calls (where `<new>` is completely
	overwritten and `git add`ed later anyway) by `git rm <old>` calls
	(removing other files, too, that are also completely overwritten
	and `git add`ed later).

This should explain the intention nicely, would you agree?

> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  t/t6042-merge-rename-corner-cases.sh | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
> > index 7cc34e7579..09dfa8bd92 100755
> > --- a/t/t6042-merge-rename-corner-cases.sh
> > +++ b/t/t6042-merge-rename-corner-cases.sh
> > @@ -1175,7 +1175,7 @@ test_expect_success 'setup nested conflicts from rename/rename(2to1)' '
> >
> >                 # Handle the left side
> >                 git checkout L &&
> > -               git mv one three &&
> > +               git rm one two &&
> 
> Here you not only remove the file being renamed ('one') but also a
> file being modified ('two'); you didn't mention the latter in your
> commit message.

True. But it *is* replaced and `git add`ed later, too.

> Since both are added back later it'll still work either way on linux,
> but was it suffering from the same problem on Windows?

Yes. All 6 versions of the file are written in quick succession. So yes,
*any* of these 6 versions that are intended to replace another of said 6
versions will suffer from the exact same problem.

> It too was a case of both the filesize before and after remaining the
> same despite contents changing, so it certainly seem possible.

Yep.

> >                 mv -f file_v2 three &&
> >                 mv -f file_v5 two &&
> >                 git add two three &&
> > @@ -1183,7 +1183,7 @@ test_expect_success 'setup nested conflicts from rename/rename(2to1)' '
> >
> >                 # Handle the right side
> >                 git checkout R &&
> > -               git mv two three &&
> > +               git rm one two &&
> 
> Also here you remove both a renamed and a modified file -- though in
> this case I think the file sizes change for both (each increases by
> one character) so this hunk of the patch probably isn't needed.

It did not make sense for me to use two *different* ways to perform
essentially the same operation. I know I would scratch my head until it
hurts if I read intentionally different command cadences, to figure out
why they are different. Only to find out that they are not intended to be
different? I don't think so.

> It doesn't hurt though, and could be considered future-proofing against
> possible changes to the setup files, and may also just be nice to make
> the two blocks of setup look more consistent

Indeed. I would *hate* to lose time over reading those test cases in 6
months, just because they use different paradigms (even if they want to do
the same thing).

And I have to spend *way* too much time reading test scripts. So I am very
adamant about making my own life easier here.

Point in case: it took me quite a good while to understand the code that I
fixed in this patch, because the underlying intention was not immediately
accessible to me. The test failure happens in the *next* test case, after
all. That was a head scratcher, too: the problem was in a test case that
*passed*, not in the one that failed.

It all comes back to what I have been harping on for at least a year: our
test suite is not really optimized for figuring out how to fix test
failures. There is nothing immediately actionable when anything fails. A
developer has to spend considerable time to find out what is going wrong
if a test failure happens (is it flakey? Is it a bug in the *test*? Is it
a *true regression*?)

Of course, this is not a new problem. And I *do* see that some
contributors are as interested as I am in a more useful test suite, one
where a failed test *really* indicates a regression, one where the output
of a failed test has enough evidence to start fixing the bug right away
(rather than spending time on understanding the intention of what was
tested first). For example, when `wc -l` invocations were replaced by
`test_line_count`, not only did we address portability problems (where BSD
`wc` would indent the output), we also changed the code to indicate quite
clearly *what* was tested. We do not yet output the contents of the file
when `test_i18ngrep` fails, but that would also be a step in the right
direction.

Here's hoping that our test suite improves in that respect: to make it
easier and quicker to fix regressions.

Ciao,
Dscho

> >                 mv -f file_v3 one &&
> >                 mv -f file_v6 three &&
> >                 git add one three &&
> > --
> > gitgitgadget
> 
> 
> Thanks,
> Elijah
> 
