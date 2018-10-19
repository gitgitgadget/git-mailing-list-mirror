Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A585D1F453
	for <e@80x24.org>; Fri, 19 Oct 2018 13:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbeJSVqd (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 17:46:33 -0400
Received: from mail-vk1-f173.google.com ([209.85.221.173]:39640 "EHLO
        mail-vk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbeJSVqd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 17:46:33 -0400
Received: by mail-vk1-f173.google.com with SMTP id y69so3767322vkd.6
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 06:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=hsycDTHWMfihgtkBheqNyl4wH4V3XIjVDgCBJioUCP0=;
        b=sAH3dudrfDEmczJOz7iLh4/XOO0vYhf2HseyQNfuM2EjKd13/HDdXRJYlv4x7x0TI/
         +ZGZIBKvy+IT4VW8n8iETXeWSLhVWq1321HFYc3iMpAYrj5mFHiEF+Ukt47Dmt12RZBH
         3am0EPu2tMnlv3kjfxfxYn7q/fJTWn2SV4QscwlmK8q7DalxfKrro5ZJE/gANs6kluy2
         wxj5VW3O0ivopxFwqbjUNMYr5CYdEGqtyPq13WZM3K09XlyoiGaTtxx3aj1kYU5ualms
         lUfaUWtegcB9P9b25yQvEkutm+x54Ll0T2QolO5WjXCoHCs75Abvc6fJyu0fO1XmZLdP
         v37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hsycDTHWMfihgtkBheqNyl4wH4V3XIjVDgCBJioUCP0=;
        b=GHIweewakENiQUCLbhlXDvEhWukdjHs2ttGWRPNzwvKJvf/xKw5ne9PTM37W66iS74
         7B0nbZn7qXgV2Omg9WofRgrdxMe1yGFUYUh9mMeqNfZTIovOn0IDxvZD6GzkT/mONpe8
         GhWPlRyZmJaRvxbed3+0rB+WaHy+LVoIU02S34LrNuP8Ul7h84qVPqv0qU738zMTaGf/
         KwfkcPGS7/BumLeFhQukIiSQxcoKZz8tTR9tXBksHh23ntn3oZjjULlVE4dJ9+GpeWxj
         MyWluQaAcC9qjN+BJFT+ag7ct3tKKvwdYYnzEOqh1KQ7/p534ydxuBseFGvyO2+fxCwK
         ShBw==
X-Gm-Message-State: ABuFfogJEDs8E7/lMGH2urmd4zG4gWsvvM2xbPJ52YkZHexm6QFUuwBc
        KWhmU5h/D/9ek/XYCkj2oPoAhhAM
X-Google-Smtp-Source: ACcGV63PUUjCSx6mYyS+vrffp1Fx6Nq9AdSofN5my6vdHXqnrmUYHYNYeCp2X2869hbjpGDRVSNZhg==
X-Received: by 2002:a1f:6e0f:: with SMTP id j15mr9586265vkc.49.1539956421866;
        Fri, 19 Oct 2018 06:40:21 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:e0ed:6621:9414:4d4e? ([2001:4898:8010:0:ca23:6621:9414:4d4e])
        by smtp.gmail.com with ESMTPSA id r123-v6sm6761408vka.16.2018.10.19.06.40.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 06:40:21 -0700 (PDT)
Subject: Re: What's cooking in git.git (Oct 2018, #04; Fri, 19)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq8t2u1nkh.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <529dfd89-a5c9-fb14-fe9c-bb2fd78a59fd@gmail.com>
Date:   Fri, 19 Oct 2018 09:40:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:63.0) Gecko/20100101
 Thunderbird/63.0
MIME-Version: 1.0
In-Reply-To: <xmqq8t2u1nkh.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/19/2018 2:02 AM, Junio C Hamano wrote:
>
> * ds/ci-commit-graph-and-midx (2018-10-19) 1 commit
>   - ci: add optional test variables
>
>   One of our CI tests to run with "unusual/experimental/random"
>   settings now also uses commti-graph and midx.
>
>   Will merge to 'next'.

s/commti-graph/commit-graph/

> * ds/test-multi-pack-index (2018-10-09) 3 commits
>   - multi-pack-index: define GIT_TEST_MULTI_PACK_INDEX
>   - midx: close multi-pack-index on repack
>   - midx: fix broken free() in close_midx()
>
>   Tests for the recently introduced multi-pack index machinery.
>
>   Expecting a reroll.
>   cf. <8b5dbe3d-b382-bf48-b524-d9e8a074ac4d@gmail.com>

A reroll exists: 
https://public-inbox.org/git/pull.27.v2.git.gitgitgadget@gmail.com/

Thanks,
-Stolee

