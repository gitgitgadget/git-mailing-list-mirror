Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3583E1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 21:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeDJViT (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 17:38:19 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:44909 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752598AbeDJViR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 17:38:17 -0400
Received: by mail-wr0-f181.google.com with SMTP id u46so14178731wrc.11
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 14:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TmwRZ6I9/7lpen5ixInl+Zvl2IEyWjfLzApxAXWl4nc=;
        b=n7u+Nx0GBBgzRRIf50jTsDVbkRZxmBQFXJMTb81V2ec1yHSHZo8nLFdxB2OjaINjo4
         xKbYl9hmW68/qGEdOYANnRilG3It0yCdf9ns7NryywZjmfuOBhv/Zk7aJuKuYVGH5VHI
         azJQUWiwnEm9BQ/X2Lr0tEuQnmt0C0Hr2916NRfA6SnPI5LroFWxPQkaDa+lcyuahNCI
         zo32+4g9bMV9aVBaUSJL7JYdcKEc2dRwiBkS/uOmFer8aKXYy0mt5f8ac7FqsXMPTpBL
         pVXtBxGOmq7K0aywa8E9kewT/z2g3EsVAMHoxxYb1xXzghDFP0/pTXuwAKj5ntTbrFov
         7dfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=TmwRZ6I9/7lpen5ixInl+Zvl2IEyWjfLzApxAXWl4nc=;
        b=hbVbnzDA3T+jdzN5rZ/LS9wBnHUhqykjYURvWOVxu5RwfCoTW8+SbGLy11WcOkNd5o
         7zIs9e5ABfUL2nTSWYYuj3yrxTxYOIeyWMNJJIXuYrVdGz9eZHxNOxdICmXBIOIogVUX
         1m+ebeYetZDMbhhf1OCuMh3NHw6C5ayfeusXrEnV+nK5mDWEw39S5JhnnecMrG0ssiz1
         MMvVLYH0cew5G7nKem+98jXzr1cZd7UX3v3gfSWxgyRYrKaCPDR+FNyrHf7LpBi1pEH5
         7hL1FFR1k8TPTlePtuhbCNhDAVfZT8vpxUt7jOSzx8KTCtISwKwFRh2ilRy4FqCV/mss
         ePBw==
X-Gm-Message-State: ALQs6tD8Bc3EYEt+EgfelJHNf2WRgPFGWIz5SfJr20klmXL6lneZn/Lz
        tn4EnQjMefdDcBvmW1vmq+g=
X-Google-Smtp-Source: AIpwx4+m8mEhs04FuciVc5lBDv9sPzLhp4+3aifNfC8TgTqPBG8cvLcwAdXZtr9X3xnxefvDzcS8Lw==
X-Received: by 10.223.220.77 with SMTP id m13mr1394627wrj.274.1523396296119;
        Tue, 10 Apr 2018 14:38:16 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q20sm3360822wmf.39.2018.04.10.14.38.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Apr 2018 14:38:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: git-gui branches, was Re: What's cooking in git.git (Apr 2018, #01; Mon, 9)
References: <xmqqd0z865pk.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1804102301200.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Wed, 11 Apr 2018 06:38:14 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1804102301200.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Tue, 10 Apr 2018 23:02:21 +0200
        (DST)")
Message-ID: <xmqqtvsi214p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 9 Apr 2018, Junio C Hamano wrote:
>
>> * bb/git-gui-ssh-key-files (2018-03-02) 2 commits
>> * bp/git-gui-bind-kp-enter (2018-03-02) 2 commits
>> * cb/git-gui-ttk-style (2018-03-05) 2 commits
>
> What is your plan with those? I thought they were on track for v2.17.0,
> but now I see that they are not even in `next`...

There is no plan. I was waiting for somebody to raise noises, get
irritated by lack of active subsystem maintainer(s), which would
eventually lead us to find a replacement for Pat.

I can play patch-monkey for git-gui part but I do not want to be the
one who judges if proposed changes to it are good ones.  Have they
been reviewed by git-gui competent people?



