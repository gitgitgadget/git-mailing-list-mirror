Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C462920401
	for <e@80x24.org>; Thu, 15 Jun 2017 14:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751955AbdFOOKu (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 10:10:50 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33199 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751016AbdFOOKu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 10:10:50 -0400
Received: by mail-qt0-f196.google.com with SMTP id w1so3379544qtg.0
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 07:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oEiVLGv3BP7TE/H4gogwjk5Q7YlVcDXq5MdOO9S4Z5Q=;
        b=dQ6rXx+O5BzPZQAhBgPsAzgeJms3xyJ67VFh/ujeJSkuilg/EB5ckP9FY50n578LW0
         Gxf4kfFFSaWV047H63Dl2BvOF4DBjiGZIwIWVLQEWoEn7hqsXxHTL3n8AaYT+f0v9e7s
         K1SYkzlYZIJ9OJaMvtW71KcN1D3NcbHM0VCoLjDUskvJE1FGCnbwwnDXtrlUAGp+X4IL
         xkcQw6rgOziecD9GP2LbfwzXYEzP/2LhWK+sr3Z3GgjgHkcd2lLP1wozY/SjlPggP+1r
         267ex2/mW4XPmp52wILiuEPX61d+v1/vln/JIRi7kA2wL7jE86hbvDetWFhI2pooB/sA
         kRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oEiVLGv3BP7TE/H4gogwjk5Q7YlVcDXq5MdOO9S4Z5Q=;
        b=t/uDSLBluvwcEJ4TJ4kgQ6YN5PGvdCd2JlPMzEkR7dyJ3qLGZJEnuvjRARLltlIznl
         DKsVBdvAJyjxkMNRpWCHHjX0rhXHhalBTzmmM1XIq9q5B5B0Tm3ZXm8IcXm5NCDoyxKV
         dp7x9dmjYgdxUq+eN2TUOSzlVw1w/D5F15PEriiQ9S3etSSO2io4aqGiOaOvnhycXyZl
         lSqVseP/fsThWjj/UEugwxbLawDuQqFnBWnbA6wV/PVrsD+5kXxrDLeHdeVhB4GYGaaq
         SYDZHl2MGQd4Py3Kxulr5sBkgP0rDYRmyTkmZAlWV3GRbhVzVrI6n+WWVsBiex78fMDQ
         K9BQ==
X-Gm-Message-State: AKS2vOwUOuokVD5lYCGXcw35dF1iGfx5JiLM/cWD0ZXfamxPIk9XSsd/
        9PUZRjgcwGDulA==
X-Received: by 10.237.47.130 with SMTP id m2mr7044301qtd.31.1497535848946;
        Thu, 15 Jun 2017 07:10:48 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id a203sm152599qkg.20.2017.06.15.07.10.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jun 2017 07:10:48 -0700 (PDT)
Subject: Re: [PATCH] sub-process: fix comment about api-sub-process.txt
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20170614151225.31055-1-chriscool@tuxfamily.org>
 <20170614182607.GW133952@aiede.mtv.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <62acd48f-8442-e9bf-9e96-ce9fa2228dac@gmail.com>
Date:   Thu, 15 Jun 2017 10:10:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170614182607.GW133952@aiede.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/14/2017 2:26 PM, Jonathan Nieder wrote:
> Christian Couder wrote:
> 
>> Subject: sub-process: fix comment about api-sub-process.txt
> 
> nit: this one-line description doesn't describe what was wrong and is
> being fixed.  I think something like
> 
> 	sub-process: correct path to API docs in comment

Looks good to me.  Thanks for finding/fixing this.

> 
> would be easier to understand in "git log" output.
> 
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>   sub-process.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> With or without such a tweak,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> 
>> diff --git a/sub-process.h b/sub-process.h
>> index 7d451e1cde..d9a45cd359 100644
>> --- a/sub-process.h
>> +++ b/sub-process.h
>> @@ -7,7 +7,7 @@
>>   
>>   /*
>>    * Generic implementation of background process infrastructure.
>> - * See Documentation/technical/api-background-process.txt.
>> + * See: Documentation/technical/api-sub-process.txt
>>    */
>>   
>>    /* data structures */
