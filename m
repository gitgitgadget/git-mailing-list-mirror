Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B0CC433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 12:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbiEXM37 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 08:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237117AbiEXM35 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 08:29:57 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0528294198
        for <git@vger.kernel.org>; Tue, 24 May 2022 05:29:53 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id v11so14917926qkf.1
        for <git@vger.kernel.org>; Tue, 24 May 2022 05:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EGRM0SwHk7R1LM95nWW3XZGjZh5geUh7ozxQyi9I5W8=;
        b=T8kAfzMPR1usulY00+0LwQjBI1lKuOBTD9L8xrHhN5ilAgZ7dgaU6idTzLel36IFTM
         t0MxfbnV8WTlNZ0wbhHTt7Fis3huJtCsVG0ohr+BzOgD+Wfuky3451d8NbNIhzUsPFtF
         a4O42nHzi6Q2u0qxyh5qCwPUHkrLwJzJCdLb++XkdEkuEpfb2z+K/syMIYG27s+aCR7P
         QISL7p2NkMGvB8N7cF06v9S3PCNkYwJ/nTTVm5IdO0cKmfa/gK2sVZy+mcMavIQNIdiW
         VdKkHBb2ZkROTX/cwL5HEF6D9leeAMMw9XOt9+9C98ON4/mv81eg8cw+z0mqn5v3W7HI
         /Vcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EGRM0SwHk7R1LM95nWW3XZGjZh5geUh7ozxQyi9I5W8=;
        b=d0SxrGp/vVgI/dSObDeaTuwz9VoRQOQz0WqpuyZWa50x25mBXHrc6XsC0FXQKKUISN
         eJc6aITKXWuZoyBWb/0NHv4gvj+ofgRqTCxYEdP4QAvriVhbbE9eY46aoByHW1JFPpXZ
         jt1Dh/14f/m9O8eS/vuCUgd4UdKdv+DVO3s3Vgp2igBQ9JPHtAY2xspCUMIKHt/AaCZf
         4pkL+4pOPgMQtasqqExfWcvvhwkF6iCSBK2u9ZSadUJplF/pd/j/fG34O/aB+wdVe6tF
         2ujbwzJX5tXN5NIber/uFq4OCu/MN8amgdzdxfM6ZMaFdAhlcUzv7i4IHZL0OfPIs1K9
         IM5g==
X-Gm-Message-State: AOAM530xoElZ+2RKboun+ZgaH1qiwKCwLg5Ficz72mV2Ial9a8BOFZmD
        eCge+uT/8Qhi4J70/FnmSEA=
X-Google-Smtp-Source: ABdhPJwBwCW0+MLB+FHxSFYFBUNJEl3GumtPjHEmIytqkpmv+vQ6AoqMobhx8Iug/RiNg8P32bCw8w==
X-Received: by 2002:a37:a6d5:0:b0:6a3:4872:32fb with SMTP id p204-20020a37a6d5000000b006a3487232fbmr14123931qke.588.1653395393048;
        Tue, 24 May 2022 05:29:53 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id w11-20020a05620a148b00b006a39e915252sm2546883qkj.97.2022.05.24.05.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 05:29:52 -0700 (PDT)
Subject: Re: [PATCH v3 0/5] Improve MyFirstContribution's GitGitGadget section
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Philip Oakley <philipoakley@iee.email>
References: <pull.1226.v2.git.1652233654.gitgitgadget@gmail.com>
 <pull.1226.v3.git.1652399017.gitgitgadget@gmail.com>
 <xmqqpmk9kxa8.fsf@gitster.g> <f47761e0-bbaa-e4a5-b74e-e9c211bd8d85@gmail.com>
 <xmqqy1yubb8j.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <0a2ab37e-58c0-378e-bc43-a935c8ebecec@gmail.com>
Date:   Tue, 24 May 2022 08:29:51 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqy1yubb8j.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 2022-05-21 à 21:35, Junio C Hamano a écrit :
> Philippe Blain <levraiphilippeblain@gmail.com> writes:
> 
>>>> Philippe Blain (5):
>>>>   MyFirstContribution: add "Anatomy of a Patch Series" section
>>>>   MyFirstContribution: add standalone section on cover letter
>>>>   MyFirstContribution: reference "The cover letter" in "Preparing Email"
>>>>   MyFirstContribution: reference "The cover letter" in GitGitGadget
>>>>     section
>>>>   MyFirstContribution: drop PR description for GGG single-patch
>>>>     contributions
>> I just realized that the additional/tweaked content that I added in v3 went into 2/5
>> where as they should have gone into 1/5 (I'm talking about the changes 
>> *before* the "The cover letter" heading in [1]). I slightly messed up my rebase
>> it seems, I'm sorry... 
>>
>> Should I send a new version, or is it too late since it's now in 'next' ?
> 
> Thanks for letting me know, and sorry about the confusion.
> 
> Could you please send an incremental fix to be queued on top of
> these 5 patches?

I can't really send an incremental fix because the final content
as it is in 'next' already is OK; it's just that some content which was added
in patch 2/5 should have been added in 1/5 instead.

It's that too big of a deal, I just wanted to let you know.

Thanks,
Philippe.
