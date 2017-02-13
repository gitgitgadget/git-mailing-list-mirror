Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D71431FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 20:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753084AbdBMUzu (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 15:55:50 -0500
Received: from mail-wr0-f169.google.com ([209.85.128.169]:36507 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752423AbdBMUzt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 15:55:49 -0500
Received: by mail-wr0-f169.google.com with SMTP id k90so158568759wrc.3
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 12:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tDQAz8+3SqX09JIMDR1IF5ziRyzdYjI1WUQhhqh8Xp8=;
        b=bkmWVriEhop91YzazGUL/TDp3qW71n9i57SjjpruJysse/MzU+RVVKYG46pFAxayyd
         iWCjtlr/G+BweUdoGMFY44gcMUsR9YYqBPdeW5X0/N2A+bUqTMm/G3s9E1P0DWA4cBgW
         qsKvBmccvy6UXNakzqks9ljxNgsNrSylDS20wmkSbDoM72Wn6gLXOMXSvhYio23keimi
         H5OuIOpUWou5pYqHy7Blk8daEcRqdAW4j5Mc9Hzg8XBCprXyyxT/MPhFaX/ROZW4WyUe
         a308UOhFajr4Q4iZs4/By7+7IHfHMwK/pW+R3a3Ucju+2S1j1VWAYsAXMF0z5WdXc86X
         oWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tDQAz8+3SqX09JIMDR1IF5ziRyzdYjI1WUQhhqh8Xp8=;
        b=BKl7+uHd80A2J9p5zET/z+pTf1FS5UTJT7utICybmYNbhO2cQ0E/lakuBcLVwUPRPK
         p+1gKoQLFeFy15d1slzH5mE+yHNR0LFB/U3dRG2qhqX+se2I3jaL23e/OK0vz0ToX7wH
         q3g3aPda7QCpSROSchQ0dILsHeMfsbhxBEosi63a9rOeCSHfgOt0mWWPNmQ3plC8wMFH
         yHX39ahFZlzH7lyFeBubWnoIi7KrXTcYd7yRGOvvwiTAtSLNfU2BEByAbmZ9Lwf0dgeB
         h62k0fLuhtuBRmLi8jvRcFfDKWBOuOO0QpSurHjI/MprjgKHMillsVCV4/QptH6fguVl
         YzUg==
X-Gm-Message-State: AMke39kpqLIXI3/d1PC3E/bY3ozBV1c+7J/dHnUgX5TZCIrzb+FYJLXY/gK4XhRubkHmFfRp8IOG4ZReZIj1GQ==
X-Received: by 10.223.177.136 with SMTP id q8mr20421062wra.134.1487019347786;
 Mon, 13 Feb 2017 12:55:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.62.208 with HTTP; Mon, 13 Feb 2017 12:55:07 -0800 (PST)
In-Reply-To: <xmqqa89pevw0.fsf@gitster.mtv.corp.google.com>
References: <CAM_JFCwYAKCWrHqCtcwid27V1HvhuSmp4QpbNpgyMzrzWUNYog@mail.gmail.com>
 <xmqqa89pevw0.fsf@gitster.mtv.corp.google.com>
From:   hIpPy <hippy2981@gmail.com>
Date:   Mon, 13 Feb 2017 12:55:07 -0800
Message-ID: <CAM_JFCwN+o54mJ1XJ3rSKnXgPx3wt_i=fd8ZSGpcL-fSegQ=Ow@mail.gmail.com>
Subject: Re: Incorrect pipe for git log graph when using --name-status option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 13, 2017 at 11:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
> hIpPy <hippy2981@gmail.com> writes:
>
>> The `git log` command with `graph` and pretty format works correctly
>> as expected.
>>
>> $ git log --graph --pretty=format:'%h' -2
>> * 714a14e
>> * 87dce5f
>>
>>
>> However, with `--name-status` option added, there is a pipe
>> incorrectly placed after the commit hash (example below).
>>
>> $ git log --graph --pretty=format:'%h' -2 --name-status
>> * 714a14e|
>> | M README.md
>
> Is it a --name-status, or is it your own custom format, that is
> causing the above issue?
>
>  - What happens if you stop using --pretty=format:%h and replace it
>    with something like --oneline?
>
>  - What happens if you keep using --pretty=format:%h but replace
>    --name-status with something else, e.g. --raw or --stat?
>



 - What happens if you stop using --pretty=format:%h and replace it
   with something like --oneline?
--oneline works correctly as expected (example below).

$ git log --graph --oneline -2 --name-status
* bf7ace7daf (HEAD -> rm/option-for-name-status) wip: --ns for --name-status
| M diff.c
*   592e5c5bce (origin/master, origin/HEAD, master) Merge pull request
#994 from jeffhostetler/jeffhostetler/fscache_nfd
|\


 - What happens if you keep using --pretty=format:%h but replace
   --name-status with something else, e.g. --raw or --stat?
I see the same issue with --raw and --stat (examples below).

$ git log --graph --pretty=format:'%h' -2 --raw
* bf7ace7daf|
| :100644 100644 84dba60c40... 87dfabf4a9... M  diff.c

*   592e5c5bce
|\

$ git log --graph --pretty=format:'%h' -2 --stat
* bf7ace7daf|
|  diff.c | 2 +-
|  1 file changed, 1 insertion(+), 1 deletion(-)

*   592e5c5bce
|\

I believe it's not my custom format that is causing the issue.
I'm including this information that may not be relevant. I apologize
in advance for that. I had simplified the custom format in my
previous email. For below custom format I still see the pipe
incorrectly placed.

$ git log --graph --date=relative --decorate --abbrev-commit
--format=format:'%h - %aD (%ar)%d%n     %s - %an' -2 --name-status
* bf7ace7daf - Mon, 6 Feb 2017 13:09:32 -0800 (7 days ago) (HEAD ->
rm/option-for-name-status)
|      wip: --ns for --name-status - Rishikesh Mandvikar|
| M diff.c

*   592e5c5bce - Wed, 1 Feb 2017 16:35:30 +0100 (12 days ago)
(origin/master, origin/HEAD, master)
|\       Merge pull request #994 from
jeffhostetler/jeffhostetler/fscache_nfd - Johannes Schindelin


If I were to put a '%n' at the end (example below), the pipe is
correctly placed with or without the --name-status option. But in
case of "without the --name-status option", there is an extra blank
line. It seems that my custom format is requiring a %n at the end. I
consider my custom format as a --twoline option and I feel the
behavior should match --oneline when using options.

With --name-status: This works correctly.

$ git log --graph --date=relative --decorate --abbrev-commit
--format=format:'%h - %aD (%ar)%d%n     %s - %an%n' -2 --name-status
* bf7ace7daf - Mon, 6 Feb 2017 13:09:32 -0800 (7 days ago) (HEAD ->
rm/option-for-name-status)
|      wip: --ns for --name-status - Rishikesh Mandvikar
|
| M diff.c
|
*   592e5c5bce - Wed, 1 Feb 2017 16:35:30 +0100 (12 days ago)
(origin/master, origin/HEAD, master)
|\       Merge pull request #994 from
jeffhostetler/jeffhostetler/fscache_nfd - Johannes Schindelin

Without --name-status: This works but has extra blank line between
commits though.

$ git log --graph --date=relative --decorate --abbrev-commit
--format=format:'%h - %aD (%ar)%d%n     %s - %an%n' -2
* bf7ace7daf - Mon, 6 Feb 2017 13:09:32 -0800 (7 days ago) (HEAD ->
rm/option-for-name-status)
|      wip: --ns for --name-status - Rishikesh Mandvikar
|
*   592e5c5bce - Wed, 1 Feb 2017 16:35:30 +0100 (12 days ago)
(origin/master, origin/HEAD, master)
|\       Merge pull request #994 from
jeffhostetler/jeffhostetler/fscache_nfd - Johannes Schindelin

I think that requiring to end custom formats with %n with options
is not good. So I think this is a bug.

Thanks,
RM
