Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1975A1F406
	for <e@80x24.org>; Fri, 11 May 2018 19:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750876AbeEKTjD (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 15:39:03 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33555 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbeEKTjC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 15:39:02 -0400
Received: by mail-qk0-f176.google.com with SMTP id c11-v6so5300594qkm.0
        for <git@vger.kernel.org>; Fri, 11 May 2018 12:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EPVMm48m2zVjp0kAPkxZ5EUKYL1N6ZQpGG4QPV/+1Jk=;
        b=r7PzdtXI6oxFq9GiaMq149h/BzQT+DC+qvo2cmr/lcjUSRbloloItO5Zn0RxW6lu1h
         +QHeDojXPIJX9fviPEs1KlRZ1/UCydE7RWuftvvZclkelFJMHmx1cYffxts+pa9pz2vQ
         EoBrgqj6df+2ZAzqBjHqJf5vsg1cEtB6eqcSZKWlfiiutH0Im1fb0sYUkAMbHK9tMm1U
         r/n+0uIF0b1gZWdMPo05k03gBMWn5OXDT77DWBukIGBO89NRKISPmsmq0Hotb4kiiN0N
         JtWv2/Ktt7JcGlYSu5gfzf1l29kS8Yn6M3a1ZWJEFHdElKRIET76fVLtpwwA1LCgjfwl
         nNoQ==
X-Gm-Message-State: ALKqPwe2XrzEIJMyvGyZKqnyYWXlQ31tvYeW0X/3HeKAnKn0TX1cHI4Y
        9mspWnPxRUJQPv+Yq7d1Z9AegjUPQ63XAYfgFtQ=
X-Google-Smtp-Source: AB8JxZoBor3pjc5KfkPzQvJScIGnt5s4HTy13PcOZpqVK3LlZbZGsqYN9/sfVvRxuSIPpbavfvaorlh19UDauNya554=
X-Received: by 2002:a37:6d04:: with SMTP id i4-v6mr5915679qkc.361.1526067541428;
 Fri, 11 May 2018 12:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180510101615.931eb0d219eac4c84cf8140d@google.com> <20180511191725.54664-1-sbeller@google.com>
In-Reply-To: <20180511191725.54664-1-sbeller@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 11 May 2018 15:38:49 -0400
Message-ID: <CAPig+cTMeYFsn1iTto_wsG0Myik_Euh+UZh3pZwks=AEt8D13Q@mail.gmail.com>
Subject: Re: [PATCH] alloc: allow arbitrary repositories for alloc functions
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jameson Miller <jamill@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 11, 2018 at 3:17 PM Stefan Beller <sbeller@google.com> wrote:
> diff --git a/commit.c b/commit.c
> @@ -296,6 +297,17 @@ void free_commit_buffer(struct commit *commit)
> +void relase_commit_memory(struct commit *c)

s/relase/release/
