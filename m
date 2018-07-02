Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9BC41F517
	for <e@80x24.org>; Mon,  2 Jul 2018 20:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752728AbeGBU5S (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 16:57:18 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:36047 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752391AbeGBU5R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 16:57:17 -0400
Received: by mail-wr0-f173.google.com with SMTP id f16-v6so16803791wrm.3
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 13:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:openpgp:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=EjsDFBtpXpKrdTrP3ZKNR6AA6CqDDBQuwvvm18m00iE=;
        b=QgHDNrJlANrPkM3T4y3qFYzQc3Zb7ARYW0AneMGbjllS94bhLmY64GRNXdoWBXjoF+
         LjQeAtAdpbb6jA1dc/aVeFBfxdO3f+RBRcvLsLzpsNYkNN+XgW000q3Y8Ch+GB379QaP
         xCOI/KBJdmIRtY390WYJEn88ZDd9BisArj8vw6Ib8DCvklMaVZ93Pp+ISzmRpFMynhQk
         JuSsfCWcRj2MsSJTGqYNVuydbzQKDtZ7nSwrkFqoAUEgCV+wLnBXxmw88isO5qnwU4R2
         UEfqTwyUkxraHX6j80MJ7rQN7JXzj/6ei397f54dV46LSgVT3C+tbPF2hqaTi7FD10D6
         XF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:openpgp:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=EjsDFBtpXpKrdTrP3ZKNR6AA6CqDDBQuwvvm18m00iE=;
        b=VkMgfUr1N+Zr2Wn+ORm+L8kPzywt0yAdvqI8Jizvbk1Rauq6a8wpbhqSxonTk3HCpg
         9QtDqZobe/g88odzU2blevoFfhZeCNl3sVML/SXs9TX44T5c/2nsvlk/qIx7dPrqwxZQ
         xrdXk/DirEtBSAizBOxUYnqcJbmMvi8Yvq1ig5O1mgW9YiQAxPRmBpX8fJZ9QG1uqFXd
         MbhAKbLGfMZBZnrZSHms+7imo1jV48rPY2ghNXsKtCohHeEB25J7g3xeCQPpzTR9Tv78
         9CML8EFviWm5K5ZLNO1drW7yBPudktpXKOULwVAcO0JZXLnu1qavjmwfo1xvEAYOW8pA
         3PUQ==
X-Gm-Message-State: APt69E35Jh6qJwYglSHqspFJ7GpCNqrK8S/j0j605JZMQVa6o0mydJQz
        N3JljLdn6P0foLzvUGTY439P/GK5
X-Google-Smtp-Source: AAOMgpcSoHyfMBR+Dgnr0iDE3EK9weIg5BhWtzJGCogBvQA9Uqi1mken9V4LiLBK4JpEs1nIL6fRCA==
X-Received: by 2002:a5d:478d:: with SMTP id w13-v6mr19389130wrq.188.1530565036147;
        Mon, 02 Jul 2018 13:57:16 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-72-143.w92-156.abo.wanadoo.fr. [92.156.124.143])
        by smtp.gmail.com with ESMTPSA id y13-v6sm17591546wrc.55.2018.07.02.13.57.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 13:57:15 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC] GSoC with git, week 9
Openpgp: preference=signencrypt
Message-ID: <adfbf1bb-5951-af05-5f49-6a444be910c4@gmail.com>
Date:   Mon, 2 Jul 2018 22:57:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I just published a blog post about last week:

    https://blog.pa1ch.fr/posts/2018/07/02/en/gsoc2018-week-9.html

Cheers,
Alban
