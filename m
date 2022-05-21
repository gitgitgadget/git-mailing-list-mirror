Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FD0C433F5
	for <git@archiver.kernel.org>; Sat, 21 May 2022 16:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245412AbiEUQRR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 12:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237279AbiEUQRP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 12:17:15 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73175C34C
        for <git@vger.kernel.org>; Sat, 21 May 2022 09:17:14 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id g21so1486742qtg.5
        for <git@vger.kernel.org>; Sat, 21 May 2022 09:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/hml4Uab6jD5E7gP/J/77ueJUFu/broUSsq48WO8zGg=;
        b=CjrXqwV1gZiVeScDHo//wv3CR3bUauZRyNmP6Eq1Wau0Hkh4F2oFlKHZ7RT1Xmmz5P
         a89CGTZ4rLFuFZA3NJYnSIl68QVMqOB30DKHkp1ZheHmWTddEbw34D5XlCnm6tZM2pHQ
         MhhEBxqg9VuCORi2NYv5vdefeyV1m4pWUkTd1ymQ3vyXs1kpSeFFngn3hWqHJNwUrBeJ
         1KaJMJwMd7vjS8rA9r2ag3Zye76wg+Rm53DUXwM4vyXcsKIOntP1uLJ0SQv6unKzTKIk
         jN5plJJSB/qFMGHvRwrAHRryAX9gzNTpSfOsNwTgNvCUVaQzuItGskVivHOyip0zZ/Rb
         Qvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/hml4Uab6jD5E7gP/J/77ueJUFu/broUSsq48WO8zGg=;
        b=mwhH4mKWulXPdKCjpI1+2/eVU7Yz69xtcr771YXwYeKvqVStatRDxdnj9dg9qD3eEV
         kqIuvvq5UrXjPIFMDXdhiB/jbqwEYXAJyvLWZviUVHA20oC2/ux40KJvjuiahAmcn6Q/
         76be5BUgRNnDkFviKbCjUUB1lyQhm0uBcfjlY5aTPOh7kdIh/7fOcBlJ33k+L1G6orEF
         hcJO8SINM1NrZ1+/rfPrMjjypc27IuSmwnKybhTKgPbpWyHdzziA3wzn8I1kr0yDiGaT
         8CvCdms3fqCHBo/t7PeuzeGIaKxrEOaXTs6pY4vW3rBpF3E8CHaqqd0xaPhbY15YfjxC
         HA9g==
X-Gm-Message-State: AOAM53043fEGdkY/gShZIXI1UHNLRBCXwtC/y8pKOkXcaH8ipRkN7S+t
        nM4HueKmSnPoLFn2BnrPVd8=
X-Google-Smtp-Source: ABdhPJxMZtXGqAlmcggCpBOnLntPD3E9/qKGKtO7mW7zV7SeJdRECGCQomGRlx/9CQT1nU1OQQ72yw==
X-Received: by 2002:a05:622a:254:b0:2f3:cf9a:989d with SMTP id c20-20020a05622a025400b002f3cf9a989dmr11635250qtx.167.1653149833722;
        Sat, 21 May 2022 09:17:13 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id g26-20020ac8469a000000b002f39b99f67bsm1478229qto.21.2022.05.21.09.17.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 09:17:13 -0700 (PDT)
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
 <xmqqpmk9kxa8.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <f47761e0-bbaa-e4a5-b74e-e9c211bd8d85@gmail.com>
Date:   Sat, 21 May 2022 12:17:12 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqpmk9kxa8.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 2022-05-19 à 17:49, Junio C Hamano a écrit :
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Philippe Blain (5):
>>   MyFirstContribution: add "Anatomy of a Patch Series" section
>>   MyFirstContribution: add standalone section on cover letter
>>   MyFirstContribution: reference "The cover letter" in "Preparing Email"
>>   MyFirstContribution: reference "The cover letter" in GitGitGadget
>>     section
>>   MyFirstContribution: drop PR description for GGG single-patch
>>     contributions
> 
> I am planning to merge it to 'next' soonish.  Please speak up if
> anybody has any issues.
> 
> Thanks.
> 

I just realized that the additional/tweaked content that I added in v3 went into 2/5
where as they should have gone into 1/5 (I'm talking about the changes 
*before* the "The cover letter" heading in [1]). I slightly messed up my rebase
it seems, I'm sorry... 

Should I send a new version, or is it too late since it's now in 'next' ?

Thanks,

Philippe.

[1] https://github.com/gitgitgadget/git/pull/1226/commits/ee3238f5a9169f0c7d046089c7951791b8db3cab
