Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC5CC43334
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 18:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344364AbiFMSoX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343953AbiFMSmP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 14:42:15 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B55286DE
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 08:01:32 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id hf10so4053461qtb.7
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 08:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=n3G2P313xX+uTorxfdTmopxAyu6192yDrydvbg70+aQ=;
        b=DM7nNuOIfHN2uDsLZNOjSVCX/3pMey+7O+60p+gLdAJtoZaGmMXKsQB9n4y4ZlVvRM
         aIPlphCiU1KgnoQYdcg5pmoM2jHfPDfMJCb6MBaytNJmUqo9h+jfMp/CZci62X9U16U+
         0gZo6mbLqOe2EsRIdLcL4naO+UWV10Uo2l4ZUwtRIunOnWw3jj3vPVGVklTdSlbbR9DL
         VC96FR6AD425ixOCfNBjFLWSeyaFiKbE1obOBbER7oxt8Cl4jIiCzCMOYZmPtVFWnhAI
         Mc9brfxL1Hnf7BKpzjvRk6HFsc5wYn91Ye7cD9eVEwwsgKreaM+4PzTVG5YA8q+t/ZzH
         08DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n3G2P313xX+uTorxfdTmopxAyu6192yDrydvbg70+aQ=;
        b=Z29YTIwYCBbo8G9XGeWZdhjux5EhxfjZRrfur9H8RFashP49K2zggudHhE04sjgger
         WALJtIhhlEfM988u5p1weekxBYW9LW00uAwCig28JrbTpCecvZpLKyzQ3oR3ME7DaDr2
         ptPa+6eQu4jpaNx923UgKlVwGuDIzLWguA+68A8j3SM58E3jC6FOLQAO+G1RAD0PMARU
         bVwYNz8wvY61ae0vLDyh9JsvtxWNY3ZSi2fs9H5hId52F/DyVSM0IORvSKYCE7Je1jl2
         cof8I0KNeLMu0nhxQ9cdlgHrk0jHyv+ZKJuBUvVw5PFKRZIxCYOToY5K3d8u0J+tC2TQ
         5ybA==
X-Gm-Message-State: AOAM532XODX5csSlbsyZLs9CdM/leoAPWgx/cUJFsworFoyhgWFXUI17
        xuZxewTk/pEPJIhKW7qI5udPdcri/0BK
X-Google-Smtp-Source: ABdhPJw/KHlon+2MEqgv9PLjVUD9M8pwfBOpQDYWLgMLOFCuBzpweurfgkKkPb0GaQKfI6hcSZr/yg==
X-Received: by 2002:ac8:5d49:0:b0:304:eb9d:4c49 with SMTP id g9-20020ac85d49000000b00304eb9d4c49mr72253qtx.153.1655132491403;
        Mon, 13 Jun 2022 08:01:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:170:45d1:1083:f688? ([2600:1700:e72:80a0:170:45d1:1083:f688])
        by smtp.gmail.com with ESMTPSA id f19-20020a05620a409300b006a6278a2b31sm7267976qko.75.2022.06.13.08.01.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 08:01:31 -0700 (PDT)
Message-ID: <07eb5cce-2948-a653-a941-c8fe0924aee2@github.com>
Date:   Mon, 13 Jun 2022 11:01:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: ds/branch-checked-out (was Re: What's cooking in git.git (Jun 2022,
 #03; Fri, 10))
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqsfobc1hw.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqsfobc1hw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/10/2022 11:39 PM, Junio C Hamano wrote:

> * ds/branch-checked-out (2022-06-08) 4 commits
>  - branch: use branch_checked_out() when deleting refs
>  - fetch: use new branch_checked_out() and add tests
>  - branch: check for bisects and rebases
>  - branch: add branch_checked_out() helper
> 
>  Introduce a helper to see if a branch is already being worked on
>  (hence should not be newly checked out in a working tree), which
>  performs much better than the existing find_shared_symref() to
>  replace many uses of the latter.
> 
>  Will merge to 'next'?
>  source: <pull.1254.git.1654718942.gitgitgadget@gmail.com>

I sent a new patch that sits on top, fixing the memory leak
that you pointed out. Please take a look when you have time.

> --------------------------------------------------
> [Discarded]
> 
> * ds/rebase-update-refs (2022-06-07) 7 commits
>  . rebase: add rebase.updateRefs config option
>  . sequencer: implement 'update-refs' command
>  . rebase: add --update-refs option
>  . sequencer: add update-refs command
>  . sequencer: define array with enum values
>  . branch: add branch_checked_out() helper
>  . log-tree: create for_each_decoration()
> 
>  "git rebase" learns "--update-refs" to update the refs that point
>  at commits being rewritten so that they point at the corresponding
>  commits in the rewritten history.
> 
>  Retracted for possible future redesign.
>  cf. <pull.1254.git.1654718942.gitgitgadget@gmail.com>
>  source: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>

Thanks. I will revisit this topic after the release window.

-Stolee
