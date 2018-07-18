Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC96D1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 18:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbeGRTDz (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 15:03:55 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35244 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbeGRTDy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 15:03:54 -0400
Received: by mail-wm0-f67.google.com with SMTP id y22-v6so3854564wma.0
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 11:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JbyBUqDB8t0Mhm2LLZLG+rF9kkJUvpC/RtXZhqXBvo4=;
        b=FBFPQ5Zu0Cv+B3TP3UkADkiqkfG3C8z86CXxXNEop3QUyDE4hei95h0Wi+vv/UT0/O
         fCrAo1c4krM3LJA2XIFwufj3+vUt6uIWu2jdYyzXk2v3X6ubkghJL5O5rEcPNRZoTT6T
         T38m4S88HZ+jcdKJljQpLO3N+4iA1tqq7Qr9Pvd947bJGu5ea/ChhaiN6qZUcRM+Ruji
         Ph/u+dIMqBMddGyHveaoc8S+BSwcl1YtmGiwNKWsOQBcKjgJ0+S8wuzpEhJzSr9d1Usa
         2nCHsL6+QBXM+zdv8zMTEt/ACCNZOrqSeAjHQKTaP+OhpQwtCPf/cws+EFt6PbFuuPAK
         +C+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JbyBUqDB8t0Mhm2LLZLG+rF9kkJUvpC/RtXZhqXBvo4=;
        b=TNK07ZvK/a0cwf1nGRaZ+r4npzVDkUYzad74Me+U6x9dqVposCOc/42UH5Qa8eK15o
         1OC7klOC5LrueRtvOZ51y1e/Bo+G/wVEkTQ2q8V6RucCJ07tHTC+/hMMj9O1Qo7zSXyC
         7LbWm9O/WORktwB51ElUtEYEDlBlET3Z4XoaHi6r4PW2WffHtW7KRkMPcwj2aYxIpO3x
         8s1XaDBr7ZBGal9M3OslajWP0oCavDx9oLrS1lGxCKKKLGQNV8cOa6FioELszHmiFdNZ
         VvP2J7Ix+EGfFkhxCnP3Sbkqe7T/xO9jUT8gSU5/R2YmEi28MFE4QoUJx5UJep/CiX0z
         NgpA==
X-Gm-Message-State: AOUpUlHGZHFx9YJEfFfR+XHYWArdV5ryTBYSrlqoEfniRb+DxCXD/kC2
        5621DKAUB3Z1CBy6puCFVpIJT7Gk
X-Google-Smtp-Source: AAOMgpclEqD/TaE7SdX7rM3z3g7k837wbVuFYFbzwSRxyo7pi8L0QoEc+Pdbnp2mdtBdrEHldRCiiw==
X-Received: by 2002:a1c:55c8:: with SMTP id j191-v6mr2231855wmb.67.1531938286530;
        Wed, 18 Jul 2018 11:24:46 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b1-v6sm4196649wma.23.2018.07.18.11.24.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 11:24:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: fix --color option formatting
References: <ccf73807-1856-1ce8-365a-0c4fb25ea7bf@gmail.com>
Date:   Wed, 18 Jul 2018 11:24:45 -0700
In-Reply-To: <ccf73807-1856-1ce8-365a-0c4fb25ea7bf@gmail.com> (Andrei Rybak's
        message of "Wed, 18 Jul 2018 19:37:48 +0200")
Message-ID: <xmqqh8kwjtaq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> Add missing colon in two places to fix formatting of options.
>
> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> ---
>
> Done on top of maint.
>
> The earliest this patch applies is on top of commit aebd23506e ("Merge
> branch 'jk/ui-color-always-to-auto-maint' into
> jk/ui-color-always-to-auto", 2017-10-04), one commit away from the
> commit that added both of the affected lines: 0c88bf5050 (provide
> --color option for all ref-filter users, 2017-10-03).
>
> I grepped the Documentation folder, and haven't found any other
> similar typos.

Thanks.
