Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E1AE1FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 13:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752253AbcIBN4i (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 09:56:38 -0400
Received: from mout.gmx.net ([212.227.15.19]:53395 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751752AbcIBN4h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 09:56:37 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MD9q8-1brya12DTI-00GaP6; Fri, 02 Sep 2016 15:56:29
 +0200
Date:   Fri, 2 Sep 2016 15:56:27 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 00/22] Prepare the sequencer for the upcoming rebase -i
 patches
In-Reply-To: <ced4a190-6a79-e608-ca0b-3815267c5f93@gmail.com>
Message-ID: <alpine.DEB.2.20.1609021432070.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <ced4a190-6a79-e608-ca0b-3815267c5f93@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1783168149-1472824589=:129229"
X-Provags-ID: V03:K0:47HpLxVRHtfw+SStE9QJzZKovVWWyBQXcQy7sp1UDixDq0OwEte
 IKy1Kco2uZ+7bWrQdhsONeLw0HUZ4/MCsjbhhYPV2cDxXJEbyJfupK5qOQLiO56MzPhlWyJ
 a6G6DGNIWQ5bISZptQjTiSTKxE48R3eVWbWwyn7xgGSP3RFoqUM0DI4W13XEaR/QdWcOrDh
 OYraYQJGQQBQ1/zGOm7GA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sYnEFvjiIyA=:luIHxGQq07lX1EwbnfwmsH
 plynNH2vl7BqR2uhR4EkjDwFvR3aOp0ddlQmyckPCsRux+m3Z0su9xH3YN7ioaJVez/T9KM1F
 8BCvoOEZ09Mn2RwgIkynxZlH/MfHtMxuXVwN1hy2kKxN7SpyNEc4Z9fowp2nYIA3Dyb5PLz7w
 EezFaBbds+qM7FVccfFP/CTcQGrpa+4d5U68mu9SdB2z7wrYGQpis5OF0iq4q/A7QVXJt6kEB
 HVCHagkmktX5Sx8NUDFLohqyT+rs0B3mZPUfvQ/icabtv+I5EnPmIA5yL2dG36Y9oaMuUUogb
 8VJ/CK4PEdGgJ6rn1VnCaxz8kG370y2TiuSLOsLnR0rlyxUlzBFi3pdRcqmQFplcmpFGyFPLl
 OPIq34PHwkpIMlNklUB4l4sWZG3Jcc6asMcXByBzWQZTmjsfL721kw13kQjmnx8egRLa+d1SW
 JVvtlNVighdlWcHWWQHfFgRzHaImFRCvmsi717xFvuTSpk3IBl0lXJxlelREfERQ4zhFFbcQN
 Jr5POzKp5mwbz6Z3kM/u7oseyPAuSfngNcprKrrTotLXx/sELIkfaiTuqNFo7+m1Wf7JHVB1v
 1zuaVe0AqJM64m5jNqd4qSpSrLbBoRo0KYtK0a6EzRK9Chnc6B2uadlTET0QGly3zCj6wa5Lo
 aRvT6DSZ9YgCLstV7N/F0e4o5+cPxofCI2jhqjDHeeZGHTDXt/G+J21gAuYQ69gwoDdKRwMn/
 19oIAohM5Irvdq8xUNgjwzzKMZ5sb/TXnyzuhAaUXxt0f4msvcfId/Jv/IbWw129ljxz2H7Zu
 gZI6zj8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1783168149-1472824589=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Fri, 2 Sep 2016, Jakub Nar=C4=99bski wrote:

> W dniu 29.08.2016 o 10:03, Johannes Schindelin pisze:
>=20
> > This patch series marks the  '4' in the countdown to speed up rebase -i
> > by implementing large parts in C. It is based on the `libify-sequencer`
> > patch series that I submitted last week.
>=20
> Which of those got reviewed (and perhaps accepted), and which of those
> needs review still?  What is subject of their cover letter?

Most of the patch series I sent before last week got accepted. Only one
got rejected, IIRC, and replaced by a better solution (3727318 (Merge
branch 'jk/test-send-sh-x-trace-elsewhere', 2016-05-17)).

The patch series I submitted as part of my rebase--helper work that were
accepted:

b232439 (Merge branch 'js/t3404-typofix', 2016-05-17)
7b02771 (Merge branch 'js/perf-rebase-i', 2016-05-23)
3437017 (Merge branch 'js/perf-on-apple', 2016-07-06)
62e5e83 (Merge branch 'js/find-commit-subject-ignore-leading-blanks', 2016-=
07-11)
c510926 (Merge branch 'js/sign-empty-commit-fix', 2016-07-13)
6c35952 (Merge branch 'js/t3404-grammo-fix', 2016-07-13)
63641fb (Merge branch 'js/log-to-diffopt-file', 2016-07-19)
3d55eea (Merge branch 'js/am-call-theirs-theirs-in-fallback-3way', 2016-07-=
19)
c97268c (Merge branch 'js/rebase-i-tests', 2016-07-28)
1a5f1a3 (Merge branch 'js/am-3-merge-recursive-direct', 2016-08-10)

You will note that I broke out a couple of patch series that do not
strictly have anything to do with the rebase--helper, such as
perf-on-apple. Nevertheless, they were part of a 99-strong patch series
that was my initial working rebase--helper, which I have used ever since
to perform all of my interactive rebases.

There are still a couple of patch series in flight. Let me list them by
the tags created by my mail-patch-series.sh script:

https://github.com/dscho/git/releases/tag/libify-sequencer-v2
https://github.com/dscho/git/releases/tag/require-clean-work-tree-v1
https://github.com/dscho/git/releases/tag/prepare-sequencer-v1
https://github.com/dscho/git/releases/tag/sequencer-i-v1
https://github.com/dscho/git/releases/tag/rebase--helper-v1

These tags all contain links to the cover letter as stored on
public-inbox.org, identified by the Message-ID.

Please note that the first four of this batch of five already saw
substantial work-after-review, thanks in part to your helpful comments.
You may appreciate the fact that a link of the form

https://github.com/dscho/git/compare/libify-sequencer-v2...libify-sequencer

shows you where I am at, although it cannot give you a real interdiff
because I rebased to a newer version of upstream/master in the meantime.

Finally, there is one last patch series that I did not yet submit: the
'rebase-i-extra' patch series. However, as I continuously update the
overall 'interactive-rebase' branch thicket (and have done so since the
very beginning of my work on the rebase--helper), it is relatively easy to
see what is left:

https://github.com/dscho/git/compare/rebase--helper...interactive-rebase

BTW thanks for making me dig out all of this information (it did take a
while to uncover it...), as I am so totally going to use that in a blog
post.

> > The reason to split these two patch series is simple: to keep them at a
> > sensible size.
>=20
> That's good.

Thanks. I really try to be sensible with other people's time.

Even more so after being so offended by the talk at the most recent Git
Merge that stated that some people deliberately waste contributors' time
because they value their own time so much more. I am *really* offended by
that.

As a maintainer of Git for Windows, I do everything in my power to strike
a sensible balance between how much time I spend on improving the software
and how much time I ask others to do so.

> > The two patch series after that are much smaller: a two-patch "series"
> > that switches rebase -i to use the sequencer (except with --root or
> > --preserve-merges), and a couple of patches to move several pretty
> > expensive script processing steps to C (think: autosquash).
>=20
> I can understand --preserve-merges, but what is the problem with --root?

The problem with --root is that it *creates* an initial commit. It is
empty, and will be amended. It would most likely not be a lot of work, but
I really wanted this work to be incremental, focusing on the most
important aspects first.

In fact, I do hope that somebody with the need for --root will take the
baton and run with it.

> > The end game of this patch series is a git-rebase--helper that makes
> > rebase -i 5x faster on Windows (according to t/perf/p3404). Travis
> > says that even MacOSX and Linux benefit (4x and 3x, respectively).
>=20
> So do I understand correctly that end goal for *this* series is to move
> most of processing to git-rebase--helper, but full builtin-ification
> (and retiring git-rebase.sh to contrib/examples/) would have to wait for
> later?

Oh yes!

Retiring git-rebase.sh is *far, far, far* in the future. We really missed
the boat a *looooong* time ago to turn this from a hacky shell script into
a proper C builtin.

There is so much more to do before git-rebase.sh can be retired.

For starters, git-rebase.sh is actually just a glorified command-line
option parser and front-end to git-rebase--am.sh,
git-rebase--interactive.sh and git-rebase--merge.sh.

To retire it, those three shell scripts need to be *completely* built-in
first.

(Actually, for the --preserve-merges case, I could imagine that we simply
refactor it into its own shell script and call that from a builtin
git-rebase, until we retire --preserve-merges, but that's a couple of
years down the road.)

So the first goal would be to retire git-rebase--interactive.sh. For that
to happen, --root needs to be supported first. Then the --preserve-merges
stuff needs to be refactored into its own shell script. And then the
command-line option parsing needs to be moved to rebase--helper, too. And
*then* git-rebase--interactive.sh can be retired.

As I stated earlier, my hope is that the rebase--helper work is only an
initial step, opening the door for other contributors to tackle
independent parts of making git-rebase a builtin.

> [...]
>=20
> I'd like here to summarize the discussion (my review, Dennis review,
> Johannes Sixt and Junio comments).
>=20
> If there are no comments, it means no problems or minor changes.

Please keep in mind that my current state (local, and pushed to my GitHub
repository) has advanced substantially. I am reluctant to send it out yet
because I still need to send out rebase-i-extra first, so that it gets
*some* visibility before v2.10.0.

> > Johannes Schindelin (22):
> >   sequencer: use static initializers for replay_opts
> There is no need for putting zeros in static initializer.  Commit
> message expanded.
>=20
> >   sequencer: use memoized sequencer directory path
> >   sequencer: avoid unnecessary indirection
> >   sequencer: future-proof remove_sequencer_state()
> Leftover unrelated chunk removed.
>=20
> >   sequencer: allow the sequencer to take custody of malloc()ed data
> Is introducing new *_entrust() mechanism (which needs docs, at least
> as comments) worth it, instead of just strdup everything and free?
> If it is: naming of function parameter + example in commit message.
>=20
> >   sequencer: release memory that was allocated when reading options
> See above.
>=20
> >   sequencer: future-proof read_populate_todo()
> Possibly mention which functions were not future-proofed because
> of planned for the subsequent patch full rewrite.

Note that this commit is about read_populate_todo(), not about
save_todo(). So I do not think that we should mention anything in this
commit's message about other functions that may be rewritten instead of
being future-proofed..

> >   sequencer: remove overzealous assumption
> Overzealous assumptions, or a worthy check?  Perhaps just remove check
> for rebase -i in future commit, and keep test.  Perhaps remove test
> temporarily.

As mentioned earlier, I bit the bullet and reimplemented that logic.
Mostly to fend off more comments in this direction.

> >   sequencer: completely revamp the "todo" script parsing
> This removes check; it should return if it was worthy.  Some discussion
> about eager versus lazy parsing of commits, but IMHO it should be left
> for later, if considered worth it.

Again, it was reintroduced. The test to check for the overzealous
assumption was not removed, and it passes, to prove that I did it right.

> >   sequencer: avoid completely different messages for different actions
> Fix l10n or drop (and not introduce lego translation).
>=20
> >   sequencer: get rid of the subcommand field
> >   sequencer: refactor the code to obtain a short commit name
> Explain reason behind this change in the commit mesage.
>=20
> >   sequencer: remember the onelines when parsing the todo file
> Lazy or eager again; "exec", "noop" and --preserve-merges.
>=20
> >   sequencer: prepare for rebase -i's commit functionality
> Add helper function, possibly extract helper function.  Rephrase block
> comment.
>=20
> "[PATCH] am: refactor read_author_script()" from Junio.
>=20
> >   sequencer: introduce a helper to read files written by scripts
> Perhaps add why not use open + strbuf_getline to commit message...
>=20
> >   sequencer: prepare for rebase -i's GPG settings
> Possibly fixes bug.  Use *_entrust() or strdup to not leak memory
> (and to not crash when freeing memory).
>=20
> >   sequencer: allow editing the commit message on a case-by-case basis
> Enhance the commit message.
>=20
> >   sequencer: support amending commits
> >   sequencer: support cleaning up commit messages
> >   sequencer: remember do_recursive_merge()'s return value
> >   sequencer: left-trim the lines read from the script
> >   sequencer: refactor write_message()
> Enhance the commit message.  Quote path in messages while at it.

Apart from the l10n issues, I think I addressed them all locally, and
pushed the result out to my GitHub repository, although I plan to send out
additional iterations only after releasing Git for Windows v2.10.0.

> > Based-On: libify-sequencer at https://github.com/dscho/git
> > Fetch-Base-Via: git fetch https://github.com/dscho/git libify-sequencer
> > Published-As: https://github.com/dscho/git/releases/tag/prepare-sequenc=
er-v1
> > Fetch-It-Via: git fetch https://github.com/dscho/git prepare-sequencer-=
v1
>=20
> An unrelated question: Dscho, how are you generating above lines?

It's the `mail-patch-series.sh` script, in conjunction with setting the
config variable mail.publishremoteto to point to my GitHub remote. You can
find the `mail-patch-series.sh` script here:

=09https://github.com/dscho/mail-patch-series

I probably forgot to adjust the README to reflect the most recent changes
(such as the `--basedon` feature)... PRs welcome [*1*].

Ciao,
Dscho

Footnote *1*:
https://raw.githubusercontent.com/dscho/images/master/i-can-haz-pull-reques=
t.png
--8323329-1783168149-1472824589=:129229--
