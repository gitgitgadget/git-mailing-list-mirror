Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C83BC207DF
	for <e@80x24.org>; Sun, 18 Sep 2016 10:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756101AbcIRKVg (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Sep 2016 06:21:36 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37551 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755474AbcIRKVe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Sep 2016 06:21:34 -0400
Received: by mail-wm0-f50.google.com with SMTP id b130so16219343wmc.0
        for <git@vger.kernel.org>; Sun, 18 Sep 2016 03:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=NkPUUEwbnppfiyK1H7ibAcPpqWGVt2eCTaU5U79hurM=;
        b=gUhLuUqnH+5jIaRBa1NvEyGfdjLH7x3XBlVqad7CplsVzHRbSHMG0rB7je8O6g5VzB
         tTR4AC4aARzJ6WDk6DtZLCtTfWHt0Bceyz7b41tWlAi+JW/s6B4E/RjSyZFkt2iWCl6v
         bkR+8Z/TvMRz0A7FPTATwRRe+jpBKUOpF38lrm69MVhaY1rGvpJG53TeGg3ZiTA+zZcz
         D7wvtzcqZWsZyn8KcEeeKWTpAz2pcPv/NC49inolpE8XGf1Y9tDk9YoWbAQFuh3ivvCE
         xnL5ReqoVb4d2Fp6XypeNdguexhozj31nvkBwaa/e0KAsxM39jvBp5ZAort4wW/M/k4K
         MWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=NkPUUEwbnppfiyK1H7ibAcPpqWGVt2eCTaU5U79hurM=;
        b=hLdEx/Rp+1NcgvCNxgE2aeovEzUOyRO7UFsWTUP8kMioJcbH1exBAlNYdP9ISRdEkN
         kZmfBhxxw8gKz4mCh5kRdUQ5/VsrmdK8V0pxSjXcTPuwskDxMHa1kEC9TKq/SSxFWnzn
         xo53VxWeFJLPuKakwl0PLqMVK8dE1hsRn3sGoRKdqX5Mpou4HX2Xzyglpo3s1Y+5edij
         y0WCN9TdwBMEr3HpGvtLsfsvFvEpHxrHbIPG642Eck6xSR9Q1NECjMZGld8AoL4rkVxq
         2TspzsBD4pPEJ0fu6sCjd1iiwQ7XSm+eqFOtTjIuDKEjeNynFzVTYZY1/4tXjXZ4jOyE
         0M5Q==
X-Gm-Message-State: AE9vXwP8vWbi1V26px3Fx5RhHNsa9Y6T15W/ReF/sVlJjrtQpEUa+2ZKvzj8m+7BqUA5IQ==
X-Received: by 10.28.8.130 with SMTP id 124mr4566041wmi.81.1474194093417;
        Sun, 18 Sep 2016 03:21:33 -0700 (PDT)
Received: from [192.168.1.26] (enz69.neoplus.adsl.tpnet.pl. [83.20.15.69])
        by smtp.googlemail.com with ESMTPSA id ce6sm17245033wjc.27.2016.09.18.03.21.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Sep 2016 03:21:32 -0700 (PDT)
Subject: Re: Why are there multiple ways to get the manual in Git?
To:     Fredrik Gustafsson <iveqy@iveqy.com>,
        Andrew Johnson <ajohnson388@gmail.com>
References: <CAM_5GX48gDAZSvAWnxO5n8uhYf8vmfAJ88_31_ewsQxyPfF7iA@mail.gmail.com>
 <20160917183919.GJ20666@paksenarrion.iveqy.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <223e818d-6d10-2679-c2d0-150011e74a59@gmail.com>
Date:   Sun, 18 Sep 2016 12:21:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160917183919.GJ20666@paksenarrion.iveqy.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 17.09.2016 o 20:39, Fredrik Gustafsson pisze:
> On Sat, Sep 17, 2016 at 01:47:52PM -0400, Andrew Johnson wrote:

>> $ git help <verb>
>> $ git <verb> --help
>> $ man git-<verb>
>>
>> I tested all three to confirm they were equivalent.
> 
> While I'm not able to answer your question, I can shred a little light
> about them not being equal. For example using a windows machine
> 
> $ man git-<verb>
> 
> does not work and
> 
> $ git help <verb>
> 
> opens a webbrowser instead of a man page. Using a unix system I would
> however assume that
> 
> $ man git-<verb>
> 
> would work since it's the standard way of getting help on those systems.

There is also additional difference.  There are help pages which are
not about specific Git command, but about concepts (gitcli, gitrevisions,
githooks, gitrepository-layout, gitglossary), or about files (gitignore,
gitattributes, to some extent githooks).

Those are only accessible with `git help <concept>` or, on OS with
installed 'man', also `man <gitconcept>`.

Just FYI
-- 
Jakub Narębski
