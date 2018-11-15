Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9310F1F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 12:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732953AbeKOWfO (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 17:35:14 -0500
Received: from mout.gmx.net ([212.227.15.19]:37437 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728950AbeKOWfO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 17:35:14 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MD9NE-1gFYZ82DTI-00GVZd; Thu, 15
 Nov 2018 13:27:26 +0100
Date:   Thu, 15 Nov 2018 13:27:09 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Pratik Karki <predatoramigo@gmail.com>
Subject: Re: [PATCH v2 2/2] rebase: Implement --merge via
 git-rebase--interactive
In-Reply-To: <CABPp-BHgeSGxVe1ThZcX=5Q4wO_-frm59=CwwrJxNRcHXiPTqQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811151233430.41@tvgsbejvaqbjf.bet>
References: <20181108060158.27145-1-newren@gmail.com> <20181108060158.27145-3-newren@gmail.com> <nycvar.QRO.7.76.6.1811121614190.39@tvgsbejvaqbjf.bet> <CABPp-BHgeSGxVe1ThZcX=5Q4wO_-frm59=CwwrJxNRcHXiPTqQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BshgIycrYK8z48zNwDf6vdWSQ5q6eMKnnb0XjHKlFMdvKovpbtt
 vf5/jz6EDq+sZLbkMsrh3QF6daej9CS+OjBoeUQyepbX7nO2CUC+u7BwAsfFBRvmuPcD1uv
 DGEu5Jvc0qUsjPiDsYWzTNRKbjai5pLhRduT/B2vBchyUs4i32RoA25ATw3lCTEERH/Tq5z
 0HIaunUlWli4vW7j1cuZg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:krjJjhRC8dw=:PsGCdAjaIu+Ty02HNTdPG+
 Ybpw7gb/iFYbx3c55gDeE0SV9MJOzf1Cc/CABolOsS/Iy2wr/wW8KKrZj3EMYbtWnwrHZ+ZIO
 XudOXgzVE8GSKSfOpX8SM/uZDtJ9Krr8mCKsmtybxhyZ/WvJeJSh/z1K3AcbH9bFGnQcedRXm
 Y5lWrULhLvmMbqobb0G6owtUl0M0EsQ+aC3ZWwfx6mZ/f7GwJq0Q4tEEX5jeVh5ARNG7dKzp1
 QWkaCMLMEMSThXbfsMpLaCmu4TvMII7rYocMzv6MzGkHoZJVuy8yPfQLBfvPrkCDxzWdZYY6V
 HDtJ9arS/TGOxdn4N1y0jjq/T+w0Z1RGYYlPTZ3rRMTDc1voQf8pBImU2o7klSdUdHddhABme
 xo7BaLNjqPRyXV627w/IKoMpqAAUNLq2TomA5XBNGsbVrOvoPc+fyiVirVLSLx+/a34LBZBBq
 VNUCum5awILpoeSsHR7t9GWntGFH5ruOPThYahwGNhK6fNvrSbVnpRktQo1F/oD1Qm7U/njOs
 I7HVbcsCraab0LTFNW+UD4iCaVFGkLscZv35CA4nFcuvK9vp9K1ZI8u2x+ohFSXm+mda6lG+B
 iRVROpucaqpaW6SzKinKk835ismUCAmID5TJTd0z4GE98xmgkZyetsEjrseWemYtsnDoNXHwf
 IuB4Mo61hPLz9k11IEJrRfFU57xccfpxl8oZt82sgktD0D5fOYLpmJ2XnSqcMOOyDIgrY1oO7
 75MvCigTCtHzh/rx4U08StdfFbtcxdxbOCCOcGPjWXgxaUOut8PlzAvqpqNA7ZVryuME97Ysn
 NbVFr3auE4VfE1SIkU6UQGKQsMUMhI2mpHyTCE687xu+UwMbB/xBUO5FfgCcdAkgVh8k2LNK6
 9HZky/+wNHIbzr/sb0Mq0KqRt73PIUyX2+aS0W0XORbVJnbQOX3UGY+SDc5A11yfv445wexlP
 Px7C8ExIV2w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Wed, 14 Nov 2018, Elijah Newren wrote:

> On Mon, Nov 12, 2018 at 8:21 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > >   t3425: topology linearization was inconsistent across flavors of rebase,
> > >          as already noted in a TODO comment in the testcase.  This was not
> > >          considered a bug before, so getting a different linearization due
> > >          to switching out backends should not be considered a bug now.
> >
> > Ideally, the test would be fixed, then. If it fails for other reasons than
> > a real regression, it is not a very good regression test, is it.
> 
> I agree, it's not the best regression test.  It'd be better if it
> defined and tested for "the correct behavior", but I suspect it has
> some value in that it's is guaranteeing that the rebase flavors at
> least give a "somewhat reasonable" result.  Sadly, It just allowed all
> three rebase types to have slightly different "somewhat reasonable"
> answers.

True. I hope, though, that we can address this relatively easily (by
toggling the `topo_order` flag).

> > >   t5407: different rebase types varied slightly in how many times checkout
> > >          or commit or equivalents were called based on a quick comparison
> > >          of this tests and previous ones which covered different rebase
> > >          flavors.  I think this is just attributable to this difference.
> >
> > This concerns me.
> >
> > In bigger repositories (no, I am not talking about Linux kernel sized
> > ones, I consider those small-ish) there are a ton of files, and checkout
> > and commit (and even more so reset) sadly do not have a runtime complexity
> > growing with the number of modified files, but with the number of tracked
> > files (and some commands even with the number of worktree files).
> >
> > So a larger number of commit/checkout operations makes me expect
> > performance regressions.
> >
> > In this light, could you elaborate a bit on the differences you see
> > between rebase -i and rebase -m?
> 
> I wrote this comment months ago and don't remember the full details.
> From the wording and as best I remember, I suspect I was at least
> partially annoyed by the fact that these and other regression tests
> for rebase seemed to not be testing for "correct" behavior, but
> "existing" behavior.  That wouldn't be so bad, except that existing
> behavior differed on the exact same test setup for different rebase
> backends and the differences in behavior were checked and enforced in
> the regression tests.  So, it became a matter of taste as to how much
> things should be made identical and to which backend, or whether it
> was more important to at least just consolidate the code first and
> keep the results at least reasonable.  At the time, I figured getting
> fewer backends, all with reasonable behavior was a bit more important,
> but since this difference is worrisome to you, I will try to dig
> further into it.

I agree that there is a ton of inconsistency going on, both in the
behavior of the different backends as well as in the tests and their
quality.

The best explanation I have for this is: it grew historically, and we
always have to strike a balance between strict rule enforcement and fun.

> > >   t9903: --merge uses the interactive backend so the prompt expected is
> > >          now REBASE-i.
> >
> > We should be able to make that test pass, still, by writing out a special
> > file (e.g. $state_dir/opt_m) and testing for that. Users are oddly upset
> > when their expectations are broken... (and I actually agree with them.)
> 
> I agree users are upset when expectations are broken, but why would
> they expect REBASE-m?  In fact, I thought the prompt was a reflection
> of what backend was in use, so that if someone reported an issue to
> the git mailing list or a power user wanted to know where the control
> files were located, they could look for them.  As such, I thought that
> switching the prompt to REBASE-i was the right thing to do so that it
> would match user expectations.  Yes, the backend changed; that's part
> of the release notes.

When you put it that way, I have to agree with you.

> Is there documentation somewhere that specifies the meaning of this
> prompt differently than the expectations I had somehow built up?

I was just looking from my perspective, with my experience: if I was a
heavy user of `git rebase -m` (I am not), I would stumble over this
prompt. That's all.

With your explanation, I agree that this is the best course, though.

> > > diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> > > index 3407d835bd..35084f5681 100644
> > > --- a/Documentation/git-rebase.txt
> > > +++ b/Documentation/git-rebase.txt
> > > @@ -504,15 +504,7 @@ See also INCOMPATIBLE OPTIONS below.
> > >  INCOMPATIBLE OPTIONS
> > >  --------------------
> > >
> > > -git-rebase has many flags that are incompatible with each other,
> > > -predominantly due to the fact that it has three different underlying
> > > -implementations:
> > > -
> > > - * one based on linkgit:git-am[1] (the default)
> > > - * one based on git-merge-recursive (merge backend)
> > > - * one based on linkgit:git-cherry-pick[1] (interactive backend)
> > > -
> >
> > Could we retain this part, with `s/three/two/` and `/git-merge/d`? *Maybe*
> > `s/interactive backend/interactive\/merge backend/`
> 
> Removing this was actually a suggestion by Phillip back in June at the
> end of https://public-inbox.org/git/13ccb4d9-582b-d26b-f595-59cb0b7037ab@talktalk.net/,
> for the purpose of removing an implementation details that users don't
> need to know about.  As noted elsewhere in the thread, between you and
> Phillip, I'll add some comments to the commit message about this.

Right. It is not exactly a democracy over here, but I do agree that both
of your opinions combined weigh more than my single one. Besides, you have
a good point: the documentation is not so much about being technically
correct, but about being helpful to the users. And the new version is
probably more helpful than the old version.

> > > -if test -n "$git_am_opt"; then
> > > -     incompatible_opts=$(echo " $git_am_opt " | \
> > > -                         sed -e 's/ -q / /g' -e 's/^ \(.*\) $/\1/')
> > > -     if test -n "$interactive_rebase"
> > > +incompatible_opts=$(echo " $git_am_opt " | \
> > > +                 sed -e 's/ -q / /g' -e 's/^ \(.*\) $/\1/')
> >
> > Why are we no longer guarding this behind the condition that the user
> > specified *any* option intended for the `am` backend?
> 
> The code is still correctly guarding, the diff is just confusing.
> Sorry about that.  To explain, the code previously was basically:
> 
> if git_am_opt:
>   if interactive:
>     if incompatible_opts:
>       show_error_about_interactive_and_am_incompatibilities
>   if rebase-merge:
>     if incompatible_opts
>       show_error_about_merge_and_am_incompatibilities
> 
> which was a triply nested if, and the first (git_am_opt) and third
> (incompatible_opts) were slightly redundant; the latter being a subset
> of the former.

Ah, that's what I missed! Thank you for your explanation.

> Perhaps I should have done a separate cleanup patch before this that
> changed it to:
> 
> if incomptable_opts:
>   if interactive:
>     show_error_about_interactive_and_am_incompatibilities
>   if rebase-merge:
>     show_error_about_merge_and_am_incompatibilities
> 
> Before then having this patch coalesce that down to:
> 
> if incomptable_opts:
>   if interactive:
>     show_error_about_incompatible_options
> 
> Since it tripped up both you and Phillip, I'll add this preliminary
> cleanup as a separate commit with accompanying explanation in my next
> re-roll.

Thank you, much appreciated.

> > > diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
> > > index 0392e36d23..04d6c71899 100755
> > > --- a/t/t3406-rebase-message.sh
> > > +++ b/t/t3406-rebase-message.sh
> > > @@ -17,14 +17,9 @@ test_expect_success 'setup' '
> > >       git tag start
> > >  '
> > >
> > > -cat >expect <<\EOF
> > > -Already applied: 0001 A
> > > -Already applied: 0002 B
> > > -Committed: 0003 Z
> > > -EOF
> > > -
> >
> > As I had mentioned in the previous round: I think we can retain these
> > messages for the `--merge` mode. And I think we should: users of --merge
> > have most likely become to expect them.
> >
> > The most elegant way would probably be by adding code to the sequencer
> > that outputs these lines if in "merge" mode (and add a flag to say that we
> > *are* in "merge" mode).
> >
> > To that end, the `make_script()` function would not generate `# pick` but
> > `drop` lines, I think, so that the sequencer can see those and print the
> > `Already applied: <message>` lines. And a successful `TODO_PICK` would
> > write out `Committed: <message>`.
> 
> I'll take a look, but is this a case where you want it only when
> rebase previously showed them, or should it also affect other cases
> such as --rebase-merges or --exec or general --interactive?

Oh, I was just interested in retaining the previous behavior. So only for
--merge, not for -r, --exec or -i.

> I'm hoping the latter, or that there's a good UI-level explanation for
> why certain rebase flags would actually mean that users should expect
> different output.

Hmm. You are right. This *is* an inconsistency, and insisting on
perpetuating it is maybe not the best idea.

> rebase seems to be loaded with cases where slight variations on options
> yield very different side output and perhaps even results mostly based
> on which backend it historically was implemented on top of.  Those
> gratuitous inconsistencies drive this particular user crazy.

If you put it that way, we can sell this change of behavior as an
improvement: we are *aligning* the output of `git rebase --merge` with the
output of `git rebase --interactive`.

I am starting to like it.

> > >  test_expect_success 'rebase -m' '
> > >       git rebase -m master >report &&
> > > +     >expect &&
> > >       sed -n -e "/^Already applied: /p" \
> > >               -e "/^Committed: /p" report >actual &&
> > >       test_cmp expect actual
> > > diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
> > > index f355c6825a..49077200c5 100755
> > > --- a/t/t3420-rebase-autostash.sh
> > > +++ b/t/t3420-rebase-autostash.sh
> > > @@ -53,41 +53,6 @@ create_expected_success_interactive () {
> > >       EOF
> > >  }
> > >
> > > -create_expected_success_merge () {
> > > -     cat >expected <<-EOF
> > > -     $(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
> > > -     HEAD is now at $(git rev-parse --short feature-branch) third commit
> > > -     First, rewinding head to replay your work on top of it...
> > > -     Merging unrelated-onto-branch with HEAD~1
> > > -     Merging:
> > > -     $(git rev-parse --short unrelated-onto-branch) unrelated commit
> > > -     $(git rev-parse --short feature-branch^) second commit
> > > -     found 1 common ancestor:
> > > -     $(git rev-parse --short feature-branch~2) initial commit
> > > -     [detached HEAD $(git rev-parse --short rebased-feature-branch~1)] second commit
> > > -      Author: A U Thor <author@example.com>
> > > -      Date: Thu Apr 7 15:14:13 2005 -0700
> > > -      2 files changed, 2 insertions(+)
> > > -      create mode 100644 file1
> > > -      create mode 100644 file2
> > > -     Committed: 0001 second commit
> > > -     Merging unrelated-onto-branch with HEAD~0
> > > -     Merging:
> > > -     $(git rev-parse --short rebased-feature-branch~1) second commit
> > > -     $(git rev-parse --short feature-branch) third commit
> > > -     found 1 common ancestor:
> > > -     $(git rev-parse --short feature-branch~1) second commit
> > > -     [detached HEAD $(git rev-parse --short rebased-feature-branch)] third commit
> > > -      Author: A U Thor <author@example.com>
> > > -      Date: Thu Apr 7 15:15:13 2005 -0700
> > > -      1 file changed, 1 insertion(+)
> > > -      create mode 100644 file3
> > > -     Committed: 0002 third commit
> > > -     All done.
> > > -     Applied autostash.
> > > -     EOF
> > > -}
> > > -
> > >  create_expected_failure_am () {
> > >       cat >expected <<-EOF
> > >       $(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
> > > @@ -112,43 +77,6 @@ create_expected_failure_interactive () {
> > >       EOF
> > >  }
> > >
> > > -create_expected_failure_merge () {
> > > -     cat >expected <<-EOF
> > > -     $(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
> > > -     HEAD is now at $(git rev-parse --short feature-branch) third commit
> > > -     First, rewinding head to replay your work on top of it...
> > > -     Merging unrelated-onto-branch with HEAD~1
> > > -     Merging:
> > > -     $(git rev-parse --short unrelated-onto-branch) unrelated commit
> > > -     $(git rev-parse --short feature-branch^) second commit
> > > -     found 1 common ancestor:
> > > -     $(git rev-parse --short feature-branch~2) initial commit
> > > -     [detached HEAD $(git rev-parse --short rebased-feature-branch~1)] second commit
> > > -      Author: A U Thor <author@example.com>
> > > -      Date: Thu Apr 7 15:14:13 2005 -0700
> > > -      2 files changed, 2 insertions(+)
> > > -      create mode 100644 file1
> > > -      create mode 100644 file2
> > > -     Committed: 0001 second commit
> > > -     Merging unrelated-onto-branch with HEAD~0
> > > -     Merging:
> > > -     $(git rev-parse --short rebased-feature-branch~1) second commit
> > > -     $(git rev-parse --short feature-branch) third commit
> > > -     found 1 common ancestor:
> > > -     $(git rev-parse --short feature-branch~1) second commit
> > > -     [detached HEAD $(git rev-parse --short rebased-feature-branch)] third commit
> > > -      Author: A U Thor <author@example.com>
> > > -      Date: Thu Apr 7 15:15:13 2005 -0700
> > > -      1 file changed, 1 insertion(+)
> > > -      create mode 100644 file3
> > > -     Committed: 0002 third commit
> > > -     All done.
> > > -     Applying autostash resulted in conflicts.
> > > -     Your changes are safe in the stash.
> > > -     You can run "git stash pop" or "git stash drop" at any time.
> > > -     EOF
> > > -}
> > > -
> > >  testrebase () {
> > >       type=$1
> > >       dotest=$2
> > > @@ -177,6 +105,9 @@ testrebase () {
> > >       test_expect_success "rebase$type --autostash: check output" '
> > >               test_when_finished git branch -D rebased-feature-branch &&
> > >               suffix=${type#\ --} && suffix=${suffix:-am} &&
> > > +             if test ${suffix} = "merge"; then
> > > +                     suffix=interactive
> > > +             fi &&
> > >               create_expected_success_$suffix &&
> > >               test_i18ncmp expected actual
> > >       '
> > > @@ -274,6 +205,9 @@ testrebase () {
> > >       test_expect_success "rebase$type: check output with conflicting stash" '
> > >               test_when_finished git branch -D rebased-feature-branch &&
> > >               suffix=${type#\ --} && suffix=${suffix:-am} &&
> > > +             if test ${suffix} = "merge"; then
> > > +                     suffix=interactive
> > > +             fi &&
> > >               create_expected_failure_$suffix &&
> > >               test_i18ncmp expected actual
> > >       '
> >
> > As I stated earlier, I am uncomfortable with this solution. We change
> > behavior rather noticeably, and the regression test tells us the same. We
> > need to either try to deprecate `git rebase --merge`, or we need to at
> > least attempt to recreate the old behavior with the sequencer.
> 
> Yes, I understand not wanting to confuse users.  But, serious
> question, are you (unintentionally) enforcing that we continue
> confusing users?  I may be totally misunderstanding you or the problem
> space -- you know a lot more here than I do -- but to me your comments
> sound like enforcing bug compatibility over correctness.

I am actually a really inappropriate person to make judgement calls on
`git rebase --merge`, as I am neither a user of it nor do I know of any. I
don't think I ever read any account of a Git for Windows user who called
`git rebase --merge`...

> As stated in the git-2.19 release notes (relative to my previous series),
>     "git rebase" behaved slightly differently depending on which one of
>      the three backends gets used; this has been documented and an
>      effort to make them more uniform has begun.
> If we aren't trying to make the behavior more uniform and don't have
> good UI rationale for things being different, then my motivation to
> work on the affected aspects of rebase plummets.
> 
> Perhaps this is attributable to a difference of worldview we have, or
> perhaps I'm just missing something totally obvious.  I'm hoping it's
> the latter.  But if it helps, here's the angle I viewed it from: These
> regression tests showed us that even when identical operations were
> being performed from the user perspective, we got very different
> results with the only difference being what backend happened to be
> selected (and the backends had significant overlap in the area they
> could all handle, as evidenced by the same testcase being run with
> each).  That seems to me like pretty obvious proof that one or more
> backends was buggy.  Said another way, it looks to me like this is
> another example of regression tests enforcing "one semi-reasonable
> behavior" instead of "the correct behavior".
> 
> 
> I fully admit I don't have good UI rationale for why the output from
> the interactive backend is correct.  It may not be.  I also don't have
> good UI rationale for why the output from the traditional merge
> backend would be correct.  (And it could be that both are wrong.)
> It'd be better to figure out what is correct and make the code and the
> tests implement and check for that.  However, while I don't know what
> correct output to show the user is in these cases, I don't see how
> it's possible that both backends could have previously been correct.
> If someone could clearly enunciate a reason for different options to
> yield different output, I'd happily go and implement it.  One obvious
> explanation could be "--interactive implies user-interactivity, which
> should thus have different output" -- but that doesn't explain the
> past because we have several interactive_rebase=implied cases which
> then should have matched --merge's output rather than --interactive's.
> Absent any such UI rationale, I'd rather at least make all the
> backends implement the same semi-reasonable behavior so it's at least
> consistent.  Then when someone figures out what correct is, they can
> fix it all in one place.
> 
> I'm curious to hear if someone has a good reason for which messages
> should be preferred and when.  I'm also curious if perhaps people
> think that I'm focusing too much on consistency and not enough on
> "backward compatibility".

It is good to have your perspective in addition to mine. As na open source
maintainer, I gravitate toward aiming for maximal backwards-compatibility
out of purely selfish reasons: I don't want to deal with so many people
complaining about changes in the software I maintain.

But you raised a good point: relying on behavior no matter how undesirable
said behavior is not doing users a big favor. It is better to face the
challenge of fixing that behavior.

> > > diff --git a/t/t3425-rebase-topology-merges.sh b/t/t3425-rebase-topology-merges.sh
> > > index 846f85c27e..cd505c0711 100755
> > > --- a/t/t3425-rebase-topology-merges.sh
> > > +++ b/t/t3425-rebase-topology-merges.sh
> > > @@ -72,7 +72,7 @@ test_run_rebase () {
> > >  }
> > >  #TODO: make order consistent across all flavors of rebase
> > >  test_run_rebase success 'e n o' ''
> > > -test_run_rebase success 'e n o' -m
> > > +test_run_rebase success 'n o e' -m
> > >  test_run_rebase success 'n o e' -i
> > >
> > >  test_run_rebase () {
> > > @@ -89,7 +89,7 @@ test_run_rebase () {
> > >  }
> > >  #TODO: make order consistent across all flavors of rebase
> > >  test_run_rebase success 'd e n o' ''
> > > -test_run_rebase success 'd e n o' -m
> > > +test_run_rebase success 'd n o e' -m
> > >  test_run_rebase success 'd n o e' -i
> > >
> > >  test_run_rebase () {
> > > @@ -106,7 +106,7 @@ test_run_rebase () {
> > >  }
> > >  #TODO: make order consistent across all flavors of rebase
> > >  test_run_rebase success 'd e n o' ''
> > > -test_run_rebase success 'd e n o' -m
> > > +test_run_rebase success 'd n o e' -m
> > >  test_run_rebase success 'd n o e' -i
> > >
> > >  test_expect_success "rebase -p is no-op in non-linear history" "
> >
> > This is a bit unfortunate. I wonder if we could do something like this, to
> > retain the current behavior:
> >
> > -- snip --
> > diff --git a/sequencer.c b/sequencer.c
> > index 9e1ab3a2a7..5018957e49 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -4394,7 +4394,8 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
> >         revs.reverse = 1;
> >         revs.right_only = 1;
> >         revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
> > -       revs.topo_order = 1;
> > +       if (!(flags & TODO_LIST_NO_TOPO_ORDER))
> > +               revs.topo_order = 1;
> >
> >         revs.pretty_given = 1;
> >         git_config_get_string("rebase.instructionFormat", &format);
> > -- snap -
> >
> > (and then pass TODO_LIST_NO_TOPO_ORDER if in "merge" mode)?
> 
> Oh, sweet, we can make these consistent?  I tried to look at this a
> little bit didn't dig too far.  I love it; I'll definitely give it a
> try.
> 
> ...but...why only in merge mode??  am, interactive, and merge backends
> gave different results, and the regression test even pointed out that
> whoever wrote these tests thought it was a bug (the several TODO
> comments).  You knew where to fix it, but want to match previous
> behavior instead of fixing the inconsistency?

I am afraid that we *have* to use topo_order for -r, but you know, I could
be convinced that it is a good idea to switch away from topo order for
regular -i.

> <Snipped a couple things that we already discussed since they were
> brought up in the commit message>
> 
> > Thank you for this pleasant read. I think there is still quite a bit of
> > work to do, but you already did most of it.
> 
> Thanks for the detailed review and the pointers.  Much appreciated.
> We may still have a disconnect of some sort (backwards/bug
> compatibility vs. correctness/consistency), or perhaps I'm just
> misunderstanding something for part of the review.  However, I can
> definitely get to work on the other parts of your review comments, and
> hopefully we can talk through the other bits.

I think it will get easier when other people chime in, so that we do not
go back and forth between our two opinions but instead get a broader
context in which to make decisions, so that we will hopefully end up with
a fine balance between consistency/correctness and
backwards-compatibility.

> > Out of curiosity, do you have a public repository with these patches in a
> > branch? (I might have an hour to play with it tonight...)
> 
> So, yesterday I pointed you at my rebase-new-default branch, but since
> it has other cruft as well, I just pushed this to a new branch with
> just the stuff in this patch series.  I'll keep it up at
> 
> https://github.com/newren/git/tree/rebase-merge-on-sequencer

Thank you!

I had originally planned on seeing how difficult it would be to reinstate
those messages of `rebase -m`, but in the meantime I get the impression
that I may not even want those to survive the merge of the --merge mode
into --interactive.

Ciao,
Dscho
