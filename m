Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78C5A20D09
	for <e@80x24.org>; Tue,  6 Jun 2017 06:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751294AbdFFGwa (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 02:52:30 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:33512 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750933AbdFFGwa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 02:52:30 -0400
Received: by mail-lf0-f43.google.com with SMTP id a136so67516021lfa.0
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 23:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Mhd/IZGVyvE13iZoP7Oqq7rPJb16FD1axaONabRtNSI=;
        b=PCmGc8eazq8wxZbi1YkTXojCfuSwDnwn2ooAS+nLQgK2c9DXgXQkHllt3HjcX1ybdI
         rd15oDsGupJrL1iANFphMsvBFwaprPBqsCu9t8nnITHr69HgpD9DLH+z4JxgeSd9QbRn
         NXx9MgCxseLLpDbg7p2don4jG6UloNjeGDeQ0TRIjckK5omzl/FQw9tUNrDVNRyG7f+k
         yszWbsXV6kI6lQZPyN6KhlXaoaSKeuIjs1Q+0ZvnZPntdvxtd0AKMY4fhjKJxYN1jCDs
         +jBM/BQmWEoh3pE8qTvIfGuDWeMqmMFXwrQVX7bqi9M/eUQoLN9L69AHi9HyS8ZUrjyX
         F/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Mhd/IZGVyvE13iZoP7Oqq7rPJb16FD1axaONabRtNSI=;
        b=UMH78ReBy0PEWF9+lj5b4SnY55HWvbPb81NafXRybUYB3VFc3C6kNo6tNvC8YyMafB
         LJd6JIe4HJXemAa8qrC9DkrsWYCQqrLwzGW0OsqKUUg9SyO88VwKmfr57b7miSMEGISj
         W2vl9WLOL1ZSUOqzXyh2lXOeKrNlQ15cs+dVzjg4TyO2wQMpI28tMUHKnGfu+qCtiB5V
         +Zvj3Zovx2t0cPFvXcJ9QnoUl/UCOwiKjhAJJAEEm5wayoFoBxGz8R1foAMLJ9Gw42pn
         HNtmvqYrsHpUHbxfmZfoYf7jBgXobXmnFPHUdBIbq6NIzzQLUTR3wX35WMZFqUf1/QiP
         f5JA==
X-Gm-Message-State: AODbwcAZubFsw9r8FhWcdpI+hbW6U0oAU6gpDsYbQOOSZwlT0M2FQQ0F
        o8+M3AP7JAK7EJogtEIxD/AHR4yA8g==
X-Received: by 10.25.99.21 with SMTP id x21mr4242767lfb.66.1496731948360; Mon,
 05 Jun 2017 23:52:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.32.133 with HTTP; Mon, 5 Jun 2017 23:52:07 -0700 (PDT)
In-Reply-To: <xmqq8tl5apkk.fsf@gitster.mtv.corp.google.com>
References: <xmqq1sqzkrui.fsf@gitster.mtv.corp.google.com> <CAGZ79kY2Z-fJYxczbzheu1hChLkKkdjEcDMwsP-hkN0TjUBotQ@mail.gmail.com>
 <xmqq8tl5apkk.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 5 Jun 2017 23:52:07 -0700
Message-ID: <CA+P7+xpvZDHum-A4omMySTebgBLFzhkpD=DiL-_Mm_Qv-OkMaw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2017, #03; Mon, 5)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 5, 2017 at 6:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>>  "git diff" has been taught to optionally paint new lines that are
>>>  the same as deleted lines elsewhere differently from genuinely new
>>>  lines.
>>>
>>>  Are we happy with these changes?
>>
>> I advertised this series e.g. for reviewing Brandons
>> repo object refactoring series and used it myself to inspect
>> some patches there[1]. I am certainly happy (but biased) with
>> what we have available there.
>>
>> Jacob intended to use this series
>> for review as well, but has given no opinion yet.
>>
>> You seemed to have used it for js/blame-lib?
>>
>> --
>> Those patches had a wide reviewer audience cc'd,
>> so I would think people are aware of this series.
>
> I tried to, yes.  I haven't had a chance to see how well the current
> iteration fares "does the externally-visible goal make sense?" test.
>
> I do not think I saw a negative "an approach to show this kind of
> output would not be useful" reaction, so I assume at least people
> would want an alternative output format that would help reviewing a
> change that moves blocks of lines around.
>
> In any case, that is not a review.  A patch series wanting to do a
> good thing, and people agreeing that the externally visible effect
> it produces matches that good thing, is one thing.  A review that
> makes sure the code achieves the externally visible effect well
> (e.g. without overly inefficient algorithm, without buffer overflows
> or underflows, off-by-ones, etc.) is another thing, and I haven't
> seen anybody going with fine toothed comb to do that kind of review,
> hence my "are we happy?" inquiry.
>

I will try to find some time tomorrow to go over it in detail.

Thanks,
Jake
