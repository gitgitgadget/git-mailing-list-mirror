Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C85F1F463
	for <e@80x24.org>; Thu, 26 Sep 2019 12:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfIZMpi (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 08:45:38 -0400
Received: from mout.gmx.net ([212.227.17.21]:56367 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfIZMpi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 08:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569501924;
        bh=y9lIufXE0uGDSUbIxlBPYDWbiK6GBMONkMHM6nGuq/I=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gLmyi0q+jbcoiRGJMhdQxyimu7emIK10pZ2ifRrke+xyOJwiuy1objdW1g/7k2fvs
         Da1S9NfWiyrQqlcU+Y+PUUyQsPc1SIoh33VWlyUTgJrG6UMlpi4yI+Y/ApWtGH5F3E
         PxzapsUcBzeM81C/5cDPkCORQrzU+6dTWK+yIP5k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvK0X-1hw4ov1Flh-00rI7c; Thu, 26
 Sep 2019 14:45:24 +0200
Date:   Thu, 26 Sep 2019 14:45:09 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Wong <e@80x24.org>
cc:     Emily Shaffer <emilyshaffer@google.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Git in Outreachy December 2019?
In-Reply-To: <20190924005529.GA8354@dcvr>
Message-ID: <nycvar.QRO.7.76.6.1909261343590.15067@tvgsbejvaqbjf.bet>
References: <20190827051756.GA12795@sigill.intra.peff.net> <20190913200317.68440-1-jonathantanmy@google.com> <20190913205148.GA8799@sigill.intra.peff.net> <20190916184208.GB17913@google.com> <nycvar.QRO.7.76.6.1909171158090.15067@tvgsbejvaqbjf.bet>
 <20190924005529.GA8354@dcvr>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:iWv6Q9nPGpBhDl+X4Uh0EuROOtDu/++yj52ZLPx+db4oRaauTzM
 UTv73LieGkgtgOlvHo/sGwDwtuEXS6etFrkZWYKBmUnp8Kox+l6W0ynGMyziT4IEywm1uMh
 PO3Y756Vc8qyj7g6sUqyC1EuBF5FPuKsvynBeXTOUNZg0c2lN+TkcledpKiwY3ojiwIr1C2
 /ovWSdF3UZziUdIleR3IA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kRKCV/CfNrc=:/iXz1GXvRkma6fx2ZB7fy3
 GPKzI48zqFS77NXQ3viZXmkj+ekyj1IRcWWQYEuDYChzsNnWEOhJp2i91F/+YyMEscDKghcl8
 GoDBem7RZ3yj/WJkHRLJc/Hbr5aWaegcoNyqOSCLzWbO1GaDi4SIylvdUvc+i9tXgzwNBVBPZ
 sJY0+gcNqPjdzUuCQtVdi5+HTkwWja9WufH0HsK9+aRjiWmQEmBZRQHlqBvxYjjU/FS80OXy9
 lVDFdV4yLCeLZZ0zWuDECRpNsWS+2K63p6VPuDEiXUQEMlOnYD+V3FiYun6gaJfigqe77vrV3
 ek4VtcN0laSSngVLjCU/nBp2roAtYIK+BY0PARxpWP5OVYx0Yy6JX0afsiCoV2j4cb8uXXe6M
 +AXtCFQoLcVkOBdfXfJM0u7taMUwE+0qOszH9ejijrEGbLDb/RDprmLF7GZjj4V+62blnBIaj
 LHaXwNRO5xBgDQ+PrgdMYGV5XX6tV/DisgW5vKw83//NjYQKN1tdGwbcmPt1RHCrC5mdd13wu
 vdzF/TbKKeDNCiYcpPVl9OtbCJn0KX+15DIO1GA6/TtiY7N4tvvWLn6LGGodg/BB1cR+9ODlT
 Hz3CnJ1Ra3+2qgiBQbVSZupNSF24sO6jkjPwTeYafNaNhJhP3XZL22TOWSJgvelj1tGUVuwJm
 +APLMA1GUpTFV+3XVHoIYXQxL7IQMJOPOtCz2tc7MuPja5XWQtPkMQj4gKZ7y0LVKCLExAqL5
 uCZPqNySBLEH6A6KFZwe9Gs6Hv0n5bg1HQsJJhnztMoIYXyefo1dSQevGYnN80PifOpsyXF2W
 0QEAmG79s+Z0jKYydfYVqGSo/xB77ouwUutkevumpqzCiFjaHHPnbpTz+tfW2MSTOlbPlezYW
 vqniTJErLT7QQyxEB4vfJI8CTPoJCAkhHWSZtsp67n+R2xxt325xgmD3NIDFadsTjIdDTbkJB
 ibjJaYzOWm2lbZX34Lq5qr8upKriWbm5oD7BwHaFhJdP0UWuhp+g+E7fXFwZcYI5gQy+lFClE
 VEOzbYZLBhorCgVM08eGawqbFmazEAFlntEgYV3bC1M6pjEr66FwJwd66I8aBTh8uAFH/V9sJ
 rXTnLt0Vovmgd69R8Ik1kNORdkvHCeklXtrEfrdI9Qys2tlPRNvXI/AI6B0AfM+iwQ3HezNSN
 Ezeg50SNhFV1bORbllx5aG4m31GK3OFpVVLDyN/ykfOq/0eCxAlKcCCxtg0UJOzqpQq9dKh/Q
 ybfsJbQEFlPsWVyI0UzD4wiM7zRMIp6nIuP+41gC8GghfZQEH8tCujWyAMeA=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Tue, 24 Sep 2019, Eric Wong wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Mon, 16 Sep 2019, Emily Shaffer wrote:
> > >  - try and make progress towards running many tests from a single te=
st
> > >    file in parallel - maybe this is too big, I'm not sure if we know=
 how
> > >    many of our tests are order-dependent within a file for now...
> >
> > Another, potentially more rewarding, project would be to modernize our
> > test suite framework, so that it is not based on Unix shell scripting,
> > but on C instead.
>
> I worry more C would reduce the amount of contributors (some of
> the C rewrites already scared me off hacking years ago).  I
> figure more users are familiar with sh than C.

Seeing as most of the patches/patch series require contributors not only
to write test cases in Unix shell script, but also to patch or implement
code in C, I fail to be concerned about that.

> It would also increase the disparity between tests and use of
> actual users from the command-line.

I find it really endearing whenever I hear anybody talking about Git
users as if every single one of them crafted extensive shell scripts
around Git. In my experience, most of the people who do that gather on
this here mailing list, or on a nearby one, and that is but a tiny
fraction of Git users.

Besides, it was my understanding that Git's test suite tries to prevent
regressions in Git's code, whether it is called in scripts or not. As
such, it would not matter _how_ that functionality is tested. Does that
not match your understanding?

> > The fact that it is based on Unix shell scripting not only costs a lot
> > of speed, especially on Windows, it also limits us quite a bit, and I =
am
> > talking about a lot more than just the awkwardness of having to think
> > about options of BSD vs GNU variants of common command-line tools.
>
> I agree that it costs a lot of time, and I'm even on Linux using
> dash as /bin/sh + eatmydata (but ancient laptop)

One thing that I meant to play with (but which is hampered by too many
parts of Git being implemented in Unix shell/Perl, still, therefore
making code coverage analysis hard) is Test Impact Analysis
(https://docs.microsoft.com/en-us/azure/devops/pipelines/test/test-impact-=
analysis).
In short, a way to avoid running tests the code touched by them was
already tested before. Example: if I change the `README.md`, no
regression test needs to be run at all. If I change `git-p4.py`, the
majority of test scripts can be skipped, only t98*.sh need to be run
(and maybe not even all of them).

There is a lot of work to be done on the built-in'ification, still,
before that becomes feasible, of course.

> > For example, many, many, if not all, test cases, spend the majority of
> > their code on setting up specific scenarios. I don't know about you,
> > but personally I have to dive into many of them when things fail (and =
I
> > _dread_ the numbers 0021, 0025 and 3070, let me tell you) and I really
> > have to say that most of that code is hard to follow and does not make
> > it easy to form a mental model of what the code tries to accomplish.
> >
> > To address this, a while ago Thomas Rast started to use `fast-export`e=
d
> > commit histories in test scripts (see e.g. `t/t3206/history.export`). =
I
> > still find that this fails to make it easier for occasional readers to
> > understand the ideas underlying the test cases.
> >
> > Another approach is to document heavily the ideas first, then use code
> > to implement them. For example, t3430 starts with this:
> >
> > 	[...]
> >
> > 	Initial setup:
> >
> > 	    -- B --                   (first)
> > 	   /       \
> > 	 A - C - D - E - H            (master)
> > 	   \    \       /
> > 	    \    F - G                (second)
> > 	     \
> > 	      Conflicting-G
> >
> > 	[...]
> >
> > 	test_commit A &&
> > 	git checkout -b first &&
> > 	test_commit B &&
> > 	git checkout master &&
> > 	test_commit C &&
> > 	test_commit D &&
> > 	git merge --no-commit B &&
> > 	test_tick &&
> > 	git commit -m E &&
> > 	git tag -m E E &&
> > 	git checkout -b second C &&
> > 	test_commit F &&
> > 	test_commit G &&
> > 	git checkout master &&
> > 	git merge --no-commit G &&
> > 	test_tick &&
> > 	git commit -m H &&
> > 	git tag -m H H &&
> > 	git checkout A &&
> > 	test_commit conflicting-G G.t
> >
> > 	[...]
> >
> > While this is _somewhat_ better than having only the code, I am still
> > unhappy about it: this wall of `test_commit` lines interspersed with
> > other commands is very hard to follow.
>
> Agreed.  More on the readability part below...
>
> As far as speeding that up, I think moving some parts
> of test setup to Makefiles + fast-import/fast-export would give
> us a nice balance of speed + maintainability:
>
> 1. initial setup is done using normal commands (or graph drawing tool)
> 2. the result of setup is "built" with fast-export
> 3. test uses fast-import

I actually talked about this in my mail. If you find it easy to deduce
the intent behind a commit history that was exported via fast-export,
more power to you. (Was the committer name crucial? The file name? Or
the temporal order of the commits?)

In contrast, I find it very challenging, myself. And please keep in mind
that the first thing any contributor needs to do who sees a failing
regression test (where the failure is most likely caused by the patch
they plan on contributing): understand what the heck the regression test
case is trying to ensure. The harder the code makes that, the worse it
does its primary job: to (help) prevent regressions.

So no, I am not at all on board with moving to fast-imported commit
histories in Git's test suite. They provide some convenience to the
authors of those regression tests, which is not the audience you need to
cater for in this case: instead, regression tests should make it not
only easy to catch, but _especially_ easy to fix, regressions. And that
audience would pay dearly for that erstwhile convenience.

> Makefile rules would prevent subsequent test runs from repeating
> 1. and 2.

That is a cute idea, until you realize that the number of developers
fluent in `make` is even smaller than the number of developers fluent in
`C`. In other words, you would again _increase_ the the number of
prerequisites instead of reducing it.

> > If we were to (slowly) convert our test suite framework to C, we could
> > change that.
> >
> > One idea would be to allow recreating commit history from something th=
at
> > looks like the output of `git log`, or even `git log --graph --oneline=
`,
> > much like `git mktree` (which really should have been a test helper
> > instead of a Git command, but I digress) takes something that looks li=
ke
> > the output of `git ls-tree` and creates a tree object from it.
>
> I've been playing with Graph::Easy (Perl5 module) in other
> projects, and I also think the setup could be more easily
> expressed with a declarative language (e.g. GNU make)

I am dubious. But hey, if you show me something that looks _dead_ easy
to understand, and even easier to write for new contributors, who am I
to object?

But mind, I am not fluent in Perl. I can probably hack my way through
`git-svn`, but that's a far cry from knowing what I am doing there.

And wouldn't that _again_ increase the number of prerequisites on
contributors? I mean, you sounded genuinely concerned about that at the
beginning of the mail. And I share that concern.

> > Another thing that would be much easier if we moved more and more part=
s
> > of the test suite framework to C: we could implement more powerful
> > assertions, a lot more easily. For example, the trace output of a fail=
ed
> > `test_i18ngrep` (or `mingw_test_cmp`!!!) could be made a lot more
> > focused on what is going wrong than on cluttering the terminal window
> > with almost useless lines which are tedious to sift through.
>
> I fail to see how language choice here matters.

In Unix shell script, we either trace (everything) or we don't. In C,
you can be a lot more fine-grained with log messages. A *lot*.

We even already have such a fine-grained log machinery in place, see
`trace.h`.

Also, because of the ability to perform more sophisticated locking, lazy
prerequisites can easily be cached in C, whereas that is not so easy in
Unix shell (and hence it is not done).

> > Likewise, having a framework in C would make it a lot easier to improv=
e
> > debugging, e.g. by making test scripts "resumable" (guarded by an
> > option, it could store a complete state, including a copy of the trash
> > directory, before executing commands, which would allow "going back in
> > time" and calling a failing command with a debugger, or with valgrind,=
 or
> > just seeing whether the command would still fail, i.e. whether the tes=
t
> > case is flaky).
>
> Resumability sounds like a perfect job for GNU make.

Umm.

So let me give you an example of something I had to debug recently. A
`git stash apply` marked files outside the sparse checkout as deleted,
when they actually had staged changes during the `git stash` call.

If this had been a regression test case, it would have looked like this:

test_expect_success 'stash handles skip-worktree entries nicely' '
        test_commit A &&
	echo changed >A.t &&
	git add A.t &&
	git update-index --skip-worktree A.t &&
	rm A.t &&
	git stash &&

	: this should not mark A.t as deleted &&
	git stash apply &&
	test -n "$(git ls-files A.t)"
'

Now, the problem would have occurred in the very last command: `A.t`
would have been missing from the index.

In order to debug this, you would have had to put in "breakpoints"
(inserting `false &&` at strategic places), or prefix commands with
`debug` to start them in GDB, then re-run the test case.

Lather, rinse and repeat, until you figured out that `git stash` was
failing to record `A.t` properly.

Then dig into that, recreating the same worktree situation every time
you run `git stash`, until you find out that there is a call to `git
update-index -z --add --remove --stdin` that removes that file.

Further investigation would show you that this command pretty much does
what it is told to, because it is fed `A.t` in its `stdin`.

The next step would probably be to go back even one more step and see
that `diff_index()` reported this file as modified between the index and
`HEAD`.

Slowly, you would form an understanding of what is going wrong, and you
would have to go back and forth between blaming `diff_index()` and
`update-index`, or the options `git stash` passes to them.

You would have to recreate the worktree many, many times, in order to
dig in deep, and of course you would need to understand the intention
not only of the regression test, but also of the code it calls.

In this instance, it is merely tedious, but possible. I know, because I
did it. For flaky tests, not so much.

*That* is the scenario I tried to get at.

Writing the test cases in `make` would not help that. Not one bit. It
would actually make things a lot worse.

> (that said, I don't know if you use make or something else to build
> gfw)

We are talking about the test suite, yes?

Not about building Git? Because it does not matter whether we use `make`
or not (we do by default, although we also have an option to build in
Visual Studio and/or via MSBuild).

On Windows, just like on Linux, we use a Unix shell interpreter (Bash).
Sure, to run the entire test suite, we use `make` (sometimes in
conjunction with `prove`), but the tests themselves are written in Unix
shell script, so I have a hard time imagining a different method to run
them -- whether on Windows or not -- than to use a Unix shell
interpreter such as Bash.

> > In many ways, our current test suite seems to test Git's
> > functionality as much as (core) contributors' abilities to implement
> > test cases in Unix shell script, _correctly_, and maybe also
> > contributors' patience.  You could say that it tests for the wrong
> > thing at least half of the time, by design.
>
> Basic (not advanced) sh is already a prerequisite for using git.

Well, if you are happy with that prerequisite to be set in stone, I am
not. Why should any Git user *need* to know sh?

> Writing correct code and tests in ANY language is still a
> challenge for me; but I'm least convinced a low-level language
> such as C is the right language for writing integration tests in.

I would be delighted to go for a proper, well-maintained test framework
such as Jest. But of course, that would not be accepted in this project.
So I won't even think about it.

> C is fine for unit tests, and maybe we can use more unit tests and
> less integration tests.

We don't have integration tests.

Unless your concept of what constitutes an "integration test" is very
different from mine. For me, an integration test would set up an
environment that involves multiple points of failure, e.g. setting up an
SSH server on Linux and accessing that via Git from Ubuntu. Or setting
up a web server with a self-signed certificate, import the public key
into the Windows Certificate Store and then accessing the server both
using OpenSSL and Secure Channel (the native Windows way to communicate
via TLS).

There is nothing even close to that in Git's test suite.

> > It might look like a somewhat less important project, but given that w=
e
> > exercise almost 150,000 test cases with every CI build, I think it doe=
s
> > make sense to grind our axe for a while, so to say.
>
> Something that would benefit both users and regular contributors
> is the use and adoption of more batch and eval-friendly interfaces.
> e.g. fast-import/export, cat-file --batch, for-each-ref --perl...

Given how hard it is to deduce the intention behind such invocations, I
am rather doubtful that this would improve our test suite.

> I haven't used hg since 2005, but I know "hg server" exists
> nowadays to get rid of a lot of startup overhead in Mercurial,
> and maybe git could steal that idea, too...

I have no idea what `hg server` does. Care to enlighten me?

> > Therefore, it might be a really good project to modernize our test
> > suite. To take ideas from modern test frameworks such as Jest and try =
to
> > bring them to C. Which means that new contributors would probably be
> > better suited to work on this project than Git old-timers!
> >
> > And the really neat thing about this project is that it could be done
> > incrementally.
>
> I hope to find time to hack some more batch/eval-friendly stuff
> that can make scripting git more performant; but no idea on my
> availability :<

Knock yourself out, if you enjoy that type of project. And who knows,
maybe you will convince me yet that it benefits the tests...

Ciao,
Dscho
