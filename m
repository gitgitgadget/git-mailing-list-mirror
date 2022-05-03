Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECD2C433F5
	for <git@archiver.kernel.org>; Tue,  3 May 2022 21:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236795AbiECVXe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 17:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiECVXe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 17:23:34 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAFD4091C
        for <git@vger.kernel.org>; Tue,  3 May 2022 14:20:00 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id z8so19525829oix.3
        for <git@vger.kernel.org>; Tue, 03 May 2022 14:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=L1DSXJYGvLJe86H555tLdEuReQf2uptwlS+P+y+MP2o=;
        b=HyyvDRCQvmNBjFQBrwRGzYpL3WfUhDpP1guzuRyDxitE9Y8WpMgZcqaWpqapU1bJp7
         kZlx2K/XnaqWRrTYXzJClmiZSUYO7mS3qcgb+9Ywm7FE6agpnpfxU+U3N2i7IvchdSTS
         +5U36cQuLfNVzgd3shwOe46XJiGkvsrWZNh3+Iryx1mctUK7Jz14ytFBUv9gT59WW/BF
         attyYHTIm5ksnZsPFHfYPp1zS8KcjFt7NBntx4CoJHc+3ZOBHg6Ze3ZUPyLjRDG1btbL
         /+1vS6BGhPricPQsCRhDjGOxVrsprjxhQoURPGF3HiwtfmzKHfwNQqM4tJux7J27t36/
         bs7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L1DSXJYGvLJe86H555tLdEuReQf2uptwlS+P+y+MP2o=;
        b=BYhXzdE5Xen5m+CYgaDmZTQsRlo0yQKQpXnYMISZwARtzp9MtXGjPrV3ZTNFG0v2yq
         k04hm8nFf2J2DN6RAwxkPiISg/tH0mSIc9O7qLsygOM5oyH5s2LLKjrEHnG5cUukTtCW
         l34vVGR/FdIyeXzBlRBi9f8XvDvSXecLa5MwbIIVoodSmKF7+otSTjg+yOxdIcHLp2ns
         o8NvJ0SwXKvskz3nlommij+UfUL+qMfqJXEMLU6iLGdKYj6gK+jp9CVJa4ATOhO/IIW6
         /6juvpuf/krDZcpbse+8FRI+udV4bsAdiC55+LUsc5uQVOaBMM/lVMOjzVAMRP7wMLRP
         sWGQ==
X-Gm-Message-State: AOAM531Dhd2IMiG4EW+uben/6m/RBZHMZB9je6+DmebLycJu82Jr2G4K
        kT4zueW/KoB67dSaVUuK4FLk
X-Google-Smtp-Source: ABdhPJyhhT69G53i/cAJaNy39BI8ZZx86XooRFaQk/rx96yizCHNz5KsJBTtJWzlsJMWsBnPwyI8vg==
X-Received: by 2002:a05:6808:209a:b0:326:448a:234f with SMTP id s26-20020a056808209a00b00326448a234fmr1081958oiw.206.1651612799929;
        Tue, 03 May 2022 14:19:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:a55e:e9b0:eb22:54df? ([2600:1700:e72:80a0:a55e:e9b0:eb22:54df])
        by smtp.gmail.com with ESMTPSA id y2-20020a056830208200b0060603221260sm4461504otq.48.2022.05.03.14.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 14:19:59 -0700 (PDT)
Message-ID: <0facc01f-ee36-333a-eb25-9c98d616700e@github.com>
Date:   Tue, 3 May 2022 17:19:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: What's cooking in git.git (May 2022, #01; Mon, 2)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>,
        Victoria Dye <vdye@github.com>
References: <xmqqilqnvacd.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqilqnvacd.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/2/2022 6:27 PM, Junio C Hamano wrote:

> * ds/sparse-colon-path (2022-04-26) 5 commits
>  - rev-parse: integrate with sparse index
>  - object-name: diagnose trees in index properly
>  - object-name: reject trees found in the index
>  - show: integrate with the sparse index
>  - t1092: add compatibility tests for 'git show'
> 
>  "git show :<path>" learned to work better with the sparse-index
>  feature.
> 
>  Will merge to 'next'?
>  source: <pull.1207.v2.git.1651005800.gitgitgadget@gmail.com>

I think this is stable and ready to go. Unless anyone else wanted to
take a stab at reviewing it. I think we've got good eyes on it already.

> * en/sparse-cone-becomes-default (2022-04-21) 9 commits
>  - Documentation: some sparsity wording clarifications
>  - git-sparse-checkout.txt: mark non-cone mode as deprecated
>  - git-sparse-checkout.txt: flesh out pattern set sections a bit
>  - git-sparse-checkout.txt: add a new EXAMPLES section
>  - git-sparse-checkout.txt: shuffle some sections and mark as internal
>  - git-sparse-checkout.txt: update docs for deprecation of 'init'
>  - git-sparse-checkout.txt: wording updates for the cone mode default
>  - sparse-checkout: make --cone the default
>  - tests: stop assuming --no-cone is the default mode for sparse-checkout
> 
>  Deprecate non-cone mode of the sparse-checkout feature.
> 
>  Will merge to 'next'?
>  source: <pull.1148.v3.git.1650594746.gitgitgadget@gmail.com>

This has been quite stable and I'd like to see it merge early in the
release cycle in case that catches anything during local testing.

Thanks,
-Stolee
