Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D736720248
	for <e@80x24.org>; Thu,  7 Mar 2019 07:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfCGHer (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 02:34:47 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46501 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfCGHer (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 02:34:47 -0500
Received: by mail-wr1-f65.google.com with SMTP id i16so16141809wrs.13
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 23:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fpvfWegOeTmNxTQJz7yzK87Kr6IpoyWVtqjsOxdNc/A=;
        b=ViV8DIEeV/A0N1BvRsTrYOkItE4sv/Z9pMOeUTf8NgndUJ0WZTYgIDxTxeFJonQRoP
         D6E+pHRiu1FjzPzRC8dp/3VSJ+zEUIjeo1ZKDZlboSyBUBtxcKTcCUog8kzrnAp/Ef9P
         njlCPKMf14wBUwNtTp9alS+3pTf/IXWzSzttkrdFmnCckNLYV/yuY8rEGqtRe49wxb0s
         Pn8FM9oKLqda1zF9T6sOm7eKRjJjxJdx3/wnsF/Zk8PH3Mhonqt2qoI20sM/s3KOUg4I
         kRC4tFAnaRBPRB8WWOfF6V5yLRFkIDUlLZqXSOGx/EcerF1UseWSAN6Ud4R4B3E9fhNf
         k8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fpvfWegOeTmNxTQJz7yzK87Kr6IpoyWVtqjsOxdNc/A=;
        b=SXctU/RUbpDPWfzHSL5tGYWqBoVbDPfM4k1UVIxKT3bBaDham0GkZVPzLWJgKIcqGT
         giuUJPUaMobeak6ip8hrQmll0q5wwwXC8qE6Uey6K3ndI4ZdU0qJSlwyfTyWCt1zQNOs
         udCrFT1Zl9YK5fQwdpnLiMfcCDd7QA/2D/3LyPz+VksD2hHphUIx4/4oGoNTv14VrmWQ
         tTvSjdI3pZcbrziSb+mTd5a/u2PoHEs2RV6CWLHmXmpVm7R6zUnKsg4zPlfXx/SJvjjD
         YZzu5HcpjHJ/AIBm/XTvYP2uyCcMhEeBvPa2VHiIo7s9IGOsB8kuSNWKySlCywllnH19
         Sh9w==
X-Gm-Message-State: APjAAAVwK3Wpzk5jPgXVcAnumDP7vnP7E9pPpKsOO9ru+Jim+uMMQmkQ
        4+G9lcGJXi0MritLcAtbhXM=
X-Google-Smtp-Source: APXvYqwFqZS0vGB/taewGs8wTqRiq0tvDd4e89fnUM8OzA4EjbcjIEnHYW3hfEckbw8AZApJCOKTSQ==
X-Received: by 2002:adf:ba12:: with SMTP id o18mr6154791wrg.326.1551944085004;
        Wed, 06 Mar 2019 23:34:45 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g10sm4397274wrq.61.2019.03.06.23.34.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 23:34:44 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 1/3] t3507: cleanup space after redirection operators
References: <cover.1551867827.git.liu.denton@gmail.com>
        <cover.1551940635.git.liu.denton@gmail.com>
        <4eee16cc5a841ac20c9ffcd010c0e1feb88059bf.1551940635.git.liu.denton@gmail.com>
Date:   Thu, 07 Mar 2019 16:34:43 +0900
In-Reply-To: <4eee16cc5a841ac20c9ffcd010c0e1feb88059bf.1551940635.git.liu.denton@gmail.com>
        (Denton Liu's message of "Wed, 6 Mar 2019 22:44:23 -0800")
Message-ID: <xmqqh8cfm92k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  t/t3507-cherry-pick-conflict.sh | 34 ++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)

A good preliminary clean-up.  Looks good.
