Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADBC71F597
	for <e@80x24.org>; Mon, 16 Jul 2018 18:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbeGPTNP (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 15:13:15 -0400
Received: from mail-yb0-f182.google.com ([209.85.213.182]:39387 "EHLO
        mail-yb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbeGPTNP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 15:13:15 -0400
Received: by mail-yb0-f182.google.com with SMTP id k127-v6so15816553ybk.6
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 11:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zgHqqyMm70Sj8DF/8oUQWxx8/1cBKQYLhcfWslpo6Ug=;
        b=t26ofhaD30lGHGEPdvzMGqaPCZBIAV4Jcmszv3gYedBQPEx7lSCr1Ux2VhYAl5XY6r
         VkuPARKjtz3aBou2kkj72PxRcSP1WL44TQ6xHbGNXj4Q3Wev09yWlCNDKt15efAasdob
         2vRJfXETKDV6IdY7aJX0N9INFlYW1NW3fPTDzdH81+oSnenlGWAX5lJfUyfuE9gpRdBo
         SCEXPLS6bjTGJo/BSMx765ii2z9wVKzAsJcxVekiSyKehjvBq+W/H9jj6hUCWf9LW2s+
         s7zNW/S8ysq9ZBKmDpZBuOCvGk2RwsI7PtAcBU+FruRTDErobefDrrSteXN4Llu4OJMu
         ABRQ==
X-Gm-Message-State: AOUpUlFE8qtfNLYa1G+D6BhsM86+fh8Jj3PBeBCbmHGk6ExlxUtBcgXO
        ZFg8U/8XnsakUpoB615BrnSBMJdP2VoRs3PrI04=
X-Google-Smtp-Source: AAOMgpddesm9yUuTWNCt5bWZwzMpRdVwufvt9yr/LdL3MKOF5klbD52Qr5EEG7oyJFXprfGIXTNUtyAavbJ3+vIlSIw=
X-Received: by 2002:a25:488a:: with SMTP id v132-v6mr9326420yba.263.1531766673360;
 Mon, 16 Jul 2018 11:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.10.git.gitgitgadget@gmail.com> <6b7a50dc-6b71-0e31-030a-42dd1b26bde4@ramsayjones.plus.com>
 <CAGZ79kYem+uMrhv+CUSDNXtE3C8Pv1cx=aZOyBLG=uo-aQWXeA@mail.gmail.com>
In-Reply-To: <CAGZ79kYem+uMrhv+CUSDNXtE3C8Pv1cx=aZOyBLG=uo-aQWXeA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 16 Jul 2018 14:44:22 -0400
Message-ID: <CAPig+cQj5_bEiLyAAS4xnsUQEPzqT_2yerdAQxd8FidVpJ5CxA@mail.gmail.com>
Subject: Re: [PATCH 00/16] Consolidate reachability logic
To:     Stefan Beller <sbeller@google.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 1:27 PM Stefan Beller <sbeller@google.com> wrote:
> Another pain point of the Gadget is that CC's in the cover letter
> do not work as I would imagine. The line
>
> CC: sbeller@google.com
>
> did not put that email into the cc field.

gitgitgadget recognizes case-sensitive "Cc:" only[1].

[1]: https://github.com/gitgitgadget/gitgitgadget/blob/c4805370f59532aa438283431b8ea7d4484c530f/lib/patch-series.ts#L188
