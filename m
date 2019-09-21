Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E7C91F463
	for <e@80x24.org>; Sat, 21 Sep 2019 22:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfIUWgn (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Sep 2019 18:36:43 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:40849 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfIUWgn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Sep 2019 18:36:43 -0400
Received: by mail-wr1-f54.google.com with SMTP id l3so10143538wru.7
        for <git@vger.kernel.org>; Sat, 21 Sep 2019 15:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=pHu3tPAO7vk9nXYSlika9nFe5yzl4BMLUeesODkEqdQ=;
        b=kbmva3mKFEddZNY6iE9TZLGsMNFYrVTClDLWg/UfJJqCifusIcSrvKAfk0QqLcN61e
         5+9BkUJppO1bUH9osRIKxjiDLUiTGNRtgOA+KJ+x4HnqGvMl5VrsErVafXmi/Y1LtJN5
         RwL3vbTV+4LDfgYFpMpwMGYJkDKP3XWFQb6uyNlU+IoUMdufdHuWLdv1Qlh2x1DniEj1
         sRHiK/HuaZyyvBr1yvEnx72jLrCMhkAWzensqo1JBMN/+3CeJUyTOHZsWzTT548WyeRq
         DvkDtMH6IebBaln3uDrWpwkaejIicxujJP0jd3KFED7AGkhCSxuNInWyxCrBc5zEH4iF
         uOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=pHu3tPAO7vk9nXYSlika9nFe5yzl4BMLUeesODkEqdQ=;
        b=kxa6KXtSgkt6AE/cdRHNrSb3u+AtTGFMuyUg8Yp67NousIajrmvb393gQnpRjuTb+2
         21MUqY24c3fCeRTsV17ZveqqLsV6j1viwLJhTvYYwB7HpHMg3hbcgHWZlScb3rU22gjU
         4sMc0Pxs5stWrbMYM5JUIHgj+G0xSVbCaqCHbuA5wG/Pl3CocCAT7CtvYG8vmAzP8MS6
         EnDXji5jsfyggPuqLabB43NHaeQxCSvXGQMMMvji+zxf2KL0MqDeXj4kcqEHOcFQ1FZe
         pBoiq+5x26X519hDDjPcgJ/AyS8mV5PU0s7atasx9jyEsCvIL2lfwq/FDObR0pkqCkFW
         vWcA==
X-Gm-Message-State: APjAAAWFxTAsdBYCz0Esdel33/ox0xdluZdhsDUNITttUXMErJCr3FTG
        ff5er5ShkLTg1mMo60DGbsn2ofS8sD0=
X-Google-Smtp-Source: APXvYqwpg6rXi00JC1EvebMnAywZ8vv7Jn6/dbEU+sFGLtIoqG2miy7Lmr4zw+QqOBERPXBirzHr6Q==
X-Received: by 2002:adf:ab0b:: with SMTP id q11mr16920717wrc.336.1569105399342;
        Sat, 21 Sep 2019 15:36:39 -0700 (PDT)
Received: from [192.168.1.66] ([188.253.231.99])
        by smtp.gmail.com with ESMTPSA id s12sm8454732wra.82.2019.09.21.15.36.38
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Sep 2019 15:36:38 -0700 (PDT)
To:     git@vger.kernel.org
From:   Alicenab <alibutlow@gmail.com>
Subject: ProGit2 translation in Azerbaijani
Message-ID: <a819214f-c7bc-bb99-cbf6-3f70b9f2e2e0@gmail.com>
Date:   Sun, 22 Sep 2019 02:36:37 +0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there!
I have a translated ProGit2 book to Azerbaijan language.
As code of country name name for our country(az) have already taken, I 
have created "aze" version of it.
I hope it will be no problem for you.
Partial translations available in https://github.com/progit2-aze/
I'll be waiting for your response.

Sincerely,
Ali
