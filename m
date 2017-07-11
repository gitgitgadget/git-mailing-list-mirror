Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4708620357
	for <e@80x24.org>; Tue, 11 Jul 2017 07:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932418AbdGKHf7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 03:35:59 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:38231 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932390AbdGKHf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 03:35:57 -0400
Received: by mail-it0-f52.google.com with SMTP id k192so11276130ith.1
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 00:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zNj4pHv6JYcBaQXZ59bFhp7RDAMb1nCbV/b59Lx3iH8=;
        b=fGt8O8muVXgsUvkjVMUNaGCM/z0huOqWDI8TQoYu2caDHR2mF6XVuE4CtrVmuyVIcr
         4AHyaNQL0oDSiWUU7RP6ZGJEG7mTk04jY1UpogWM9mRLINIoR9uYBgZ+NwG0gsDZOfrY
         dHGWRlK3/IMUD+9knBkIHj4oeEg3w70IQn2gPjlGvnxO4nF82xz40//HxzmyCLyiloTD
         ex0Gt8b/z/UD+HzsGQjxK3w+hMk008opgzG8kWaQoIFB0Otqh52rl0etvRRtbe1QjoVF
         HEWmWvGlhTxwdCc4PAf1WgPRMNbAOs+VvwFgpITtjRHo+ercOcdvyNPEUfd1WDcR41vR
         kJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zNj4pHv6JYcBaQXZ59bFhp7RDAMb1nCbV/b59Lx3iH8=;
        b=b4ZBKpLzp53v2CQY52Ne4C32/7/VKRQyvsjuLoKmDeMJA3Qt0jFK+6KKZLV4AC3Yal
         g5iNM0UDnL19KwVTSbYQPV1ILdZPNsRlPrRmbGig20ADrZBsjOIw7Su+9s3590/xuCkT
         A+GQg2+YPovJWKb3AraGVGcqt3PmRsktF1RnFdo0ZW6hkEWUNQ1KLKF34JeQWqqi4hwX
         OAe9KadYILaCKjcVGfBnAfcyaU6qfEnkz4318B0O0yyy9NdsXt1vnag+W676SZSdOkJG
         jEvzVkVUHIUDdStLtUzhIMt5/eWkFjlzgF3o7uxxZFf/Jhjn19s1T+MmQ6AuGyAEPyao
         fB5g==
X-Gm-Message-State: AIVw111eCadxXAMb/bjNDwo68vp0SRwjkmCRGhGzoIq+dSM/TxogzYpT
        OfbVMtqUK9BBGSbK6sMtrW+svr0Up89N
X-Received: by 10.36.19.5 with SMTP id 5mr2002311itz.65.1499758550822; Tue, 11
 Jul 2017 00:35:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.196.153 with HTTP; Tue, 11 Jul 2017 00:35:50 -0700 (PDT)
In-Reply-To: <20170711044553.GG3786@inner.h.apk.li>
References: <20170704075758.GA22249@inner.h.apk.li> <20170705082027.ujddejajjlvto7bp@sigill.intra.peff.net>
 <20170706133124.GB1216@inner.h.apk.li> <CAGyf7-FnaWM=XNb_Skb1qR4vu_jAw-5swkgWpEDQqwM0NNq3YQ@mail.gmail.com>
 <20170711044553.GG3786@inner.h.apk.li>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 11 Jul 2017 00:35:50 -0700
Message-ID: <CAGyf7-F-zG7NR_bd_sVLdVM5xT9UbJrW_=5imiihNu15E5OsYg@mail.gmail.com>
Subject: Re: Flurries of 'git reflog expire'
To:     Andreas Krey <a.krey@gmx.de>
Cc:     Jeff King <peff@peff.net>, Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 10, 2017 at 9:45 PM, Andreas Krey <a.krey@gmx.de> wrote:
> On Thu, 06 Jul 2017 10:01:05 +0000, Bryan Turner wrote:
> ....
>> I also want to add that Bitbucket Server 5.x includes totally
>> rewritten GC handling. 5.0.x automatically disables auto GC in all
>> repositories and manages it explicitly, and 5.1.x fully removes use of
>> "git gc" in favor of running relevant plumbing commands directly.
>
> That's the part that irks me. This shouldn't be necessary - git itself
> should make sure auto GC isn't run in parallel. Now I probably can't
> evaluate whether a git upgrade would fix this, but given that you
> are going the do-gc-ourselves route I suppose it wouldn't.
>

I believe I've seen some commits on the mailing list that suggest "git
gc --auto" manages its concurrency better in newer versions than it
used to, but even then it can only manage its concurrency within a
single repository. For a hosting server with thousands, or tens of
thousands, of active repositories, there still wouldn't be any
protection against "git gc --auto" running concurrently in dozens of
them at the same time.

But it's not only about concurrency. "git gc" (and by extension "git
gc --auto") is a general purpose tool, designed to generally do what
you need, and to mostly stay out of your way while it does it. I'd
hazard to say it's not really designed for managing heavily-trafficked
repositories on busy hosting services, though, and as a result, there
are things it can't do.

For example, I can configure auto GC to run based on how many loose
objects or packs I have, but there's no heuristic to make it repack
refs when I have a lot of loose ones, or configure it to _only_ pack
refs without repacking objects or pruning reflogs. There are knobs for
various things (like "gc.*.reflogExpire"), but those don't give
complete control. Even if I set "gc.reflogExpire=never", "git gc"
still forks "git reflog expire --all" (compared to
"gc.packRefs=false", which completely prevents forking "git
pack-refs").

A trace on "git gc" shows this:
$ GIT_TRACE=1 git gc
00:10:45.058066 git.c:437               trace: built-in: git 'gc'
00:10:45.067075 run-command.c:369       trace: run_command:
'pack-refs' '--all' '--prune'
00:10:45.077086 git.c:437               trace: built-in: git
'pack-refs' '--all' '--prune'
00:10:45.084098 run-command.c:369       trace: run_command: 'reflog'
'expire' '--all'
00:10:45.093102 git.c:437               trace: built-in: git 'reflog'
'expire' '--all'
00:10:45.097088 run-command.c:369       trace: run_command: 'repack'
'-d' '-l' '-A' '--unpack-unreachable=2.weeks.ago'
00:10:45.106096 git.c:437               trace: built-in: git 'repack'
'-d' '-l' '-A' '--unpack-unreachable=2.weeks.ago'
00:10:45.107098 run-command.c:369       trace: run_command:
'pack-objects' '--keep-true-parents' '--honor-pack-keep' '--non-empty'
'--all' '--reflog' '--indexed-objects'
'--unpack-unreachable=2.weeks.ago' '--local' '--delta-base-offset'
'objects/pack/.tmp-15212-pack'
00:10:45.127117 git.c:437               trace: built-in: git
'pack-objects' '--keep-true-parents' '--honor-pack-keep' '--non-empty'
'--all' '--reflog' '--indexed-objects'
'--unpack-unreachable=2.weeks.ago' '--local' '--delta-base-offset'
'objects/pack/.tmp-15212-pack'
Counting objects: 6, done.
Delta compression using up to 16 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (6/6), done.
Total 6 (delta 0), reused 6 (delta 0)
00:10:45.173161 run-command.c:369       trace: run_command: 'prune'
'--expire' '2.weeks.ago'
00:10:45.184171 git.c:437               trace: built-in: git 'prune'
'--expire' '2.weeks.ago'
00:10:45.199202 run-command.c:369       trace: run_command: 'worktree'
'prune' '--expire' '3.months.ago'
00:10:45.208193 git.c:437               trace: built-in: git
'worktree' 'prune' '--expire' '3.months.ago'
00:10:45.212198 run-command.c:369       trace: run_command: 'rerere' 'gc'
00:10:45.221223 git.c:437               trace: built-in: git 'rerere' 'gc'

The bare repositories used by Bitbucket Server:
* Don't have reflogs enabled generally, and for the ones that are
enabled "gc.*.reflogExpire" is set to "never"
* Never have worktrees, so they don't need to be pruned
* Never use rerere, so that doesn't need to GC
* Have pruning disabled if they've been forked, due to using
alternates to manage disk space

That means of all the commands "git gc" runs, under the covers, at
most only "pack-refs", "repack" and sometimes "prune" have any value.
"reflog expire --all" in particular is extremely likely to fail. Which
brings up another consideration.

"git gc --auto" has no sense of context, or adjacent behavior. Even if
it correctly guards against concurrency, it still doesn't know what
else is going on. Immediately after a push, Bitbucket Server has many
other housekeeping tasks it performs, especially around pull requests.
That means pull request refs are disproportionately likely to be
"moving" immediately after a push completes--exactly when "git gc
--auto" tries to run. (Which tends to be why "reflog expire --all"
fails, due ref locking issues with pull request refs.) Bitbucket
Server, on the other hand, better understands the context GC is
running in. So it can defer GC processing for a period of time after a
push completes, to increase the likelihood that the repository is
"quiet" and GC can complete without issue.

Another limitation is that you can't configure "negative" heuristics,
like "Don't run GC more than once per day.". If "git gc --auto"'s
heuristics are exceeded, it'll run GC. Depending, for example, on how
rapidly a repository generates unreachable objects, it's entirely
possible to get to a point where "git gc --auto" wants to run after
every single push, sometimes for days in a row, while it waits for
objects to hit the prune threshold. By managing GC ourselves, we gain
the ability to enforce "cooldowns" to prevent continuous GC.

"git gc --auto" also has a tendency to run "attached" to the "git
receive-pack" process, which means both that pushing users can have
their local process "delayed" while it runs, and that they sometimes
get to see "scary" errors that they can't fix (or, often, understand).
Newer versions of Git have increased the likelihood that "git gc
--auto" will run detached, but that doesn't always happen. (Up to and
including 2.13.2, the "git config" documentation for "gc.autoDetach"
is qualified with "if the system supports it.") Managing GC in
Bitbucket Server guarantees that it's _always_ detached from user
processes.

That's a few of the reasons we've switched over. I'd imagine most
hosting providers take a similarly "hands on" approach to controlling
their GC. Beyond a certain scale, it seems almost unavoidable. Git
never has more than a repository-level view of the world; only the
hosting provider can see the big picture.

Best regards,
Bryan Turner

> ...
>> Upgrading to 5.x can be a bit of an undertaking, since the major
>> version brings API changes,
>
> The upgrade is on my todo list, but there are plugins that don't
> appear to be ready for 5.0, notable the jenkins one.
>
> Andreas
>
> --
> "Totally trivial. Famous last words."
> From: Linus Torvalds <torvalds@*.org>
> Date: Fri, 22 Jan 2010 07:29:21 -0800
