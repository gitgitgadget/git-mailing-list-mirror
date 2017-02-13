Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 051D61FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 23:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751394AbdBMXqt (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 18:46:49 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:34479 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751333AbdBMXqs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 18:46:48 -0500
Received: by mail-it0-f66.google.com with SMTP id r141so1317509ita.1
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 15:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8rXJYbH8+48H4d2vxYvxTnRM9i+GuXY2neUagVgsjBo=;
        b=mgvIbSH58X4JdQCOYGHzJLPIiyfkhzZGXxButU/sIMJl/eJX5pFXAVRwHiTw2/fW4u
         OHLKUdxm3BaaibFOZuJX3K7G1p99qPxsv+x9g+CkNJ/lqOiiHvP5hvva+ls44DEiiwSn
         78soT5NktF8o33IIKe5FGT+HEFdSvAupR3/2uW/PvFaSUKiGT1ajW0uc0w5iy7QjVZqX
         lTVaTj6mSGbkxAIQhbjXMIMDDavwXtgwW1vNzXrU1znQm1zve1ZA21zJgS55dkysZCTR
         vohD3dIGceqqTiAnZWDZcDk4D7k6C903ro1jcmXVGWsWhzUVST/sUJWlxChNB2Ra6dSH
         n7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8rXJYbH8+48H4d2vxYvxTnRM9i+GuXY2neUagVgsjBo=;
        b=b0opQ1QSXMYdw4fvRRDRM02kRxGd/WG5AP/gMNPYSRaXgALaHrQt8w/hhGfAyBDtii
         FVEz8PmpwLkWY8CY50rdEnujuk7GtWSrtAuBHeljxSeyULW38c/cYqk1LDbLZjCZ8Wtt
         m9F14qHQ9v6re/NqvRjjx8qr/81mEMCkdF7rLMET+VEaFERJIKCPUlPtaV/gxROuxpH6
         uVdxc1zw00fHu4YP7QSCzQfMRx3kqpMZnDdZcx9jhgrf0rpRctOXs+CnlACBJlE0qd/z
         LKA6tbemkoIlsrouyR3AHEge3yzO/01+lZr+SZduMTklf1rdQHz71jT2n3xn+mc9zEgK
         APWQ==
X-Gm-Message-State: AMke39k/x+4ZAyhKir3tEPk+DTc9DlM74NYOnFhHVk7lLlMWFV3YeUbKNLYwE+sBYAidaw==
X-Received: by 10.99.121.72 with SMTP id u69mr28864991pgc.207.1487029607203;
        Mon, 13 Feb 2017 15:46:47 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d0e0:42a7:601f:5154])
        by smtp.gmail.com with ESMTPSA id f3sm22916263pfd.10.2017.02.13.15.46.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Feb 2017 15:46:46 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git-for-windows@googlegroups.com, git@vger.kernel.org
Subject: Re: Continuous Testing of Git on Windows
References: <alpine.DEB.2.20.1702101241210.3496@virtualbox>
Date:   Mon, 13 Feb 2017 15:46:45 -0800
In-Reply-To: <alpine.DEB.2.20.1702101241210.3496@virtualbox> (Johannes
        Schindelin's message of "Fri, 10 Feb 2017 13:24:20 +0100 (CET)")
Message-ID: <xmqq60kdbqmy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> That is why I taught the Git for Windows CI job that tests the four
> upstream Git integration branches to *also* bisect test breakages and then
> upload comments to the identified commit on GitHub

Good.  I do not think it is useful to try 'pu' as an aggregate and
expect it to always build and work [*1*], but your "bisect and
pinpoint" approach makes it useful to identify individual topic that
brings in a breakage.  I wouldn't be surprised if original submitter
and I were the only two people who actually compiled the patches on
a topic in isolation while a topic is in 'pu', and chances are that
these two people didn't try their builds on Windows.  A CI like this
one will help the coverage to stop premature topics from advancing
to 'pu' without getting any Windows exposure.

Thanks.


[Footnote]

*1* The reason why topics not in 'next' but in 'pu', especially the
    ones merged near the tip of 'pu', exist in 'pu' are because they
    are interesting enough and could be polished to become eligible
    for 'next' but known to be premature for 'next' yet.  They are
    there primarily to give human contributors an easier way to
    download them as a whole and help polish them.  And I have to be
    selective when I queue things on 'pu'; it is not like I have
    infinite amount of time to pick up any cruft that is sent to the
    list.
