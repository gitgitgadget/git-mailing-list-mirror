Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3AFB1F42D
	for <e@80x24.org>; Tue,  8 May 2018 21:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755823AbeEHVT1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 17:19:27 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42512 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755699AbeEHVTY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 17:19:24 -0400
Received: by mail-wr0-f194.google.com with SMTP id v5-v6so33695986wrf.9
        for <git@vger.kernel.org>; Tue, 08 May 2018 14:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hCqlGcR2X7vztZC2QassKBQcoqCGaeHlh2ZhI+wzS2w=;
        b=oVDbGSwYAaJK9s80dsKeLU90X+JewfBSNf+Yan4wwMsc9QIwT3qu489xv2NAoWHUqo
         mmzGIX/qdX4vJoJhFJP68op3ozH7+HTrT8rLIPQ/qCUlya6ARuTupv8XMHp3xGzfYbYF
         ktiYS0veB1RkmsGsSNfOZKI0nTyEWm3CFm7jYBTJtUkeiQiRUa7Nhj4nhZDklPphFvi5
         tQU/hUD21/s3jHeYdBqF6AoB9bKhpPKQsCohanA1Nm4qJgm6C1Xez1Tgk6QDc6IfQS7i
         oblyaXCfu+650o+27VbTJy4Lfi/w2blkIfNGYII+MZGEwWg1/daqVhmLV/CZTA5nvAmb
         vrHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hCqlGcR2X7vztZC2QassKBQcoqCGaeHlh2ZhI+wzS2w=;
        b=UH2s6AzjIQGMmfuy8h/2b7yR6pNfaBuKwQNUR9/AKu2IAt2DWUbDmVTp8HnIerv2hC
         C9NqfzWRDVJ/MSaEySpwWoTTa6K4MRh9/rZPCtLWjqqU2BQPI0p6f3THdNgac/72GVST
         q9IFCzDeRJ0tWFNbPgO1zXFX9anMrxI3NN6sOH5VTAWcZAWKpfa5kxV38UZCowBUSo/M
         RtNDrEkhWybtvk++xflQTeHwwffnm+JJRurYXnhIi27fvFqNM5d3pQNOi9NlkvsrsBKk
         ZvA7uNjhhcqjBE5YGG8xuKep/HNx/vxF3A6bFmTr5G30fp/LRJnTvy11kl2U+Xm2TAMm
         MO6A==
X-Gm-Message-State: ALQs6tDBT/zVzN2O/vzV1MdxO6O9e/XIKKoRncHCzKusGOtKkE9XYoR3
        9dw5qNVSqA6lntMlhg+gJwhtVCQp
X-Google-Smtp-Source: AB8JxZpthkwms7Psa8iVESv9uTVLTYViZ/5mDi4TscIi7Z7OOwP6Ls+KY6F8wOswInwzasi+Oxt1Qg==
X-Received: by 2002:adf:86fa:: with SMTP id 55-v6mr38274485wry.232.1525814363275;
        Tue, 08 May 2018 14:19:23 -0700 (PDT)
Received: from [192.168.0.103] ([92.55.154.57])
        by smtp.gmail.com with ESMTPSA id j8-v6sm42922603wra.58.2018.05.08.14.19.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 May 2018 14:19:22 -0700 (PDT)
Subject: Re: [GSoC] A blog about 'git stash' project
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <67e6d306-0885-9340-13c8-3e3d4333dc20@gmail.com>
 <20180508040037.GA2816@syl.local>
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Message-ID: <d4d4c9f7-9b7d-cd41-bddb-85994f227e3b@gmail.com>
Date:   Wed, 9 May 2018 00:19:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508040037.GA2816@syl.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On 08.05.2018 07:00, Taylor Blau wrote:
> On Fri, May 04, 2018 at 12:48:21AM +0300, Paul-Sebastian Ungureanu wrote:
>> Hello everybody,
>>
>> The community bonding period started. It is well known that for a greater
>> rate of success, it is recommended to send weekly reports regarding project
>> status. But, what would be a good form for such a report? I, for one, think
>> that starting a blog is one of the best options because all the content will
>> be stored in one place. Without further ado, I would like you to present my
>> blog [1].
> 
> Hi Paul, and welcome to Git! I am looking forward to reading your
> patches and any additional writing posted on your blog.

It is a pleasure to be here. Thank you!

>> Any feedback is greatly appreciated! Thank you!
> 
> Do you have a RSS feed that I can consume in a feed reader?

Yes. It can be found here [1].

[1]
https://ungps.github.io/atom.xml
Best,
Paul
