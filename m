Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAEEC433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 23:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240598AbiC2XfA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 19:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiC2Xe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 19:34:58 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AEA532FC
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 16:33:13 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id s11so17230136pfu.13
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 16:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=TgpjAvdWdJ6e68qMLZ3Q/WPVdmSJ8HYIvkEVEFJ54zk=;
        b=HtMUWcau3Vln4YPsFlvFRAZIlTYrYZzS8s1Mn2HsnP0/N41zfFkaHCXVD6h2wCahZO
         xQMqblSW7yDjZffuMZCcy30nhFL+5GKaMd+mwdc1hqRoWQttuJF3q+xSZVjmaUKUeC/g
         1UTSpr/ixwWVK1bI4ETZlpOa5+mxbahFGXa1xme2XP/H5OBi/nyKFRbT9kzNYFQQjf13
         ALdherWCENdf3OqmUeP12+h1eQHvytRS/2DBPByYuohtJv4aQNm8C+ItdH7cXZfzWZh/
         hohowpKt/ujh+qwNbjR3JC0HMjnrEfL3mC8r/9tX5nr3i6pks5mt00fROwvb1nqgvj16
         L+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TgpjAvdWdJ6e68qMLZ3Q/WPVdmSJ8HYIvkEVEFJ54zk=;
        b=U2B8V2j4gcBDC3IQQKwVnNtQUW3JhIAkyfgowvpS9W/Eid98HJbxgs7ry55ZeKmg7h
         FblZwUMwMUiWQM6Bk1rYVuFLsLw6OODT8s74MupCGi4stx5AqNzhNpOAwusob0Xaolz5
         qS9vwsuhdNFTnLdKllz33MmUfn/L1dF8T4c3AxjIQ7Md8cl7E7ziV7UOHeG7p5ItehEo
         KAQUGNgTgsnx90tI5WEAFa30SRAsGmF2XbjNb2J/RJmPDbpoarVnVidOW3LeeJVQEkWs
         q5WeAlDoNWRp7i1jjzudGAViVFsAbtn0wBVhK/yok/VaE5tISOX7HVw8yCjskpSUQyDf
         8x3A==
X-Gm-Message-State: AOAM5301IwuOL2K4542eehUwCvGRvvJ5jYVQQZ1MfMhkAhy7L4gqdjEq
        RkWs848jGY3vmTD3+6fettwt5T4+9pGm
X-Google-Smtp-Source: ABdhPJzOEv6V+UCSRmPo6xEYMkTCamz1J48TVydzxzAb97bqmrWhD1uq+DnybALMGWDtWfjJ96jN3Q==
X-Received: by 2002:a63:9dc6:0:b0:398:6e02:c105 with SMTP id i189-20020a639dc6000000b003986e02c105mr3859004pgd.495.1648596792722;
        Tue, 29 Mar 2022 16:33:12 -0700 (PDT)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id z9-20020a63b909000000b003823389e47csm16868038pge.9.2022.03.29.16.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 16:33:12 -0700 (PDT)
Message-ID: <2e50d310-5014-d2fd-b145-6d7bf4e370a7@github.com>
Date:   Tue, 29 Mar 2022 16:33:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [GSoC] Applicant Introduction and Microproject Selection
Content-Language: en-US
To:     Labnan Khalid Masum <khalid.masum.92@gmail.com>,
        git@vger.kernel.org
References: <CAABMjtFTy++Rvty+4TVXeEegEMhJ6c0_jW06x=G-pLh8fLPf9Q@mail.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <CAABMjtFTy++Rvty+4TVXeEegEMhJ6c0_jW06x=G-pLh8fLPf9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Labnan Khalid Masum wrote:
> Hello Everyone,
> 

Hi Labnan!

> I am Khalid Masum Labnan, An undergraduate at Islamic University of
> Technology, Bangladesh, Currently majoring in Software Engineering. I
> would like to get involved in Git development as I want to be part of
> this community and would like to use GSoC as the starting point.
> 
> I would like to submit a patch on the microproject "Use test_path_is_*
> functions in test scripts", by changing test t3501, if it is
> available.
> 

Absolutely! I'm not sure how much progress you've made on your patch, but
here are some resources you might find helpful:

- This particular microproject has been around for a while (at least since
  2019 [1]), so there are some past submissions of changes to other test
  files that might serve as a good reference ([2], [3]).
- If you need information on getting started (or even just how to submit
  your completed patch), you might want to take a look at the
  MyFirstContribution guide [4] - it's a really nice guide for getting set
  up for Git development.

Looking forward to your first submission!
-Victoria

[1] https://git.github.io/SoC-2019-Microprojects/
[2] https://lore.kernel.org/git/f881f01e4f05c1c9ad7e35fea5fd7db2947427a1.1551349607.git.gitgitgadget@gmail.com/
[3] https://lore.kernel.org/git/ERmIkC3rLZ3BAyv2Nq_GK0CjWvEQw6ejl8V-HVvwCsyIv0guQV67nO8KMLi7eA9qO5mo_ZJ8XB360uP_LtP-LY1xsaRBXHsc0F1uSID-KPE=@protonmail.com/
[4] http://git-scm.com/docs/MyFirstContribution

> Regards,
> Labnan

