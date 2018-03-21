Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6C4B1F404
	for <e@80x24.org>; Wed, 21 Mar 2018 21:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753799AbeCUVta (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 17:49:30 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:38157 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753744AbeCUVt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 17:49:29 -0400
Received: by mail-lf0-f45.google.com with SMTP id y2-v6so10121580lfc.5
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 14:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZRfVxWQfckBwiWAsl4nsSA30YCVrNbIXBxWqcLVpv1k=;
        b=Tb6q/32pMpEdbGirJzm2r68r/+tOW90CneyfQnbMSWBT7quZtTT81CZ6HjFAsyWlB5
         FtQfLFZz6hgOoh7UFZsk6Y53LfhIRwU1UOu70m/gE8rg/qxGDncCGi2eSKv5KC0O+RJg
         LihX5P25E7IYoJpWBntR0HS4S/BnupyhawQWFOICp2D1V6Yd1qZQ9mciURMZTjikdzcR
         IuRKwKcDU+q75L/OWDaRKHwJLv6HboJU5u9iyZVbMyuOLjDD6lrvjQ4tcgbTB/Lvb39h
         pdon0W5xWGg5VFgzWG2J+PGmHXIgQcDd9FhHwcN2YNkNNr4wwjifionIODyYbIyy2zXs
         N//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZRfVxWQfckBwiWAsl4nsSA30YCVrNbIXBxWqcLVpv1k=;
        b=KUdOGqaYObKQfcYbV/DZ5nwkEFtoZ1l1DuAHttpzBRKC0A1q87lNTsPbkBuBeRKqEx
         fDOycfPDKuMAIJsmYEmJzTdLub9/8bXdixVHii1+j4PFMiepEkCym+/Z7HymXbaK6E0F
         yOPzrn/Qoy39Sa+hNGkXIMcfJUxEzxK6UT19t8fFfLFFHVv3wMvyEqnns03pYANuOIoT
         ySbGfE0sLsi/A602KJ+1bVxzwSQxJZUKCgJkExvUGrFDcMB6RdXb4pkvFUeBsoRFrrWi
         aRy8tKCW7cVa6t+4UwO/ICeagnZc1IerRAf4eTn6Mmy4L34Qhrh9fgbFdnzMfL37oG+3
         iDAA==
X-Gm-Message-State: AElRT7HW4LbStbmyXcdDCsPSjrqh36Oy7e+TKdE/FzLz3DXuKl6US1rK
        WU8Pfpnj6qdP4BvP3QJ5AxW47a+6trCHGMbO/rJPkw==
X-Google-Smtp-Source: AG47ELtIdoFI+D59ODH9zUTb5UpPbWYDY0c5L1kb8SQah9pzuXgiOn5I+XRYvEVWq6qSM5yfbse1o6q+K42eBr5QqW4=
X-Received: by 2002:a19:1449:: with SMTP id k70-v6mr15719875lfi.23.1521668967264;
 Wed, 21 Mar 2018 14:49:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:9a93:0:0:0:0:0 with HTTP; Wed, 21 Mar 2018 14:49:06
 -0700 (PDT)
In-Reply-To: <xmqqy3ilnrkn.fsf@gitster-ct.c.googlers.com>
References: <CAPig+cSm3kHF_hTRKutCCNsY82sE3xZfXJkQsKi+zedq9rdnPw@mail.gmail.com>
 <cover.1521653702.git.wink@saville.com> <c169a69be3c61fd1e90eaf79febccef2afdfbd3b.1521653702.git.wink@saville.com>
 <xmqqy3ilnrkn.fsf@gitster-ct.c.googlers.com>
From:   Wink Saville <wink@saville.com>
Date:   Wed, 21 Mar 2018 14:49:06 -0700
Message-ID: <CAKk8isqopygpS0BfPi7Xa3jVTacptup-WKusZ3rzRzgU_WDaZg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/1] rebase-interactive: Add git_rebase__interactive__preserve_merges
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 21, 2018 at 12:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Wink Saville <wink@saville.com> writes:
>
>> Refactor git_rebase__interactive__preserve_merges out of
>> git_rebase__interactive resulting in fewer conditionals making
>> both routines are simpler.
>>
>> Changed run_specific_rebase in git-rebase to dispatch to the appropriate
>> function after sourcing git-rebase--interactive.
>> ---
>
> I think this will become (more) reviewable if it is split into two
> patches (at least).  A preliminary patch that does the style changes
> and line wrapping (left below) as step #1, and all the rest on top
> as step #2.

Yes, I will break this into several commits

>
>> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
>> index 331c8dfea..65ff75654 100644
>> --- a/git-rebase--interactive.sh
>> +++ b/git-rebase--interactive.sh
>> @@ -1,5 +1,7 @@
>> -# This shell script fragment is sourced by git-rebase to implement
>> -# its interactive mode.  "git rebase --interactive" makes it easy
>> +#!/bin/sh
>
> Addition of #! implies that this might be invoked as the top-level
> script; is that the case now?  I did not get such an impression from
> the proposed log message and it is still always dot-sourced (in
> which case #! gives a wrong signal to the readers).

Will remove adding the shebang

>> +# This shell script fragment is sourced by git-rebase--interactive
>> +# and git-rebase--interactive--preserve-merges in support of the
>> +# interactive mode.  "git rebase --interactive" makes it easy
>>  # to fix up commits in the middle of a series and rearrange commits.
>>  #
>>  # Copyright (c) 2006 Johannes E. Schindelin
>> @@ -7,6 +9,7 @@
>>  # The original idea comes from Eric W. Biederman, in
>>  # https://public-inbox.org/git/m1odwkyuf5.fsf_-_@ebiederm.dsl.xmission.com/
>>  #
>> +
>>  # The file containing rebase commands, comments, and empty lines.
>
> Why?

Will remove the blank line.

>> @@ -274,7 +290,8 @@ pick_one () {
>>
>>       case "$1" in -n) sha1=$2; ff= ;; *) sha1=$1 ;; esac
>>       case "$force_rebase" in '') ;; ?*) ff= ;; esac
>> -     output git rev-parse --verify $sha1 || die "$(eval_gettext "Invalid commit name: \$sha1")"
>> +     output git rev-parse --verify $sha1 ||
>> +             die "$(eval_gettext "Invalid commit name: \$sha1")"
>
> Just linewrapping.

Will be leaving for now

>
>> @@ -287,8 +304,8 @@ pick_one () {
>>                       ${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")} \
>>                       "$strategy_args" $empty_args $ff "$@"
>>
>> -     # If cherry-pick dies it leaves the to-be-picked commit unrecorded. Reschedule
>> -     # previous task so this commit is not lost.
>> +     # If cherry-pick dies it leaves the to-be-picked commit unrecorded.
>> +     # Reschedule previous task so this commit is not lost.
>
> Ditto.

Will be leaving for now

>
>> @@ -307,17 +324,15 @@ pick_one_preserving_merges () {
>>       esac
>>       sha1=$(git rev-parse $sha1)
>>
>> -     if test -f "$state_dir"/current-commit
>> +     if test -f "$state_dir"/current-commit && test "$fast_forward" = t
>>       then
>> -             if test "$fast_forward" = t
>> -             then
>> -                     while read current_commit
>> -                     do
>> -                             git rev-parse HEAD > "$rewritten"/$current_commit
>> -                     done <"$state_dir"/current-commit
>> -                     rm "$state_dir"/current-commit ||
>> -                             die "$(gettext "Cannot write current commit's replacement sha1")"
>> -             fi
>> +             while read current_commit
>> +             do
>> +                     git rev-parse HEAD > "$rewritten"/$current_commit
>> +             done <"$state_dir"/current-commit
>> +             rm "$state_dir"/current-commit ||
>> +                 die "$(gettext \
>> +                     "Cannot write current commit's replacement sha1")"
>>       fi
>
> Good code simplification that turns
>
>         if A
>                 if B
>                         do this thing
>                 fi
>         fi
>
> into
>
>         if A & B
>                 do this thing
>         fi

Will be keeping this in a future commit

>
>> @@ -337,10 +352,10 @@ pick_one_preserving_merges () {
>>               if test -f "$rewritten"/$p
>>               then
>>                       new_p=$(cat "$rewritten"/$p)
>> -
>> -                     # If the todo reordered commits, and our parent is marked for
>> -                     # rewriting, but hasn't been gotten to yet, assume the user meant to
>> -                     # drop it on top of the current HEAD
>> +                     # If the todo reordered commits, and our parent is
>> +                     # marked for rewriting, but hasn't been gotten to yet,
>> +                     # assume the user meant to drop it on top of the
>> +                     # current HEAD
>
> Just line wrapping.

Will be leaving for now

>
>> @@ -379,7 +394,7 @@ pick_one_preserving_merges () {
>>               then
>>                       # detach HEAD to current parent
>>                       output git checkout $first_parent 2> /dev/null ||
>> -                             die "$(eval_gettext "Cannot move HEAD to \$first_parent")"
>> +                        die "$(eval_gettext "Cannot move HEAD to \$first_parent")"
>>               fi
>
> Ditto.

Will be leaving for now

>
>> @@ -553,7 +568,7 @@ do_next () {
>>       pick|p)
>>               comment_for_reflog pick
>>
>> -             mark_action_done
>> +             mark_action_done $sha1 "$rest"
>
> This demands more attention from the readers than all the changes we
> have seen so far which were just line wrapping and whitespace
> changes.  That is why it is better to leave these changes to a
> separate patch after preliminary clean-up.  It allows reviewers'
> eyes coast over the clean-up step, and then lets them focus on the
> more "meaningful" changes  like this one.
>
>> @@ -637,7 +652,7 @@ you are able to reword the commit.")"
>>               read -r command rest < "$todo"
>>               mark_action_done
>>               eval_gettextln "Executing: \$rest"
>> -             "${SHELL:-@SHELL_PATH@}" -c "$rest" # Actual execution
>> +             "${SHELL:-/bin/sh}" -c "$rest" # Actual execution
> Why?  This change is not justified in the proposed log message.

Left over from testing, will be removed.

>

Junio, thanks for the review.

As you suggest in v3 I'm going to break the change into several commits
but leave everything in one file as it is here in v2. If desired we can break
it into several files as a last step.

I'm currently contemplating not touching long lines. In this file long lines
were acceptable in the past and rather than introduce many changes to
fix them I think it might be best to leave them. Also, there is a proposal
that a GSOC might convert one or more of the git-rebase--* files into C,
in which case these files could be removed.

But if that doesn't come to past, I believe my goal of simplication and fixing:
  "not ok 24 - exchange two commits with -p # TODO known breakage"
In t3404-rebase-interactive.sh is worth while.
