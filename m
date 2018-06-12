Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AF241F403
	for <e@80x24.org>; Tue, 12 Jun 2018 21:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933533AbeFLVOA (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 17:14:00 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:37201 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933155AbeFLVOA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 17:14:00 -0400
Received: by mail-yw0-f171.google.com with SMTP id j134-v6so148411ywg.4
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 14:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mkusSL5WW74cmNR3wqZHMwL4a33bOvcYPxtzTAWdnGQ=;
        b=Xk0Mednbs37X0xzqUX4paq/rz47WP1LSqX51EiLnQQAy0mbX8wUumGfeiYz7SI+WjQ
         UlDnPpjCWnWK/PTwMhwDhanZ/PTHTmp1LQmGuVgyBkQbd3LacvdnIFPMCgtQnFNBF/Pm
         5vYCzhPvfM3Xkz5od7IfkH+TV945BB9S56nlXXjfb4gAsBORByAg5COW+WlEGrYGr1LS
         atH4MPOM107LrJrhF2MBte294p+DZqV+Ql0QX6mCqU7/TSc7oB7zRdpTmLlwl3Xg4mG3
         bzsV1j2P0PPRD7Blxogato5JhPEB31qbvlYDgRgbq4LLvy/EmMgFIbA0BkbwqybcmonT
         OpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mkusSL5WW74cmNR3wqZHMwL4a33bOvcYPxtzTAWdnGQ=;
        b=tWZNBToD5wV1mUFvIJLAVV8ZxZjYoKndzkQrJDwEm5R5L5JsYJTrh+qC5N7km+LApL
         XR2CvFZA+gMBhopnx3U6VPo3nIanJOmg9u/XJAoIECXI4YRCk2MwsHnertKk7F5AD6Hr
         30EqXmUssHCHE7mmNzn/jgfRCK865OhI3MBVMigKCjuOD2B5RlvuLuLviJKuxJl4zM65
         ER2oPtbXaxnU3oyaQfq7xf6xG4pMHUH1o6c6chYtAwEavvKFgPCnMc6aSUGvVrhCMgE7
         9WreOMStvtBCHm3pjM4ESXt3Lb9tw6gYDllGjXzp8TnuxIarU6NMBvmeYspgEFd++OUT
         1b/g==
X-Gm-Message-State: APt69E2/+GsMKH4z4kmKqXk8uCv1rt7RJE3rQdFpnbfCGTuRcxPg/JQC
        jy7loxaxKxfG+tjvF614RBMkxEnFMZgHeifrj2riYQ==
X-Google-Smtp-Source: ADUXVKLXRN3kMM4ZmW12nDsoxNbw+VlpuHhB4qZw1a9ba+maPs0caiHu2vx/yXkWN2Nyvcv4LIgl6BhEWRkViw6wgMg=
X-Received: by 2002:a0d:f442:: with SMTP id d63-v6mr1054541ywf.238.1528838039142;
 Tue, 12 Jun 2018 14:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqbmcf90uf.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqbmcf90uf.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 12 Jun 2018 14:13:47 -0700
Message-ID: <CAGZ79kZn_i4=w2fUdCgOjqeEY1SnnP6kqmExZKC3-aKK45x88g@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2018, #03; Tue, 12)
To:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> A tl;dr summary for -rc2 that hopefully should happen in 24 hours:
> the following four topics
>
>  jk/submodule-fsck-loose-fixup
>  sb/submodule-merge-in-merge-recursive
>  jk/index-pack-maint
>  sg/completion-zsh-workaround
>
> are planned to be merged in -rc2.

It would be nice to have
https://public-inbox.org/git/20180609110414.GA5273@duynguyen.home/
included as well, but as it is not yet a proper patch, I can
understand why we err on the cautious side.
