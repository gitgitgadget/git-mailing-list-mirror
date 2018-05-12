Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99FBF1F406
	for <e@80x24.org>; Sat, 12 May 2018 18:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751227AbeELSSo (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 14:18:44 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35527 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751048AbeELSSn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 14:18:43 -0400
Received: by mail-wm0-f49.google.com with SMTP id o78-v6so8420592wmg.0
        for <git@vger.kernel.org>; Sat, 12 May 2018 11:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:openpgp:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Nbi7KVcNlst69d3TQSHYqrjiXrmIzqS/InMDs41Eblc=;
        b=EqOIUt1UK1DgjhMZSO+TpLkisIUh0e0GAD3il9xZ7RhEvlKOk+scKRhaOa30ioDcM1
         nYpHuKACWlas8dArnMSmgoxZ8oYJIho+oBXAVPG9oLZKHTao8DLiM1sM0qGj5dPfIUTS
         bYztrJt5B2Njay+Qm0eOoXYpjKo0bYSkiHxPdO+mZI8+ku7X0Fro4HgQP8RtIXmXEAbd
         ueKcj4yiM988xjQiqYUzdLZNSYRSvvj4Yhyke4jjazT/jes5DXjKZGp16/Iz9zAmt93Q
         PiNuaX9BPGqiRmWWn6NPFXq3gAI38liVa2MHwS146/xitfvpebH1A+2/zHWN442rcEYc
         b2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:openpgp:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=Nbi7KVcNlst69d3TQSHYqrjiXrmIzqS/InMDs41Eblc=;
        b=agRo2yR+KE5Xc1qOpENtDd5FF5Cm5aGZA15SSjFuV8ZKZIFeGu9r9WPMoRgxDOmnyh
         dpnOQyp4UQnUksEGy81DrorEtoCwQn1VWflvesvMAe9St7KGGmJZlnVMDpxGOo1j2yPQ
         aPnC+ob6dotQxI+UwrpPjNXoBuARgv5A5NTJNMsWpvKjJkLLbgzsteVxhyjOPMmwHMI+
         p9ibSD8Y7YlcAfx7/bI49lwMqPkCA6zPtqLNnIIER7GOrkuO9rJ04hctDUEyCB6ZHK1Y
         lAlXqkdZs885ZoLKp8vTV+tp4LTSwQlN5+1FWR8EpX1aVRT8CWi88wspHiL2cyC5exu2
         uuVw==
X-Gm-Message-State: ALKqPwd5/MrlgxqClC1g/358PT6lhmbHvGOOtXtsw7tp4Li8vgMxTcup
        rHT3D3BCtFdWX3NDTzh+dsw8l5sDv18=
X-Google-Smtp-Source: AB8JxZrMAF1M5zhet3VlXRRS24SavKWHIpINgwhZHbIyGDFV5LqQa/GJNXxyZaPUFGSSNQPZMS8QTQ==
X-Received: by 2002:a1c:180b:: with SMTP id 11-v6mr1789766wmy.21.1526149122482;
        Sat, 12 May 2018 11:18:42 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-21-254.w86-222.abo.wanadoo.fr. [86.222.20.254])
        by smtp.gmail.com with ESMTPSA id h196-v6sm4928887wme.1.2018.05.12.11.18.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 May 2018 11:18:41 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
From:   Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC] GSoC with git, week 2
Openpgp: preference=signencrypt
Message-ID: <f3c4e4b4-20d1-1990-e31d-f6b257122e75@gmail.com>
Date:   Sat, 12 May 2018 20:18:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I published a new blog post about this week. You can read it here:

https://blog.pa1ch.fr/posts/2018/05/12/en/gsoc2018-week-2.html

Please tell me what you think about it :)

Cheers,
Alban

