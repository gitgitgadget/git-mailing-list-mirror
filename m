Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6281A1F770
	for <e@80x24.org>; Wed,  2 Jan 2019 18:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfABSFp convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 2 Jan 2019 13:05:45 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41936 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfABSFp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jan 2019 13:05:45 -0500
Received: by mail-qt1-f193.google.com with SMTP id l12so34273358qtf.8
        for <git@vger.kernel.org>; Wed, 02 Jan 2019 10:05:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QxHo24ZoX2UyriYChIxsMeQC32zKsthfXzy2dcQnRbE=;
        b=bwzhTL0yOIc0gvFwLKmw3IaYNjiGUgbJMIyy6kOk4ucAHiUYsLzy3l2XDODkJIaul7
         L9JJ5X8tNVL4eO4XJWb6Xsv+dEtgezy6oba977PEG/PC7GMoJ3cC0RQqfXzCqBE5SuuW
         U239aop3gGH8952dKR5gjutAKmqToatL4fI6dHQTUImAdUMOJdvKbcBoxO6vXj8Gphj9
         BG7UeHapJkcywSJzPirmL3HYwAjrwJXnTp8OOmwprshU/1xYbUT8QeJ/JoTiVovM0B6o
         /F3AKU5oT9MPewJr4VGLFca3mvfMCJmPv7MC6aPlN4lrQUeHSYt2NEtVXauomS3CKVlJ
         K8OA==
X-Gm-Message-State: AJcUukd5fjUg/dWaWR+m5CStAMnCLe73b4KrFMtWFoikzvVUAITLlpXB
        9O/o39mC1ohEbrTBJGwzk2xYwlBjRkvIJOe0fTc=
X-Google-Smtp-Source: AFSGD/Uda3TVrWzGLzMU3NVPHjedoZ6K6A3VNnjlLDKJV87pX5r19YHMrXW7GG9VmVH1YSF2onSuK6OJMC3SuPVgayc=
X-Received: by 2002:ac8:101a:: with SMTP id z26mr43747219qti.184.1546452344444;
 Wed, 02 Jan 2019 10:05:44 -0800 (PST)
MIME-Version: 1.0
References: <20190101231949.8184-1-szeder.dev@gmail.com>
In-Reply-To: <20190101231949.8184-1-szeder.dev@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 2 Jan 2019 13:05:34 -0500
Message-ID: <CAPig+cRLqy3Zdt4rUbMXC2dd1bhOXYZ=8HEn++zsb=Rau7zADw@mail.gmail.com>
Subject: Re: [PATCH] test-lib: check Bash version for '-x' without using shell arrays
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
        Carlo Arenas <carenas@gmail.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 1, 2019 at 6:20 PM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> [...]
> To my understanding both shells are right and conform to POSIX,
> because the standard allows both behavior by stating the following

s/behavior/behaviors/

> under '2.8.1 Consequences of Shell Errors':
>
> Reported-by: Max Kirillov <max@max630.net>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
