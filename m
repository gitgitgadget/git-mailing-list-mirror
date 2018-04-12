Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D92A91F424
	for <e@80x24.org>; Thu, 12 Apr 2018 11:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751832AbeDLLfr (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 07:35:47 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:43066 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751112AbeDLLfq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 07:35:46 -0400
Received: by mail-io0-f179.google.com with SMTP id q84so5917263iod.10
        for <git@vger.kernel.org>; Thu, 12 Apr 2018 04:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=TL1QFIFaeL3yg+h5dF+FJBJ74twjg+gxy5isH+1W8WA=;
        b=Lvnc5P+fvhLIPFowSeSgzbJpAoWyIkwAKitZPOy8V2mlAvkyemu803uLFRza9nGHS7
         bKuFKWCQkLNh6b/igtYefT3T7C+FSyDaCTYLvnCpyHCNm//Xz17KzdNEvkZdIwnwDSvg
         MzEWdlH99LyCD0N/KylJtkothEPPjvw98c5vMDNCeHwbAx4ZOone94Leq9jqP4y1jJbn
         yPp83L7ZYmUHh0SHXknMEqFz7KzqF7A5LgdUFSSvXbn66XuWMdsR1DqrYw+UsIk38YbC
         z++HnkShNmve1Ob1rbFxVf06Zr2XEFlkFHahpwysPlKXD9mJeimVS9fM5cWvOK6u+Nfd
         rqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TL1QFIFaeL3yg+h5dF+FJBJ74twjg+gxy5isH+1W8WA=;
        b=eb3WORPPYyYjeOoiCvd+ijp9zE1V9kTXC9T8J475D3HUCjm9QtmQ4+EoXZyO1f+Uj0
         yR4jKvxTszPp2xVTmuCYSaXAtUNccQR54V1tyvVrmizNfGIM6S772UZq9c5LIHnDAnFT
         U1lfKm+BHKSqLpKI4/5sk11DmRF3pSu7SnqnqOlRdL8FAVcFbvijt+hAQDwn3hJAq38U
         +RD7aJ7/1Fl+cZCcWBODyj+XGT/Ks4dDJF0RWbuZr2QvAhCimiNmhbOQCmPsLXo0rtjO
         qhdV22cJHcA2h216iKOuOWwSaOReKjuu2A2sEX1TxsmPaER6455jbPzSJWc5i1W1vgWF
         ssZw==
X-Gm-Message-State: ALQs6tDI8Ac1HCBoUSyRBo+wznNowgbx02VOOor+VEtOzPsEdMf5QSEx
        r9fQ+D4SYRru9ZW7pZiQDoY=
X-Google-Smtp-Source: AIpwx49N7nZ3UAKKKmVHMqUI0F6u4xhIkuxyFMS9TbP1cA1HGEAO096R+BTJJ+bbgo2A+BLIjnerMg==
X-Received: by 10.107.200.208 with SMTP id y199mr9108033iof.64.1523532945264;
        Thu, 12 Apr 2018 04:35:45 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id 129-v6sm1853796itk.20.2018.04.12.04.35.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Apr 2018 04:35:43 -0700 (PDT)
Subject: Re: [PATCH v2 07/10] commit-graph.txt: update future work
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "bmwill@google.com" <bmwill@google.com>
References: <20180403165143.80661-1-dstolee@microsoft.com>
 <20180409164131.37312-1-dstolee@microsoft.com>
 <20180409164131.37312-8-dstolee@microsoft.com>
 <xmqqfu403i0p.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f557058d-7836-4b66-8fda-7fdfc7484219@gmail.com>
Date:   Thu, 12 Apr 2018 07:35:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqfu403i0p.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/12/2018 5:12 AM, Junio C Hamano wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> +Here is a diagram to visualize the shape of the full commit graph, and
>> +how different generation numbers relate:
>> +
>> +    +-----------------------------------------+
>> +    | GENERATION_NUMBER_INFINITY = 0xFFFFFFFF |
>> +    +-----------------------------------------+
>> +	    |            |      ^
>> +	    |            |      |
>> +	    |            +------+
>> +	    |         [gen(A) = gen(B)]
>> +	    V
>> +    +-------------------------------------+
>> +    | 0 < commit->generation < 0x40000000 |
>> +    +-------------------------------------+
>> +	    |            |      ^
>> +	    |            |      |
>> +	    |            +------+
>> +	    |        [gen(A) > gen(B)]
>> +	    V
>> +    +-------------------------------------+
>> +    | GENERATION_NUMBER_ZERO = 0          |
>> +    +-------------------------------------+
>> +			 |      ^
>> +			 |      |
>> +			 +------+
>> +		     [gen(A) = gen(B)]
> It may be just me but all I can read out of the above is that
> commit->generation may store 0xFFFFFFFF, a value between 0 and
> 0x40000000, or 0.  I cannot quite tell what the notation [gen(A)
> <cmp> gen(B)] is trying to say.  I am guessing "Two generation
> numbers within the 'valid' range can be compared" is what the second
> one is trying to say, but it is much less interesting to know that
> two infinities compare equal than how generation numbers from
> different classes compare, which cannot be depicted in the above
> notation, I am afraid.  For example, don't we want to say that a
> commit with INF can never be reached by a commit with a valid
> generation number, or something like that?

My intention with the arrows was to demonstrate where parent 
relationships can go, and the generation-number relation between a 
commit A with parent B. Clearly, this diagram is less than helpful.

>
>>   Design Details
>>   --------------
>>   
>> @@ -98,17 +141,12 @@ Future Work
>>   - The 'commit-graph' subcommand does not have a "verify" mode that is
>>     necessary for integration with fsck.
>>   
>> -- The file format includes room for precomputed generation numbers. These
>> -  are not currently computed, so all generation numbers will be marked as
>> -  0 (or "uncomputed"). A later patch will include this calculation.
>> -
>>   - After computing and storing generation numbers, we must make graph
>>     walks aware of generation numbers to gain the performance benefits they
>>     enable. This will mostly be accomplished by swapping a commit-date-ordered
>>     priority queue with one ordered by generation number. The following
>> -  operations are important candidates:
>> +  operation is an important candidate:
> Good.

