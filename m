Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DC8C433F5
	for <git@archiver.kernel.org>; Sat, 12 Feb 2022 18:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiBLSNC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 13:13:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiBLSNB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 13:13:01 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEBB5007C
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 10:12:54 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id c5-20020a17090a1d0500b001b904a7046dso13445147pjd.1
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 10:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R7jcVzbUS+WJL+PhCHC4J+F60gufl+eAEeCan6eo3WQ=;
        b=MP+av9584mYsjusMrqEBOEqUTL6XPzWUN/kHhdRlpRv/x+iqXhnba7kx4m/pcirdt5
         MqQwcHJzbYHhHo8HtLH+E9P9n10oWnvbU11+xw9T8/jxgxOSt5Ju7XF5Q7TCOwhXJQfM
         6H4dOTfi/VdTLkSjHy5ijwvQlQ/b3+5XCEEnotw8jwbVBHVS5KIDjCjvrby5a37uPUbI
         zWkw3rjkEaTVodFB7TsBg6aJZlztTgvdnKpiS8ItqJbZBTAYzZkhel4ot+cfhMdvGoRE
         UjsT89YfxGWon0PHNL6xwMEsG/FnH5vCz8T58s4RH85MJYTlewSbBRZSAd3KW8y8ADVc
         f4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R7jcVzbUS+WJL+PhCHC4J+F60gufl+eAEeCan6eo3WQ=;
        b=IeYtwNZ6CCdoqj+xJithwjrK1CqWxcmLg+9Pl1Vg2AEqHrKpX+kb72+C+CCciE6D3W
         uT7cJ66YecPZ7mokbEyHpfqrqCW6VRwhQVKhH9ZMPug7sM/wtOZdUAm0MUin9cKcB8dm
         NJHocT/tj6J8QvLVp4E+s23WH5URayZYH48Qq+KqWfMr0/ubU4LGzLlF6RICUGegjbd0
         hpxG9B28ROi8OIDGIig/Fcv1aIGFrcZRcUiOdsZwpWqrop8+DAdPv3WGUpmQY329gsut
         zV7MmZtZUZEwMobmfoRIxcdIcIf/KEWFpSTlneVRm1kOlkYG3ZDk7ESp3pjuXotvCHT0
         54QA==
X-Gm-Message-State: AOAM531UCX7MmNFsLkNabznPtMuCdSGuFVALoeuRs5IPKLjZQKkvMyGz
        ntrceV6yTQQCL+62Ap7xdKkduKamo7U=
X-Google-Smtp-Source: ABdhPJz1iWqNttAMT4p26ux5HV09V5hdGRd0TW5PwW/j2oS7xmus3eaa2mDplEmpMMQF542wfdbfwg==
X-Received: by 2002:a17:903:244a:: with SMTP id l10mr6842283pls.32.1644689574393;
        Sat, 12 Feb 2022 10:12:54 -0800 (PST)
Received: from [192.168.0.108] ([183.82.176.65])
        by smtp.gmail.com with ESMTPSA id v20sm8759468pju.9.2022.02.12.10.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Feb 2022 10:12:53 -0800 (PST)
Subject: Re: Git in GSoC 2022?
To:     Philip Oakley <philipoakley@iee.email>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        Git Community <git@vger.kernel.org>
References: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com>
 <730fb307-3bc7-b52f-49c1-d83b5ab55c95@iee.email>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <3b112eee-8110-baf6-d7e7-cb25b03c32ff@gmail.com>
Date:   Sat, 12 Feb 2022 23:42:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <730fb307-3bc7-b52f-49c1-d83b5ab55c95@iee.email>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/02/22 7:42 pm, Philip Oakley wrote:
> On 26/01/2022 18:29, Kaartic Sivaraam wrote:
>>
>>    - Project ideas: There are two mentioned in SoC-2021-Ideas[3]
>>      but both were picked by GSoC students the previous year. So,
>>      we would need new ones this year.
> Git Demonstration Repositories
> =============================
> 
> One idea/concept that I've had that might be suitable for a project
> either here or within the Google Season of Docs is to generate
> demonstration repositories that match the examples used in the
> documentation and parts of the test suite to help users explore and
> understand the concepts that are being documented in the man pages.
> 
> It's more than a classic coding problem because it impinges on a lot of
> subjective and admin areas but should be fairly beneficial for users.
> 

This does sound like a good idea.

> The two examples that come to mind are the --show-pulls repo [1], and
> the 'history simplification' repo [2].
> 
> Using the test suite as the repo generator ensures the Demo Repos are
> reproducible/deterministic.
> 
> My latest thinking is that the repos would be held in-tree under
> /Documentation/RepoBundles and have been exported as bundles by an
> explicit test_export_function. Of key importance in the project is to
> minimise/eliminate any extra maintainer actions, so once a patch with a
> repo export is accepted, the flow through the delivery process to user
> installs is essentially the same as the man pages.
>

We could possibly include this one in the idea list but I suppose we might
need a more concrete idea on what needs to be done as part of this project.
That would help very much with guiding the student during the project
period.

We also need to know if the end result of such a project would be an
acceptable contribution to the project. What it would take for the contribution
to be acceptable? etc.

Just to make it clear, I'm trying to think through on what we need to do to
make this a GSoC idea proposal.
  
> Not sure if that's fleshed out enough, or if it's at the wrong level for
> GSoC, or If I'm right as a Mentor, but I'd be happy to co-mentor.
> 

That's nice. Thanks for volunteering.

On a related note, the organization registrations are now open for this year.
The deadline is February 21 - 18:00 UTC. I'm not sure if anyone else is
planning on applying for Git. In case no one else beats me to it, I plan on
applying for Git around February 15 17:00 UTC.

-- 
Sivaraam
