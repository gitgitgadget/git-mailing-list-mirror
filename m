Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73DF41FBEC
	for <e@80x24.org>; Wed,  8 Mar 2017 03:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756651AbdCHDQ4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 22:16:56 -0500
Received: from mail-vk0-f49.google.com ([209.85.213.49]:34520 "EHLO
        mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756556AbdCHDQz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 22:16:55 -0500
Received: by mail-vk0-f49.google.com with SMTP id r136so2855333vke.1
        for <git@vger.kernel.org>; Tue, 07 Mar 2017 19:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:cc;
        bh=/qj87n8dOwOTlBo6/mWf1Lc1W/sW800LgoOHm1yNt3M=;
        b=lvUAVFShKu1nyW7M91w7NvPELk9KohLw+wVa1SI8qP+Ds1swyXuIoH/+bh9Wzntd92
         nscNwvxvzGxFLVRHwy/UntFT9B5GDbVwwlqcC1nymsolOP1/ikFVXYt9rsh+trLF/POl
         r3+qa5stD9J/eSBRTYzCps3vDQ0SXTcqbazRKgiaHBpCvGqTIVd1kitJNrzdc4p/+Ew5
         sRQzlxhmeQagys+OrWpVj/JnqwqXbfUpVzq22/7OoVKLw5ECFiXkMiROtryTpN6nQZk3
         nKNcbDwleIAhZ44sLG7KgOPUQXdNhk15MoaTeAJyQIEFJTfUAM62ixr60cFQTA6hHmrp
         9wbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:cc;
        bh=/qj87n8dOwOTlBo6/mWf1Lc1W/sW800LgoOHm1yNt3M=;
        b=RcUEKSjyjoC9Mac0Ap56CTK/cIel1M/KmVoMCJUVJodnt/wRGb7rp7R72+CbMod9Lu
         o9JvV8j9WC7A7gLBGBL6oFdkXIAlFsbsm7I2DgNPROFWLFJUBuUGg0XSKqiMObqu6MZQ
         uxAak7wVIlrzpsuANc2JqbH8Ayey4q9ATf7lwkv22Ye467ubC5DwZd5ctq6bwWH1Uvbp
         D1lM0/4w3QwMZyGjVTCJK2tydaK5hMZWY5EhMYNKcP+2JZLY+wstcw0oKpoOOwnGqqGW
         q1qDgfp6nKsM4hLbf0J/HvZ8EDR8qWxbHhZ1Cox/fu4+LVGpj4kc6t1yawP7NjnVAn4d
         wWGg==
X-Gm-Message-State: AMke39lymoFjeE4/je7EDnOb7RKcF08ViJMVmJ+XzmL9w995hxCEapNKHt9vWkAB49QRfqckaTIQdE+SnjlAQw==
X-Received: by 10.31.150.134 with SMTP id y128mt2302052vkd.102.1488903522079;
 Tue, 07 Mar 2017 08:18:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.87.218 with HTTP; Tue, 7 Mar 2017 08:18:41 -0800 (PST)
From:   Prathamesh Chavan <pc44800@gmail.com>
Date:   Tue, 7 Mar 2017 21:48:41 +0530
Message-ID: <CAME+mvVA+-HA2Gy-66VpLwQFYUixLTt9wLTXsK=4WA36CgsJKg@mail.gmail.com>
Subject: [PATCH] t*: avoid using pipes
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>
Content-Type: text/plain; charset=UTF-8
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
I'm Prathamesh Chavan. As a part of my micropraoject I have been working on
"Avoid pipes for git related commands in test suites". I tried sending the
patch, but it got blocked since the mail contained more than 100 000
characters.
Hence, I have made the required changes in branch "micro-proj" and you may
find it in 'git' repository on my github account. My user name is: pratham-pc.
Please review the changes.

Thanks.
