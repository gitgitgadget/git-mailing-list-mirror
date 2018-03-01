Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BFDC1F404
	for <e@80x24.org>; Thu,  1 Mar 2018 19:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161215AbeCAT0D (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 14:26:03 -0500
Received: from mail-oi0-f50.google.com ([209.85.218.50]:45459 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033435AbeCAT0C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 14:26:02 -0500
Received: by mail-oi0-f50.google.com with SMTP id j79so5328824oib.12
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 11:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clarifai.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uBuUY/5t02lwFnWevMSZJf7V8oXpVb/+GB66NEQV1A8=;
        b=dN5TCzqXZNe6HuB2mG0G4aJrdD6CZlt/OLttnfx2YEX9NgDNxaFfMWZn0Zx45wb2yn
         9f2Ce2JYDsWhu3QjRGsvVKy8OfaB6yLmFNPLs6J3qBsze9dMOXRfO0vqn6XWEzBuO9OV
         COeccZkMaLOrBO8ceYIGquAfxAwPFiIvKgkig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uBuUY/5t02lwFnWevMSZJf7V8oXpVb/+GB66NEQV1A8=;
        b=dDJigkCbEX6SvVEpVOu8b96jxAAdKojzDNe8wOPFVFzl2wK5gpStBuIXKS1FvulJs+
         bJFMcxkYYeZejvZPHjmI0UHEIqjgGWFx9/CH3MCAWBC6jB2aQ45K9mHo+ie1m+2cDZ5Z
         GXM9tlPA0kCdjSHWGbaW3W+/9GWQn/q/0i+0hBg50+QYuyFAXBx3jgm9C3/pO77CJUqR
         za3KghBTW6+0js8mQp3JyYgjy3MKsCHR+rpMy/PIXVDV4phMQgwNTK6PHsfGpedW6UyC
         50ap+e+RbvqBKXIAzPBV+caFTXsMuq1hM0VZe3GBa/5llw0cg34czIHcgj6CLXrOfbK1
         gmPw==
X-Gm-Message-State: AElRT7G5suqXOQ6AueoLY0UiU09rTRWbOsuAh0oiVkylXb3rILEFFuXr
        xzE6N8Vq0po5PS6F02Or4JgCaH+e3NODewdZdBXATg==
X-Google-Smtp-Source: AG47ELstTy+jZTwXBqg21Zlkm8flsuETgMKFdMqaZuas6qB88cSwU1rFl35SpZ16V2xPxcbzN0/QrqW/g7ZNqWDUDX4=
X-Received: by 10.202.77.7 with SMTP id a7mr1891127oib.160.1519932361123; Thu,
 01 Mar 2018 11:26:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.138.221 with HTTP; Thu, 1 Mar 2018 11:25:40 -0800 (PST)
In-Reply-To: <CAPFeJUCkcWMJMt6Eam3NrnYUWXgOS+GB695pzgL+QJsvgOgWWQ@mail.gmail.com>
References: <CAPFeJUAF99buo=yTZQeHawU-npLHk0iJ1iQxYwMroFdDcKhqjA@mail.gmail.com>
 <cc579f55-cb5c-d6fb-c03f-f180137e5c25@gmail.com> <CAPFeJUCkcWMJMt6Eam3NrnYUWXgOS+GB695pzgL+QJsvgOgWWQ@mail.gmail.com>
From:   Josh Tepper <josh@clarifai.com>
Date:   Thu, 1 Mar 2018 14:25:40 -0500
Message-ID: <CAPFeJUDz1GxCUSBzqsNH7wTynbb1Ma03=cOfY0G3frGDCs7H+Q@mail.gmail.com>
Subject: Re: Bug: git log: boundary commits do not respect order (e.g.
 date-order, topo-order) 2
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I just wanted to follow up -- what do you think?

On Thu, Feb 22, 2018 at 9:21 PM, Josh Tepper <josh@clarifai.com> wrote:
> My use case is that when combined with --graph, the ordering is
> necessary to render a reasonable looking commit graph; by placing the
> commits at the end, each boundary commit essentially produces another
> vertical line all the way to the bottom where the commits reside.
> More specifically, the case where I noticed this was:
>
> git log --boundary --graph ^master feature
>
> which will have one vertical line going all the way to the bottom for
> each merge from master into feature.
>
> Another issue that I've noticed is that if one is using
> --show-linear-break (instead of --graph), the linear breaks are
> missing between the boundary commits and the other commits.
>
> Regarding the documentation, while it doesn't explicitly say where the
> boundary commits will be ordered with the other commits (nor does it
> say that they'll have accurate linear breaks), the documentation for
> the order flags (and for the linear break flag) makes no mention that
> certain commits are excluded.  The implicit understanding of the
> documentation for --date-order is that it will apply to all of the
> commits.  Certainly, if you add the flag --full-history, one expects
> the ordering to apply to the additionally traversed commits.  I
> suppose boundary commits are a little different since they're not
> explicitly part of the range -- nonetheless I expected them to be
> treated similarly.
>
> Maybe this could at least be documented?
>
> Best,
> ~Josh
>
> On Thu, Feb 22, 2018 at 2:29 PM, Derrick Stolee <stolee@gmail.com> wrote:
>> On 2/21/2018 6:57 PM, Josh Tepper wrote:
>>>
>>> When using git log, boundary commits (ie, those commits added by
>>> specifying --boundary) do not respect the order (e.g., --date-order,
>>> --topo-order).  Consider the following commit history, where number
>>> indicates the order of the commit timestamps:
>>>
>>> <view with a fixed with font! 3's ancestor is 1, 6's ancestors are 4,5>
>>> 0----1----2----5  <--A
>>>         \         \
>>>           3----4----6  <--B
>>>
>>>
>>> Executing the following command:
>>>
>>> $ git log --boundary --date-order ^A B
>>>
>>> Should produce the following order (boundary commits shown with dashes):
>>> 6 -5 4 3 -1
>>>
>>> However, it in fact produces:
>>> 6 4 3 -5 -1
>>>
>>> Please advise.
>>>
>>
>> Hi Josh,
>>
>> Looking at the docs [1], I don't see any specifics on how the boundary
>> commits should be ordered.
>>
>> Clearly, the implementation specifies that the boundary is written after all
>> other commits. For a full discussion of this, see the commit message for
>> 86ab4906a7c "revision walker: Fix --boundary when limited". Here is an
>> excerpt:
>>
>>      - After get_revision() finishes giving out all the positive
>>        commits, if we are doing the boundary processing, we look at
>>        the parents that we marked as potential boundaries earlier,
>>        see if they are really boundaries, and give them out.
>>
>> The boundary commits are correctly sorted by topo-order among themselves as
>> of commit 4603ec0f960 "get_revision(): honor the topo_order flag for
>> boundary commits".
>>
>> So, I'm not sure that this is a bug (it is working "as designed") but it
>> certainly is non-obvious behavior.
>>
>> In what use case do you need these boundary commits to appear earlier?
>>
>> Thanks,
>> -Stolee
>>
>> [1] https://git-scm.com/docs/git-log
>>
>>
