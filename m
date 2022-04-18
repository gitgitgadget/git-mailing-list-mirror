Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0A3C433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347242AbiDRR5Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345630AbiDRR5S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:57:18 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9448734BB2
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:54:39 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q12so20136322pgj.13
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EraWDy4V1Gc6+0Pwn3DfYpHT10M750AdLL0AzMmT+zE=;
        b=p9tC59yKbi1qL/ePuV+PiciCemHXou1uxt+BYhDYyV/Be8dz2KMxtFFsgDf82ItJaL
         2WMe5u47AFpEqIV0jF//gUhpLb8g4Z7miIRI8McjB7o+H0j+bMwDyriOEBobZH3b/Fpa
         jQ1KdAEfKndHkKLqeYTkp3wlAffb/mBkFhlST/UVB6nwJa75Nh93Uwo6aP/xCG5NxwiB
         XU+xUw2qJDLnIySXNPZq4ZxkZVAgJMaBYTx3t9Qmmlw9hf5HqXStj7R6xBviuSiE/dkR
         LQ6TcXylF2d1/iakGWzK/hr0KVtAMH2OpKKmKCyR7+u8zHTFUP06cG5hxMxrl33Ay87n
         vASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EraWDy4V1Gc6+0Pwn3DfYpHT10M750AdLL0AzMmT+zE=;
        b=qV4uX9BiRmq0PR1R/sYY2zMab0foDH9SKaV8jMH1IIILtTztA9nSfpPhdJkz1VijtB
         WmQSp3Szs1/wWPWw7M01wVY0rayyWBSaC/VrRe/fv8k0wrX6fTmFKuZCjXBIaiTm2/Da
         y/P6KUBVbXMlTnET3n15tY7hmIJyrvIWd42SS06F5XRJoVCJVWvykdDv0NNhHgqQPcIw
         8KgYNmLLcrpq+nZDgG5YWBaBqZ57REdpwWevd1RlS1JaqO3cMk9cVI4TvQUjB96JOgUy
         bGnp00u0ofQuuOm1bKzexaVC283DxzwgpIOQU4kZNjybdvFPo78R+gVBb55uBO5rAHvv
         SG1g==
X-Gm-Message-State: AOAM532/0Y792cObM1jXwiinWRkqUzci2ztoqRFq9CKBiluAFhCLD9cf
        LHMDb4A3xkc/2H4vsGWr0Yg=
X-Google-Smtp-Source: ABdhPJw3Z4ug5gp7sMpwTXyccJd1E0Ubv4jQRMJGbhtc84leTVUdmJrgAxzHwB9WgZzC6etKOd9ydQ==
X-Received: by 2002:a63:5565:0:b0:3a2:7450:5e94 with SMTP id f37-20020a635565000000b003a274505e94mr11089898pgm.527.1650304479132;
        Mon, 18 Apr 2022 10:54:39 -0700 (PDT)
Received: from [192.168.208.37] ([49.204.135.226])
        by smtp.gmail.com with ESMTPSA id e12-20020a056a0000cc00b00508343a6f9esm13327361pfj.5.2022.04.18.10.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 10:54:38 -0700 (PDT)
Message-ID: <660025e5-637d-8e93-e7ba-65a3ad474bad@gmail.com>
Date:   Mon, 18 Apr 2022 23:24:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [GSoC] Contributor candidate introduction
Content-Language: en-US
To:     Plato Kiorpelidis <kioplato@gmail.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
References: <CAO2gv81zCGbxNN_7a2j7sJZ_fbHiFXf4YxagddWLBWw7-ki5zw@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <CAO2gv81zCGbxNN_7a2j7sJZ_fbHiFXf4YxagddWLBWw7-ki5zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

Just a heads up that the proposal deadline (19Apr2022 18:00 UTC) is
approaching shortly. I noticed that Abhradeep has submitted his proposal
so far. Others, do make sure you submit your proposals in the GSoC
website before the deadline. Only then can we consider your proposals
for GSoC [ref].

Thanks.

[ref]:
https://developers.google.com/open-source/gsoc/faq#should_i_send_proposals_directly_to_the_mentoring_organizations

--
Sivaraam

