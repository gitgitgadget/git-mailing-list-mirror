Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C0911F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 09:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbeJLQnc (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 12:43:32 -0400
Received: from mout.gmx.net ([212.227.15.18]:48795 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbeJLQnc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 12:43:32 -0400
Received: from DESKTOP-QUA364F ([89.204.153.145]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lb5nF-1fn58I3LA1-00kcsc; Fri, 12
 Oct 2018 11:11:52 +0200
Received: from DESKTOP-QUA364F ([89.204.153.145]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lb5nF-1fn58I3LA1-00kcsc; Fri, 12
 Oct 2018 11:11:52 +0200
Date:   Fri, 12 Oct 2018 11:11:51 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Michael Witten <mfwitten@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Pratik Karki <predatoramigo@gmail.com>, git@vger.kernel.org
Subject: Re: `--rebase-merges' still failing badly
In-Reply-To: <645452fda0ae411d86487b76aaac8151-mfwitten@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1810121054050.45@tvgsbejvaqbjf.bet>
References: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com> <645452fda0ae411d86487b76aaac8151-mfwitten@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:99HvhYXnO18zglrwSqqnbYHxFU3EZJdNazGUyRpcJEH4WfeOKgE
 ZtfXRitugFs2iLf/m9HDpuhnLqnsCV+5Pky70xPbVkiNqik/7CsPrErT5nI3lERlLy8/wyC
 MK6Di8tJ4VovviDAj8QBiffGgRXLM/8DrD0WwZiUsSN4vH4+951X2ZY0uloBOLfvkgcYNiN
 fGoj5082f1Tph059q3xwA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Cxee/9X+MYM=:GizPeWFm5f+/BXLGaTBzwT
 FK57zxixfwNR+dc7ayGwhZPtfohFJKDVKJfvY6EVA/pbdXR5vNryK+jYFKxPTUU8eqXgS+LO+
 Yz/wPG6LJ1ZkV9hNOIhFdXNObbXXsGkWM7ncjUjgyXfMMCi8IgMMRavbxXy9XhGyB8erjbmFW
 B4hHtU0OH1QYgD8LUnBwWW8rLkufdMJa+KranJlOrkd7uEgIAFiAIE1nGC2FvgZ9UDg9pNQVg
 Uh/F9OqGbZJlZCHBc7d6rhRJK4S5qHWnpWVkVQnsB9amV34arthVjrj6HszHpS/uZHasfIg9/
 Smel6zd0PVUi7ch5BQ1knEqY9dVnACQn5pOnlbcLe/Y9fLUbcZaGVgm+rjbF9EfDGUNIhlyBO
 gWSoKYcipRKE3QnwfmzPW7SFIC+nS9LZkLLsy8oShwrzm8mRdsbDnhgWJ7IDzkODgdZ8CVGYX
 S/NyC/6d7w2y0kulqR9KDzRPc59lsU4gZU/3CYjn8ek6dUYDDf35Sg/R4JoN7F4wIxMab1Afv
 qDnkxuGizL3ZhGuGF/ZwVsvlJUB7GA9tOvzxelgPYQfWHiIMkj5uf79t9kmI3UOSDRju27BJZ
 qpE1E+lX3KUE8LfAX3ncWJbQMgJ/dR4imMnYyvxedvZ0UgLdwO/wPkMxx4ds05a+A220Q5HEs
 wALHo2KRFWp6O/Fl5e1m9AMNnbJC7N87CA9tmeZwk8qXrmxS5YfLxRb3eQGVpD8SK6gBadXnP
 78EKag/GBEdPE0tn3Qp8dW3h6lsJZ+Hqkwk4bCoPO2iu1RO4U60bJVLRXKkL9M1UQ+wfe2hto
 eOIpaWOO4WDaGxrMT2vY89kA1k/6fdU/EAFUFO5sK6Nl3BOot8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

On Wed, 10 Oct 2018, Michael Witten wrote:

> In my opinion, the `--rebase-merges' feature has been broken since the
> beginning, and the builtin version should  be fixed before it is moved
> ahead.

Everybody is entitled to an opinion. My opinion differs from yours, and I
am a heavy user of `git rebase -kir`.

The `--rebase-merges` feature is not without problems, of course. I can
name a couple of bugs, but I have a hunch that it is more efficient for me
to just fix them.

> In short: "labels" are brittle; see below for tests.

Sure, let's improve them.

> Also, here are some quick *additional* thoughts:
> 
>     * Labels should be simply "r0", "r1", ... "rN".

That would not be an improvement.

The *interactive* version of `--rebase-merges` is what I use extensively
to juggle Git for Windows' branch thicket. It would be really bad if I had
to somehow map those label names in my head, rather than having the
intuitively-understood labels.

I would understand if you suggested to try to come up with a better naming
than `branch-point-<n>`. But `r<n>`? That's worse than the current state.
By a lot.

>     * Why is the command "label" and not "branch"?

Because it is more versatile than just a branch. It is also branch points.
As a matter of fact, the very first statement is about the `onto` label,
which is not a branch.

>     * In my experience, there's a lot of this boiler plate:
> 
>           pick 12345
>           label r1
>           reset r0
>           merge r1
> 
>       How about instead, use git's existing ideas:
> 
>           pick 12345
>           reset r0
>           merge ORIG_HEAD

Too magic. And you cannot change it easily. I had this very real example,
a couple of times yesterday: A merge was in one of the "branches", and
needed to be moved out of it:

	pick abc
	label branch-point
	merge -C 0123 topic
	pick def
	label bug-fix

	reset branch-point
	merge -C 4567 bug-fix

This `merge -C 0123 topic` needed to be moved before the branch point.

Another example where the explicit labeling comes in *real* handy is when
I made a Pull Request in Git for Windows ready for contribution to core
Git. These Pull Requests are normally based on `master`, because that is
what the best PR flow is: you based your contributions as close to the tip
as possible, to avoid merge conflicts (and to test as close to the real,
after-merge thing). This would look like this:

	label branch-point
	pick 123
	pick 456
	label pr-0815

	reset branch-point
	merge -C abc pr-0815

Now, to prepare this for core Git, I have to graft this PR onto the
`master` of *upstream*, in our case I would use the `onto` label for that,
by inserting a `reset onto` just before `pick 123`.

So you see, the current, non-implicit, but very much explicit syntax,
makes all of these tasks *quite* easy, and more importantly,
straight-forward: I did not have to explain this to anyone who I needed to
teach how this works.

Remember: the syntax of the todo list is not optimized to be short. It is
optimized to be *editable*. I need to have a very easy way to juggle
criss-cross-merging branch thickets. And the current syntax, while
chattier than you would like, does the job. Pretty well, even.

>     * Why not just `--merges' instead of `--rebase-merges'?

This ship has sailed. It is pointless to discuss this now.

Besides, I believe that in your quest to shorten things, you unfortunately
shortened things too much: it is no longer clear what "merges" means in
the context of `--merges`.

> Unfortunately,   both  the   legacy   version  and   the  rewrite   of
> `--rebase-merges'  display  a  bug  that  makes  this  feature  fairly
> unusable in  practice;

You will be surprised just how much I would embrace bug fixes, once you
provide any.

> it tries  to create  a "label" (i.e.,  a branch name) from a commit log
> summary  line, and the result is often invalid (or just  plain
> irritating to work  with). In particular, it  fails on typical
> characters, including at least these:
> 
>     :/\?.*[]

And of course those are not the only ones. The trick is to reduce runs of
disallowed characters to dashes, as is already done with spaces.

Ciao,
Johannes

> 
> To see this, first define some POSIX shell functions:
> 
>     test()
>     {
>         (
>             set -e
>             summary=$1
>             d=/tmp/repo ##### WARNING. CHANGE IF NECESSARY.
>             rm -rf "$d"; mkdir -p "$d"; cd "$d"
>             git init -q
>             echo a > a; git add a; git commit -q -m a
>             git branch base
>             echo b > b; git add b; git commit -q -m b
>             git reset -q --hard HEAD^
>             git merge -q --no-ff -m "$summary" ORIG_HEAD
>             git log --graph --oneline
>             git rebase --rebase-merges base
>         ); status=$?
>         echo
>         return "$status"
>     }
> 
>     Test()
>     {
>         if test "$@" 1>/dev/null 2>&1; then
>             echo '    good'; return 0
>         else
>             echo '    fail'; return 1
>         fi
>     }
> 
> Then, try various commit summaries (see below for results):
> 
>     test c
>     test 'combine these into a merge: a and b'
>     Test ab:
>     Test a:b
>     Test :
>     Test a/b
>     Test 'Now supports /regex/'
>     Test ab/
>     Test /ab
>     Test /
>     Test 'a\b'
>     Test '\'
>     Test 'Maybe this works?'
>     Test '?'
>     Test 'This does not work.'
>     Test 'This works. Strange!'
>     Test .git
>     Test .
>     Test 'Cast each pointer to *void'
>     Test '*'
>     Test 'return a[1] not a[0]'
>     Test '[ does not work'
>     Test '['
>     Test '] does work'
>     Test ']'
> 
> Here are the results of pasting the above commands into my terminal:
> 
>     $ test c
>     warning: templates not found in ../install/share/git-core/templates
>     *   1992d07 (HEAD -> master) c
>     |\
>     | * 34555b5 b
>     |/
>     * 338db9b (base) a
>     Successfully rebased and updated refs/heads/master.
> 
>     $ test 'combine these into a merge: a and b'
>     warning: templates not found in ../install/share/git-core/templates
>     *   4202c49 (HEAD -> master) combine these into a merge: a and b
>     |\
>     | * 34555b5 b
>     |/
>     * 338db9b (base) a
>     error: refusing to update ref with bad name 'refs/rewritten/combine-these-into-a-merge:-a-and-b'
>     hint: Could not execute the todo command
>     hint:
>     hint:     label combine-these-into-a-merge:-a-and-b
>     hint:
>     hint: It has been rescheduled; To edit the command before continuing, please
>     hint: edit the todo list first:
>     hint:
>     hint:     git rebase --edit-todo
>     hint:     git rebase --continue
> 
>     $ Test ab:
>         fail
>     $ Test a:b
>         fail
>     $ Test :
>         fail
>     $ Test a/b
>         good
>     $ Test 'Now supports /regex/'
>         fail
>     $ Test ab/
>         fail
>     $ Test /ab
>         fail
>     $ Test /
>         fail
>     $ Test 'a\b'
>         fail
>     $ Test '\'
>         fail
>     $ Test 'Maybe this works?'
>         fail
>     $ Test '?'
>         fail
>     $ Test 'This does not work.'
>         fail
>     $ Test 'This works. Strange!'
>         good
>     $ Test .git
>         fail
>     $ Test .
>         fail
>     $ Test 'Cast each pointer to *void'
>         fail
>     $ Test '*'
>         fail
>     $ Test 'return a[1] not a[0]'
>         fail
>     $ Test '[ does not work'
>         fail
>     $ Test '['
>         fail
>     $ Test '] does work'
>         good
>     $ Test ']'
>         good
> 
