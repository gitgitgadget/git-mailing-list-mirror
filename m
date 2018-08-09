Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 305411F405
	for <e@80x24.org>; Thu,  9 Aug 2018 18:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeHIUi1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 16:38:27 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:55146 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbeHIUi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 16:38:26 -0400
Received: by mail-wm0-f47.google.com with SMTP id c14-v6so1090385wmb.4
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 11:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=C7UvdYYJmrGSCrLuEWZGQzfQVEM11dnm8k5QtGn8BUQ=;
        b=osApWi2wT6g6rtCq4ysXS/QXKh8BGSFsrViH6pWzG0HaOMRtXufQx959QxW2SJvbLx
         4DNTcBc2PM6SBJ1o3XeyxrcH1XcyOUwILgINIjPFlsJydmRtz54Wz4op3B5uCptQrI/5
         Tv5rYTdzDg+TiqpmO5TbkaMelm22I1pIVKLC1poIzbTbJqZD3seH67YeOH0VIi+i+Jqi
         pnFesLaEROSNlCA5csN3wVq/VmU8ieUIjYtSXgdi75sbAgfS3Kgmmv3xd3yXB31sujOO
         687iRom7VdjihH3y96wF+HRdNpqRnZ4umzEXfjaJu+xm9keRuhdWbkTzwAxHCZTdU70h
         LzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=C7UvdYYJmrGSCrLuEWZGQzfQVEM11dnm8k5QtGn8BUQ=;
        b=RYuNViCjbYds/RpKU1HCHd4UNcoZmDrf55kwz1ZMu4+4mSECUDoqMldBJRKcW02Qy+
         u77e995iXMv2Jri0Xxbqot7oeC4uu14k113Q+iatDPlOJq/pvPkf4Z8HjOA/ErkPGaTv
         GtYtr3LZEcQ12WGy0vhI0hnP4d6sGNYJjbS0Vn4VUZ2ct4ggTVczYgNEbiHuPIFDWUJd
         lU7fTUeB1iPALMHq0ixUGqCgG2SnPtXbETuvZxvxfrGqI6Xh3ZknzauUd6NkQFxbZ5Ae
         uRTV/ZM+IylifVLjR1HoZeJ9e8t/CoCDEpJIF+j81bVASibBuzyPfzHrq1P/HgmwUWe2
         FB6w==
X-Gm-Message-State: AOUpUlH9SXkpCa3AFMQGX0wAaINXTx97trEHvnd9LsIK9kXhwtJVqOF5
        C8coPH0wCdBtgtICcYJY41o/G5BPGlWBbDeSLoqFk3X5RLU=
X-Google-Smtp-Source: AA+uWPwyki2Sb5e5vLK+i8yn36Q5iVLQoHeAir1akJjytQzcz+GqwBtjY20XA2s2AsKyuoXyLQ/V07dbiGzboerUjZI=
X-Received: by 2002:a1c:5bc7:: with SMTP id p190-v6mr2263651wmb.101.1533838344317;
 Thu, 09 Aug 2018 11:12:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:f00c:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 11:12:23 -0700 (PDT)
In-Reply-To: <xmqqftzncvxv.fsf@gitster-ct.c.googlers.com>
References: <cover.1533672584.git.jonathantanmy@google.com>
 <cover.1533767314.git.jonathantanmy@google.com> <3dab08e467c23f2c0785e34c3a8703d809b6479a.1533767314.git.jonathantanmy@google.com>
 <xmqqftzncvxv.fsf@gitster-ct.c.googlers.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Date:   Thu, 9 Aug 2018 11:12:23 -0700
Message-ID: <CAGf8dg+5ywyQVfuPfbRrKFdAatst25307ctQvkWqCDKHka7z4g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] repack: repack promisor objects if -a or -A is set
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 9, 2018 at 10:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Hmm, it is clever to auto-start the pack-objects (and notice there
> wasn't anything needing to pack).  Two things that are worth noting
> are:
>
>  - The code takes advantage of the fact that cmd.in being left as -1
>    is a sign that start_command() was never called (well, it could
>    be that it was called but failed to open pipe---but then we would
>    have died inside write_oid(), so we can ignore taht case).  This
>    is not relying on its implementation detail---cmd.in would be
>    replaced by a real fd to the pipe if start_command() was called.
>
>  - We know that pack-objects reads all its standard input through to
>    the EOF before emitting a single byte to its standard output, and
>    that is why we can use bidi pipe and not worry about deadlocking
>    caused by not reading from cmd.out at all (before closing cmd.in,
>    that is).
>
> So I kind of like the cleverness of the design of this code.

Thanks for checking this.

> For now, as we do not know what is the appropriate thing to leave in
> the file, empty is fine, but perhaps in the future we may want to
> carry forward the info from the existing .promisor file?  What does
> it initially contain?  Transport invoked with from_promisor bit
> seems to call index-pack with "--promisor" option with no argument,
> so this is probably in line with that.  Do we in the future need to
> teach "--promisor" option to pack-objects we invoke here, which will
> be passed to the index-pack it internally performs, so that we do
> not have to do this by hand here?

There might be more than one .promisor file that we are repacking, so
we would also have to deal with the order. It might be better to
document that the contents of .promisor files are lost upon repack.

> In any case, don't we need to update the doc for the "--promisor"
> option of "index-pack"?  The same comment for the new options added
> in the same topic, e.g. "--from-promisor" and "--no-dependents"
> options added to "fetch-pack".  It seems that the topic that ended
> at 0c16cd499d was done rather hastily and under-documented?

Yes, you're right - I'll make a patch documenting these.

>> @@ -440,6 +513,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>>
>>       /* End of pack replacement. */
>>
>> +     reprepare_packed_git(the_repository);
>> +
>
> I do not think this call hurts, but why does this become suddenly
> necessary with _this_ patch?  Is it an unrelated bugfix?

Hmm...I thought I mentioned somewhere that we need
reprepare_packed_git now because for_each_packed_object calls
prepare_packed_git, but apparently I didn't. I would add the following
to the commit message (if you'd rather not do it yourself, let me know
and I'll send a v3 with the new commit message):

Because for_each_packed_object() calls prepare_packed_git(), a call to
reprepare_packed_git() now has to be inserted after all the packfile
manipulation - if not, old information about packed objects would
remain in the_repository->objects->packed_git.
