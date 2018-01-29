Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 527D91F404
	for <e@80x24.org>; Mon, 29 Jan 2018 23:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751439AbeA2XVr (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 18:21:47 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:55456 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751357AbeA2XVq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 18:21:46 -0500
Received: by mail-wm0-f52.google.com with SMTP id 143so17532976wma.5
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 15:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=iS+jxGYg+hMchE4/MnmL62LCzyu/icH8DDCXrsbbX/g=;
        b=OOyp3uWxBYf05e3p5s78wd99EetAdDTjUj0341jeiuO/RGstyS6t/CDyT3rPThNR65
         3YRhvoDCpBdfjeaLBQNI1lL2KClX786gngzOI1Pto+Bk/0CVc1Ate5yfVh2g1wY9Fdui
         ihIaUSZb4cmAas9wfo629Wz1nc/l/J0x2NWSc0vbSg0hUy36zwlTZoUA3uuajnmHiJpP
         UMBt0H90cGXMRCbaxs2L57eGiiLKddZMHkoi5G53n+KPb62hv+UKWgzZju90xUdcv8EZ
         L5CraPEv0uiVmIZuZxCA39AyrE5iHfC20bYGeq0Lxny4aFBYoJl+p/0DCqhG6aM3tgm9
         jJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=iS+jxGYg+hMchE4/MnmL62LCzyu/icH8DDCXrsbbX/g=;
        b=EaAG9BpIlsXd5Gg5ZLK0SKT3AMMwyGVsz0RIKOcNamMvGETLCC234LWsGfqOJme1i1
         UJh/Zx5+w3HMFAfKtZxB/POZyGJ2AszGnRTrHbWtEba66eeOM/mzltCUVml6A7XV/vgH
         PSyO4rC75QaJ3qr3JDCgKPKvuIUVn6cxH1ViCUe3BXYWfceZJiNvcMKJfGSbn1sw5vKP
         uHe7GjbGFXSQT9PMvFJF34OC23Qlo1IrQ9wZ9KyPJywquCAwzeTYGjzYLLmKyQ6GBvmW
         Kz+Nh3NBzFTfr72AhBKUtjq5OU0pnAdPcuf3Egj5BcrafWor0onWXX/k4l40cwqhqyGW
         puiA==
X-Gm-Message-State: AKwxytdVhwvaMQ1NJ7ZB0SBycILpEKePTBkwYCQ/CZK62U2pk4xFbAY/
        dU42oiyTZLW82uLFhOC9gyrBqc5L
X-Google-Smtp-Source: AH8x226YUFxatEAUO1Q4x3qDa2bTiyuZ1cOl+Vq5gQX1+UyzUoEsYFM1jCFVyj1Je21EPTH6czHHtw==
X-Received: by 10.80.134.44 with SMTP id o41mr48531073edo.243.1517268105062;
        Mon, 29 Jan 2018 15:21:45 -0800 (PST)
Received: from ?IPv6:2001:981:882f:1:b9c1:30fb:4a39:f18f? ([2001:981:882f:1:b9c1:30fb:4a39:f18f])
        by smtp.gmail.com with ESMTPSA id g7sm6512893edf.76.2018.01.29.15.21.43
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jan 2018 15:21:44 -0800 (PST)
To:     git@vger.kernel.org
From:   Ilija Pecelj <pecelj@gmail.com>
Subject: Bug/comment
Message-ID: <2df7b921-6fe2-d55f-4ef0-3f4f0bd69261@gmail.com>
Date:   Tue, 30 Jan 2018 00:21:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Though it might not be considered a bug 'per se' it is definitely wired. 
Namely, when you type 'yes' word and hit enter in git bash for widnows, 
the process enters infinite loop and just prints 'y' letter in new line. 
It can be interrupted with CTRL+C. I'm not sure if it has any other 
consequences other than printing letter 'y' in infinite loop.


Cheers,

Ilija

