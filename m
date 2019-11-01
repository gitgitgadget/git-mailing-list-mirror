Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CFDE1F454
	for <e@80x24.org>; Fri,  1 Nov 2019 20:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfKAUf5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Nov 2019 16:35:57 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:38257 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfKAUf4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Nov 2019 16:35:56 -0400
Received: by mail-wr1-f49.google.com with SMTP id v9so10799984wrq.5
        for <git@vger.kernel.org>; Fri, 01 Nov 2019 13:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IQjRsQZio5CzAmiKy5Ma+dGOfCiyhzPP8qDemkydekI=;
        b=OqDcGsTEu/rjc36dfhVjKa70oPT5cYB7vXlCo8NCj8kMQi1GEtXCB87ajYrfZz80i1
         AVIYI2xKxTbX5FZjslKkjzvnPNg4SSlO8k1ZyFMK2nJjkPJwskM6WLNgVDPmFRL3rDwx
         L8+ED+gio4jgjq4LBqmYSe5WslWFBaSRp4Anii8Wt8gGilALxd6bekGxRrnQJaM/6+7k
         nNV2ldfi0VJc56uC2dGQPkwK2YM8sRIx2hLxbqzW3wCGKZ9y6DjblH1tyisuElABZE8h
         Q4KLNfvsYObYurGUCtboDjQ9Vd72kLkW7D3E81LjwEPhhuckS7DwD/Ng2ry5zcS5EXAR
         8Liw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IQjRsQZio5CzAmiKy5Ma+dGOfCiyhzPP8qDemkydekI=;
        b=d54i1PfSlPAaG96dbbiVwUxCHVHd4uqBs80Adr/M+iYgAW4SsL6TD6Pyx85zeLbk2e
         SHH6JiE2IcFj7fKJmgaZti55N4SJuzThQLZUZoXcU/tcqaD3HelLkKVB6UDUHuQYk0vk
         JenHANtX7WEzn4Txi303AQ9aUQiBUzfRP+6RAwillOJdqcDYbzUPWvGrILgrgSfAchFE
         hpIQqeBV4u7AmsxwCr7RMq3jP3jROtz3Drtx8uWJZyhhpazlK41N85aXgHsOtZUG3KBA
         eTIZ8YQMAsvLxAoyp1U24GHHE7zXJpPghVGt4J3mbyrsc6GQdXu71aXqbpD9sWnszzBZ
         vXqg==
X-Gm-Message-State: APjAAAX6SBl9WA/saOnM+bciNUthjQE5gj5wkHLTuqSLqv5eNuNJgJIp
        wsdm+SkaOw44gUgP5Bbuw/W4mr9p
X-Google-Smtp-Source: APXvYqwpm1MnQm+/54UOE9AfIoMIOGpyyGv5WD/Zx6NV41j6iyuvMnPKV6c9IzXU3Byp8KYqVRqLxQ==
X-Received: by 2002:adf:f685:: with SMTP id v5mr1312448wrp.246.1572640554463;
        Fri, 01 Nov 2019 13:35:54 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-25-166.as13285.net. [92.22.25.166])
        by smtp.gmail.com with ESMTPSA id u21sm10936148wmu.27.2019.11.01.13.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2019 13:35:53 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git branch --edit-description a custom file
To:     Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk
Cc:     Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
References: <20191030183950.GA21277@generichostname>
 <20191030202835.GB29013@sigill.intra.peff.net>
 <20191030224328.GB44961@generichostname>
 <20191031061832.GA20830@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1910311119080.46@tvgsbejvaqbjf.bet>
 <20191031181920.GB70819@generichostname>
 <4ef79cfb-b970-2b2b-131d-3f47e6b0e308@gmail.com>
 <20191031200739.GA19313@sigill.intra.peff.net>
 <822d51af-d522-bf2c-72de-f54a4ccb3b38@gmail.com>
 <20191101164955.GA26219@sigill.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <0bd3d494-ff99-9895-d913-51a24f8092af@gmail.com>
Date:   Fri, 1 Nov 2019 20:35:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191101164955.GA26219@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff

On 01/11/2019 16:49, Jeff King wrote:
> On Fri, Nov 01, 2019 at 12:29:43PM +0000, Phillip Wood wrote:
> 
>>>> I'd love to see a consensus around putting remote versions of refs/foo under
>>>> refs/remote/<remote-name>/foo. To share notes I add a refspec that fetches
>>>> to refs/remote/<remote-name>/notes. It is a pain that 'git pull' wont merge
>>>> them for me though.
>>>
>>> The trouble with that sort of scheme is that it conflicts with the
>>> current namespace scheme, which puts the remote "notes" branch in
>>> "refs/remotes/<remote-name>/notes". And it's not just a problem if you
>>> want to have a branch called "notes". Think about what "git fetch
>>> --prune" would do.
>>
>> I was suggesting a convention of using refs/remote/ not refs/remotes/ for
>> tracking remote refs that are not branches to avoid that problem. It's not
>> ideal to have remote branches under a different namespace to all the other
>> remote refs but it does avoid breaking current setups. I haven't thought it
>> through but perhaps in the long run we could migrate remote branches to
>> refs/remote/<remote-name>/heads/ and treat refs/remotes/<remote-name>/ as an
>> alias for refs/remote/<remote-name>/heads/. As you say below we'd need to
>> think about how to use remote tags as well.
> 
> Oh indeed, I totally missed that subtlety. Sorry.

I should have made the difference clearer, it's easy to miss the missing 
's'

>> Thanks for the links, I'll have a read through them.
> 
> Maybe I've managed to trick you into working on the greater refs/remotes
> organization problem, though. ;)

Maybe we'll see once I've read those threads next week!

Phillip
> -Peff
> 
