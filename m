Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 130772047F
	for <e@80x24.org>; Mon, 18 Sep 2017 14:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbdIROGp (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 10:06:45 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37334 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751499AbdIROGo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 10:06:44 -0400
Received: by mail-qt0-f193.google.com with SMTP id u48so400076qtc.4
        for <git@vger.kernel.org>; Mon, 18 Sep 2017 07:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=blKYuzAXAtMibMyzlmC47E5SKZPe3uLmkUtTFAmMQJc=;
        b=JFr3BaEO1/IbmCQpiBt42sZEPQEtIcm0hC0xfX1hz4yT/1OkAx1mUsukw5dGWrN3K0
         JxtO/3bnnhqrk463LHVOpkQ0ukG5oYiyNCFKM/p/UtPl4WHQnU0koLnhvsZ+Kc+TpJwN
         KbVZBG6/vfhPal2yg/jm9OK8M36izQ+PWtfDTyy8Re/PUss75Kgc57U26EK5+yhCEaE0
         0m8aukam1wVyGpAAZjvYZQQVk9J3Z8iSmBvE0zpvk329X1Sq3QhxXernKGLGOWgC9mws
         ZH/9lOW1IRgz1A7pKa7tzC8iI3t8B58+T7NM6CfpC1uOvxNGMWV0MAfaPHLKzGIwOE6Z
         hcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=blKYuzAXAtMibMyzlmC47E5SKZPe3uLmkUtTFAmMQJc=;
        b=Bl9qDAVXF0seurgoAs14V7Njfp1d6fnwHq37F8KKblLKD2uVTaLsgSWoBnWvA+nUb2
         wtvdpOquLo/nHnmD3BJ6P1Kl9XThQ4Vomj5a0sQZC/4+a1RuOtLMwtBRp4+MAZsKHkLl
         mEg+e3RWs3krMjD9BtJ9JYJpZT5001/tLKf0xXyTN1fYBhT2KM+xarwNbk6jkG7sBMJt
         F0svqQjIX7/ENo6CQejP57MzL9pADUkV842iBj13wDubcNphReNC9Dt2uO2ZFTMxF79+
         kSS6MIkSAR48Fcx7SmnMA+OaPt9zDVO4KuwlRl6io7NyXZ00A6fidbWxr+GqbmAinSGz
         8stw==
X-Gm-Message-State: AHPjjUjAK4/4TeqmG7OirIoG8yuxZ+4BvZAif7H+fYVnrArFdJ8KVfrF
        4il1+UJYZAJ4CA==
X-Google-Smtp-Source: AOwi7QA3HkOjSXNoy9sjg9XkiO0lHar/nesydUGrXkb8Omobb1YGhl2/b1KFjMJ8jKm8/xWtVi9hXw==
X-Received: by 10.200.5.132 with SMTP id a4mr51495141qth.316.1505743604215;
        Mon, 18 Sep 2017 07:06:44 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id a12sm5223767qta.3.2017.09.18.07.06.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Sep 2017 07:06:43 -0700 (PDT)
Subject: Re: [PATCH v6 10/12] fsmonitor: add test cases for fsmonitor
 extension
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Ben Peart <benpeart@microsoft.com>
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170915192043.4516-1-benpeart@microsoft.com>
 <20170915192043.4516-11-benpeart@microsoft.com>
 <ce17a042-91e4-bf84-d9e6-36a9e99f3644@web.de>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <61c14a6e-99e0-8b6e-d4ab-4a2547fba04a@gmail.com>
Date:   Mon, 18 Sep 2017 10:06:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <ce17a042-91e4-bf84-d9e6-36a9e99f3644@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/16/2017 11:27 AM, Torsten Bögershausen wrote:
> On 2017-09-15 21:20, Ben Peart wrote:
>> +if [ "$1" != 1 ]
>> +then
>> +	echo -e "Unsupported core.fsmonitor hook version.\n" >&2
>> +	exit 1
>> +fi
> 
> The echo -e not portable
> (It was detected by a tighter version of the lint script,
>   which I have here, but not yet send to the list :-(
> 
> This will do:
> echo  "Unsupported core.fsmonitor hook version." >&2
> 

Thanks, I'll fix these and the ones in the t/t7519 directory.
