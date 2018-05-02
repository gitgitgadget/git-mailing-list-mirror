Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A638B21847
	for <e@80x24.org>; Wed,  2 May 2018 03:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751029AbeEBDjn (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 23:39:43 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42162 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750785AbeEBDjm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 23:39:42 -0400
Received: by mail-pg0-f65.google.com with SMTP id p9-v6so6709821pgc.9
        for <git@vger.kernel.org>; Tue, 01 May 2018 20:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0DOJJWeqiWAe0VOuerU9EDhepfChquEuP8G6V4MH0Jk=;
        b=BYwCSCHdLRDjyi+JJ0JTcDCOqiyHuef52ldyOrm+cCdEP6WxV/SefYFlOHUXMbfi0h
         Ao3Hq7Jxjv791Oub+M1hle79FC7HR8eQB48CJEqhRqC3kIARZNzLKoe5vf0P0Qg2OEh4
         IL5+5EDyO+tvU3ULRwd8lGyVjwn+Rw/ldf55gS+NT2CMvOfV1ljhKfHso2K1AlRmMfhq
         /C+6rDZIasxomN92+710EWXhQMV7b0lKD4vlrCINTRV2uWX/0hAB8CJ2Q9vd5L/d7N0b
         hxra2XiXWFcSm6gmmOdZBKD4FsbB208llrCFbGXONaA28rRGgOy4o0N7jn5XGqG/SePG
         hEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0DOJJWeqiWAe0VOuerU9EDhepfChquEuP8G6V4MH0Jk=;
        b=pX4mZuipaAUVW3erBef/3Is+228oDKcMCknOWiGMpXeEuUA+TQ9Jbtrm5uctO/iVBL
         d4nRlCheuMHOs24HKW8EbJcYjQQJJxaYphH2QQkJX0apnYrEvv1kZjhl/VXB5uLZrkNy
         0oQLUPigDTFmaIoSKmbpELq8kv15qHVJKApHZehuu/7zdiFcUHmKPKyrMGak5ytajzE5
         2QD5Ho2l3W3i4OYQW7Fzuky7sd57uJ73vnJi3LswI5R27ryZ+v+bJthqGWpfNRhwjO7m
         k57kgRw7lptXbD3tTrEEE/z1hgXOkyyjw+VSDSQt4yxDc9k/qi31y6SMtrQG1FpPN5Sw
         s77Q==
X-Gm-Message-State: ALQs6tBWY8Ywq0lJuwR69G66skSkZfTn1fqCYtPCCKaM0LaM74GkH4/B
        R/ZY36tGNMoRMwMt9uEes+Y559J1gf8=
X-Google-Smtp-Source: AB8JxZrG5PejjxYCUcuXIoUGtsrEQedQCznkldUm5HnMx+R9FkoUjzpu/V3IRRCCsueWHqhtDV9Q2w==
X-Received: by 2002:a63:10a:: with SMTP id 10-v6mr14723834pgb.444.1525232382174;
        Tue, 01 May 2018 20:39:42 -0700 (PDT)
Received: from localhost.localdomain ([27.34.20.40])
        by smtp.gmail.com with ESMTPSA id s6-v6sm6574915pgq.19.2018.05.01.20.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 20:39:41 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git <git@vger.kernel.org>
Cc:     Pratik Karki <predatoramigo@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [GSoC] Info: new blog series of my work on Git GSoC '18
Date:   Wed,  2 May 2018 09:24:25 +0545
Message-Id: <20180502033925.6744-1-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello mentors,

As promised in my proposal, I've started
to write a blog series of GSoC '18 with Git. The initial blog is up.
You can find it here[1]. The initial one is just to get started and
from next iterations, I'll start detailing of my work towards converting
rebase to builtin.

[1]: https://prertik.github.io/categories/git/

Cheers,
Pratik Karki
