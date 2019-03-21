Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6969F20248
	for <e@80x24.org>; Thu, 21 Mar 2019 16:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfCUQnv (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 12:43:51 -0400
Received: from mout.gmx.net ([212.227.15.15]:37115 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728628AbfCUQnu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 12:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553186621;
        bh=7L4wrzn33LDe50oNGEyFDN2Njhh0Hl6Bqk0sz5KQ2dY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=g/fkgC/2175CzmxxRyKo9PlY4uCwa3xTXetnYE/3/gFWenoJ01duTj3AWe7/bt05G
         SeYMhnxzB/t76FrFtiuYPs3t6gg7BHxg0CGh/pfTOGYZqAGb4bFNJcPvzW8C1cWA28
         +Y3oGPKsvKaA9xsBqejocOmk7QNE3bnWiUAszPoE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LngRb-1gVics13hn-00hsTI; Thu, 21
 Mar 2019 17:43:41 +0100
Date:   Thu, 21 Mar 2019 17:43:25 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Duy Nguyen <pclouds@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: separating regression test patches from fixes, was Re: [PATCH
 3/3] cherry-pick --continue: remember options
In-Reply-To: <xmqqbm2980wk.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1903211548200.41@tvgsbejvaqbjf.bet>
References: <20190313182615.7351-1-phillip.wood123@gmail.com> <20190313182615.7351-3-phillip.wood123@gmail.com> <nycvar.QRO.7.76.6.1903132344350.41@tvgsbejvaqbjf.bet> <xmqqimwm9hh5.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1903141432000.41@tvgsbejvaqbjf.bet>
 <CACsJy8DCZLNNa9zFj04kPx=f1S_5VJqqP_qTK6QYJ0fFmusymg@mail.gmail.com> <xmqqbm2980wk.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:uKjJ3ZVyR2eRPpVntln7PaTuFtk9bnvJNoajL4jHKxxiVcEQyWT
 2OzPcZPEgd1uDOtWhi9uPzZXNfp43Jy8nVm/5EHXEaVhDZllBtaofhwsHKh4AAEr4o8CQ7G
 rc4KrYgfDC/bY5rccBFmPRhMIJgylnJ84Ldg2cL80WrKgPktNKryxyYlOxWmUJmU8vylv+j
 QAFu9inioTxDvaQ9wHwGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OpKoVISjidE=:8PnXuYeG9tHGf+CPNnLUE1
 zL2F44BYQMkTGhBhU08u7iG8meM53b79y6w2lUPVdlfZ5LTXr1GL7qpYDHSPGrkytL+Bn6/d8
 XsxjtRgrBdt93kToinkMp9e9dQqTbO2AG1G5YsCyKfOHSaxJDm+iLAPoPfkomyPi0kywGdiqu
 rlhvdI/ieGaBiapOgFRE2N0ZKBkZ50oUZK8HwieuIBaKV4Jus6ISndDonK2kU12c3pOHf67+8
 jMXV33saAqLIbfngGn0L9/NUWxW6Tr+ygGJcwYIx3F8n7Au9lbG/yYd1gRPiq2GwOTvj881ID
 1acQwRQd9JOtT1zunFFEqU8LerI2XBPH3HkuHVGxNsNhYh64sBxszUqy2KsvC3TFsQQvECnvQ
 hgqi0vexnkhlvMYxlvUDxEfytT4KTsnTjkZpfgGeLjCRXF+MgKoJFUmMmnplYZgdPmfgfaA9y
 gqmEc1YhT8ZrqVqpWucXa5kTigAch0XbMYrTSGhwfjJ38syTqPg86Jjk2NXMHr1qubF0+20vQ
 g4kF7ln0Rx1blr07a63nD5o3ylm/UxPhGAPzeJkCpf0Ofx6dgzx1eqgY5rdHQPcZBUH6QBmVn
 K22h3sn7I88OgyIkKRfZkV1yh/NMbwVUavfsEtNfWzq8+Mgj2yYnUkD1l8HSLNW7clYAEdjqZ
 u16IT46byzEj6xWXIKpBl8jVJ4Cm7+qvRzUKamNNN15YF/FUUNn6lvKVPCZdr70XrBqCj0e31
 kkX+MzShOMndWUZNjweZwAWWsm7FmJU1Bw9ZEel3sEN96w9Fg7psdV40yNmfhrWl0yevQOkBG
 c++4Z58ju7YJvWrXl5Qx/QnT8oXCXCyPXgKXXkHiDSy1P4USb7vPzVTKEwaVWVlN2CTy+tH0e
 iiYD662WrzGtqtc06cdoU/ICchJKKlKYsxm3f6/9So+/KEpjfRMP9dEFKNNgd9v8u1MjjLPE5
 rSXye3lhlnQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 18 Mar 2019, Junio C Hamano wrote:

> Duy Nguyen <pclouds@gmail.com> writes:
>
> > On Thu, Mar 14, 2019 at 9:10 PM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> >> In any case, before we get better tooling to work around these issues=
, I
> >> still think it makes a ton of sense to encourage proper separation of
> >> concerns: to keep patches that introduce regression tests demonstrati=
ng a
> >> breakage separate from patches that fix the breakage. It would certai=
nly
> >> help me (e.g. when staring at a range diff).
> >
> > Then perhaps improve the tools now because these separate patches
> > enter 'master' and stay in the history forever. One of the problems I
> > have with separating tests from the actual code change is the
> > description of the problem often stays on the test commit, which I
> > can't see in git-log if I'm searching for the code change. And no
> > sometimes I can't just look at the parent commit if I filter code by
> > path (and with --full-diff)
>
> I do not think the phrase "separation of concerns" is applied
> correctly here.

You might currently still think so, so let me give you material to
re-think that stance:

- If you truly care about contributors of all stripes, you also care about
  contributors who report bugs, contributors who turn bug reports into
  reproducible regression test cases, contributors who verify regressions,
  etc.

  And if you really want to give your respect to, say, the contributors
  who provide such regression test cases, you will accept them as full
  commit authors.

  And that fact alone makes it a separate concern, notwithstanding that in
  my case, the contributor who wrote the regression test case and the
  contributor who fixed the regression happened to be the same person: me.
  That fact simply does not invalidate that there are different concerns a=
t
  play.

  You probably even know people who are good at one of those concerns, but
  not at the other.

- If it true what you say, that a bug fix should be in the same commit as
  the regression test case designed to prevent the bug from being
  reintroduced, then both should live in the same file, because it is
  really the same concern.

  But test code lives in a separate area of the source code, is not even
  "shipped with the product", *because* it is a separate concern.

- There is an entire industry built on books and training advertising
  Test Driven Development (TDD). If you really believe what you said, that
  regression tests are really the same concern as fixing the regressions,
  then you claim that all of them are wrong. Which would be a, how can I
  say it, erm, bold statement indeed.

- You did brush aside the example I gave: Hannes Sixt applied a patch
  that demonstrated the breakage, or more correctly: that *should* have
  demonstrated a breakage.

  Let's not brush aside this example. Let's not ignore it just like that.

  This commit addressed a very specific concern: it verified that there is
  a breakage. Or actually, that in this case, there was *no* breakage.

  By not separating those concerns, as you would have me do it, I would
  have made it harder to demonstrate that this bug fix was not even necess=
ary
  in git.git's `master`. I would have made it harder to bisect *where* in
  Git for Windows' patch thicket the regression was introduced.

  You might now say that it should have been easy to separate the concern
  after the fact, to extract it from a commit that adds both fix and
  regression test case.

  But by that token, you should squash all contributions into a single, bi=
g,
  honking commit that do way too much "because it is easy to extract what
  you need". I agree, that sounds ridiculous.

  And even saying that it would be easy to extract the test case from the
  commit already admits that there is a good chunk that you can extract
  *that can live on its own*, i.e. is a separate concern.

- We introduced, specifically, the shell function `test_expect_failure` to
  allow demonstrating breakages. If we really thought that that has no
  value, if there should not be any commit that introduces a regression
  test case without fixing any bug at the same time, if that was not a
  concern, then we should get rid of that function. But experience tells u=
s,
  of course, that we need to keep it.

- There is *semantic* meaning in `test_expect_failure`. Depriving the
  commit history from the commits that introduce such test cases
  demonstrating bugs, and from commits that fix those bugs, makes it
  impossible to perform otherwise simple queries along the lines "how many
  regressions did <insert-name-here> fix in September 2017?".

  I know you are a fan of software archaeology as much as I am (maybe even
  a bit more), so hopefully you find at least this argument convincing.

> The concern of a simple single-patch is to fix a bug---the test that
> shows what bug was fixed and protects the code by ensuring that a
> reintroduction of the bug gets noticed is an integral part of it.

By this reasoning, it should not be possible (or allowed) to write and
contribute a patch that merely demonstrates that something is wrong with
Git, but does not fix it.

That position is untenable.

> It does not make much sense to artificially split it into two.

Let's not brush aside the above-mentioned example, okay?

Let's consider how much easier it was for Hannes (and for that matter, how
much easier it is for *me*) to grab a patch that demonstrates a breakage,
apply it, and the report back whether I can confirm the breakage or not.

It would be *even* easier, of course, if I could just fetch a branch and
cherry-pick, but that is not possible in a project that is centered around
a mailing list. So that's just not an option here.

But back to the point: there is a *lot* of value in having an easy way to
reproduce breakages. Conflating this value with the value of a bug fix
does a disservice to everybody involved.

There was nothing artificial about splitting this patch into two.

Even worse: that commit was never artificially split to begin with! What
you assumed was incorrect: those two commits were always two commits. I
came up with the regression test case first, to convince myself that there
was something that needed fixing (much in the same way as Hannes wanted to
convince himself that there was something that needed fixing, and the fact
that that commit was separate from the fix made it very easy for Hannes to
point out that there was actually nothing in git.git yet that needed
fixing).

And if you are still averse to the idea of separating the concern of
demonstrating a breakage from the concern to fix it, I have really,
really, really bad news for you: a couple of my branches that I intend to
contribute as patch series, once they are finalized, *already* have those
commits that demonstrate breakages, *without* commits to fix them!

I am sorry if that made you shudder ;-)

You even saw at least one of them:
https://public-inbox.org/git/cab7bb36eb85dbe38ad95ee02b083f11f0820e24.1533=
421100.git.gitgitgadget@gmail.com/

But here is a silver lining for you: There is a real advantage of having
this regression test case in a separate patch *for you* (and other
reviewers): That regression test case will most likely not change in
subsequent iterations of the patch series, while the fix will most likely
look *very* different. And by having the regression test case in a
different patch than the regression fix, you will have a very easy time
verifying that it is unchanged from before, that you do not have to
re-review it.

(Although you might have to re-review it if you do not remember that patch
from the beginning of August, last year.)

> It's like arguing for adding declarations for new functions and
> global variables in *.h files in a step before a separate step adds
> their implementations in *.c files, claiming that the first step
> designs the interface (which is sufficient for writing the client
> code) and the second one gives an implementation of the interface
> (which can be replaced later), and they address two separate
> concerns.

No, that is an apples-to-oranges comparison because the declarations
themselves cannot really be used for anything, while the regression test
cases demonstrating a breakage *can* be used for:

- validating the claim that there is a breakage,

- bisecting,

- debugging,

- implementing a fix,

- verifying the claim that a given Git version has this breakage, or
  disproving it.

> And then you would find that there are some compilers that warn
> against unimplemented functions and undefined variables.

Indeed. And I often find myself between a rock and a hard place when I
want to wrap my patch series into nice, reviewable, logically separate
patches, and I cannot, because we specifically discourage file-local
(`static`) functions without users. Although we have not the faintest
problem with *global* functions without users (which makes no sense,
either disallow both file-local *and* global functions without users, or
allow both):

In b0fa1a3f9974 (test-lib-functions.sh: add generate_zero_bytes function,
2019-02-09), a function was introduced that was then consumed in
24b451e77c7d (t5318: replace use of /dev/zero with generate_zero_bytes,
2019-02-09).

In f1f5de442faf (revision: add mark_tree_uninteresting_sparse,
2019-01-16), we introduced a function that was consumed in the following
commit 4f6d26b16703 (list-objects: consume sparse tree walk, 2019-01-16).

In 47edb649973c (hex: introduce functions to print arbitrary hashes,
2018-11-14), the hash_to_hex*() functions were added, to be used only in
subsequent commits.

And the list goes on.

So in this instance, your argument is that we have to please the compiler,
even if it does not make any logical sense for humans.

After all, a patch series has a temporal order. It has a "story arc", so
to say, or in musical terms, it is a "slur". The compiler does not know
that a function will be used, or a regression test will be marked as
fixed, in a future patch. The human reviewer would. But we actively make
it harder on the human reviewer, by combining, say, the (rather large)
implementation of a linear assignment problem solver into the same commit
as its only user (also large), just to please the compiler.

Or at least we would have made it harder on the human reviewer if we had
not used a *trick* to *fool* the compiler into not complaining: the
implementation was put into the separate file file linear-assignment.c,
*even* if it has *but a single user*!

And since you actually committed this in that form, you already proved
that you agree with me. You also did not find it better to smoosh separate
concerns into the same commit. You had no objection to apply a patch that
had no value whatsoever on its own, that only realizes its value together
with a subsequent commit actually introducing a caller to that
functionality. Which is actually worse than a commit doing nothing else
than introducing a single regression test case that demonstrates a bug,
which does have value on its own.

> The "solution" would be to enclose the whole thing that was added in the
> first "*.h only patch" inside "#if 0/#endif" to hide it from the
> compiler ;-)

Yes, if we really wanted to cater to the compiler, rather than human
readers, then we would indeed do that.

Plus, let's not forget about the fact that this is an apples to oranges
comparison. More on that below.

> That in fact looks quite similar to how "test only patch" marks the new
> tests as expecting failure in the beginning. Neither is truly useful
> when applied to a context different from where it is originally
> developed for.

If you really want to hear what the equivalent to your `.h only commit`
would be, here you go. It would look something like:

=2D- snip --
diff --git t/...
@@ ... @@
 '

+test_expect_failure 'demonstrate a horrible bug' '
+	false # will be implemented later
+'
+
 test_done
=2D- snap --

*That* is the equivalent to your example of introducing just the function
signatures, leaving the actual implementation to a later commit.

You will note that this looks very different from what I am advertising,
where the actual implementation that does demonstrate a horrible bug (and
will hopefully gain a second life after the bug is fixed by keeping the
bug fixed) is added at the same time as the `test_expect_failure`.

And if you really, really, really needed another argument in favor of
accepting regression test-only patches as standalone commits: take the
unfortunate example of
https://public-inbox.org/git/CA+h-Bnuf6u=3DhkPBcxhMm06FbfkS+jtrozu+inqqmUY=
1cNkXrWQ@mail.gmail.com/

It might not have mattered in this case had you stopped discouraging
contributions of patches that merely add test cases demonstrating
breakages. But it could not have helped, for sure.

If we keep discouraging such patches (and note that I specifically
*encouraged* such a patch instead [*1*]), if we keep insisting that a
regression test case on its own is of no value, we will get even less of
those contributions.

And we will be repeating the same type of story again, where a bug was
reported, no patch was contributed (let alone applied) to demonstrate the
bug, the bug will be fixed, only to be broken *just in time* for the next
official Git version.

That is not what I want.

And that is why I keep considering it a bad practice to discourage
separating commits adding regression tests from the corresponding commits
that fix the regressions.

As I said, it might not have mattered in this instance. Or in the next
one. Or even in many cases.

But encouraging that separation of concerns, acknowledging that there is a
real, measurable value not only in knowing about a bug, but in addition
having an automated way to reproduce the bug (and to verify a bug fix),
*this* will get us more of those contributions rather than less.

Phew. What a long mail. I am glad you made it this far.

Let me end by saying that laying out all of the above, I do not intend to
annoy you or anything. I simply care about this project, and I want it to
run as smoothly as possible. And I really think that the separation of
concerns that we are talking about is one of the ways to make it run
smoother. To make it easier on contributors. To make it easier on
reviewers. To make it easier on developers validating bugs.

Ciao,
Dscho

Footnote *1*:
https://public-inbox.org/git/nycvar.QRO.7.76.6.1901091501320.41@tvgsbejvaq=
bjf.bet/
