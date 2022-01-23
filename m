Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF248C433EF
	for <git@archiver.kernel.org>; Sun, 23 Jan 2022 21:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240191AbiAWVGx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Jan 2022 16:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiAWVGw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jan 2022 16:06:52 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D35C06173B
        for <git@vger.kernel.org>; Sun, 23 Jan 2022 13:06:51 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ah7so15914313ejc.4
        for <git@vger.kernel.org>; Sun, 23 Jan 2022 13:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=MFFqyifpVVLxyT/ZobDaFyuq29GJ79nFfRsxC0oYqAk=;
        b=W576Yt5qQmjnTR3WjdiL5ZpcevdCJ6loCTGh8Akp5fldO44aWuRpeZOAHPLCsGuh8+
         ve0phPqljt0hN3vQCSuAHfPwUd45NxYPvNLlBRSehUwrvl4wXEQ7PTz6QMu7SPIk6q8J
         sbuFhJqTyEMix3lnsBSMdNZ8tGc0uNTdURNKAISyGZxTwqYUyGF90o1sDAqyjGj6jNDS
         +jLc2MKNNwHd+lohK2r6bUUYuqmTdQG3ToE92V/ruCybz+fZnVspdcjZaSpShZfBKIoJ
         AdNF7cc4S67PFoYymVHR9T8FtxZJpRkVv7J8ssEaoCysZSt+PX6ddSkZe8KTmroq/Y0m
         8Dmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=MFFqyifpVVLxyT/ZobDaFyuq29GJ79nFfRsxC0oYqAk=;
        b=qJFFBuTB1VIAg8Np/vWyAVplsrs09KAZIfcDPpmdEFYs2YjSfBg0MF5vtRD4X6tHbY
         S3suVTjfzRJsE8FbzHe5QJzoxSUAnGATmbQ21g4pstaQfZ3nRd0bF1L6a3jgVukz6KaO
         f9BCScCViJwFJn3o53izLVWL8Mj92cTM4uQpP2wFQIfFEvqIMf4sc5ncu1759R1cvR83
         m6OTw2V9uyrNv8R8WDh9QwzuYJGv+RvYeiRbCT0S6uqbF6TOUq3FbkBQCvrEDHM1FdDN
         BfbFc8ojcQaDMxiT2v1jwtickl7k7sF4jeFTdcohoo6tLm1rxN7YyRTMqjRjYStvSn0I
         dTmg==
X-Gm-Message-State: AOAM530nAystrZu2X8FqBrfRMPsbbfdB2SrQCzqKNGqEP/Xf6XkzKa9T
        VynyP1aPf1dlCseUwK2slTT3+CrJdjc=
X-Google-Smtp-Source: ABdhPJzjJHt8s1JTKHAqSCO10mQ7u2X9qiN18l8KYsCJV98PwmlLyMItVtXKxHkMNB6qqN/VLCSTtA==
X-Received: by 2002:a17:906:90b:: with SMTP id i11mr10681320ejd.661.1642972009880;
        Sun, 23 Jan 2022 13:06:49 -0800 (PST)
Received: from [192.168.1.94] (176.248.7.93.rev.sfr.net. [93.7.248.176])
        by smtp.gmail.com with ESMTPSA id e19sm3108463ejl.225.2022.01.23.13.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jan 2022 13:06:49 -0800 (PST)
To:     git@vger.kernel.org
Cc:     git.jonathan.bressat@gmail.com, guillaume.cogoni@gmail.com
From:   Cogoni Guillaume <cogoni.guillaume@gmail.com>
Subject: [Newcomer] Any ideas for microprojects ?
Message-ID: <e5a0448a-4606-7ed1-78d9-b06520688616@gmail.com>
Date:   Sun, 23 Jan 2022 22:06:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

We are students from Université Claude Bernard Lyon 1 in France in
first year of Master’s degree Computer Science
We want to try to contribute to the Git project as a part of
our studies.
Our mentor in this work is Matthieu Moy, who has already contributed
to Git a lot.

So, we are looking for ideas to start our contribute.
Can you help us ?
And if we have an idea, how we submit it to be sure that we don't
go in something wrong. Is there a special tag ?

Thank you in advance for your help.

Sincerely,
COGONI Guillaume and BRESSAT Jonathan
