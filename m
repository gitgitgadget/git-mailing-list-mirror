Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E638C1F51A
	for <e@80x24.org>; Mon, 14 May 2018 19:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752035AbeENTTv (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 15:19:51 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:41387 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751941AbeENTTu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 15:19:50 -0400
Received: by mail-wr0-f171.google.com with SMTP id g21-v6so13474825wrb.8
        for <git@vger.kernel.org>; Mon, 14 May 2018 12:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=MTIkKqJGG9yxj/s++CBvRPd7v4v33+4binSkudtH2ns=;
        b=dxlj67Nht0vyJB/Nh1Q/R/Of5cjytfSZKxufmJdVnv64VA6ihoC6BYDcJqzCpCAfXt
         uXTt8kCuziwpJciw4daJ4Q7jrrzOMlDL/ukbtRJg8dd4fX5UeJp0W+pZPBXxmcZgNrDT
         zgUa1/wXlhToJMocigX35DxPW6x4CQv0+UsG4YffEU8H1sn8XVRIQllR4jH7LZ8wIwFU
         jcTxFNPcboLFqzWe8QY7hVsiEl847KJblf1eB4Zb221v/PqY/6ZV1EtD0cjkIUrPjCjk
         8Wyh/s1CRevHRCZkU9CG6cxIsQxalon/ypQzpKKeQdpRGEypW2QkBEE2NBYzY8qsWKhU
         urfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=MTIkKqJGG9yxj/s++CBvRPd7v4v33+4binSkudtH2ns=;
        b=h4HZ2mjxDLJMkkNAddfpwlkz6Cnw11khEJxU5jU1VZsG031SBctN0lAt18achczjFJ
         P186WtPSi8lGnHSP63VNwFfBEbgnof1O33bNAXYOWyVIJkZIkSK2Hz2scEXhEjVKBC8H
         NkQLC9U8sIj4TAJrRvfLDVHGISzATVn0J11ALngKFQ2U/kGEs6uJi/dnwlfv0mjmLZyd
         dwQy/Q9VnPmaS6ysnfDaXetZda26ZCGIn/LHRmDOojG/6U6iT4xC99pM5RB6apLRY6QP
         HnqFoTff+qXqGuNArGmrt6JRwqFHpa+GXmOTFBYYnspDmLCTeKhJZtDpP/22EfJl4lcO
         3qPg==
X-Gm-Message-State: ALKqPwcA9F9R5cHLnBtxvpN/CG0q203I2KV1FioENCjJADSlhvyicsNm
        4O/3LYyFI7b9gWufTcvddC0=
X-Google-Smtp-Source: AB8JxZqcOC9rKc5MpPOfG4oPzCq1gz9W+Jsphc4o2JsfOWCAHM55Misl5OgdfQZwixNyOJVviRU8EQ==
X-Received: by 2002:adf:d0cb:: with SMTP id z11-v6mr7394433wrh.281.1526325589540;
        Mon, 14 May 2018 12:19:49 -0700 (PDT)
Received: from [192.168.0.103] ([92.55.154.57])
        by smtp.gmail.com with ESMTPSA id y6-v6sm11242869wmy.39.2018.05.14.12.19.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 May 2018 12:19:48 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: [GSoC] Week 2 - 'git stash' blog
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        predatoramigo@gmail.com, alban.gruin@gmail.com
Message-ID: <24638e06-18de-612c-a4f9-f94f68be609c@gmail.com>
Date:   Mon, 14 May 2018 22:19:47 +0300
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

Hello world,

A new week has begun, but how was the last one? I posted a new blog post 
about it [1].

Any feedback is greatly appreciated! Thank you!

[1]
https://ungps.github.io/

Best regards,
Paul
