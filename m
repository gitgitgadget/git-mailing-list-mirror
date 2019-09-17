Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 801A91F463
	for <e@80x24.org>; Tue, 17 Sep 2019 11:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfIQLXq (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 07:23:46 -0400
Received: from mout.gmx.net ([212.227.17.20]:59097 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbfIQLXq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 07:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568719415;
        bh=QZRD4dffgSAOhFJaCi973gPek6fN/NdmOVwnvqa3oXQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CEwQ8xCmxo2pCsT9M/eH43ZRFGchmwIG5yhMCnQFBiMGOvjUE4RSGIk0SLjD5oUxc
         OELyR0UURjmdv8CtdkRyRzwEX96w2AFyDq+A+vK0OEG4bDRzZDXJNma7x9L6WthXtc
         tghE5j3D3lqk4mkZUpLEx63+xxYujo4zraaFzfA0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MPZuP-1iEsXW2VyT-004lYF; Tue, 17
 Sep 2019 13:23:35 +0200
Date:   Tue, 17 Sep 2019 13:23:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>,
        git@vger.kernel.org
Subject: Re: Git in Outreachy December 2019?
In-Reply-To: <20190916184208.GB17913@google.com>
Message-ID: <nycvar.QRO.7.76.6.1909171158090.15067@tvgsbejvaqbjf.bet>
References: <20190827051756.GA12795@sigill.intra.peff.net> <20190913200317.68440-1-jonathantanmy@google.com> <20190913205148.GA8799@sigill.intra.peff.net> <20190916184208.GB17913@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6j9JShOA0wxSJujbp9J5aTHgkGSv7+aVw5DA+2lzSv3iMonQ6Y1
 FouF1rdWXNfRzQiAkHhjaOpvk4ZLD31JaBciZecDBceIOu9dtHxU1sJOi0IqmYPHBQs/Abk
 VxQxvjvr6GTtKNyTxddT7xZzq1ueu34WZq7crxiPihDhwORTwif+69Em+2b0UtY0OW4rTBT
 nUiLOEnITSEthdm4Hv9JQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zGDKjWN3XdI=:DQ0KNmw5hcV3+bg4c/vyrK
 2uGNlC06TozbSXesKtuDl6fa2lj/T0nkk2Nkyi+oAUHar5dvdE5c+d7JxDE8tiY7FqLLWRi3k
 9hP0Vme8GoSC5ne4s8ORdE2yhh+Y+qhpFA9q9r6B/CYgcO3CJti/pIQ8pOL3yBCAY/uQtCQM/
 bwWi2MqMKALl5k7VGHwNxuddyDfcvmxkyza+CIrdNFNtzPLLq0GhXWQCKLvfF+XnRTAdIinok
 x1NkVKULvuoPOVfXx92LQFB0R0HhUSsh113y4G+iQvISY0b1FmGX1CjWEAkh/hezSWV8rxQSL
 Jz7x1NnXhQnOU6c5XzVu0dzZ0S66nr5NJUrNtxh78HWwsX8WRGKmj1guTPsBV0FKQIz7eefGO
 7ZHgDKKVIJcWMJxkhw6pn0YDiFwgiCPGPISE2ZQoD0YFzU26719y6E3c4iclobxHHATDFbhJl
 PVFnoYSi/GeRykITuuw0X4b5T8XKFlE+dRH0NUN2Zp7uudZ9M8ZK6DzBZ1KFVsGZCTJecoZYV
 gXcS2EWX6I+9UEeLBwrqRrCFu1G2I0YBoAippJ+Bi8+oN4ejsho2euXzihsFmiAq9Jti5/fZz
 yrGpwCt0d4Iz5oJT7T+n2/5PYaAahXc+6ZB9qdoMZOGPYdMf58HIy7+Phb8ZTaOcvtHaabe6d
 9fpuiNCjHvhOBrHdqMiPL0vF18lBSotRB44jejLSXEbk49rsymHg2cATiiPtgeHak8dFWKnYl
 Q9MIeJXMuztaZlFHQxPHy+6x1x+SE2RcGnq+zJklb4/PSrbliiJXe6JrOfL6NYHBZgZQu0tsD
 IpdSndC1265R9y/scfGw8Zhg0jkoLbMwET8ULwW3O/y4kF9XIdnWH3uawY8TPWkfur+DZoKRZ
 QEQdJ7wFXP97kphgWpvg0zjWVRhb2Ltlr85VZuc/tCVs8ZAEZscJ9N4qg00yr2Qr6B3TKHmzh
 ni7GGSu9krwK27FeQZCJkVxwM8LAo7XsDhirNnOpEhtjUYAFSTW1VsF7UcOZr2qyXBa8oWWQU
 pTIK+FDXEsCcThsH3viSXR1J5wVUYut5uEeEucqS29p4CDK9LKHNHR438OBcvHh+1aOJMOKIv
 wg3DbyQpBbzuKtxPB0zcc7zm8zfiqLpgrlADlfC3B1JMl3lYJGmVbuFxAvBhpSzyprvWB/Ykk
 9lnlTgyd6gnlYdOjKIKw1G8NU0Cxtv+TZlXKHi57d4wR/nCf9vpxqKYAM9Nws44RYwz/X+xIe
 6kSi+VesBgugJWaA5GehpQsatC0f2TumiWE7Q6C37ufCeLNCqLaKw88OoK0I=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Mon, 16 Sep 2019, Emily Shaffer wrote:

> Jonathan Tan, Jonathan Nieder, Josh Steadmon and I met on Friday to
> talk about projects and we came up with a trimmed list; not sure what
> more needs to be done to make them into fully-fledged proposals.

Thank you for doing this!

> For starter microprojects, we came up with:
>
>  - cleanup a test script (although we need to identify particularly
>    which ones and what counts as "clean")
>  - moving doc from documentation/technical/api-* to comments in the
>    appropriate header instead
>  - teach a command which currently handles its own argv how to use
>    parse-options instead
>  - add a user.timezone option which Git can use if present rather than
>    checking system local time

Nice projects, all. There are a couple more ideas on
https://github.com/gitgitgadget/git/issues, they could probably use some
tagging.

> For the longer projects, we came up with a few more:
>
>  - find places where we can pass in the_repository as arg instead of
>    using global the_repository

Good project, if a bit boring ;-) Also, `the_index` is used a lot in
`builtin/*.c`, still.

>  - convert sh/pl commands to C, including:
>    - git-submodules.sh

I am of two minds there. But mostly, I am of the "friends don't let
friends use submodules" camp, so I would not even want to mentor for
this project: it just makes me shudder too much every time I have to
work with/on submodules.

Of course, if others are interested, I'd hardly object to turn this into
a built-in.

>    - git-bisect.sh

That would be my top recommendation, especially given how much effort
Tanushree put in last winter to make this conversion to C so much more
achievable than before.

>    - rebase --preserve-merges

No. `rebase -p` is already deprecated in favor of `rebase -r` (which
_is_ already built-in).

I already have patches lined up to drop that rebase backend. Let's not
waste effort on converting this script to C.

>    - add -i

Please see PRs #170-#175 on https://github.com/gitgitgadget/git/pulls,
and please do help by adding your review of #170 (which was already
submitted as v4:
https://public-inbox.org/git/pull.170.v4.git.gitgitgadget@gmail.com/

In other words: this project is well under way. In fact, Git for Windows
users enjoy this as an opt-in already.

>    (We were afraid this might be too boring, though.)

Converting shell/Perl scripts into built-in C never looks as much fun as
open-ended projects with lots of playing around, but the advantage of
the former is that they can be easily structured, offer a lot of
opportunity for learning, and they are ultimately more rewarding because
the goals are much better defined than many other projects'.

Another script that would _really_ benefit from being converted to C:
`mergetool`. Especially on Windows, where the over-use of spawned
processes really hurts, it is awfully slow a command.

To complete the list of sh/pl commands:

- git-merge-octopus.sh
- git-merge-one-file.sh
- git-merge-resolve.sh

These seem to be good candidates for conversion to built-ins. Their
functionality is well-exercised in the test suite, their complexity is
quite manageable, and there is no good reason that these should be
scripted.

The only slightly challenging aspect might be that `merge-one-file` is
actually not a merge strategy, but it is used as helper to be passed to
`git merge-index` via the `-o <helper>` option, which makes it slightly
awkward to be implemented as a built-in. A better approach would
therefore be to special-case this value in `merge-index` and execute the
C code directly, without the detour of spawning a built-in.

- git-difftool--helper.sh
- git-mergetool--lib.sh

These would be converted as part of making `mergetool` a built-in, I
believe.

- git-filter-branch.sh

This one is in the process of being deprecated in favor of `git
filter-repo` (which is an external tool), so I don't think there would
be much use in wasting energy on trying to convert it to C. Especially
given that it wants to call shell script snippets all over the place,
and those shell script snippets are supposed to run in the same context,
which might actually make it completely impossible to convert this to C
at all.

- git-legacy-stash.sh

This will go away once the built-in stash is considered good enough.

- git-instaweb.sh
- git-request-pull.sh
- git-send-email.perl
- git-web--browse.sh

I don't think that any of these should be converted. They are just too
unimportant from a performance point of view, and obscure enough that
even their portability issues don't matter too much.

As to `send-email` in particular: I would not want anybody to drag in
all the dependencies required to convert `send-email` to a built-in to
begin with.

- git-archimport.perl
- git-cvsexportcommit.perl
- git-cvsimport.perl
- git-cvsserver.perl
- git-quiltimport.sh
- git-svn.perl

These are all connectors of some sort to other version control software.
It also feels like they become less and less important, as Git really
takes over the world.

At some stage, I think, it would make sense to push those scripts out
into their own repositories, looking for new maintainers (and if none
can be found, then there really is not enough need for them to begin
with, and they can be archived).

>  - reduce/eliminate use of fetch_if_missing global
>  - create a better difftool/mergetool for format of choice (this one
>    ends up existing outside of the Git codebase, but still may be pretty
>    adjacent and big impact)
>  - training wheels/intro/tutorial mode? (We thought it may be useful to
>    make available a very basic "I just want to make a single PR and not
>    learn graph theory" mode, toggled by config switch)
>  - "did you mean?" for common use cases, e.g. commit with a dirty
>    working tree and no staged files - either offer a hint or offer a
>    prompt to continue ("Stage changed files and commit? [Y/n]")
>  - new `git partial-clone` command to interactively set a filter,
>    configure other partial clone settings
>  - add progress bars in various situations
>  - add a TUI to deal more easily with the mailing list. Jonathan Tan has
>    a strong idea of what this TUI would do... This one would also end up
>    external but adjacent to the Git codebase.

I don't think that this would be a good project for anybody except
people who are already really, really familiar with our mailing
list-centric workflow.

>  - try and make progress towards running many tests from a single test
>    file in parallel - maybe this is too big, I'm not sure if we know how
>    many of our tests are order-dependent within a file for now...

Another, potentially more rewarding, project would be to modernize our
test suite framework, so that it is not based on Unix shell scripting,
but on C instead.

The fact that it is based on Unix shell scripting not only costs a lot
of speed, especially on Windows, it also limits us quite a bit, and I am
talking about a lot more than just the awkwardness of having to think
about options of BSD vs GNU variants of common command-line tools.

For example, many, many, if not all, test cases, spend the majority of
their code on setting up specific scenarios. I don't know about you,
but personally I have to dive into many of them when things fail (and I
_dread_ the numbers 0021, 0025 and 3070, let me tell you) and I really
have to say that most of that code is hard to follow and does not make
it easy to form a mental model of what the code tries to accomplish.

To address this, a while ago Thomas Rast started to use `fast-export`ed
commit histories in test scripts (see e.g. `t/t3206/history.export`). I
still find that this fails to make it easier for occasional readers to
understand the ideas underlying the test cases.

Another approach is to document heavily the ideas first, then use code
to implement them. For example, t3430 starts with this:

	[...]

	Initial setup:

	    -- B --                   (first)
	   /       \
	 A - C - D - E - H            (master)
	   \    \       /
	    \    F - G                (second)
	     \
	      Conflicting-G

	[...]

	test_commit A &&
	git checkout -b first &&
	test_commit B &&
	git checkout master &&
	test_commit C &&
	test_commit D &&
	git merge --no-commit B &&
	test_tick &&
	git commit -m E &&
	git tag -m E E &&
	git checkout -b second C &&
	test_commit F &&
	test_commit G &&
	git checkout master &&
	git merge --no-commit G &&
	test_tick &&
	git commit -m H &&
	git tag -m H H &&
	git checkout A &&
	test_commit conflicting-G G.t

	[...]

While this is _somewhat_ better than having only the code, I am still
unhappy about it: this wall of `test_commit` lines interspersed with
other commands is very hard to follow.

If we were to (slowly) convert our test suite framework to C, we could
change that.

One idea would be to allow recreating commit history from something that
looks like the output of `git log`, or even `git log --graph --oneline`,
much like `git mktree` (which really should have been a test helper
instead of a Git command, but I digress) takes something that looks like
the output of `git ls-tree` and creates a tree object from it.

Another thing that would be much easier if we moved more and more parts
of the test suite framework to C: we could implement more powerful
assertions, a lot more easily. For example, the trace output of a failed
`test_i18ngrep` (or `mingw_test_cmp`!!!) could be made a lot more
focused on what is going wrong than on cluttering the terminal window
with almost useless lines which are tedious to sift through.

Likewise, having a framework in C would make it a lot easier to improve
debugging, e.g. by making test scripts "resumable" (guarded by an
option, it could store a complete state, including a copy of the trash
directory, before executing commands, which would allow "going back in
time" and calling a failing command with a debugger, or with valgrind, or
just seeing whether the command would still fail, i.e. whether the test
case is flaky).

Also, things like the code tracing via `-x` (which relies on Bash
functionality in order to work properly, and which _still_ does not work
as intended if your test case evaluates a lazy prereq that has not been
evaluated before) could be "done right".

In many ways, our current test suite seems to test Git's functionality
as much as (core) contributors' abilities to implement test cases in
Unix shell script, _correctly_, and maybe also contributors' patience.
You could say that it tests for the wrong thing at least half of the
time, by design.

It might look like a somewhat less important project, but given that we
exercise almost 150,000 test cases with every CI build, I think it does
make sense to grind our axe for a while, so to say.

Therefore, it might be a really good project to modernize our test
suite. To take ideas from modern test frameworks such as Jest and try to
bring them to C. Which means that new contributors would probably be
better suited to work on this project than Git old-timers!

And the really neat thing about this project is that it could be done
incrementally.

> It might make sense to only focus on scoping the ones we feel most
> interested in. We came up with a pretty big list because we had some
> other programs in mind, so I suppose it's not necessary to develop all
> of them for this program.

I don't find that list particularly big, to be honest ;-)

Ciao,
Dscho
