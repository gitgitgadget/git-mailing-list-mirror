Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E09B1F461
	for <e@80x24.org>; Sat, 29 Jun 2019 14:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfF2OIU (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jun 2019 10:08:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53957 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfF2OIU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jun 2019 10:08:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id x15so11702344wmj.3
        for <git@vger.kernel.org>; Sat, 29 Jun 2019 07:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wmQmQNykpK9ZIA7TZkyUatwIhxve6D4v9CbuYepCpqs=;
        b=blYACHxwCiP5CvC3OWM7pHjsNgoTU0SLR9Tzru7RkY+A57zXP4t09l8XCCeKY3gOM3
         EinzqhD9UewVkuEn4bo/6ltRlcW71R9aWoLqkwfTyT58KnUn1xXnEX99vwVnbPuodDP/
         9D+kaM2R4QQEJCNTo6f0UEHj70rdkwIQ7HL5V8yF1Rd+lgy14ylOiIb29f1nFBRmqqye
         n6pq7ldNt/yp38APOs6Rk+GRQXnHvi9uIAeWZAci2ghnLscBSQvKDOnm/Zu2DFQ8fL58
         BKTqHDFth9rghd72Cnmya6ksPKl+OT3FbMPTIoL1R326W4E0hL40mpeTKakhgUxO/U67
         cV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wmQmQNykpK9ZIA7TZkyUatwIhxve6D4v9CbuYepCpqs=;
        b=O9OqLUJaU5WCXx7AJEXolWI2Y8f3w6U5BX7yyAsdHbnJR8COuFFAVj5y+hestJNiDm
         aOqwNAAB/va/p9SrQ+N8ijmqW0yO0IQmVSIR5B9SBE+MyYyhgAnFV5W/GYJPpxip3IzX
         VGuW6Tk1O+SHuc8B/QglsCP1HEJUzLooQpuCq9d4aeZVkUNwWNaYLXG6MVkbJLkNEFEn
         UQFy+MHMzOWfHK1QPPbpOUZ6pBThTJOJdrGDdajsGhqWcY8Hz9ENYaJXxvqkW6kgO/8S
         JiaWavFGhFVhRxqEobMdnEIypc+gpevp2InI5mj2kbVkiVByCrC9f/t7OgEjCmGXdSjT
         ouXw==
X-Gm-Message-State: APjAAAVETI7ANy18mAIRXXu2fXK4DXkkhU+jzgQ8NYXUibGgOY7Vx+ED
        Tm7XhPyYwnLHcrgXWfvu6eo=
X-Google-Smtp-Source: APXvYqwHvDPbITYpgF91+HdE9M413oedqo1WWzsOehzOP+gLaGIp6lqi9BFwOtkyqSL09h2EDw6vAw==
X-Received: by 2002:a05:600c:2210:: with SMTP id z16mr11038347wml.29.1561817298545;
        Sat, 29 Jun 2019 07:08:18 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id v18sm5037985wrs.80.2019.06.29.07.08.17
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 07:08:17 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Jun 2019, #06; Wed, 26)
To:     Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <xmqq36jwc75i.fsf@gitster-ct.c.googlers.com>
 <20190628191133.GA15477@hank.intra.tgummerer.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <4f69c62f-f38b-7630-cd8a-ec152a8b6ad0@gmail.com>
Date:   Sat, 29 Jun 2019 15:08:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190628191133.GA15477@hank.intra.tgummerer.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 28/06/2019 20:11, Thomas Gummerer wrote:
> On 06/26, Junio C Hamano wrote:
>> * ra/cherry-pick-revert-skip (2019-06-24) 6 commits
>>   - cherry-pick/revert: advise using --skip
>>   - cherry-pick/revert: add --skip option
>>   - sequencer: use argv_array in reset_merge
>>   - sequencer: rename reset_for_rollback to reset_merge
>>   - sequencer: add advice for revert
>>   - advice: add sequencerInUse config variable
>>
>>   "git cherry-pick/revert" learned a new "--skip" action.
>>
>>   Is this one ready for 'next'?
> 
> Yes, I believe this is ready for 'next'.  I had a look at the latest
> round, and only had a minor comment on the organization of the patch
> series that is probably not worth a re-roll.
> 
> I also added Phillip to Cc, as he's been heavily involved in reviewing
> this series, in case he has any more comments.

Thanks Thomas. I've just posted a comment [1] about a confusing commit 
message and combining two patches but I'm not sure if it's worth a 
re-roll or not. The implementation looks fine to me

Best Wishes

Phillip

[1] 
https://public-inbox.org/git/5ae3461e-7c83-2eeb-552c-ffe838bb03b6@gmail.com/T/#u
