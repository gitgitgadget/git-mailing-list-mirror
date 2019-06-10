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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BA091F462
	for <e@80x24.org>; Mon, 10 Jun 2019 17:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388434AbfFJRrC (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 13:47:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42685 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387643AbfFJRrB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 13:47:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id x17so10053077wrl.9
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 10:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BemgM+alGqRO3VoH3eKhAiltI7TUoBiGa2+6ld0vJSc=;
        b=FTe0K2f4ErzQHYmC/lmSDVlf9rryzBUBiH8PSvl3KJz3MPlmjjPYNCKUogd1J+B8J9
         RdRRDhxYEeHKUdhgq4Ki1mvEqbd4WO0kF+mb44AogJ2tdN8SbjWaVKoBJpVsMCK/792R
         s7Oaq9WaKMs68OvpEZ1SMckoOt2ELYJv0IVzzjP6Ka3M0G89Hu4WOQA+COaTzKx9nj8e
         lyhpRpJRkZ0+o+SqyD013ajsXE6v+v71jlo83xm2S2QbJ2mgUyZo/Ma+SANesrNWHVIs
         1nRwo4WVTmhQ4wCkUzHEfZ7DXEs6EIlX5qMI40TSzKOrkdKgJp4zIIphRvWGmAhajj4e
         oFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BemgM+alGqRO3VoH3eKhAiltI7TUoBiGa2+6ld0vJSc=;
        b=lFgTXqGzAqyjpbCDU8j3GsUqnQcgoolPpcqOcOq207FQBQxOtpp9iSz2ias1XSbOlh
         Wyz1Bx7r2M5KQe0dzuxa+zKfcfg7eYtM+f4kfKdz1D00S9sceVFC+nUiJcqnQIe2IxLx
         ULwBD0prqGQB4H1TKFD4yQXcvPAZoIcATpXwkwylXWwzZ1lsQOd+jGfShxBThr6jD7XZ
         rWig9guhf/eNtwmbAoypBVTEaXiIF5qTVk5dlzv6SOp4f/MHTRiaE2p+YP8W+/ngH+dG
         qV4LdQQ0Vko+Ao07BZcywN2oxbIMXwrnA9DncvEdMp9kovn/8qQeH/EAoY65fKu4zjCL
         79eQ==
X-Gm-Message-State: APjAAAVwU/Osp0CIHUjCyRcs33Cwkan7KBrZjN5UQZb/80e23IN/LbfG
        jcqYX9q/RCDDni2K9DBoxLs=
X-Google-Smtp-Source: APXvYqymMKfBI14aDNuG0RyK4kioSPsf0lH+PPnQ8XMdwiGImBexT1h7KZioykeUlX3lhT2XdSUQZQ==
X-Received: by 2002:adf:ef09:: with SMTP id e9mr32074605wro.79.1560188820738;
        Mon, 10 Jun 2019 10:47:00 -0700 (PDT)
Received: from [192.168.2.201] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.googlemail.com with ESMTPSA id o15sm14570345wrw.42.2019.06.10.10.46.59
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 10:47:00 -0700 (PDT)
Subject: Re: [GSoC][PATCH 3/3] cherry-pick/revert: update hints
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com
References: <72b44513-1182-8172-94aa-ca69730d9a22@gmail.com>
 <20190610133321.7901-1-rohit.ashiwal265@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <81dbc317-c11f-c3b4-f20f-cff20254d626@gmail.com>
Date:   Mon, 10 Jun 2019 18:47:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610133321.7901-1-rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit

On 10/06/2019 14:33, Rohit Ashiwal wrote:
> Hi Phillip
> 
> On 2019-06-10 10:40 UTC Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Hi Rohit
>>
>> On 10/06/2019 06:28, Rohit Ashiwal wrote:
>>> Hey Phillip
>>>
>>> On Sun, 9 Jun 2019 19:03:02 +0100 Phillip Wood <phillip.wood123@gmail.com> wrote:
>>>>
>>>> Hi Rohit
>>> [...]
>>> I think it is more about suggesting what are all the possibilities
>>> you can try and not about intelligently suggesting what you should
>>> do.
>>
>> Previously all the suggested options were viable, --skip is not
>> applicable if the user has committed a conflict resolution. The idea of
>> the advice is to help the user, suggesting options that wont work is not
>> going to help them.
> 
> Now that I know what I should do, I'll make the change and submit a
> better patch.


That's great, thanks

Phillip

>>> ofc, we can not use `revert --<option>` while cherry-picking.(
>>
>> As I suggested in patch 1 we should tailor the error message to the command.
> 
> Yes, I'll tailor the messages based on which command was ran.
> 
>>> we should not be able to do so in ideal conditions, but the world
>>> does not work as we think it should). Still we are suggesting so
>>> here.
>>
>> Yes because you have the power to easily make that change. It is normal
>> to try and improve the code base when we make related changes.
> 
> :)
> 
>>> Also, I think it is more reasonable to make "this" a part of patch
>>> which will cover "tailored" advice messages which is also a topic
>>> of discussion as I described here[1].
>>
>> That might make sense, but it is a pretty self contained change as part
>> of this patch.
> 
> Yes, this patch is the place where all changes should be made.
> 
> Thanks
> Rohit
> 

