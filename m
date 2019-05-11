Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D4171F45F
	for <e@80x24.org>; Sat, 11 May 2019 00:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfEKAP6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 20:15:58 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:46342 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfEKAP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 20:15:57 -0400
Received: by mail-pf1-f182.google.com with SMTP id y11so4010637pfm.13
        for <git@vger.kernel.org>; Fri, 10 May 2019 17:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7LRPnyHGPCkUXbR6SZOBNA7iUEe5OAd0ZCJUtF4hU0U=;
        b=W8QSYb5+SdN6oLIa6PAEhilDGgE4UF14J7TBoQPtMlJEU3JXz5vJ7NGMq8Kn50ErMj
         fRRqcba5tL29OS/VT6mWmN4wAh2FUhv21AGTwKgisp+g8Sl7J5+HhbMPLt88J1UW54TR
         LX4SXCM6O9q66nUwfLmO1biIxykBsma7HbeixHE8lwd90kWMh40xJF9GX7Rs0ap72/9v
         iRV+eZLAORGHf3E40Wd17F7oowaXYj76I9laCBNgLxKJX5xHMaNhDq/u4TYRRJyjWH6k
         zFLhu47yia1VqYVA+3xg+CWDrD/BsFulnHPBYWKPpWM69kbBiB9Y0Ak+dDz++0LjeIAM
         v38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7LRPnyHGPCkUXbR6SZOBNA7iUEe5OAd0ZCJUtF4hU0U=;
        b=dzyyuJBUXH+AsUgFh8225wiDTL8mnL/TmqtdJg7WK2agSKDju9jOngJpKVM/FvreQT
         Nh9WyHXuJ+GyJ+4IPufd0EIV8okPicvRjksVvI9EiA5iLma1aZoTgmlcXESjyEbk6EfH
         9Yu/uvdNrNFKFZrbw1C/KaSdtM2yW5LoY5T+R2vzQ04ckwUbqAqf29m3IEhXYhyy/uqn
         /8J22vMiKzuNcVaFLkqB2xludQDdUh+UKi7gry0XYdzCwo5xGXY00f8srdW2USearztx
         cVzawlAUN2k88i2Zn8eH34CRmkhDsoLCWuMhBNtDBDWg5nwQdhe/hO8pZZTTmbfMjCzi
         RJ0Q==
X-Gm-Message-State: APjAAAXTq7RnUkTn2hKBfhiGF8vLPeg3N2ZDevj4LaP+13evfT1cpW3X
        6QWfAsrn+/A6Lhg3E1UmVHZ2W1m8ljU=
X-Google-Smtp-Source: APXvYqx9HFcBM1pBCPhojQa/tQ/a+RJlwtnv/Po+pZ6iAfqARNHLYwXgQC+/GpDo4Zi+i3523FF3UQ==
X-Received: by 2002:a63:ed12:: with SMTP id d18mr17345057pgi.248.1557533756120;
        Fri, 10 May 2019 17:15:56 -0700 (PDT)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id g19sm6764328pgj.75.2019.05.10.17.15.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 17:15:55 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com, newren@gmail.com, christian.couder@gmail.com,
        olyatelezhnaya@gmail.com, matheus.bernardino@usp.br
Subject: [GSoC] Blogging with Rohit
Date:   Sat, 11 May 2019 05:44:21 +0530
Message-Id: <20190511001421.25283-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey all

Thanks for welcoming me to the community. To inform more people about
the progress of my GSoC project and workings at Git, I am thinking of
starting a blog series on my website[1]. Please find time to read some
of the blogs and comment on them.

Thanks
Rohit

---
[1]: rashiwal.me
PS: comment section is not working now but I'll fix it as soon as possible.
