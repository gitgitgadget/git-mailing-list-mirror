Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A3DE20D0D
	for <e@80x24.org>; Tue, 31 Jan 2017 01:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751110AbdAaBnH (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 20:43:07 -0500
Received: from mail-qt0-f180.google.com ([209.85.216.180]:34351 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbdAaBnG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 20:43:06 -0500
Received: by mail-qt0-f180.google.com with SMTP id w20so152463834qtb.1
        for <git@vger.kernel.org>; Mon, 30 Jan 2017 17:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TSnDVyRDltHfrNzdpEkGFmQHaSuNMILdWJn7a+Att88=;
        b=ra34v7HAxQqgubCSuwUdduTfHW02OBET40p1/XtYIuLXMgRDpYyhejO/6PozfR/cjP
         C5/BGzlxjTnRzjzX/7ZSA3OTIA55JGwILbkNhfGOnjeVO9nKotilPzkbHzjDceM2L89z
         rxWo4DlCqz+BVrNml+2i0KrlO/i634TjfmAyD8kUqRUvWS+g4+J+UHxSut5Ujiqg/Etf
         Wbjbtn0107bExO1NtRR0BNfEwVbcGPdWIVzy5uaL83jDDSbCcN2RB8mAarQNCo85Y3pa
         5A5d/hrl+sDmpsMjuDyy6hn5vjAaBPilf/oOOK0K4Ak0BHDpS14rrZsCZoJrrSMy9y1d
         mDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TSnDVyRDltHfrNzdpEkGFmQHaSuNMILdWJn7a+Att88=;
        b=pW0C9u/LMViWc1Y6hYU4EdnjHw9KKetTGUY8jaT1juk3+HArXkReDhZVUz0TGN0+3l
         4khq4cN9OOGRF+IbyG+i04b/KVVK8cBkSMh0Bcy+39GhMBE7ExqUMQw1q+6mg+DtZ+0o
         qSrtgsVXEsYZjDrOJAZHh/SJTjhX+NJ/6/cxCHJzWp3DgjMUe7hHPXtRfKXH/aoGJ/bC
         TQAHjE5K2tCwxadV5W3DDJjF34CJmjQyznLJXZYYOf4jB64AskL3XU042mmp3/4vmh4S
         JCcuwYIBhLv1eWvAeYsdNoH+oHGwzlQF8cHdtWjDxnNrl/UZ8XZ4sQ/ImOAZDOP18OKH
         OtRQ==
X-Gm-Message-State: AIkVDXLoguSvJNd9GWQrJEAJr48+zame7G+yLwXYphuevPq+GrgEphoQkmCd4++DZ1dEwggzFscGRimBT6UCAA==
X-Received: by 10.200.56.51 with SMTP id q48mr24921220qtb.189.1485826524394;
 Mon, 30 Jan 2017 17:35:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.45.226 with HTTP; Mon, 30 Jan 2017 17:35:23 -0800 (PST)
In-Reply-To: <20170130232559.krdxkt4dq4lfv4rj@sigill.intra.peff.net>
References: <CAOc6etaCk=OEyarMNhorM94MBnYRscCkJBM-K08snv1ecmOaPQ@mail.gmail.com>
 <20170128035321.yrcqwkg2fiwadxj4@sigill.intra.peff.net> <xmqqd1f4uug6.fsf@gitster.mtv.corp.google.com>
 <20170130232559.krdxkt4dq4lfv4rj@sigill.intra.peff.net>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Mon, 30 Jan 2017 19:35:23 -0600
Message-ID: <CAOc6etZZSgeBRwQA4C4Ag5A48W8tAAArdOaaKxkTOVvVGi+EpQ@mail.gmail.com>
Subject: Re: difflame
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm thinking of something like this:

Say I just discovered a problem in a file.... I want to see who worked
on it since some revision that I know is working fine (or even
something as generic as HEAD~100..). It could be a number of people
with different revisions. I would diff to see what changed.... and
blame the added lines (blame reverse to try to get as close as
possible with a single command in case I want to see what happened
with something that was deleted). If I could get blame information of
added/deleted lines in a single run, that would help a lot.

Lo and behold: difflame.



On Mon, Jan 30, 2017 at 5:26 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Jan 30, 2017 at 01:08:41PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>> > On Tue, Jan 17, 2017 at 11:24:02PM -0600, Edmundo Carmona Antoranz wrote:
>> >
>> >> For a very long time I had wanted to get the output of diff to include
>> >> blame information as well (to see when something was added/removed).
>> >
>> > This is something I've wanted, too. The trickiest part, though, is
>> > blaming deletions, because git-blame only tracks the origin of content,
>> > not the origin of a change.
>>
>> Hmph, this is a comment without looking at what difflame does
>> internally, so you can ignore me if I am misunderstood what problem
>> you are pointing out, but I am not sure how "tracks the origin of
>> content" could be a problem.
>>
>> If output from "git show" says this:
>>
>>       --- a/file
>>       +++ b/file
>>       @@ -1,5 +1,6 @@
>>        a
>>        b
>>       -c
>>       +C
>>       +D
>>        d
>>        e
>>
>> in order to annotate lines 'a', 'b', 'd', and 'e' for their origin,
>> you would run 'blame' on the commit the above output was taken from
>> (or its parent---they are in the context so either would be OK).
>>
>> You know where 'C' and 'D' came from already.  It's the commit you
>> are feeding "git show".
>
> I think the point (or at least as I understand it) is that the diff is
> not "git show" for a particular commit. It could be part of a much
> larger diff that covers many commits.
>
> As a non-hypothetical instance, I have a fork of git.git that has
> various enhancements. I want to feed those enhancements upstream. I need
> to know which commits should be cherry-picked to get those various
> enhancements.
>
> Looking at "log origin..fork" tells me too many commits, because it
> includes ones which aren't useful anymore. Either because they already
> went upstream, or because they were cherry-picked to the fork and their
> upstream counterparts merged (or even equivalent commits made upstream
> that obsoleted the features).
>
> Looking at "git diff origin fork" tells me what the actual differences
> are, but it doesn't show me which commits are responsible for them.
>
> I can "git blame" each individual line of the diff (starting with "fork"
> as the tip), but that doesn't work for lines that no longer exist (i.e.,
> when the interesting change is a deletion).
>
>> In order to run blame to find where 'c' came from, you need to start
>> at the _parent_ of the commit the above output came from, and the
>> hunk header shows which line range to find the final 'c'.
>
> So perhaps that explains my comment more. "blame" is not good for
> finding which commit took away a line. I've tried using "blame
> --reverse", but it shows you the parent of the commit you are looking
> for, which is slightly annoying. :)
>
> "git log -S" is probably a better tool for finding that.
>
> -Peff
