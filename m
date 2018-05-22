Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7648A1F51C
	for <e@80x24.org>; Tue, 22 May 2018 22:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753283AbeEVW33 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 18:29:29 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36659 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753167AbeEVW32 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 18:29:28 -0400
Received: by mail-wm0-f53.google.com with SMTP id n10-v6so3924178wmc.1
        for <git@vger.kernel.org>; Tue, 22 May 2018 15:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=m7eql7YS1IfkiF0y/iLUHhtYfZiwAA7qbHdDfXUZwIM=;
        b=jhnXEGANf6nhqa0ymoIGFmErmjN36/6kxKSeoayctE0DrWwtbeNRoQWexT/+1TavfL
         rHke5kSAICsCpNJR8nXqZBpVXE33APtLp7n899tdhihzoxPbkABejpofdmnH3UoBy5Rm
         HkTiMPWEmo7V1qzfQoMfRO2OoebBhXaApk9fzsfD8nC1e1dETwBZSiRivjxdTrsnjuzL
         skkIN2TDMYT/0q3bdh87QFGqWBP7pVEsR3nQ93GWB0JUuTXxxbzatBjwu0wAD+qMCrSl
         dMT0j64H/w03rLmEWrCnaF9XhMV8DDuAgtW6JwlnNr9AXwXmJv6Vm8p4t0ipLJYMjRei
         dJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=m7eql7YS1IfkiF0y/iLUHhtYfZiwAA7qbHdDfXUZwIM=;
        b=idBluwsCco//S1e4yU93GfcVTFxPaaMIbIrzKHHqaJpx71hcOZdnx24Sn3FYqYt5HN
         I/itqg3AyOAai+4g59BMZiaLQvC2+hYOYd0mWXJAvV7r4wcJuGeNRT6p43bMLZH4aZDW
         jGIgvTXWyKW+X8z5rlInImbVSu0t89ufNhQCg6N1cRaijXqVhP1Lc3DthIcfat+gBp9J
         fb90joEJoOLNxqRKv0v/8F0lIdmeR/53w6MzHcPNyPia9852sEdE1l1arbnxyPt8kHzT
         CT0ACkk69jYlj779p3AqWddW9wXLv4I3FOh70AYRF3ZFTly/MjHufQ2HgBkAzao2qjwX
         3ByA==
X-Gm-Message-State: ALKqPwdfhedku0FA4S8YASFZ9o0aQtFtnx0KciPtmvbh8V4MaJztgar7
        4lE/WbX9YK8VqgnXPXvPX1Y=
X-Google-Smtp-Source: AB8JxZqEsqVgZhnrNHzZ/tPxYrFBDC8IDJWzsy0uzHtycOiiRABowHHDEZGnItraZ1LWq34Yb8xgQA==
X-Received: by 2002:a1c:b807:: with SMTP id i7-v6mr2449747wmf.126.1527028166828;
        Tue, 22 May 2018 15:29:26 -0700 (PDT)
Received: from [192.168.0.103] ([92.55.154.57])
        by smtp.gmail.com with ESMTPSA id 123-v6sm1101207wmt.19.2018.05.22.15.29.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 May 2018 15:29:25 -0700 (PDT)
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: [GSoC] Week 3 - 'git stash' blog
Message-ID: <d4094a2b-1173-9d64-ca9e-0853ab7695be@gmail.com>
Date:   Wed, 23 May 2018 01:29:24 +0300
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

Hello,

New week, new blog post [1]. Any feedback is greatly appreciated! Thank you!

[1]
https://ungps.github.io/

Best,
Paul
