Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E06BB1F424
	for <e@80x24.org>; Tue, 24 Apr 2018 21:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbeDXVLf (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 17:11:35 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:37650 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbeDXVLe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 17:11:34 -0400
Received: by mail-wr0-f179.google.com with SMTP id c14-v6so11181938wrd.4
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 14:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9WwXgoAnm5gjVgs3r54K124Mja/g0CRKWwdZhV5L55w=;
        b=eSz/6jokHcDhAR76cj5jPHHzvyzXCSk9TnOIwWDOi0o4X5g5ZLZF9ye8gaUX2YBfg4
         LnFMo6q45AU4Y1J8caM0buyKwGFQF6qhmdGGvEvmfL2vxJLHPPg2mj/aBOxuQ2Z3lp3/
         NbhEBCkQf64TG1u8Tyvv8Q+MSXWd+ttMg9MSkTZNEgwT4T0sI0PvRDt8gKag12R5EN6P
         FF2n9oiba0xGV69FLONyD0UyCYnG4sdfRNKkMxBaVWxRP65GOmvbtptqtSjZozD7NMbr
         CKB1sly89wZEBve3O760/wKg/xEpXt5tW0725dv9Volhk2z29DALAPhv2lDgKDjg50gg
         9W1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9WwXgoAnm5gjVgs3r54K124Mja/g0CRKWwdZhV5L55w=;
        b=nCXnCa01u5Lb/BYyRGTsBgF32oCIZnP5N+9oI7DToIgiwPDuFyjRFaWfrhi9LV2ocJ
         H+CDkfMe6k0mYDtKWdFeHabr/NNCA0LxZ/94x7zTf7+XChO9ATsRxgQGPtXnKX4fk31k
         qiGpwVkFqM5xNUU6UESXdDwOeLylj8XBDVJilYTcntBW+U3hLD2JZ8vctnJJhiEufIqM
         Bd/j/UpNifOhc8RnZi+Ak895ABysi/W17AWaJZYU0hsb7TZ0fg18TTeYB4ZqOimmfoW0
         bjj6l8WpZmoGY8zQVbeuj3pB7t7qbSlAZedaqBbvhUOiAt/8+T1J9X5Yo6YwgFZfNvgQ
         6RCg==
X-Gm-Message-State: ALQs6tCt4RTdYHjtTffOFR7G92VAMhX3OPJsfVENUESutwUb5jPQtiwr
        l1StsUo/aBZ9z3R6QEbCUds=
X-Google-Smtp-Source: AIpwx4/X8kJhuDXytS8euPydI0GsmhCV1d4Wob8bWCqH0ZoubzSHLHGjU0Vx5Y3J15Lgn9mqlGYjwg==
X-Received: by 2002:adf:b594:: with SMTP id c20-v6mr21783107wre.65.1524604293569;
        Tue, 24 Apr 2018 14:11:33 -0700 (PDT)
Received: from [192.168.0.103] ([92.55.154.57])
        by smtp.gmail.com with ESMTPSA id u36-v6sm27454327wrf.87.2018.04.24.14.11.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Apr 2018 14:11:32 -0700 (PDT)
Subject: Re: GSoC students and mentors in 2018
To:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Cc:     Pratik Karki <predatoramigo@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        alban.gruin@gmail.com
References: <CAGZ79kbzFGn2-xcrWFi1+ZUgSGGHdUPEQOexu8Lan796LCsvBg@mail.gmail.com>
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Message-ID: <ee9499f1-5657-1f23-08a7-0abefc688ff1@gmail.com>
Date:   Wed, 25 Apr 2018 00:11:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kbzFGn2-xcrWFi1+ZUgSGGHdUPEQOexu8Lan796LCsvBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 24.04.2018 00:01, Stefan Beller wrote:
> Hi Git community,
> 
> This year we'll participate once again in Google Summer or Code!
> We'll have 3 students and 3 mentors, which is more than in recent years.
> 
> Paul-Sebastian Ungureanu mentored by DScho, wants to convert git-stash
> into a builtin.
> 
> Alban Gruin and Pratik Karki want to convert parts of git-rebase into
> a builtin. Both are mentored by Christian and myself.
> 
> The slots were just announced today, please join me in welcoming them
> to the Git mailing list! (Although you may remember them from the
> micro projects[1,2,3])
> 
> [1] https://public-inbox.org/git/20180319155929.7000-1-ungureanupaulsebastian@gmail.com/
> [2] https://public-inbox.org/git/20180301111907.17607-1-alban.gruin@gmail.com/
> [3] https://public-inbox.org/git/20180327173137.5970-1-predatoramigo@gmail.com/
> 
> Thanks,
> Stefan
> 

Hello,

It is a pleasure and an honor for me to take part in Google Summer of 
Code. I am sure it will be a exciting summer and I will definitely give 
100% to successfully fulfill 'git stash' project!

Best regards,
Paul Ungureanu
