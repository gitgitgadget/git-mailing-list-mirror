Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A2151F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 14:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751753AbdFIOdM (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 10:33:12 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34205 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751742AbdFIOdK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 10:33:10 -0400
Received: by mail-wr0-f193.google.com with SMTP id u101so7225896wrc.1
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 07:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UHWlTCiBsa5tTA1ujHSVXI7/vlt0oAmRoH0bJGTdnNw=;
        b=i8UNYpGuro9kvibVkSXGQFi0Ldnmb7a/Bhj+R6vQcBPle6b3TOxWIhumTTDl6vCiD8
         0RI6lsnGXk2PC9gRslt8RPmZRzVSt5bHi0VTllkE/bNXQNQL5+xGE85lTpP7Cg+gl5gq
         whr86X0XKRjzoRKwBWfHAJiX/wycTvcoGhRZFbkjWhvKX2LWJqlAsqssIvJy1g+fh2Gr
         PEVwOq0C5CVv5tPvgHfFP9mtNcH/3yQ/KUGSGfciQ4b9x/6a0E8kJAxup22cvrhWFuok
         WhXPuqnV9RxwIEj/x8vZMu4BUZC0mDyw6q6mPv/BxAE/8grTP4LQZKrUDwEoV8m2Wn25
         UT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UHWlTCiBsa5tTA1ujHSVXI7/vlt0oAmRoH0bJGTdnNw=;
        b=J0V49cepl5Msl1B44N3RY+huwFW9v0C7DdW+P1RjrQpl4vlmXLQFHprYicuq3bEwRu
         MvoDT1GlUbwmiVTKBeGi2MwCRzgGl3islY+yip3Qfi5tH6c4F34R4p40eDH6APQYqvG9
         X8JJdUJGbPh9oCkmg2d20rNGgz1AGdb7hFLUOZpOo5r1kFX9g5VD6XkirYN6xhZm+OCb
         FK+aRq1R0ZP+s43wwCEhZJ+af/Ru49tIk5BckHIyc4x1YuGmkh/H+Ix9MNmYtwmev58D
         /byuFM41p/k4utWezOem4yQoK4P1o+ECbbKm57M38PSJMqqzdnON0OcnVwwhVnePGsmL
         74tQ==
X-Gm-Message-State: AODbwcDDTpGRhBj6ii2bHvP69SsYVL1P4jqbeK5UQOAKVpnKFadKE6l4
        mVAY3GtKVvx81+h9
X-Received: by 10.28.91.80 with SMTP id p77mr7505267wmb.84.1497018788959;
        Fri, 09 Jun 2017 07:33:08 -0700 (PDT)
Received: from ?IPv6:2001:a61:3406:f800:9008:1841:1ac1:dc4a? ([2001:a61:3406:f800:9008:1841:1ac1:dc4a])
        by smtp.googlemail.com with ESMTPSA id 187sm2106677wmu.23.2017.06.09.07.33.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jun 2017 07:33:07 -0700 (PDT)
Subject: Re: [PATCH 2/2] add [--] to usage of filter-branch
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20170603101755.13619-1-asheiduk@gmail.com>
 <20170603101755.13619-2-asheiduk@gmail.com>
 <ef30e8f5-8206-7b42-e229-6cd4b0492e76@gmail.com>
 <xmqqk24l717a.fsf@gitster.mtv.corp.google.com>
From:   Andreas Heiduk <asheiduk@gmail.com>
Message-ID: <243a8308-6696-1494-49e9-ccd01acfaa46@gmail.com>
Date:   Fri, 9 Jun 2017 16:33:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqk24l717a.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.06.2017 um 15:14 schrieb Junio C Hamano:
> Andreas Heiduk <asheiduk@gmail.com> writes:
> 
>> Am 03.06.2017 um 12:17 schrieb Andreas Heiduk:
>>> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
>>> ---
>>>  Documentation/git-filter-branch.txt | 3 ++-
>>>  git-filter-branch.sh                | 2 +-
>>>  2 files changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
>>> index 45c849d8c..1efdda804 100644
>>> --- a/Documentation/git-filter-branch.txt
>>> +++ b/Documentation/git-filter-branch.txt
>>> @@ -86,7 +86,8 @@ OPTIONS
>>>  	This is not a real filter executed for each commit but a one
>>>  	time setup just before the loop. Therefore no commit-specific
>>>  	variables are defined yet.  Functions or variables defined here
>>> -	can be used or modified in the following filter steps.
>>> +	can be used or modified in the following filter steps except
>>> +	the commit filter, for technical reasons.
>>
>> I'll move that into the previous commit.
> 
> Yeah, the description of "technical limitation" is different from
> clarifying the disambiguating "--" in the documentation.
> 
> I am curious what the "technical reason" really is, though ;-)
> 

Well, I just picked up the wording from the "Filter" section a 
couple paragraphs above:

> The filters are applied in the order as listed below.  The <command>
> argument is always evaluated in the shell context using the 'eval' command
> (with the notable exception of the commit filter, for technical reasons).

Because these reasons exist independently from my change I think I
can get away with just that snappy reference :-]
