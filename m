Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFA6621847
	for <e@80x24.org>; Wed,  2 May 2018 14:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751246AbeEBOdL (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 10:33:11 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:34695 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750936AbeEBOdK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 10:33:10 -0400
Received: by mail-qt0-f181.google.com with SMTP id m5-v6so18645221qti.1
        for <git@vger.kernel.org>; Wed, 02 May 2018 07:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WARlFoT5g95e92n/IjmGhNteawYDuFBeAfk/5GGoUfA=;
        b=VccqcKv5Yqx80eDfIrwV7N6FwrtxhNregFE74psDiiKgQFwy9orVP75BOM/QCxt184
         7nBnRJ4q5O/tigtMy1StKZ2RsDWWpeVuoVDKoTFHJ3fD5x//Vh4k1twK3rRA3qCtOWsp
         hJiO+u6oGMNxxakqr9wI7ICjVogr8vp5nPLz0MyPJxh+SHCkTJk/oy8Y7lS8HpqIy21l
         Ckl6mEqDYAjUP0xDYntIeuRSsYx+6UjqGWXXbzsJrdTqSAAdN4WLpRPHg7MgtuqLEXDT
         iBOvE57fqOOX2msK3tAnRHo8KBrjfD7IimFExEJoLZW39/h7ggzNqNhaFbhWDpPovW3Y
         KPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WARlFoT5g95e92n/IjmGhNteawYDuFBeAfk/5GGoUfA=;
        b=ugZHxXOr1mEBN83hC9ga2GcCWyC+VpeZhFYvZEfeJcNDS0KpzPOAHBm8a4IDbNN11m
         mJ8hyBSkwvYuqTEC2+dRdRm3g6ZAdBZi04aTvfMikIvHXXgMTmCC5ZMrdOSX9ggDCwU6
         9IoqK0bu76xUOSUIom4u22k1rZRS1w4arhk9HTDqUVTCXAqVHjIBsTR/QZZYfiFpOV5b
         KFkUzD9WNmlD6sox3ppHDxLHXn4D2wTssskRCDsZmlLgFRvtqbj6y427NLN8bPq8V+L5
         iGPDeAAHZ3emqxN0N+oQx4Ft7NU3a+Dz+/TrFQ7216roy+9lIcnoMfhYTvgCZ7vDV+yM
         uHyQ==
X-Gm-Message-State: ALQs6tB2vCCnYIO+Aej8fVKMWR/EKw9sgL58MDDW+Ki2uDvA2c2D0cse
        XSPGJKjrWTumS80g/lcf+JU=
X-Google-Smtp-Source: AB8JxZoH5ohi4Xn4gZT+KfdUXFJghyX9szk6NQiPgjIxXb2dwOPp4giv6Vx5CbAwDMtUU9xytNtu7w==
X-Received: by 2002:ac8:3a64:: with SMTP id w91-v6mr17223029qte.339.1525271589728;
        Wed, 02 May 2018 07:33:09 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id o17sm10057273qki.60.2018.05.02.07.33.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 May 2018 07:33:09 -0700 (PDT)
Subject: Re:
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren <newren@palantir.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Eckhard_Maa=c3=9f?= <eckhard.s.maass@googlemail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kevin Willford <kewillf@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmc=?= =?UTF-8?B?4buNYw==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Miklos Vajna <vmiklos@frugalware.org>
References: <7de8f144-8a37-e471-48e8-0b6f17a7bf29@gmail.com>
 <20180427181937.7607-1-newren@palantir.com>
 <e753d8fd-5329-b819-0076-0ff4659dabf1@gmail.com>
 <CABPp-BEC2cnpdvDsMPFodvNR06G5E434Hpdmaex+6+zHpYm_QQ@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <c5c262f7-c24e-46bf-e9c8-24b322543711@gmail.com>
Date:   Wed, 2 May 2018 10:33:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BEC2cnpdvDsMPFodvNR06G5E434Hpdmaex+6+zHpYm_QQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/30/2018 12:12 PM, Elijah Newren wrote:
> On Mon, Apr 30, 2018 at 6:11 AM, Ben Peart <peartben@gmail.com> wrote:
>> On 4/27/2018 2:19 PM, Elijah Newren wrote:
>>>
>>> From: Elijah Newren <newren@gmail.com>
>>>
>>> On Thu, Apr 26, 2018 at 5:54 PM, Ben Peart <peartben@gmail.com> wrote:
>>>
>>>> Can you write the documentation that clearly explains the exact behavior
>>>> you
>>>> want?  That would kill two birds with one stone... :)
>>>
>>>
>>> Sure, something like the following is what I envision, and I've tried to
>>> include the suggestion from Junio to document the copy behavior in the
>>> merge-recursive documentation.
>>>
> <snip>
>>
>> Thanks Elijah. I've applied this patch and reviewed and tested it.  It works
>> and addresses the concerns around the settings inheritance from
>> diff.renames.  I still _prefer_ the simpler model that doesn't do the
>> partial inheritance but I can use this model as well.
>>
>> I'm unsure on the protocol here.  Should I incorporate this patch and submit
>> a reroll or can it just be applied as is?
> 
> I suspect you'll want to re-roll anyway, to base your series on
> en/rename-directory-detection-reboot instead of on master.  (Junio
> plans to merge it down to next, and your series has four different
> merge conflicts with it.)
> 
> There are two other loose ends with this series that Junio will need
> to weigh in on:
> 
> - I'm obviously a strong proponent of the inherited setting, but Junio
> may change his mind after reading Dscho's arguments against it (or
> after reading my arguments for it).
> 
> - I like the setting as-is, and think we could allow a "copy" setting
> for merge.renames to specify that the post-merge diffstat should
> detect copies (not part of your series, but a useful addition I'd like
> to tackle afterwards).  However, Junio had comments in
> xmqqwox19ohw.fsf@gitster-ct.c.googlers.com about merge.renames
> handling the scoring as well, like -Xfind-renames.  Those sound
> incompatible to me for a single setting, and I'm unsure if Junio would
> resolve them the way I do or still feels strongly about the scoring.
> 

I think this patch series (including Elijah's fixup!) improves the 
situation from where we were and it provides the necessary functionality 
to solve the problem I started out to solve.  While there are other 
changes that could be made, I think they should be done in separate 
follow up patches.

I'm happy to reroll this incorporating the fixup! so that we can make 
progress.  Junio, would you prefer I reroll this based on 
en/rename-directory-detection-reboot or master?
