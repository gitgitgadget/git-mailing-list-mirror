Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D49920248
	for <e@80x24.org>; Thu, 18 Apr 2019 00:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387488AbfDRATX (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 20:19:23 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:47035 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729446AbfDRATX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 20:19:23 -0400
Received: by mail-pg1-f178.google.com with SMTP id q1so289432pgv.13
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 17:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D3HrZrkbTIZr5TP5e5WYIkxgax5uaHK8a0C7FkoF9Tg=;
        b=CyW8tdJC/tlfZxCJ7urW3q7nK4ggpogaXHl1/Ovx1ZzhHIjJ45mFURr6SAm3HstRA9
         BqrqYxxdRP5noucBQQKsU2g0erRvjAfsGWZ0drPrOa5Y35oIkskflyil1BchSk5Wep0p
         fpqc117kl1c67GR1TSskczkLzI0YGbdEhKuJjsmgl2DV1HNeYjqMBGWdC0LnDgi3iHbB
         xVS5Hiel//YJMy3JFYiGXPTH9YHS9Q00fjZDrhTDRzfTuD8qbE8V1noAHbfEA0gzDKC/
         xMF9Hm5I9TgixI6E0L1Oxcik3dmKYuqFDTxKSg12zltR97JtdruGryGFnj5O4hoXkMSm
         rt2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D3HrZrkbTIZr5TP5e5WYIkxgax5uaHK8a0C7FkoF9Tg=;
        b=pK9kOjpVuvqTKIK89P8K3lv3w6v/Sg1L0AE7q9OxbeH0A5oEByBqBCKH0W8Xq0V8bz
         ONvEXV2Xeazui9bXlvxxohMm5VneyZroUmG7cuvm4NOon+DCSJ0ZuzTTXDL6i9z1tums
         K06qjSqbB+8m8kq0YHqWtIsGEIlcVNLamchEkZWIe3k5uUZrM2eYQS7AXhRqokOCWuV1
         ckG+3mwHXan7pTdyJFCHGqYCyi8wLflj/Cw0+R50W3ooehjpmZWVpsm2bCbq8jvDbKP0
         4EdQuHLJMpBleYmX9W25Mf3pcaaoJBLs02ROzHFKCS1YjDXqPBOOkXmt7jXPbvrlgyld
         k0AQ==
X-Gm-Message-State: APjAAAV/roE4c6F+40oVgY1VRa2pfiD+pQ/tZqY8QN8y6a7KrYvgHBvj
        wPDp+5nJgPqxuZgK+Dp86C0=
X-Google-Smtp-Source: APXvYqwy+Y5oyxJU6sD9RYyWgezKbT2KNndgRc1fW5qiKrFr5EOvhInOGgx5RD2amnDeVk0ahv+TOg==
X-Received: by 2002:a62:1690:: with SMTP id 138mr93827151pfw.28.1555546762726;
        Wed, 17 Apr 2019 17:19:22 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id p9sm422200pfi.186.2019.04.17.17.19.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 17:19:21 -0700 (PDT)
Date:   Wed, 17 Apr 2019 17:19:20 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2019, #03; Tue, 16)
Message-ID: <20190418001920.GA31901@dev-l>
References: <xmqqef62ozny.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqef62ozny.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, Apr 16, 2019 at 10:19:45PM +0900, Junio C Hamano wrote:
> * dl/rebase-i-keep-base (2019-04-16) 6 commits
>  - rebase: teach rebase --keep-base
>  - rebase: fast-forward --fork-point in more cases
>  - rebase: fast-forward --onto in more cases
>  - t3432: test rebase fast-forward behavior
>  - t3431: add rebase --fork-point tests
>  + tests (rebase): spell out the `--keep-empty` option
>  (this branch is tangled with js/spell-out-options-in-tests.)
> 
>  "git rebase --keep-base <upstream>" tries to find the original base
>  of the topic being rebased and rebase on top of that same base, which
>  is useful when running the "git rebase -i" (and its limited variant
>  "git rebase -x").
> 
>  Will merge to 'next'.

Since this patchset has grown in scope, could we update the description
to mention that rebase now fast-forwards in more cases? I think this
would be useful information for users to know when we write the release
notes.

Thanks,

Denton
