Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12D3A1F462
	for <e@80x24.org>; Mon, 10 Jun 2019 17:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388505AbfFJRqm (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 13:46:42 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52749 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388215AbfFJRql (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 13:46:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id s3so214135wms.2
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 10:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c49OPRVmi6sf+mNhvXc9/II6J6cjQIoma/pWBi5OwEQ=;
        b=T8Tp5S9N/+rjxUSo3fTGOBXY8PWz86q2PoLFjPjuHrn5RONB+vCjC+muA3TPlAfqLY
         goeI+d9NuszfRcgjO+gF/stEml3HNrXTdpdYReZB+X1ECNYSL9a8npVklaQJfeg9oQ5Q
         QnCl9pr1Z8LBoz62qdOtLuCuzXUjVVcdeK/h+DWCTwl/e8213FCJnfK+7gY90nCM3aMi
         gJjsTcsJvOhOxvf810R6VpCYr1wmCKFP40jbqFDb9pGAFipdWBJoHwFpgSJF72TTUMlf
         oTwEp2zH3FRXjDc24GKp5S2PAy2gNq6b9jgBHNqZiJXMepLsPhVwrgwtbRCI1aEUxmza
         Qfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c49OPRVmi6sf+mNhvXc9/II6J6cjQIoma/pWBi5OwEQ=;
        b=SBge0Rn4yXYZ95DpiVBDY9+sRD2wFpZwu3U974ZNYm8fISE6/lX+1uA/0y2rdxNIeF
         sCZTYSMMkgBqFfs5Y+dKD0+U3gN0LAWVCKuRHM96DFg5nk5hgXXMpgm8rCwcdspZIm8O
         wCm7Bxp+i6IMoZsjHPQgmvz/FMq34Wpfyx/TvAHPtqu9hcG2J48RV2RY6ECNDNAdX0P8
         qsCcJiott44zSqGzX8958OGqOZH9vkTUfd8iWoo4t62dShPqFYYXzyxuJx5SvHOrNm9Q
         cdFaXKjhzFnJJrmiOYYxabz7H/rvjdkGj4wk7h4VMrwa/8hGkJQkk06ldH6QORXj6j7O
         G9gA==
X-Gm-Message-State: APjAAAXOglOdiuajJJu1pI+79eqnGa9g5C/5tEqpPDBpqBSgo8FM32FJ
        TgI2hAvbtx0Lu8A/80zigaQ=
X-Google-Smtp-Source: APXvYqxXuCFdh2qZ3nOaXVZiIYHG5ALRENZMZkgp1i/UAGaUuFjBvO+ac8kI1hS070pTBd1ThcG6Mw==
X-Received: by 2002:a7b:c057:: with SMTP id u23mr14645074wmc.29.1560188799533;
        Mon, 10 Jun 2019 10:46:39 -0700 (PDT)
Received: from [192.168.2.201] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.googlemail.com with ESMTPSA id 88sm19100714wrl.68.2019.06.10.10.46.38
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 10:46:39 -0700 (PDT)
Subject: Re: [GSoC][PATCH 1/3] sequencer: add advice for revert
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com
References: <d59c078c-61da-1c3a-d215-80c9e3d08896@gmail.com>
 <20190610132509.7581-1-rohit.ashiwal265@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <80217c99-8113-6320-e413-4a5646fd4ea5@gmail.com>
Date:   Mon, 10 Jun 2019 18:46:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610132509.7581-1-rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit

On 10/06/2019 14:25, Rohit Ashiwal wrote:
> Hi Phillip
> 
> On 2019-06-10 10:39 UTC Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Hi Rohit
>>
>> On 10/06/2019 06:13, Rohit Ashiwal wrote:
>>>
>>> [...]
>>> Firstly, signature of `create_seq_dir` doesn't allow us to call
>>> `sequencer_get_last_command()`. Changing that for the sake of a
>>> better error message is too much task for this patch as it is a
>>> subject of discussion on its own.
>>
>> There is only one caller and it already has a struct repository pointer
>> so it is a two line change, one of which is the insertion of a single
>> character to change create_seq_dir() so it can call
>> sequencer_get_last_command(). It is normal to change function signatures
>> (especially for static functions like this) when making changes, it is
>> part of improving the code base. The quality of error messages is
>> important to the overall user experience. It's when things go wrong that
>> users need accurate advice about what to do.
> 
> Nice! I'll do this in next revision then.

I'm glad that helped

> 
>>> (Also changing signature only
>>> makes sense if this patch series gets merged). FWIW, I think we
>>> should left this to further discussions for now and decide what
>>> to do later on.
>>
>> It is only a small change so why not do it now rather than putting it
>> off for another series which will be more work in the long run.
> 
> I'm fine with changing that here.

That's great

Best Wishes

Phillip

> 
> Thanks
> Rohit
> 

