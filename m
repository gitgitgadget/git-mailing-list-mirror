Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00B411FC46
	for <e@80x24.org>; Tue,  7 Feb 2017 19:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755390AbdBGTSp (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 14:18:45 -0500
Received: from mail-lf0-f52.google.com ([209.85.215.52]:35187 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755096AbdBGTSn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 14:18:43 -0500
Received: by mail-lf0-f52.google.com with SMTP id n124so68745894lfd.2
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 11:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NQWMZlVQAhlwfFGVX64P7MO0VhiP7/erZTFwkalOvIg=;
        b=dwn7OALEQPxM7i7PW+IgAXr1bpeY7AFdMQqPyB3s//dlsZ3l5ApGswMpGqT7P0ZDIh
         wGJMg8xqpb38/+BZrabDORD1kVorpwvpwNw5UoArrqwSThVFYElNvdDjRqFB/0U/2l4r
         zZYAezy8+G6k+f34u18XJUvWrQSUFOhOun5yTctCYTLfj25DGA9qDdkU3kRiyTroXjXc
         JN0x5ojF3CoYJo0rNVYu5+KFvS3VveWGFp9Uuq+7Kj5Dvd5dFnnxm859dLmTFHF4A8Fj
         gLIlRC8uZmzT6XP9D1tKv0ivgHO0XgYyUCQ66GR/qlYRLapnNuLjZ1M9ii8/KQW+3S2W
         J0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NQWMZlVQAhlwfFGVX64P7MO0VhiP7/erZTFwkalOvIg=;
        b=RqJYu89h0eaqsawsNv8eUkTOkrGcMafrgqsMOHBHBMbyk/mrvxD56dcn4u4u8+vIKi
         tjvQrLBlKrUYC6zUIiberHTo3ZUB3ZbQxHX+BEUzFAYr41XpeK4IYXef8kTgOUYGXcYb
         JXkqhkfxqhNNHnaX8grLy6SOn/54OnptaLXn1E0JnyOQyBT/EgrWxHaT12V+FkIIv8U1
         5J1etB06RRlnmLKHEh8RIG4knaOJZlK1LLF9236gV8XrbT1x7VsTSDojqfmS5rJD7jsG
         MzHf8lXTMdSERbSF76zkmGa/VCWT3vfGl2bQO8MlAjJKCBi4uNsRvLR3eQZmcx9Ytnxf
         de/g==
X-Gm-Message-State: AIkVDXLHL1iseTGHm5xfOLxeO9tSDZ/TYPKS08lmHSCtzfERwKB+L9PG2eSBPJFQXo2TMdFA2aNddFRzS0wJkQ==
X-Received: by 10.25.141.12 with SMTP id p12mr6508922lfd.147.1486495121857;
 Tue, 07 Feb 2017 11:18:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Tue, 7 Feb 2017 11:18:21 -0800 (PST)
In-Reply-To: <CAJZjrdWbqvBRtyyfhgAt1E9ZdTUaz+Zpk7iGasNoeSuFJbsKog@mail.gmail.com>
References: <CANOj2JG5VuDtS30PfOrZ=4q8pTv_frY7=p+0g=UW3yV6ev+1KQ@mail.gmail.com>
 <CABURp0qbKMfngfsC5pQeO+qyRPxa21vi090hMWDtLd+BBH_3Jg@mail.gmail.com> <CAJZjrdWbqvBRtyyfhgAt1E9ZdTUaz+Zpk7iGasNoeSuFJbsKog@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 7 Feb 2017 11:18:21 -0800
Message-ID: <CA+P7+xoZHOtURfbBbHHTpC3DsGxaGOVToqmW5wTg2EniRpL-Cg@mail.gmail.com>
Subject: Re: Request re git status
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     Phil Hord <phil.hord@gmail.com>, Ron Pero <rpero@magnadev.com>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 7, 2017 at 6:54 AM, Samuel Lijin <sxlijin@gmail.com> wrote:
> On Mon, Feb 6, 2017 at 6:45 PM, Phil Hord <phil.hord@gmail.com> wrote:
>> On Mon, Feb 6, 2017 at 3:36 PM Ron Pero <rpero@magnadev.com> wrote:
>>> I almost got bit by git: I knew there were changes on the remote
>>> server, but git status said I was uptodate with the remote.
>>>
>>
>> Do you mean you almost pushed some changed history with "--force"
>> which would have lost others' changes?  Use of this option is
>> discouraged on shared branches for this very reason.  But if you do
>> use it, the remote will tell you the hash of the old branch so you can
>> undo the damage.
>>
>> But if you did not use --force, then you were not in danger of being
>> bit.  Git would have prevented the push in that case.
>>
>>
>>> Why ... not design it to [optionally] DO a fetch and THEN declare
>>> whether it is up to date?
>>
>> It's because `git status` does not talk to the remote server, by
>> design.  The only Git commands that do talk to the remote are push,
>> pull and fetch.  All the rest work off-line and they do so
>> consistently.
>>
>> Imagine `git status` did what you requested; that is, it first did a
>> fetch and then reported the status.  Suppose someone pushed a commit
>> to the remote immediately after your fetch completed.  Now git will
>> still report "up to date" but it will be wrong as soon as the remote
>> finishes adding the new push.  Yet the "up to date" message will
>> remain on your console, lying to you.  If you leave and come back in
>> two days, the message will remain there even if it is no longer
>> correct.
>>
>> So you should accept that `git status` tells you the status with
>> respect to your most recent fetch, and that you are responsible for
>> the timing of the most recent fetch.  To have git try to do otherwise
>> would be misleading.
>
> This argument doesn't work for me. Race conditions in *any*
> asynchronous work flow are inevitable; in commits, particularly to a
> shared branch, I also can't imagine them being common. It's like
> saying because there's lag between the remote's response and the
> output on the local, `git fetch` shouldn't bother saying that the
> local remote has been updated.
>
> It wouldn't be hard, though, to define an alias that fetches the
> remote-tracking branch and then reports the status.
>
> Nevertheless, this is one of those cases where I think Git suffers
> from a poor UI/UX - it's letting the underlying model define the
> behavior, rather than using the underlying model to drive the
> behavior.
>

Personally, I think that the fact that Git forces the user to think
about it in terms of "oh I have to fetch" instead of that happening
automatically, it helps teach the model to the user. If it happened in
the background then the user might not be confronted with the
distributed nature of the tool.

An alias to fetch and then show status is very straight forward, and
you can do so locally if you want.

Thanks,
Jake
