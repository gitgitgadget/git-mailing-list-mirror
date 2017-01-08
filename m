Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA3F61FEB3
	for <e@80x24.org>; Sun,  8 Jan 2017 09:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754479AbdAHJyf (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jan 2017 04:54:35 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:63714 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935063AbdAHJwb (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Jan 2017 04:52:31 -0500
X-AuditID: 1207440d-8b7ff700000009ba-8b-58720bdb9fe5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id B9.49.02490.BDB02785; Sun,  8 Jan 2017 04:52:29 -0500 (EST)
Received: from [192.168.69.190] (p5B105C39.dip0.t-ipconnect.de [91.16.92.57])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v089qPCx005156
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sun, 8 Jan 2017 04:52:26 -0500
Subject: Re: [ANNOUNCE] git-test: run automated tests against a range of Git
 commits
To:     Jeff King <peff@peff.net>
References: <1341c01a-aca7-699c-c53a-28d048614bfe@alum.mit.edu>
 <20170107071832.2rucap3rskzmkgq4@sigill.intra.peff.net>
Cc:     git discussion list <git@vger.kernel.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <ce6f98a4-1fb7-aa4b-2efb-78d8f49397a7@alum.mit.edu>
Date:   Sun, 8 Jan 2017 10:52:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <20170107071832.2rucap3rskzmkgq4@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsUixO6iqHuXuyjC4OMfNYuuK91MFj9aepgd
        mDye9e5h9Pi8SS6AKYrLJiU1J7MstUjfLoErY8+tW2wFU3wqXlxbw9TAuNm6i5GTQ0LAROLW
        gmdsXYxcHEIClxkl9jfsZIRwzjBJNHxdyQ5SJSwQJnFv1jcmEFtEQFbi++GNjCC2kEClxKoj
        21lBbGYBXYkHHY/BatiA7EU9zWA2r4C9xKmuXrA5LAIqErdntYHViwqESFyec5QNokZQ4uTM
        JyxdjBwcnAIuEu8/J0OMVJf4M+8SM4QtL9G8dTbzBEb+WUg6ZiEpm4WkbAEj8ypGucSc0lzd
        3MTMnOLUZN3i5MS8vNQiXSO93MwSvdSU0k2MkHDk3cH4f53MIUYBDkYlHt4JWwojhFgTy4or
        cw8xSnIwKYnyOkYVRAjxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4b3FUhQhxJuSWFmVWpQPk5Lm
        YFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4HXlAmoULEpNT61Iy8wpQUgzcXCCDOcBGs4L
        UsNbXJCYW5yZDpE/xagoJc6bApIQAElklObB9cLSxStGcaBXhHn3gFTxAFMNXPcroMFMQIMF
        PfNBBpckIqSkGhjtdjhMPm70fbtQ4rk/RY5RtQZ/1+qG6xxvbnvAz8x4Vp1rw79At3gevTeK
        xWKz3Oy4Hr72/XF1vm25dK3WCjnt/i8Xrj1elRN43YF1geFKzZ0zP6k1bZOxXnL2ZnPmzPXT
        VAWbTv086/J736RJJyX/tm80vPpgrfnZ+UvZb2no1tkaaVQs1mZRYinOSDTUYi4qTgQAnJ4U
        IfICAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/07/2017 08:18 AM, Jeff King wrote:
> On Fri, Jan 06, 2017 at 04:52:16PM +0100, Michael Haggerty wrote:
> 
>> I just released ﻿⁠⁠⁠⁠`git test﻿⁠⁠⁠⁠`, a script for running automated
>> tests across a range of Git commits and keeping track of the results in
>> git notes:
>>
>>     https://github.com/mhagger/git-test
>>
>> This is a script that I've been using in one form or another for years
>> and I find it really handy [1].
> 
> Neat. I usually "git rebase -x 'make -j8 test' @{u}" after finishing a
> topic to make sure the intermediate steps are good. But it would be neat
> to have this running continuously in the background to alert me to
> problems sooner (and the key thing there is that it remembers
> already-run tests, so it should be safe to basically for new commits
> every 10 seconds or so).
> 
> I did hit a few interesting cases trying out "git test". So here's a
> narrative, and you can pick out where there may be room for improvement
> in the tool, and where I'm just being dumb. :)
> 
> I tried it out first on a topic I finished earlier today, which has 3
> commits. So I did:
> 
>   $ git test add 'make -j8 test'
>   $ git test range @{u}..HEAD
> 
> It barfed on the first commit, because the script expects "git co" to
> work, but I don't have that alias. No big deal (and I already submitted
> a PR to fix it).

I make the same mistake in most of my scripts :-/ Thanks for the PR; I
merged it.

> So then I reinvoked it like:
> 
>   $ git test range @{u}..HEAD
> 
> and it actually ran some tests. Yay.
> 
> And then of course I wanted to prove to myself how cool the notes
> feature is, so I ran it again. It didn't run any tests this time. Yay
> again. But there were a few surprises:
> 
>   $ git test range @{u}..HEAD
>   setup_test default
>   Using test default; command: make -j8 test
>   Old status: bad
>   Tree 9fcdbd5c78^{tree} is already known to be bad!
>   Old status: good
>   Tree c22f4f6624^{tree} is already known to be good.
>   Old status: good
>   Tree 19e2e62e5e^{tree} is already known to be good.
>   Already on 'jk/wait-for-child-cleanup'
>   Your branch is ahead of 'origin/master' by 3 commits.
> 
>   ALL TESTS SUCCESSFUL
>
> My initial run with "git co" had left the first commit marked as "bad".
> That's not _too_ surprising, since it did indeed fail. I think it's
> probably a bug to record a failure note, though, if checking out fails.
> It's not necessarily an immutable property of the tree.

I definitely agree. This was an oversight which I just fixed.

> [...]
> 
> The second thing that surprised me was "ALL TESTS SUCCESSFUL", when
> clearly one of them was known-bad. :)

Replayed results weren't being treated internally as failures. That's
fixed, too.

> So at this point I knew I needed to re-run the test. Looks like there's
> a "--force" option. Let's try it. There's no need to re-run the other
> two, so let's just give it one commit:
> 
>   $ git test range -f HEAD~2
>   ...
>   Object 95649d6cf9ec68f05d1dc57ec1b989b8d263a7ae^{tree} has no note
>   Object e1970ce43abfbf625bce68516857e910748e5965^{tree} has no note
>   Object 368f99d57e8ed17243f2e164431449d48bfca2fb^{tree} has no note
>   Object ceede59ea90cebad52ba9c8263fef3fb6ef17593^{tree} has no note
>   Object dfe070511c652f2b8e1bf6540f238c9ca9ba41d3^{tree} has no note
>   Object 902d960b382a0cd424618ff4e1316da40e4be2f6^{tree} has no note
>   ...
> 
> This started spewing out many lines like the one above, until I hit ^C.
> Yikes!
> 
> [...]
> I see the symmetry and simplicity in allowing the user to specify a full
> range. But it also seems like it's easy to make a mistake that's going
> to want to test a lot of commits. I wonder if it should complain when
> there's no lower bound to the commit range. Or alternatively, if there's
> a single positive reference, treat it as a lower bound, with HEAD as the
> upper bound (which is vaguely rebase-like).

I see how this might be unexpected, and it's definitely inconvenient at
some times (like when you want to test a single commit). I thought it
would be nice to allow arbitrary `rev-list` expressions (albeit
currently only a single word), but I think that you are right that other
semantics would be more convenient.

I'm thinking of maybe

* If an argument matches `*..*`, pass it to `rev-list` (like now).

* Otherwise, treat each argument as a single commit/tree (i.e., pass it
to `rev-parse`).

* If no argument is specified, test `@{u}..` (assuming that an
  upstream is configured). Though actually, this won't be as
  convenient as it sounds, because (a) `git test` is often run
  in a separate worktree, and (2) on errors, it currently leaves the
  repository with a detached `HEAD`.

* Support a `--stdin` option, to read a list of commits/trees to test
  from standard input. By this mechanism, users could use arbitrary
  `rev-list` commands to choose what to test.

> A few other observations about the note deletion:
> 
>   - The "has no note" message should perhaps be suppressed. We're just
>     trying to overwrite the value if there is one (alternatively,
>     instead of removing it, just overwrite it, so the old note stays
>     until we get a result one way or the other).

Yes. That's a one-time problem that I haven't seen in a long time. The
script is overly chatty in general.

Aside: It would be nice if `git notes` had a subcommand to initialize a
note reference with an empty tree. (I know how to do it longhand, but
it's awkward and it should be possible to do it via the `notes` interface.)

I think ideally `git notes add` would look for pre-existing notes, and:

* If none are found, create an empty notes reference.

* If pre-existing notes are found and there was no existing test with
  that name, probably just leave the old notes in place.

* If pre-existing notes are found and there was already a test with
  that name but a different command, perhaps insist that the user
  decide explicitly whether to forget the old results or continue using
  them. This might help users avoid the mistake of re-using old results
  even if they change the manner of testing.

>   - It was sufficiently slow that it looks like we invoke "git notes
>     remove" once per commit. It would be a lot more efficient to batch
>     them (not just in terms of process startup, but because you're going
>     to write a _ton_ of intermediate notes trees).
> 
>     Of course none of that matters if you don't do something stupid like
>     trying to "git test" 45,000 commits. :)

Yeah, I've never experienced that problem myself :-P But I see that
notes supports `git notes remove --ignore-missing --stdin`, so that will
be easy to implement.

> [...]
> It would be even easier if I could just repeat my range and only re-test
> the "bad" commits. It was then that I decided to actually read the rest
> of "git test help range" and see that you already wrote such an option,
> cleverly hidden under the name "--retest".

I think you were being ironic, but if not, would this have been easier
to find under another name?

> And one final nit. I notice there is also a "--keep-going" option. Which
> made me surprised that we bothered to test HEAD~1 and HEAD, when we knew
> that HEAD~2 was bogus. I suspect this is related to the "ALL TESTS
> SUCCESSFUL" issue.

Yes, that's part of the same bug from above.

> So those were all little cosmetic things. The other big thing I wanted
> to see was what it's like to fix a bug deep in a topic. So I used "git
> rebase -i" to inset a compile error into the first commit of my 3-patch
> series. And then I tested it:
> 
>   $ git test add -t compile 'make -j8'
>   $ git test range -t compile HEAD~3..
> 
> As predicted, it stopped at the first commit and told me it was buggy.
> But I'm dumped onto a detached HEAD, and I'm on my own to actually get
> the working tree to a state where I can test and fix on my actual
> branch.

Yeah, this is awkward, not only because many people don't know what to
make of detached HEAD, but also because it makes it awkward in general
to use `git test` in your main working directory. I didn't model this
behavior on `git rebase --interactive`'s `edit` command, because I
rarely use that. But I can see how they would fit together pretty well
for people who like that workflow.

I've considered that rather than leave you in a detached HEAD state,
maybe `git test` should always restore your old branch. But it seems
like it would more often be useful to be in the directory with the
broken commit checked out and any test results, coredumps, etc intact.

I would definitely like to implement a `git test reset` command that
returns you to your initial branch (like `git bisect reset`).

I like your idea of a `git test fix` command:

> [...]
> I think it should be possible to script the next steps, though.
> Something like like "git test fix foo", which would:
> 
>   - expand the range of foo@{u}..foo to get the list of commits
> 
>   - see which ones were marked as broken
> 
>   - kick off an interactive rebase, but override GIT_EDITOR to mark any
>     broken ones as "edit" instead of "pick"
> 
> That lets you separate the act of testing from the act of fixing. You
> can let the tester run continuously in the background, and only stop to
> fix when you're at an appropriate point in your work.

I think you would usually only want to mark only the *first* broken
commit as "edit", because often errors cascade to descendant commits.

Thanks for all the great feedback!

Michael

