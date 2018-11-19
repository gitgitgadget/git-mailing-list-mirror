Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88D3D1F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 19:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbeKTFfk (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 00:35:40 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:38652 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbeKTFfk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 00:35:40 -0500
Received: by mail-qk1-f169.google.com with SMTP id d19so50476907qkg.5
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 11:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=eBKeFHYie+Z9p2eRfCIrEO8E16TB2HtAsjLISQRq8a4=;
        b=gkTAQF/z0bgjfdU8K5lQL0br7uQ9Wvn2RdqdjsAdhW3sX/rKoGlddUd7qCwoHvvOCv
         fGFyYOh0oZ+4ZBNDES1am4vbkaLo59CozBkb3Sk4BkGOEV5mRpO+vBjtDLA6k0Lly12h
         IWsoxmE6EyqHDcRY6dE+rr64kSKsC+WXzMMC3TpIBSzDZrh13IuXoucQxTD4WU5NOhB1
         IbOKdHipjh+qiUX5bhdHIfsRASk9Cdgol7og8hs1hx+GiYhrrj/RiDDr9jmp6Ahawl9I
         uEh3NfObAQkacrOUQnYnBFueTGmO15YcbnF2V955xIb5qtw6nn/GVb+ZzjIAj08kyenQ
         ZUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=eBKeFHYie+Z9p2eRfCIrEO8E16TB2HtAsjLISQRq8a4=;
        b=ttVhYTS7mhF72148802/e6weN3gjmU3yDs/geF27laoNGfSVJmu13dREPrpHTOekeA
         Tusxn522pJrI8iayMghjCNVGWLvuIPHLNe4P5XSRCdxabw3hTFRXny3FXCAYHlFw+Mus
         8le3rl57xt3z0gKUZT3nsvJ4vew/48Mp6OorKdK8WfU7WTv69191wc18woE5Cr/NRuco
         V3TUghjW89R7drQjrSqRIzmS/kIqNvR6Fr8/68L07inBUBMrTXyxTnw9bRvezjNF63wT
         PUY2N7RVueBqOpnl2gtmfCogJPEh86xSDF8aymL8YW86i1FtAlMhQQD7J3Pd+Lgbj8zc
         4mKw==
X-Gm-Message-State: AGRZ1gIeerVULfAFcg0/KQerOmPHmYvisIJgQUzmoxnybTSalf4eLn/k
        ZmekYolWK2jP9oaG8zXhGY9c3mJ2
X-Google-Smtp-Source: AJdET5chG+8FGfTeTjVE8E0S9Hm2plBURmg2KS5XUj2D58ZILXdIWcEYB9dEykGKg5blTm6neIfYSQ==
X-Received: by 2002:a37:aa0c:: with SMTP id t12mr21279249qke.358.1542654641374;
        Mon, 19 Nov 2018 11:10:41 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:9842:9c91:9414:a691? ([2001:4898:8010:0:8178:9c91:9414:a691])
        by smtp.gmail.com with ESMTPSA id c77sm28214410qkh.82.2018.11.19.11.10.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 11:10:40 -0800 (PST)
Subject: Re: Git Test Coverage Report (v2.20.0-rc0)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <9e293b1b-1845-1772-409b-031c0bf4d17b@gmail.com>
 <871s7g29zy.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <37b2c29d-43bb-9987-e91c-cb3e6b65d354@gmail.com>
Date:   Mon, 19 Nov 2018 14:10:39 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <871s7g29zy.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/19/2018 1:33 PM, Ævar Arnfjörð Bjarmason wrote:
> On Mon, Nov 19 2018, Derrick Stolee wrote:
>
>> Here is a test coverage report for the uncovered lines introduced in
>> v2.20.0-rc0 compared to v2.19.1.
> Thanks a lot for this.
>
>> [...]
>> builtin/rebase.c
>> 62c23938fa 55) return env;
>> [...]
>> Ævar Arnfjörð Bjarmason 62c23938f: tests: add a special setup
>> where rebase.useBuiltin is off
> This one would be covered with
> GIT_TEST_REBASE_USE_BUILTIN=false. Obviously trivial, but I wonder if
> the rest of the coverage would look different when passed through the various GIT_TEST_* options.

The coverage report has been using the following:

export GIT_TEST_MULTI_PACK_INDEX=1
export GIT_TEST_COMMIT_GRAPH=1
export GIT_TEST_INDEX_VERION=4
export GIT_TEST_SPLIT_INDEX=yes
export GIT_TEST_OE_SIZE=10
export GIT_TEST_OE_DELTA_SIZE=5

I need to add GIT_TEST_INDEX_THREADS=2 and GIT_TEST_REBASE_USE_BUILTIN=false

Thanks!
-Stolee
