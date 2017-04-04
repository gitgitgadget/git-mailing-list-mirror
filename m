Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47CE720964
	for <e@80x24.org>; Tue,  4 Apr 2017 15:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752961AbdDDPSz (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 11:18:55 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:35133 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752518AbdDDPSx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 11:18:53 -0400
Received: by mail-io0-f177.google.com with SMTP id z13so97837675iof.2
        for <git@vger.kernel.org>; Tue, 04 Apr 2017 08:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hP0Loma4ealLH1KG3hiaE30VvpG9GIfY5RjBuGWL6sA=;
        b=hxRklqD34v/bfkyfHxj16sE5Ak9YcRtCTrenvFMRNDDblwQlVoOAPGpPMCGOdecEGL
         9EvzzkpLzKSyPlFrMxlcXaU+J8I0t+bsVyxSeP7HtIm0nfJ3V479frdFaLPwAN2Qg9al
         1IquUJI1XwwcjR74z8XUaLllNHJHL6IT3mmu4az6o5LPflzt8oOuAHPrr0AJKvVBp/D9
         CIStpedLj/c7dykq4EHgYxmC9WpfLCHWNb4fXTIVpWrEUnVy+RQF0NjhRTxSRigKyZJf
         yyAh5BUXFnSzRTzVltET63xcj+Fyhsn4wQd7MXoyI3ZYe3DZuHJ3W70lx9hUuPST7Xkq
         omSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hP0Loma4ealLH1KG3hiaE30VvpG9GIfY5RjBuGWL6sA=;
        b=SlhaJy2BsRV9aZuGGyWtroiC9qPv38Wsvj2daCQDF4ckUFyy6ecgNd05W78EFjaf8J
         p2rJ5q1O1a2YcES/acB8RnoxalGZEHLqREBcqomY7MphZAFR2VWAQ3GwZX9SnFGXoUiN
         BYyN7nWfKtdq17XxwrZn3ysSk+X7omBcGkp8LzzKPd4LLZ1dM1EbrPNaY4WKXvv6Xhpw
         rlc/0oCg/AkZMaLny8F3vmWV6SIiDYMSQCEN82Zr3IMILFizPtFLEzT8geTVKoF3+vcv
         kERXyb2fpZZoK81Nlult5vMrrARq120224QUMjET0EtXFgQt30tHrnLQRg8wKQb7NKAs
         kL2g==
X-Gm-Message-State: AFeK/H3OIPki4/ol+iu1djMhKNvgvqph37TV1iJnDcT+DjjlrU2fVl6oaSj6NimZCY5mYoFV/ZcbDQ3JKZr8PA==
X-Received: by 10.107.150.201 with SMTP id y192mr25431277iod.33.1491319132869;
 Tue, 04 Apr 2017 08:18:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Tue, 4 Apr 2017 08:18:32 -0700 (PDT)
In-Reply-To: <658ab318-43d6-6940-50e6-0b32ecd2543f@jeffhostetler.com>
References: <20170403211644.26814-1-avarab@gmail.com> <658ab318-43d6-6940-50e6-0b32ecd2543f@jeffhostetler.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 4 Apr 2017 17:18:32 +0200
Message-ID: <CACBZZX5gYeRWOY+J0E55FfzqnqP8+4JGR9f42Y+MVqUZhxt87A@mail.gmail.com>
Subject: Re: [PATCH/RFC] gitperformance: add new documentation about git
 performance tuning
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 4, 2017 at 5:07 PM, Jeff Hostetler <git@jeffhostetler.com> wrot=
e:
>
> On 4/3/2017 5:16 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> Add a new manpage that gives an overview of how to tweak git's
>> performance.
>>
>> There's currently no good single resource for things a git site
>> administrator might want to look into to improve performance for his
>> site & his users. This unfinished documentation aims to be the first
>> thing someone might want to look at when investigating ways to improve
>> git performance.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>
>> I've been wanting to get something like this started for a while. It's
>> obviously woefully incomplete. Pointers about what to include would be
>> great & whether including something like this makes sense.
>>
>> Things I have on my TODO list:
>>
>>  - Add a section discussing how refs impact performance, suggest
>>    e.g. archiving old tags if possible, or at least run "git remote
>>    prune origin" regularly on clients.
>>
>>  - Discuss split index a bit, although I'm not very confident in
>>    describing what its pros & cons are.
>>
>>  - Should we be covering good practices for your repo going forward to
>>    maintain good performance? E.g. don't have some huge tree all in
>>    one directory (use subdirs), don't add binary (rather
>>    un-delta-able) content if you can help it etc.
>>
>> - The new core.checksumIndex option being discussed on-list. Which
>>   actually drove my to finally write this up (hrm, this sounds useful,
>>   but unless I was watching the list I'd probably never see it...).
>
>
> You might also consider core.preloadIndex.

It's been enabled by default since 2.1.0 (299e29870b), or do you mean
talk about disabling it, or "this is a perf option we have on by
default"?

I don't know the pros of disabling that, haven't used it myself & it's
not clear from the docs.

> For people with very large trees, talk about sparse-checkout.

*nod*

> And (on Windows) core.fscache.  Or leave a place for
> an addendum for Windows that we can fill in later.

I have no core.fscache in my git.git, did you mean something else?

>
>
>>
>>
>>  Documentation/Makefile           |   1 +
>>  Documentation/gitperformance.txt | 107
>> +++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 108 insertions(+)
>>  create mode 100644 Documentation/gitperformance.txt
>>
>> diff --git a/Documentation/Makefile b/Documentation/Makefile
>> index b5be2e2d3f..528aa22354 100644
>> --- a/Documentation/Makefile
>> +++ b/Documentation/Makefile
>> @@ -23,6 +23,7 @@ MAN5_TXT +=3D gitrepository-layout.txt
>>  MAN5_TXT +=3D gitweb.conf.txt
>>
>>  MAN7_TXT +=3D gitcli.txt
>> +MAN7_TXT +=3D gitperformance.txt
>>  MAN7_TXT +=3D gitcore-tutorial.txt
>>  MAN7_TXT +=3D gitcredentials.txt
>>  MAN7_TXT +=3D gitcvs-migration.txt
>> diff --git a/Documentation/gitperformance.txt
>> b/Documentation/gitperformance.txt
>> new file mode 100644
>> index 0000000000..0548d1e721
>> --- /dev/null
>> +++ b/Documentation/gitperformance.txt
>> @@ -0,0 +1,107 @@
>> +giteveryday(7)
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +NAME
>> +----
>> +gitperformance - How to improve Git's performance
>> +
>> +SYNOPSIS
>> +--------
>> +
>> +A guide to improving Git's performance beyond the defaults.
>> +
>> +DESCRIPTION
>> +-----------
>> +
>> +Git is mostly performant by default, but ships with various
>> +configuration options, command-line options, etc. that might improve
>> +performance, but for various reasons aren't on by default.
>> +
>> +This document provides a brief overview of these features.
>> +
>> +The reader should not assume that turning on all of these features
>> +will increase performance, depending on the repository, workload &
>> +use-case turning some of them on might severely harm performance.
>> +
>> +This document serves as a starting point for things to look into when
>> +it comes to improving performance, not as a checklist for things to
>> +enable or disable.
>> +
>> +Performance by topic
>> +--------------------
>> +
>> +It can be hard to divide the performance features into topics, but
>> +most of them fall into various well-defined buckets. E.g. there are
>> +features that help with the performance of "git status", and couldn't
>> +possibly impact repositories without working copies, and then some
>> +that only impact the performance of cloning from a server, or help the
>> +server itself etc.
>> +
>> +git status
>> +~~~~~~~~~~
>> +
>> +Running "git status" requires traversing the working tree & comparing
>> +it with the index. Several configuration options can help with its
>> +performance, with some trade-offs.
>> +
>> +- config: "core.untrackedCache=3Dtrue" (see linkgit:git-config[1]) can
>> +  save on `stat(2)` calls by caching the mtime of filesystem
>> +  directories, and if they didn't change avoid recursing into that
>> +  directory to `stat(2)` every file in them.
>> ++
>> +pros: Can drastically speed up "git status".
>> ++
>> +cons: There's a speed hit for initially populating & maintaining the
>> +cache. Doesn't work on all filesystems (see `--test-untracked-cache`
>> +in linkgit:git-update-index[1]).
>> +
>> +- config: "status.showUntrackedFiles=3Dno" (see
>> +  linkgit:git-config[1]). Skips looking for files in the working tree
>> +  git doesn't already know about.
>> ++
>> +pros: Speeds up "git status" by making it do a lot less work.
>> ++
>> +cons: If there's any new & untracked files anywhere in the working
>> +tree they won't be noticed by git. Makes it easy to accidentally miss
>> +files to "git add" before committing, or files which might impact the
>> +code in the working tree, but which git won't know exist.
>> +
>> +git grep
>> +~~~~~~~~
>> +
>> +- config: "grep.patternType=3Dperl" (see linkgit:git-config[1]) will us=
e
>> +  the PCRE library when "git grep" is invoked by default. This can be
>> +  faster than POSIX regular expressions in many cases.
>> ++
>> +pros: Can, depending on the use-case, be faster than default "git grep"=
.
>> ++
>> +cons: Can also be slower, and in some edge cases produce different
>> +results.
>> +
>> +- config: "grep.threads=3D*" (see linkgit:git-config[1] &
>> +  linkgit:git-grep[1]). Tunes the number of "git grep" worker threads.
>> ++
>> +pros: Giving this a more optimal value might result in a faster grep.
>> ++
>> +cons: It might not.
>> +
>> +Server options to help clients
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +These features can be enabled on git servers, they won't help the
>> +performance of the servers themselves, but will help clients that need
>> +to talk to those servers.
>> +
>> +- config: "repack.writeBitmaps=3Dtrue" (see
>> +  linkgit:git-config[1]). Spend more time during repack to produce
>> +  bitmap index, helps clients with "fetch" & "clone" performance.
>> ++
>> +pros: Once enabled & run regularly as part of "git repack" speeds up
>> +"clone" and "fetch".
>> ++
>> +cons: Takes extra time during repack, requires doing full
>> +non-incremental repacks with `-A` or `-a`.
>> +
>> +GIT
>> +---
>> +Part of the linkgit:git[1] suite
>>
>
