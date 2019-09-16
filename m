Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B57C1F463
	for <e@80x24.org>; Mon, 16 Sep 2019 21:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731365AbfIPVo5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 17:44:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34159 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfIPVo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 17:44:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id y135so959791wmc.1
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 14:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=85aNPwYZuCpHag3oEoNhjBSgdMPL3XJ3CsfaigvLQJ8=;
        b=Lp443OqfKXqBY55S7xAqXn15taPpXtcwwYr4CxxrAglRvfnkIQB9EWt9F3sHZQBATL
         2hO3ID8YPM5k3UeCzeWTopXFXpSKu2ZVIEvdcezgD9VtvkHElJF6x1H6rYBCYSqe0w+R
         MPUfRsKFKQIabIPoS1DcldMmKw6uEfDCbpJUSq8Hv1VYQ1YQ1CtjRsxCszIo/itILLqb
         hyJN3Jbf8ZIJ2YHIfSiOo+B0P2P6otI+sFxqQUt42aOgSbdTFzcstZwOrY0uCAZ8FNkI
         A0kvGvFBUgs2/6enuQow0zO4pDkayVOahUJZ3YtH0lfGvt0m9vzf1vOJVwzSnYrVl4Jd
         lI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=85aNPwYZuCpHag3oEoNhjBSgdMPL3XJ3CsfaigvLQJ8=;
        b=k5mHHyfByhjGDqVeogywTDumk2gho0tevtt1IiZ9l7NgZoE074gSFTUldeadlE+/lR
         To4NcXERa61rGiVBcqSy73kLKHKUqeQSN22BmEv9oNJGARdmDyeOF1m16EmLD0QOqMVa
         ryBfse0+CU8NJQICt5Hn/Bol/RiXSWEBt07yWNKULYJorc6vRV3o3yn9ivLOp5H9KQSW
         IwK5EMEdOWUym6MqTh38toNBpTsv/GZn0LxCylwMK7BlW009OKg7ChXe3mZtrXv7wle4
         BDapz3usgSNdALVXqzqhAq6cy1DY8dSU4ymje7x95P7WZV6x3aPtIz/dUN08Rgn4RsY5
         pxSw==
X-Gm-Message-State: APjAAAV0gmr1TBfq1/3sAiQI88rgNg68uTB4E8qK865O1vk7UKVKlSLB
        lwiutDG0SUh0/aEkT51/M88=
X-Google-Smtp-Source: APXvYqxrwP5ObkEC7HzuIvok9O0/zJ5pDT35M20aCEJZXfAq72VcEvSgqIROVNbTJu0xIDUlNIaHCA==
X-Received: by 2002:a05:600c:2386:: with SMTP id m6mr842161wma.164.1568670295443;
        Mon, 16 Sep 2019 14:44:55 -0700 (PDT)
Received: from szeder.dev (x4db93de7.dyn.telefonica.de. [77.185.61.231])
        by smtp.gmail.com with ESMTPSA id z1sm493491wre.40.2019.09.16.14.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 14:44:54 -0700 (PDT)
Date:   Mon, 16 Sep 2019 23:44:52 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>,
        git@vger.kernel.org
Subject: Re: Git in Outreachy December 2019?
Message-ID: <20190916214452.GC6190@szeder.dev>
References: <20190827051756.GA12795@sigill.intra.peff.net>
 <20190913200317.68440-1-jonathantanmy@google.com>
 <20190913205148.GA8799@sigill.intra.peff.net>
 <20190916184208.GB17913@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190916184208.GB17913@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 16, 2019 at 11:42:08AM -0700, Emily Shaffer wrote:
>  - try and make progress towards running many tests from a single test
>    file in parallel - maybe this is too big, I'm not sure if we know how
>    many of our tests are order-dependent within a file for now...

Forget it, too many (most?) of them are order-dependent.

