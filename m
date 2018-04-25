Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E8741F424
	for <e@80x24.org>; Wed, 25 Apr 2018 15:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754761AbeDYPWi (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 11:22:38 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35692 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754749AbeDYPWf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 11:22:35 -0400
Received: by mail-qk0-f196.google.com with SMTP id b131so18626839qkg.2
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 08:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O96R17LKWQbfr017rXk2VdH4I3m9DKSnJ2bXQvke10k=;
        b=cINP2RxLb8clBq2W5VdMbxS8zHwN8901kCffJze5kpPnLwSxGuTcJVONFMjDp6O0Sn
         u7ukabkAL9uhyKT+oUxRYypJY4IPHwBN5gE78jUTCmCAA5yLYqW82ire+4Byq2ISwmVo
         iyo2lmkzNhrxCiGnh0PQ21yZ7jbWQDbhQNJiqF+f91HixaOIVihZrg0L3oC84IZUuDHs
         EO69bqdjmXpeIABjERM77HFOsKr1I1ZwPGRyPiuWkDc16fYWXQAVjWNhckEjoWqizw6J
         SUNqPv9Ja1FbQ5Odyn/qaP1eveR8yxZ6bT7vQL0MXinz0eOVhuAUfD/TOcahwyxZem4o
         843g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O96R17LKWQbfr017rXk2VdH4I3m9DKSnJ2bXQvke10k=;
        b=O8QJISkObdEiZPZgYD/C02CbMmpsgGjQt10NsZZmiq7NF/ANdaS8HC01oYwG9cHBWm
         2DQIZgjUi+/gmsRgj/uO202pP3O5UprfoNxkrhcgce+8gsoExD5NMd1EJB2zVzRs7wZl
         VVDew1T7YUc5elQr16BqufRfDVb4cUIO7oYzuoCRjGypEUBBWZwf04MaPZ8jAWh+/6z3
         ZFbZF5gIDjzfo51g+uQS6HfqW/yVWvFQOu2nPurSmF1F4yiGZhZJEBVOztnaBZSOLS5N
         NNPM3eUBVti5CWCu0j3fjRK00DK/cBbg/dOmyyzjEVj58Nj7JOS8subVHju5xZrK/Fp0
         7Scw==
X-Gm-Message-State: ALQs6tCtNqwDIcIg4135KrpfM6/xY1GkRrzSXV6RWlwOG0h8OgX3xiUG
        pxccGoy4pLC620+AlrmZFa4=
X-Google-Smtp-Source: AB8JxZq4yxj66lHF5r5ku2f1XstsMrG6SNmEVECaFanCm+MQfia4CAO9XF2IqfrUJ6Xt/hQmJtNYdw==
X-Received: by 10.55.162.143 with SMTP id l137mr30631824qke.200.1524669753714;
        Wed, 25 Apr 2018 08:22:33 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id g12-v6sm13080141qtj.42.2018.04.25.08.22.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Apr 2018 08:22:32 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] add additional config settings for merge
To:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "newren@gmail.com" <newren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass@googlemail.com" <eckhard.s.maass@googlemail.com>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180424171124.12064-1-benpeart@microsoft.com>
 <xmqqd0yo5ejb.fsf@gitster-ct.c.googlers.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <365838dc-d988-b72c-ef29-20369a7f54a2@gmail.com>
Date:   Wed, 25 Apr 2018 11:22:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqd0yo5ejb.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/24/2018 8:13 PM, Junio C Hamano wrote:
> Ben Peart <Ben.Peart@microsoft.com> writes:
> 
>>   diff.renameLimit::
>>   	The number of files to consider when performing the copy/rename
>> -	detection; equivalent to the 'git diff' option `-l`.
>> +	detection; equivalent to the 'git diff' option `-l`. This setting
>> +	has no effect if rename detection is turned off.
> 
> You mean "turned off via diff.renames"?
> 
> This is not meant as a suggestion to rewrite this paragraph
> further---but if the answer is "no", then that might be an
> indication that the sentence is inviting a misunderstanding.
> 

Yes, this is referring to turned off via the config setting 
"diff.renames" but it could also be turned off by passing "--no-renames" 
on the command line.

To be clear, this documentation change isn't trying to document any 
changes to the code or behavior - it is just an attempt to clarify what 
the existing behavior is.  If it isn't helping, I can remove it.

>>   diff.renames::
>>   	Whether and how Git detects renames.  If set to "false",
>> diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
>> index 5a9ab969db..38492bcb98 100644
>> --- a/Documentation/merge-config.txt
>> +++ b/Documentation/merge-config.txt
>> @@ -39,7 +39,8 @@ include::fmt-merge-msg-config.txt[]
>>   merge.renameLimit::
>>   	The number of files to consider when performing rename detection
>>   	during a merge; if not specified, defaults to the value of
>> -	diff.renameLimit.
>> +	diff.renameLimit. This setting has no effect if rename detection
>> +	is turned off.
> 
> Ditto.  If your design is to make the merge machinery completely
> ignore diff.renames and only pay attention to merge.renames [*1*],
> then it probably is a good idea to be more specific here, by saying
> "... is turned off via ...", though.
> 
>>   merge.renames::
>>   	Whether and how Git detects renames.  If set to "false",
> 
> [Footnote]
> 
> *1* ...which I do not think is such a good idea, by the way.  I'd
> personally expect merge.renames to allow overriding and falling back
> to diff.renames, just like the {merge,diff}.renameLimit pair does.
> 

It looks like I'm in the minority on whether the merge settings should 
inherit from the corresponding diff settings so I will submit a new 
patch series that does it the same way as the {merge,diff}.renameLimit 
pair works.

I'll leave it as an exercise for someone else [1] to change any other 
merge settings that should behave that way.

[1] 
https://public-inbox.org/git/20180420133632.17580-1-benpeart@microsoft.com/T/#m52a3dbd0945360bfb873fd3b553472558ef3b796
