Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05FB41F954
	for <e@80x24.org>; Thu, 23 Aug 2018 10:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbeHWN4E (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 09:56:04 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:44393 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbeHWN4E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 09:56:04 -0400
Received: by mail-qt0-f194.google.com with SMTP id r13-v6so5552256qtr.11
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 03:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=+eLnoNcifkgbz6/PtzcY72x18Em0EAFboUJIBYJVjS4=;
        b=oh0pYXt39PnhU1UVHc9ELQn5eukQSpBnheKO9dsxTz7LqEiIIbCv9eLxkW2xKrlx7P
         dOTFwUq7HLLbCrrlIzfubmVuBjm4v8TTzF94PPnqwCV+UilFYJ+73DypfdwSzYM57qqJ
         IgwIzBFwi4/6wiHUaei8ps7X9nXwD23pnSS1cB244hogaCmuaj90jWrSfdbqQWAbbe0E
         Sh/L4mzWAVOtPxLWfsjxirt4Lx58qQjRXBWebShlxmHzbniscmq48pkH/ct2LtUX/Zyq
         GiCBcqEQS1Q5SmlcOZLEKWOfJibypY/QYxPqLHTQqzboUrJFWBvvj65+Er8wdUD61TYO
         okCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+eLnoNcifkgbz6/PtzcY72x18Em0EAFboUJIBYJVjS4=;
        b=h5aqZPeECL4HSkB61keCOEq89nncPg4Eg0KfihQ55PEKwv8XiF7h36i9KUdqkotj2E
         JfXZG6MP5qYOlOkf277iS42dqcJciyGKFqZn1frKIWEJTGfnKI2v9GnCjt7wYnBUt0Uo
         ZUQVWbKglDV0cqRKD6KIPQqv7ppf/CrHLuZgiAhEqO0tHzio2DTS1yQUqMhpLp0X+yMX
         aFmJ9coFPmZvnr+j9GuOa/M0z/EMzBkKEVy6zGC4ffR6eUCldEcYG0pDaCIc3tVoWlq5
         L7Go4eTTN0IQw5VyWct0d0MmFvFJVM23IOMJCkZxpTnkPMOXb26MDdqRA3t3KBNLbWD3
         8Rwg==
X-Gm-Message-State: AOUpUlGghD5LmcWvN7uCxeJz4YRNh87wiPlAOV9kTNj0hFmKcUAhsCzY
        bcurKgDQNGM80ddyeBGlhYo=
X-Google-Smtp-Source: AA+uWPwVZm1j3OhTLVFgjiIVYGJ+mOp3z9VGhPPcwIdaZUC9KGoWsMJzuVXpCbEYO2pI1jjODoycBA==
X-Received: by 2002:ac8:9e:: with SMTP id c30-v6mr15770083qtg.173.1535020021911;
        Thu, 23 Aug 2018 03:27:01 -0700 (PDT)
Received: from [10.0.1.17] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id l5-v6sm2267638qte.20.2018.08.23.03.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 03:27:01 -0700 (PDT)
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
To:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Paul Smith <paul@mad-scientist.net>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
References: <xmqqwoskadpe.fsf@gitster-ct.c.googlers.com>
 <1b20b754-987c-a712-2594-235b845bc5d0@gmail.com>
 <20180821212923.GB24431@sigill.intra.peff.net>
 <20180822004815.GA535143@genre.crustytoothpaste.net>
 <20180822030344.GA14684@sigill.intra.peff.net>
 <814549a01074e89a4b26cb0cf13e4dddeb3a040a.camel@mad-scientist.net>
 <20180822152306.GC32630@sigill.intra.peff.net>
 <20180823012343.GB92374@aiede.svl.corp.google.com>
 <20180823021618.GA12052@sigill.intra.peff.net>
 <20180823034707.GD535143@genre.crustytoothpaste.net>
 <20180823050418.GB318@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f854aba0-6d28-7f2b-aad2-858983c4af36@gmail.com>
Date:   Thu, 23 Aug 2018 06:26:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180823050418.GB318@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/23/2018 1:04 AM, Jeff King wrote:
> On Thu, Aug 23, 2018 at 03:47:07AM +0000, brian m. carlson wrote:
>
>> I expect that's going to be the case as well.  I have patches that
>> wire up actual SHA-256 support in my hash-impl branch.
>>
>> However, having said that, I'm happy to defer to whatever everyone else
>> thinks is best for 2.19.  The assert solution would be fine with me in
>> this situation, and if we need to pull it out in the future, that's okay
>> with me.
>>
>> I don't really have a strong opinion on this either way, so if someone
>> else does, please say so.  I have somewhat more limited availability
>> over the next couple days, as I'm travelling on business, but I'm happy
>> to review a patch (and it seems like Peff has one minus the actual
>> commit message).
> I just posted the patch elsewhere in the thread.

Thank you for that!

> I think you can safely
> ignore the rest of it if you are otherwise occupied. Even if v2.19 ships
> without some mitigation, I don't know that it's all that big a deal,
> given the numbers I generated (which for some reason are less dramatic
> than Stolee's).
My numbers may be more dramatic because my Linux environment is a 
virtual machine.

I was thinking that having a mitigation for 2.19 is best, and then we 
can focus as part of the 2.20 cycle how we can properly avoid this cost, 
especially when 32 is a valid option.

Around the time that my proposed approaches were getting vetoed for 
alignment issues, I figured I was out of my depth here. I reached out to 
Daniel Lemire (of EWAH bitmap fame) on Twitter [1]. His blog is full of 
posts of word-based approaches to different problems, so I thought he 
might know something off the top of his head that would be applicable. 
His conclusion (after looking only a short time) was to take a 'hasheq' 
approach [2] like Peff suggested [3]. Since that requires auditing all 
callers of hashcmp to see if hasheq is appropriate, it is not a good 
solution for 2.19 but (in my opinion) should be evaluated as part of the 
2.20 cycle.

Of course, if someone with knowledge of word-alignment issues across the 
platforms we support knows how to enforce an alignment for object_id, 
then something word-based like [4] could be reconsidered.

Thanks, everyone!
-Stolee

[1] https://twitter.com/stolee/status/1032312965754748930

[2] 
https://lemire.me/blog/2018/08/22/avoid-lexicographical-comparisons-when-testing-for-string-equality/

[3] 
https://public-inbox.org/git/20180822030344.GA14684@sigill.intra.peff.net/

[4] 
https://public-inbox.org/git/7ea416cf-b043-1274-e161-85a8780b8e1c@gmail.com/
