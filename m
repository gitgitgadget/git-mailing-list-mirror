Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B88E51F424
	for <e@80x24.org>; Tue, 24 Apr 2018 23:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751268AbeDXXsx (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 19:48:53 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:51122 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbeDXXsw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 19:48:52 -0400
Received: by mail-wm0-f53.google.com with SMTP id t67so4122925wmt.0
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 16:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jh/Lc22NuSRqIvPEOgDpnUO5FMTwKsIle9Wm+aU6rIE=;
        b=lHyyAQAokjiOSkj1gRZalmxVRLGmdw7J5aMMKpeO13YMfuAEi256WX9EJ6YyymuU8T
         cqSt27UpXB642GtrnsbGAVp0GPfQ7JnGVUk4EBELcwGJns7BXBioQEKCJOlZ/bBga/GW
         0jA1bhrFY8IGudNdgSW1DVS1SzrVaBmUb0gHQU1aHe5NOQUscONizdHcnU3ueSI/mamV
         9xKELtpTe6yKs15xDCdVZC62iNib9mySX0jwO+lu7ENPAQoDsjBk4VuDM4+UvbvEou9b
         I+ZqvUOU50OShyiIrAoAHTSW20rt470fWTORScKJoBqEUG9aHsWbISpxux7HzGJMVbQu
         7PNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jh/Lc22NuSRqIvPEOgDpnUO5FMTwKsIle9Wm+aU6rIE=;
        b=Yhkj1YZ148c5FFG1fGkEOWiwZAPURd5iwp2kw8qrB/ZF2y9tz29D9erGK1935tu2qa
         7mJG9Hu9ieSpTKjeYLCbnxgjzZm0hpMfMx8itezvOdDdIEIvXs5NPBt9pchBbnWU8FAI
         CzHMvZWmq5KitfaWUnI8SRpqgMNmyXcDNPcx0fENwxEIXQ7eO0kOc+NBLIO2ppS+YZf4
         qXib0NQ76S0NcI/eLmn0g2icUbw6zbPTN47V6SOBv48DzhkxiCz7gPUtoSoyW81jNriF
         +RlJJn0G9cJPGiwy8iDNBZw5v9ZOfGM9c3zQwRhRQ4j6T3plSAEUoP2B+t/1X9rsmK+E
         y64Q==
X-Gm-Message-State: ALQs6tALUyaxgWLzZT2kVC6TspMTE4DQS5TgsTsNJYt58jkME3T7NhvS
        NbHDpGSup5flu5QJVJV73//485tXii73ewh7WnI=
X-Google-Smtp-Source: AIpwx4+hGiof6L6cI2gj8XAej/iVW1CTrw4Ax21hwd6INEPX1Z4lwjpb5lrpWHlLPMSnNBNXj0iuDVhSkaYt11vS1rs=
X-Received: by 10.80.171.72 with SMTP id t8mr35963729edc.133.1524613731180;
 Tue, 24 Apr 2018 16:48:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.180.180 with HTTP; Tue, 24 Apr 2018 16:48:30 -0700 (PDT)
In-Reply-To: <CAKk8isrAmWOdioJe2CdY+2F_AzKxcTGwd+kBsrAmGx-U=ZHGgA@mail.gmail.com>
References: <CAKk8isrAmWOdioJe2CdY+2F_AzKxcTGwd+kBsrAmGx-U=ZHGgA@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 24 Apr 2018 16:48:30 -0700
Message-ID: <CA+P7+xrciFXjufQM5KfjQjWnMsvs_9KoAFPPHSSU7VjLPuTDqg@mail.gmail.com>
Subject: Re: Fetching tags overwrites existing tags
To:     Wink Saville <wink@saville.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 24, 2018 at 12:57 PM, Wink Saville <wink@saville.com> wrote:
> If have a repository with a tag "v1.0.0" and I add a remote repository
> which also has a tag "v1.0.0" tag is overwritten.
>
> Google found [1] from 2011 and option 3 is what I'd like to see. Has it been
> implemented and I just don't see it?
>
> [1]: https://groups.google.com/forum/#!topic/git-version-control/0l_rJFyTE60
>
>
> Here is an example demonstrating what I see:
>
> $ echo abc > abc.txt
> $ git init .
> Initialized empty Git repository in
> /home/wink/prgs/git/investigate-fetch-tags/.git/
> $ git add *
> $ git commit -m "Initial commit"
> [master (root-commit) 1116fdc] Initial commit
>  1 file changed, 1 insertion(+)
>  create mode 100644 abc.txt
> $ git tag v1.0.0
> $ git remote add gbenchmark git@github.com:google/benchmark
> $ git log --graph --format="%h %s %d"
> * 1116fdc Initial commit  (HEAD -> master, tag: v1.0.0)
> $ git fetch --tags gbenchmark
> warning: no common commits
> remote: Counting objects: 4400, done.
> remote: Compressing objects: 100% (15/15), done.
> remote: Total 4400 (delta 5), reused 5 (delta 3), pack-reused 4382
> Receiving objects: 100% (4400/4400), 1.33 MiB | 2.81 MiB/s, done.
> Resolving deltas: 100% (2863/2863), done.
> From github.com:google/benchmark
>  * [new branch]      clangtidy       -> gbenchmark/clangtidy
>  * [new branch]      iter_report     -> gbenchmark/iter_report
>  * [new branch]      master          -> gbenchmark/master
>  * [new branch]      releasing       -> gbenchmark/releasing
>  * [new branch]      reportercleanup -> gbenchmark/reportercleanup
>  * [new branch]      rmheaders       -> gbenchmark/rmheaders
>  * [new branch]      v2              -> gbenchmark/v2
>  * [new tag]         v0.0.9          -> v0.0.9
>  * [new tag]         v0.1.0          -> v0.1.0
>  t [tag update]      v1.0.0          -> v1.0.0
>  * [new tag]         v1.1.0          -> v1.1.0
>  * [new tag]         v1.2.0          -> v1.2.0
>  * [new tag]         v1.3.0          -> v1.3.0
>  * [new tag]         v1.4.0          -> v1.4.0
> $ git log --graph --format="%h %s %d"
> * 1116fdc Initial commit  (HEAD -> master)
>
> As you can see the tag on 1116fdc is gone, v1.0.0 tag has been updated
> and now its pointing to the tag in gbenchmark:
>
> $ git log -5 --graph --format="%h %s %d" v1.0.0
> *   cd525ae Merge pull request #171 from eliben/update-doc-userealtime
>  (tag: v1.0.0)
> |\
> | * c7ab1b9 Update README to mention UseRealTime for wallclock time
> measurements.
> |/
> * f662e8b Rename OS_MACOSX macro to new name BENCHMARK_OS_MACOSX. Fix #169
> *   0a1f484 Merge pull request #166 from disconnect3d/master
> |\
> | * d2917bc Fixes #165: CustomArguments ret type in README
> |/
>
> Ideally I would have liked the tags fetched from gbenchmark to have a prefix
> of gbenchmark/, like the branches have, maybe something like:
>

That would require a complete redesign of how we handle remotes. I've
proposed ideas in the past but never had time and they didn't gain
much traction.

It's a known limitation that the tags namespace can only hold a single
tag name (even if remotes differ in what that tag is). I *thought*
that the tags should not be updated after you fetch it once, but it
seems this is not the behavior we get now?

My basic idea was to fetch *all* remote refs into a
refs/<remotes-bikeshed>/<remote-name>/* such that *every* ref in a
remote can be determined by something like
"refs/tracking/origin/tags/name" instead of
"refs/remotes/origin/name", and then tags would have to be updated to
check for tags in each remote as well as locally. Additionally, you
could update the tool to warn when two remotes have the same tag at
different refs, and allow disambiguation.

Ideally, "origin/branch" should still DWIM, same for "tag" should work
unless there are conflicts.

Unfortunately, it's a pretty big change in how remotes are handled,
and I never had time to actually work towards a POC or implementation.
Mostly, we ended up on bikeshedding what the name should be now that
we can't use "refs/remotes" due to backwards compatibility. I don't
really like "tracking" as a name, but it was the best I could come up
with.

(Note, the impetus for this proposal was actually to allow easy
sharing of notes and other specialized refs).

Thanks,
Jake

> $ git fetch --tags gbenchmark
> ...
>  * [new branch]      v2              -> gbenchmark/v2
>  * [new tag]         v0.0.9          -> gbenchmark/v0.0.9
>  * [new tag]         v0.1.0          -> gbenchmark/v0.1.0
>  * [new tag]         v1.0.0          -> gbenchmark/v1.0.0
>  * [new tag]         v1.1.0          -> gbenchmark/v1.1.0
>  * [new tag]         v1.2.0          -> gbenchmark/v1.2.0
>  * [new tag]         v1.3.0          -> gbenchmark/v1.3.0
>  * [new tag]         v1.4.0          -> gbenchmark/v1.4.0
>
>
> -- Wink
