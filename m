Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF3FB200B9
	for <e@80x24.org>; Thu,  3 May 2018 21:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751236AbeECVs0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 17:48:26 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:32999 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751178AbeECVsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 17:48:25 -0400
Received: by mail-wm0-f46.google.com with SMTP id x12-v6so4598667wmc.0
        for <git@vger.kernel.org>; Thu, 03 May 2018 14:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=etSClSsHzEZJB5kHop2+wwI+CXy7s78IsOpg880lzaA=;
        b=Kyijh8CLMOV4RNQx95nfjefl/QcGohNnlHuOT5G+qMMAKoQzkvgaAcW+g0jP5TmZ7k
         4FoI4OMKi3LtGFXbJxYugeBgpSeEacWHDCOMrka6es/x26h3yvX3DNfWU92oVdMABnWT
         JBJP8qVyPohM40JqL2kyPODqQc3hQNr5vZ6ZicaiSDmrL7xTtze9KkDWm+h86tGePNxz
         jkhOyr6ex1EZBqJLOw+zOPDMeZxZcXfpRUtKsz2wxNFu7L9AD8jQ/JqCk0/a8i0BZM0d
         cwFqENaJpGWr7mlx6gMIz0T4j5GhTeuj7zlYb/oeQUt6c8hahc2coqcTnW3dIpOYQcTY
         KpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=etSClSsHzEZJB5kHop2+wwI+CXy7s78IsOpg880lzaA=;
        b=CjVvwKAfhQ9rnFs4ms5QiQqg8cy242fKGRArO2VI4EsBglNOFmBj4ZFhB+fxwMa5L/
         YJhTlOTToieOjY/7DKBWXWwwclvshrCXLN50jxqLGV/T2UXEP3+tCrL+f3RKbmxO2xZ9
         rByCDiagH/xL7t+/ZkqPPs59f7YXxvIfnQOgYXr3k4PcXkdADZEQMewrPTSmh/6V4VN8
         +/ZOM4Mr9fj/Jjlx4Y1XfNY4+wfRJFdMOwBn3hntJx1l0jvF8lVfyUik7WXqd1IFq82p
         dkUuPSeVqnJ/PB14AR5A7STmXGtlAcVdVS2F7o+3h0VGFw/n3WZjIGWRpvVZOanFxWbO
         Fl5Q==
X-Gm-Message-State: ALQs6tDs/1J+mWEub3yy+WYUJeNUbC8l4xl1Dsw3jdfQXjUUfwkEl48U
        oaeq3ifRPXzbBYn8j8vc0Q57YEdY
X-Google-Smtp-Source: AB8JxZpCz8q2J3O1kzc/khr8Z5zSp5FH4Dl2oPKIhUx/0WYgybcqkC83MBnXc5fujf3MLMs8boohVA==
X-Received: by 10.28.197.136 with SMTP id v130mr1915313wmf.135.1525384103876;
        Thu, 03 May 2018 14:48:23 -0700 (PDT)
Received: from [192.168.0.103] ([92.55.154.57])
        by smtp.gmail.com with ESMTPSA id k126sm504785wmd.45.2018.05.03.14.48.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 May 2018 14:48:22 -0700 (PDT)
To:     Git Mailing List <git@vger.kernel.org>
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: [GSoC] A blog about 'git stash' project
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-ID: <67e6d306-0885-9340-13c8-3e3d4333dc20@gmail.com>
Date:   Fri, 4 May 2018 00:48:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everybody,

The community bonding period started. It is well known that for a 
greater rate of success, it is recommended to send weekly reports 
regarding project status. But, what would be a good form for such a 
report? I, for one, think that starting a blog is one of the best 
options because all the content will be stored in one place. Without 
further ado, I would like you to present my blog [1].

Any feedback is greatly appreciated! Thank you!

[1]
https://ungps.github.io/

Best regards,
Paul Ungureanu
