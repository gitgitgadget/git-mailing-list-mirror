Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0105620D12
	for <e@80x24.org>; Mon, 30 Jan 2017 21:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754386AbdA3VOD (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 16:14:03 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36099 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754152AbdA3VOB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 16:14:01 -0500
Received: by mail-wm0-f67.google.com with SMTP id r18so8267084wmd.3
        for <git@vger.kernel.org>; Mon, 30 Jan 2017 13:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CWP7EP4/KG7K7K/l5+AJTSjmy1Pn8DVtOmcZGWz7UUA=;
        b=W96Hxv/RxXeDeRY01zOTibHxcuGPgvg5qB9SPNlC63kVbiljD1l27pPvnpJ3K7NF4m
         FhKFW0+l4F3CmE/VYbx9LF8R4nwA5/2b6gdh3qSto82perwCrMkuaSBzKOZnE3+GOux9
         NwyMZ+chZ4I7DJR7DDpByAcYnWVO5ocNliY1j8UyEkb9e/OKN34tIQs3TSkPLBOHEJPo
         bOw3NzX7jumHNOkSKnHOfbfWui73ov1RqZEQw+VYksjByrfiIC7LQtPfQ5mLIsL/jAiK
         7UvTkLzA9i2VP1DHENh0t2QX3jw2M7gZcpST8xDEEoHGiClxDIOIxx2KX7eG95Ht62mS
         p95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CWP7EP4/KG7K7K/l5+AJTSjmy1Pn8DVtOmcZGWz7UUA=;
        b=IKr4gkk2vDs5hGbQUL4Aw9mempK1HwgMk+krrLl6HvX2oT/qedWtBP4Ixr14FbAizv
         TXgEeRmnnxWR0k5WMs+oI7SHXGMoOJrc544uPJdxjVw9CVqvW2TW+1549Cqe0kUTplAD
         fEw1s1WF/zcxSEbzmzWMor6BqveuS3qcBCwKnr46Wy+9oWEltZj0eMBID8pna5ysyOe1
         qzRpW58XDlO68YnllRy7b4SJyiJqTRCjHed0W2S6sbNWAJQkiuPWiqncEnuQXcj3fxAz
         yYRhuge4Cpzz+AYCuUTs4AsIZD5Qm4J/1DZkgCBx5D0PDdJBhNAC1M2hGg2RPxpDAzMd
         sVyQ==
X-Gm-Message-State: AIkVDXIeQZdk6UfDBxBmXSHtveEbYgaSjGGj8FkUzkJZ/ubBhm5TPiV+41IPY5dTLElbHb+MY+jRfS1umAg05g==
X-Received: by 10.28.150.202 with SMTP id y193mr16587025wmd.106.1485810837803;
 Mon, 30 Jan 2017 13:13:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.167.100 with HTTP; Mon, 30 Jan 2017 13:13:37 -0800 (PST)
In-Reply-To: <20161204144127.28452-1-peterjclaw@gmail.com>
References: <20161204144127.28452-1-peterjclaw@gmail.com>
From:   Peter Law <peterjclaw@gmail.com>
Date:   Mon, 30 Jan 2017 21:13:37 +0000
Message-ID: <CAKoneT+Bn+MdbeNnPJsu23rbLCZ=jxADNVtpNefw9zNYMq26dA@mail.gmail.com>
Subject: Re: [PATCH] Completion: Add support for --submodule=diff
To:     git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, szeder@ira.uka.de
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

> Teach git-completion.bash about the 'diff' option to 'git diff
> --submodule=', which was added in Git 2.11.

I posted this patch back in December, but I've not heard anything. I'm
sure as maintainers you're all quite busy, but I was wondering how
long it usually takes to get a response to patches? (also whether I'd
gotten some part of the submission process wrong?)

Thanks,
Peter
