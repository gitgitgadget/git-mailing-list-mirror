Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4378B20986
	for <e@80x24.org>; Tue, 27 Sep 2016 20:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935513AbcI0Uc6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 16:32:58 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:34243 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932747AbcI0Uc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 16:32:56 -0400
Received: by mail-it0-f53.google.com with SMTP id 15so21046454ita.1
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 13:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IZ1jnXj2vWMOknNvFo++cV2jKkieHFQdyrdgyf1EasU=;
        b=S1I/Tf9Q5sl4hcU4S3ltVeEa9M/5NMTY9SSjF0bODrdSiHR+WBFEyyc0eEpOpiyW38
         8xfUxAqMKf04isKtJibeoMu8b6eYV5Y6qMosaYZXPfZjIyrEOjH4AsbmGxVL+H+4xAp9
         lat1reUuPbNm7IWuiZ0Na8gOYomRlTgjRHSXmBys+fkxniAs6ei2NodCutECmM9TjP2o
         TG+82h0m9nH4+Ewwa93gpUc0gUEt1zT4O13Rwfwlmh+vQYfStRnF6U/KYL6srW7vgKOw
         T3NQrfYR77H5X33mu26E5w/DVSVEBrXSsbDeDPfq1tFcuJmdM6OEIT58SIaShmFasvNd
         JS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IZ1jnXj2vWMOknNvFo++cV2jKkieHFQdyrdgyf1EasU=;
        b=jgMyBQmejrzsIEBvO/+nOyO7aQyMb7LvGYEUG5Hf3uOFqqItjTCTO+vb+5SW57yGAc
         DbUPuu9HbHhZnr2oMpXhJISitwrXh6ChvVPimwDDKhk9XrPJmnK5q3U69gBetxP3te2R
         IEj7kOTtkgKVEHjp8QRmTXXVoCWf29dx2+oM+/2D2YujYirW/j6hNn7PDkr2k39pK4FO
         JVP4hncZsfqPftFeBbZXGcqQyFr/7xUCyZJnwdEx+jYeiL3yarK3u/O/G8Qj5hdoV/ku
         cnkpfdQmBIfo0pB2jUelS5fpbz3oFAu1QkuUeVakShk9LbFMjIEWR/MLjceal3z1SRhx
         pWFw==
X-Gm-Message-State: AA6/9RkwA+KwaAwT0Z+ly+lxYI1HDcE4ev9rdQ5kOVo8IKATckUAb/wCbJCdcYtz6ONE+TRHXK+GZGa6f6vrXw==
X-Received: by 10.36.3.76 with SMTP id e73mr6995817ite.42.1475008374735; Tue,
 27 Sep 2016 13:32:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.27.131 with HTTP; Tue, 27 Sep 2016 13:32:54 -0700 (PDT)
In-Reply-To: <xmqq1t05qoad.fsf@gitster.mtv.corp.google.com>
References: <201609271240.19759.sweet_f_a@gmx.de> <010201576bfb6c7d-0b68228f-9503-4dd1-9721-713477fa2596-000000@eu-west-1.amazonses.com>
 <xmqq1t05qoad.fsf@gitster.mtv.corp.google.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Wed, 28 Sep 2016 02:02:54 +0530
Message-ID: <CAFZEwPPev-fxev0jHsdj3MbtpX=SMFJ3gTjeJ2Uz8vcuknAL3w@mail.gmail.com>
Subject: Re: [PATCH] rev-list-options: clarify the usage of -n/--max-number
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Junio,

On Tue, Sep 27, 2016 at 10:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> -n=<number>, -<number>, --max-number=<number> shows the last n commits
>> specified in <number> irrespective of whether --reverse is used or not.
>> With --reverse, it just shows the last n commits in reverse order.
>
> I think it is easier to understand if you updated the description of
> "--reverse", rather than "-<n>".  "rev-list -n $N" that stops after
> showing $N commits is something everybody understands.  What often
> dissapoints some users is that "--reverse" kicks in _after_ what
> commits are to be shown are decided.

True.

>>  Documentation/rev-list-options.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
>> index 7e462d3..6b7c2e5 100644
>> --- a/Documentation/rev-list-options.txt
>> +++ b/Documentation/rev-list-options.txt
>> @@ -18,7 +18,7 @@ ordering and formatting options, such as `--reverse`.
>>  -<number>::
>>  -n <number>::
>>  --max-count=<number>::
>> -     Limit the number of commits to output.
>> +     Limit to last n number of commits to output specified in <number>.
>
> These essentially say the same thing.  The original does not mention
> where and how <number> is used, but "Limit the number of commits" as
> a description for "-<number>" would be understood by anybody halfway
> intelligent that the given number is used as that limit, so I do not
> think an updated description is making it easier to understand.

To clear out that confused I used the word "last" but I can now
understand that it can be easily misunderstood.

> There is a paragraph of interest in an earlier part of "Commit
> Limiting" section (which is the section "-n" appears in, among other
> options):
>
>     Note that these are applied before commit
>     ordering and formatting options, such as `--reverse`.
>
> So the documentation already makes an attempt to avoid confusion
> Ruediger saw, i.e. "rev-list traverses, limits the output to N, and
> then shows these N commits in reverse" is what it expects readers to
> understand, and that it also expects it would lead naturally to
> "these N commits are still from the newest part of the history,
> hence 'rev-list --reverse -n N' is not how you grab the earliest N".

It surely does :)

> But apparently the attempt by the current documentation is not
> enough.  Let's see how it describes the '--reverse' option:
>
>     Commit Ordering
>     ~~~~~~~~~~~~~~~
>
>     By default, the commits are shown in reverse chronological order.
>     ...
>
>     --reverse::
>             Output the commits in reverse order.
>             Cannot be combined with `--walk-reflogs`.
>
> Perhaps "Output the commits chosen to be shown (see Commit Limiting
> section above) in reverse order." would make it clearer?

That would be a much better edit. Thanks! Will send out a re-roll.

Regards,
Pranit Bauva
