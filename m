Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C56D20798
	for <e@80x24.org>; Thu, 12 Jan 2017 05:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750767AbdALFEI (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 00:04:08 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:44965 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750760AbdALFEH (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Jan 2017 00:04:07 -0500
X-AuditID: 1207440e-059ff70000000a39-2d-58770e000fda
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 93.03.02617.00E07785; Thu, 12 Jan 2017 00:02:56 -0500 (EST)
Received: from [192.168.69.190] (p57906C77.dip0.t-ipconnect.de [87.144.108.119])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v0C52sJa021235
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 12 Jan 2017 00:02:55 -0500
Subject: Re: [ANNOUNCE] git-test: run automated tests against a range of Git
 commits
To:     Jeff King <peff@peff.net>
References: <1341c01a-aca7-699c-c53a-28d048614bfe@alum.mit.edu>
 <20170107071832.2rucap3rskzmkgq4@sigill.intra.peff.net>
 <ce6f98a4-1fb7-aa4b-2efb-78d8f49397a7@alum.mit.edu>
 <20170110093502.wbfgof55gdo6mtov@sigill.intra.peff.net>
Cc:     git discussion list <git@vger.kernel.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <51fff12e-8bac-41fb-c93a-df504ae25942@alum.mit.edu>
Date:   Thu, 12 Jan 2017 06:02:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170110093502.wbfgof55gdo6mtov@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqMvAVx5hcHudikXXlW4mix8tPcwO
        TB7PevcwenzeJBfAFMVlk5Kak1mWWqRvl8CVsenYMeaCLpOKXVNfMTYwdmh2MXJySAiYSNx5
        +5kdxBYSuMwocf+pdBcjF5B9gUniz/lFYAlhgTCJe7O+MYHYIgKyEt8Pb2SEKHrJKLHs9xaw
        ImYBXYkHHY/BitiA7EU9zUA2BwevgL3Ekv/1ICaLgKrEyVVgFaICIRJzFj5gBLF5BQQlTs58
        wgJicwq4SKy88ZoRYqK6xJ95l5ghbHmJ7W/nME9g5J+FpGUWkrJZSMoWMDKvYpRLzCnN1c1N
        zMwpTk3WLU5OzMtLLdI11svNLNFLTSndxAgJRr4djO3rZQ4xCnAwKvHwZjiWRQixJpYVV+Ye
        YpTkYFIS5TW4ChTiS8pPqcxILM6ILyrNSS0+xCjBwawkwqvHWh4hxJuSWFmVWpQPk5LmYFES
        51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4NXnBWoULEpNT61Iy8wpQUgzcXCCDOcBGp7MDTK8
        uCAxtzgzHSJ/ilFRSpxXiwcoIQCSyCjNg+uFJYtXjOJArwjz5oBU8QATDVz3K6DBTECDI+2K
        QQaXJCKkpBoYqz1D1W/u0Q6JcIxXjNGZLLA++qDo9CdBle7ui9mvBxZoPTSfl8KeGpoa2rP+
        dZH93Ipd21bq5PK1/kj81x9smMsScPVA8Mu2DU8mlrRcZHXVcNwWcLzaQVOMbYbte6dzu4wN
        Kj5XyHbHVduu6v1hzXO3L7rnWZPB93cHi9h5JqQ0apzrnKbEUpyRaKjFXFScCACSU0ei8QIA
        AA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/10/2017 10:35 AM, Jeff King wrote:
> On Sun, Jan 08, 2017 at 10:52:25AM +0100, Michael Haggerty wrote:
>> [...]

Since my last email, I have implemented a bunch of what we discussed
[1]. Because of the new semantics, I also *renamed the main command* from

    git test range [...]

to

    git test run [...]

>> I'm thinking of maybe
>>
>> * If an argument matches `*..*`, pass it to `rev-list` (like now).

This was already implemented.

>> * Otherwise, treat each argument as a single commit/tree (i.e., pass it
>> to `rev-parse`).

This is now implemented, too. Plus, it is now allowed to specify
multiple commits and/or ranges in a single invocation.

>> * If no argument is specified, test `@{u}..` (assuming that an
>>   upstream is configured). Though actually, this won't be as
>>   convenient as it sounds, because (a) `git test` is often run
>>   in a separate worktree, and (2) on errors, it currently leaves the
>>   repository with a detached `HEAD`.

I decided that if no argument is specified, it makes more sense to test
HEAD if the working tree is clean, and the contents of the working tree
otherwise. In the latter case no results are stored to notes, but it is
still useful to be able to run a preconfigured test quickly while
working. These are both implemented.

>> * Support a `--stdin` option, to read a list of commits/trees to test
>>   from standard input. By this mechanism, users could use arbitrary
>>   `rev-list` commands to choose what to test.

This is now implemented, too.

> [...]
>> I think ideally `git notes add` would look for pre-existing notes, and:
>>
>> * If none are found, create an empty notes reference.
>>
>> * If pre-existing notes are found and there was no existing test with
>>   that name, probably just leave the old notes in place.
>>
>> * If pre-existing notes are found and there was already a test with
>>   that name but a different command, perhaps insist that the user
>>   decide explicitly whether to forget the old results or continue using
>>   them. This might help users avoid the mistake of re-using old results
>>   even if they change the manner of testing.
> 
> I'm not quite sure what you mean here. By "test" and "command", do you
> mean the test name that is used in the notes ref, and the command that
> it is defined as?

By "test", I mean a test as configured in `git-test` and referred to by
its name (e.g., in `--test=name`). Currently the only configuration for
a test is `test.<name>.command`, but I structured the namespace that way
to leave room to add more configuration in the future.

> In the notes-cache.c subsystem, the commit message stores a validity
> token which must match in order to use the cache. You could do something
> similar here (store the executed command in the commit message, and
> invalidate the cache the user has changed the command). The notes-cache
> stuff isn't available outside of the C code, though. You could either
> expose it, or just do something similar longhand.
> 
> Thinking about it, though, I did notice that the tree sha1 is not the
> only input to the cache. Things like config.mak (not to mention the
> system itself) contribute to the test results. So no system will ever be
> perfect, and it seems like just making an easy way to force a retest (or
> just invalidate the whole cache) would be sufficient.

It's true that the tree and the test command are not the only inputs to
the testing machinery. I wasn't hoping to build a watertight system to
prevent accidental use of old results when `config.mak` or something
else in the environment has changed. I was only trying to give the user
a reminder that if they change the command, it's a good time to consider
whether the old results have to be invalidated.

I suppose if we wanted to make this system more watertight, we could let
the test configuration specify the names of other files on which its
results depend; for example,

    test.default.command = make -j16 test
    test.default.auxiliaryInput = config.mak

and include some kind of hash of the auxiliary inputs in a validity
token. But that feels like overkill.

> [...]
>> Yeah, this is awkward, not only because many people don't know what to
>> make of detached HEAD, but also because it makes it awkward in general
>> to use `git test` in your main working directory. I didn't model this
>> behavior on `git rebase --interactive`'s `edit` command, because I
>> rarely use that. But I can see how they would fit together pretty well
>> for people who like that workflow.
> 
> Yeah, after sleeping on it, I think it's best if "git test" remains
> separate from that. It's primary function is to run the test, possibly
> serving up a cached answer. So it would be perfectly reasonable to do:
> 
>   git rebase -x 'git test range HEAD'
> 
> to accomplish the interactive testing (though perhaps just "git test"
> would be a nice synonym for that).

That invocation can now be written `git test run`, which is a bit
shorter. There could be a special case that `git test` is shorthand for
`git test run`, but it quickly gets ambiguous if the user wants to start
adding any `run` arguments.

> And then "jump to a thing that I know is broken" becomes a separate
> action, whether you are using "git test" or not. I wonder if we could
> have:
> 
>   git rebase -e HEAD~2
> 
> to do an interactive rebase, with "edit" for HEAD~2. I feel like
> somebody even proposed that at one point, but I don't think it got
> merged.

That sounds handy. (The GIT_EDITOR thing is pretty hacky.)

> And then "git test fix" basically becomes:
> 
>   git rebase -e "$(git test first-broken)"
> 
> though I think you'd still want a shorthand for that.

There could be a `git test fix --rebase <range>` that does this. Plus my
preference, `git test fix --branch=fix <range>`, which creates a branch
named `fix` at the first broken commit and checks it out. (If the fix is
nontrivial, my next step is usually to `git imerge rebase` the original
branch onto the `fix` branch.)

>>> I think it should be possible to script the next steps, though.
>>> Something like like "git test fix foo", which would: [...]
>>
>> I think you would usually only want to mark only the *first* broken
>> commit as "edit", because often errors cascade to descendant commits.
> 
> Yeah, I had a similar thought. OTOH, if you didn't say "--keep-going",
> you'd only have one breakage either way. [...]

True enough.

Thanks for all your feedback!

Michael

[1] https://github.com/mhagger/git-test

