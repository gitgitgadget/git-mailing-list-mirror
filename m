Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01A0E2021E
	for <e@80x24.org>; Tue, 15 Nov 2016 19:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754596AbcKOTcu (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 14:32:50 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34146 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752703AbcKOTct (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 14:32:49 -0500
Received: by mail-vk0-f66.google.com with SMTP id p9so9951277vkd.1
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 11:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4ki4WVKfPIl2KA6XV3FICAo8w/q55RklyCE4f2SY/go=;
        b=zcU0P42DCJtAybGcsNFAOota3qxUMyOSkuXv/J0QjtdZs0lu6sIfHz/aA2TGWyJsPj
         WkQerTYlQ3t7GfEZHuAXDx8oX6XdPqkeLYDzXPDGoqLEp6eDD8rKAINKRL7Zh4GyeLwq
         WUYY4Uu72C2oZ3PBCWbLZGnoqhnIUOdqTxWyZFWFCkTSs8+mWSPo+up8sz+wKsTHtsnX
         cBnRDlNMco8wpsDMXmHBujfgsA2jVyhVzZdni9t0e0FNDg8tZjbhdm+15uGk0BKVu2oe
         oNWF0UtWD0w2rSTJxf1nmeaUQC3DD6AZH+Bpqj5YZSy1fkr4xn3Jp90n+UKHfNXW2J3c
         nClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4ki4WVKfPIl2KA6XV3FICAo8w/q55RklyCE4f2SY/go=;
        b=ktr+fjKISCDkOzyAJX4WuKy5S7gXDFArh+TX0CU9Sr6q1kW4+6NtFMZGnrG+k8kwy/
         fDJh+3Gq6NIBQraQ1wU15SUCac6+ki2hhxUYH+9he3dl2YePbfWl98oe7fRRtTwHIZ+P
         hZIh/1Ch8j1y+rpGSEWKdCWRVRDVbddcHeSYYgrFRxztu2XtS5cP8p21thfUHm0TcH1D
         dYMeFczrCJqrxnn7IBvqKOG4jQeNOjJBARsqUBTi8a3nrAIL+V8mylprM4XYm0J+Y/ZJ
         q0SVtXWVYh9HMQwTGxnWv3qEbXXwW2Fz8G5XwDjMlf5IVrT9wbpMubetoxn6b5BpAiCL
         7SpA==
X-Gm-Message-State: ABUngveDYrWiPeu4LPl0KKPVyvdIvwta+sYFgybC7sZ9ig3OZ3XbTYA56Bw3WnNPXdhr9p8fG9SXycbi62qvbg==
X-Received: by 10.31.97.1 with SMTP id v1mr14340585vkb.108.1479238368658; Tue,
 15 Nov 2016 11:32:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.24.69 with HTTP; Tue, 15 Nov 2016 11:32:48 -0800 (PST)
In-Reply-To: <xmqqr36ctw47.fsf@gitster.mtv.corp.google.com>
References: <CALj-rGcSrbAiyxPOYD1KCacK_gqi3T5_R=e0H_UfBTqLb5VRmg@mail.gmail.com>
 <CALj-rGdRDa0EU6AeMHWYketr5QBOnV7-3RKraiuPCk=Aepz=pQ@mail.gmail.com> <xmqqr36ctw47.fsf@gitster.mtv.corp.google.com>
From:   John Rood <mr.john.rood@gmail.com>
Date:   Tue, 15 Nov 2016 13:32:48 -0600
Message-ID: <CALj-rGeXEQ6wtxHq3ZN29AD5AjNExrF7RUbvhS=oBRtqaQ-n=Q@mail.gmail.com>
Subject: Re: ignore blank line removals
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yes that makes sense.
I was not aware of custom merge drivers, but indeed that may address
my situation. I'll look into it.
Thanks!

On Tue, Nov 15, 2016 at 12:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> John Rood <mr.john.rood@gmail.com> writes:
>
>> On Thu, Nov 3, 2016 at 10:57 AM, John Rood <mr.john.rood@gmail.com> wrote:
>>> If the contents of a file initially are:
>>>   one
>>>
>>>   three
>>> and on branch A there is a commit, removing the blank line:
>>>   one
>>>   three
>>> and on branch B there is a commit, adding 'two':
>>>   one
>>>   two
>>>   three
>>> Normally, if you try to merge A into B (or B into A), git recognizes a
>>> decision needs to be made between removing the second line or add
>>> "two" to the second line. It would be convenient to have a merge
>>> strategy that defaults to the latter in cases where the removed line
>>> was a blank line (or a line containing only whitespace) ...something
>>> like -Xignore-blank-line-removals.
>>
>> Is there any push-back on this, or is there a backlog that we can add
>> this feature to?
>
> If you mean by "push-back" objections that say "this feature is evil
> and should not be added to Git, ever", I do not think we saw any on
> the list.  The lack of response is most likely that everybody
> thought "Meh." aka "It is not useful/interesting/valuable enough
> feature to bother discussing."
>
> One thing I wondered was what you would want if the contents were
> one/three without blank, A added blank between the two and B
> replaced blank with two.  As your example shows, in the filetype you
> are dealing with, a blank line has no significant meaning (otherwise
> you won't be ignoring the change A made to remove the blank in your
> original example).  The outcome desired by you may be one/two/three
> without any blank in that case because of that.  Which would lead to
> the suspicion that ignore-blank-line-removals is not a good general
> feature (i.e. in this other example, you want to ignore blank line
> addition).  Which further leads to the suspicion that the desire you
> expressed in the original post is not well thought through to be a
> useful specifification to build anything out of (yet), but is merely
> a potentially interesting discussion starter.  And nobody so far
> found it interesting enough to spend time discussing it further to
> make the wish detailed enough to be called a "design" of a new
> feature.
>
> Having said all that.
>
> I suspect that you may not have to make any change to Git to do what
> you want; can't you just use the 'merge' attribute with a custom
> 3-way merge driver that removes an empty line?
>
