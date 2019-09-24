Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_RED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 155AF1F463
	for <e@80x24.org>; Tue, 24 Sep 2019 14:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731018AbfIXOko (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 10:40:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41754 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfIXOko (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 10:40:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id h7so2244349wrw.8
        for <git@vger.kernel.org>; Tue, 24 Sep 2019 07:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xda43rKov4qggLuzZGRoCh9sr4jWrkwJ+EjY5tiM3N0=;
        b=IXlfZQa47sRQoviEjm9qZvuCnCn1vKCYAZikfPSL3VEPIEeOmiQTXV1e1WCcpeY5eP
         PUJ31VlTuapGkikScHiFB35/cSwj0hFBOPI0xc+qrvSG1SBpiXYvuVhASjb4FQZ8cGP+
         BFcbVaN9oc14BagG9pAKNZvPxkqetUFkvH31pjQ0kdRDRFBvykMLpdl5xvcUjVT0GEDj
         VFoLLUtE6HC2UyJgw04UkjZ//B1ClUDYfP+djLdpgyEIa+NubRvjGk4KzbbsRV9/csli
         anQldMb1n8NhcsLUHddJE9PbsGMbv1rLC6mktqCuTYbxuypbmJQBijG8HOJ0+HZqOech
         dAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xda43rKov4qggLuzZGRoCh9sr4jWrkwJ+EjY5tiM3N0=;
        b=HJJkKjiM17ZR+BSuAIdgSC/iX0c2W3aGeaEwQ/BkDoj1xEiRFrJgx0GT0HHYSlIMtq
         pzpfxOfs7Irk25RLPwNrw/6Z6SneBkDc+tYkwBAdQGOWpdnxlrHLrn8HMQueYxLTmlI3
         k4Oi2f/eMKQrXfIniofodNGf4tpzD8ppDlWzP+8L16qYFVCWIjU9+JVO46/PUam63i0p
         zJeI12zc98kKBqiEyi6j9dgFWZFUppkN3JzShjctIZtLmbG3cntGx/z+/wzK7P3viITG
         6O0tFzAUWZRHvyO9uQEuK5Y4Hpv+dyd2PuV+DIeZlYTlIGD2/o1HPov9Gnnpe9xP6Gus
         BITw==
X-Gm-Message-State: APjAAAWi+0iSDEyS+861R4OL6xMUozJyjg5ZguFpFpzkHMqOXoQscKh8
        iYDTubTJlX6gFtDGIbo1kxQ=
X-Google-Smtp-Source: APXvYqzcIhJWZSE9dPlmCIf2Xdf8Qycn3QUyq9sJSzJAC2oEZSLF1D4zs6n1ThUeXEpLFwNiNuHQ6A==
X-Received: by 2002:adf:a415:: with SMTP id d21mr2507527wra.94.1569336042062;
        Tue, 24 Sep 2019 07:40:42 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-10-31.as13285.net. [92.22.10.31])
        by smtp.gmail.com with ESMTPSA id z4sm2153415wrh.93.2019.09.24.07.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2019 07:40:41 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] add a Code of Conduct document
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, git@sfconservancy.org,
        Derrick Stolee <stolee@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, garimasigit@gmail.com
References: <20190924064454.GA30419@sigill.intra.peff.net>
 <20190924090152.GA7209@szeder.dev>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <9e65e95c-4a8d-c904-d8e9-bdd494f41ce0@gmail.com>
Date:   Tue, 24 Sep 2019 15:40:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190924090152.GA7209@szeder.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Gábor

On 24/09/2019 10:01, SZEDER Gábor wrote:
> On Tue, Sep 24, 2019 at 02:44:54AM -0400, Jeff King wrote:
>> [...]
>>
>> After some poking around at various CoC options, this one seemed like
>> the best fit to me. But I'm open to suggestions or more discussion. It
>> seems to me that the important piece is having _some_ CoC, and picking
>> something standard-ish seems a safe bet.
> 
> We are decent people, and know how to behave properly and treat each
> other with respect.  It is my fundamental assumption that all future
> contributors are decent and respectful human beings as well.

History suggests that almost all will be decent but there will be one or 
two who aren't and cause trouble.

> A CoC
> like this, which is "explicit about the behavior we want to model"
> (quoting the original discussion starter) inherently insinuates that
> we aren't decent, and can't behave without being told how to do so.
> Frankly, I find this borderline insulting to me, to my parents, to all
> fellow contributors, and to future contributors as well.

I don't find it insulting, to me it just sets out that the project 
welcomes contributors who behave decently.

> There are locations, nationalities and cultures, where the avarage
> wide-spread CoCs, like Contributor Covenant and its derivatives, are
> perceived as (paraphrasing) too "American", politically overcorrect,
> corporate BS, etc., which are forced upon open-source projects.
> Consequently, such CoCs are often found rather discouraging, and
> announcements about their adoption in open-source projects generally
> get negative reaction.
> 
> Less is more.  Much-much more.  A concise CoC that treats its readers
> as responsible, well-behaved human beings is met with much approval.

I was pleasantly surprised at how short the proposed CoC is, I don't 
think it's too long at all. It only takes a couple of minutes to read 
and is quite clear.

Best Wishes

Phillip


> Take, for example, the TrueOS Rules of Conduct, which in just a few
> short sentences covers everything that's worth covering:
> 
>    https://www.trueos.org/rulesofconduct/
> 
> If diversity and inclusion of other cultures is indeed a priority,
> then we should carefully consider that some potential contributors
> will rather choose not to contribute because of a CoC like this.
> 
> 
>> If people are on board with this direction, it might be fun to pick up a
>> bunch of "Acked-by" trailers from people in the community who agree with
>> it. It might give it more weight if many members have publicly endorsed
>> it.
> 
> Because of the above I'm leaning towards NACK.
> 
