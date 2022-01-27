Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37CFC433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 14:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242506AbiA0OjS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 09:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242502AbiA0OjP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 09:39:15 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7AAC061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 06:39:15 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id b12-20020a9d754c000000b0059eb935359eso2734460otl.8
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 06:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eHSxnbyT5f7IQMy8RXXYhnOlGOo3q1AuUfcQUqqD7O0=;
        b=cIEXpbf5yFcIEV8n1eB6+ibTUqNQUmGHUyBbzvs7NFQqE6uc4OJpvhui+xZP/R9E7W
         Gym6fp00BXnmRp5eemi8k/9vPTS272n+QgEuxWbhbYvTFCEXZ3hNMBCzyX+MxGVy/FrG
         6cEr5pVUuYLtO4AbQ1mIPCKRARtGeYsMsjuf42uVx7kfWuLM4i1+MTD3KjUxkJIqyFig
         KKKT5zuKovlyqkE8LrNV8CxLJ59Q7OGKTRplx2fuwCbD8aVPNIM9rxzo5P/nVcxOJcNG
         W1C80Lvzrs5lhTeHTYeuH9oh04tSFjpZN2oVel4wdkTAC6cSBip6XcEUNJl7wR7UDQzK
         +gUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eHSxnbyT5f7IQMy8RXXYhnOlGOo3q1AuUfcQUqqD7O0=;
        b=Ycc4JdhhALE3gda5ZFyzVy7WWJQgr/GZdui3YlDfKlU5LR0jdK2RXWyYJZZduO8nHV
         5LmGKe1Gc+Vt+BteShUo/5s39Bt4m9iDia5g03MaoJAHWlhx6QLwdC/RAUdJTZ/6a49d
         ZG0cpgDykBA8ye03RX9t54UM0GJqnlOFFPyft5w1WeH9jHf313npVoNm4YXODFWEUYB/
         50rKAQIjbqWbZwHm7Mghxz5T/9Vu9LC1gmHiMgUUILyJymJ8GTTOByiPLmWjoOY0x+UC
         Y1DMFjak2KT4OHm1Iy175KRiZnJeHoYKqy2bM8BKS3jrfcJaIkg56oda/ocpcdTTQ7f3
         Vvuw==
X-Gm-Message-State: AOAM5328DdI7876cdJTgoKzSMkETMrY1k1aLnXhPdnbJ1h8B/XoKJoJn
        Xs4GqNt/8B4WoSC1RzJYUT8=
X-Google-Smtp-Source: ABdhPJw0YZr72UI1NprPMmHhus5n7YpTP4q802IryivL9xksaOYg3kOcd31ZMY/WGH2F9+/bSYn2Hw==
X-Received: by 2002:a05:6830:1493:: with SMTP id s19mr2261970otq.85.1643294354515;
        Thu, 27 Jan 2022 06:39:14 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d9cb:250e:9ea6:f8? ([2600:1700:e72:80a0:d9cb:250e:9ea6:f8])
        by smtp.gmail.com with ESMTPSA id j19sm6425947ots.21.2022.01.27.06.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 06:39:13 -0800 (PST)
Message-ID: <ca51848c-d3e1-7f85-0268-ab4c999ea2bd@gmail.com>
Date:   Thu, 27 Jan 2022 09:39:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Git in GSoC 2022?
Content-Language: en-US
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git Community <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        Victoria Dye <vdye@github.com>
References: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/26/2022 1:29 PM, Kaartic Sivaraam wrote:
> If we are interested in participating we need:
> 
>   - Volunteers who are wiling to act as mentors. I would be
>     willing to be volunteer myself as a mentor for one student.
>  
>   - Microprojects: I believe we could repurpose the Outreachy
>     microproject ideas[2] for GSoC too. If others have suggestions
>     for microproject ideas, please share them.
> 
>   - Project ideas: There are two mentioned in SoC-2021-Ideas[3]
>     but both were picked by GSoC students the previous year. So,
>     we would need new ones this year.

One project that could be interesting for GSoC (and the timing
should work out) is to complete the sparse index integrations for
some of the less critical commands. Some examples include 'git mv'
and 'git rm', I think.

This of course depends on some ongoing work to integrate more of
the critical commands that we implemented early in microsoft/git,
such as Victoria's current series which is leading to a 'git stash'
integration and a series I have waiting in the wings for a 'git
sparse-checkout' integration.

However, I think we have a decent paved-path for a new contributor
to jump in and get started on the remaining commands. The granularity
means that the project has multiple milestones that can be hit
without an all-in-one series.

>   - Multiple Sizes of Projects: In 2021, project size was reduced
>     (~175 hours). This year, both medium sized projects (~175 hours)
>     and large projects (~350 hours) are supported.
> 
>     GSoC organizers recommend communities to have both medium _and_
>     large size projects.

I think this project would fit in the "medium" category.

Thanks,
-Stolee
