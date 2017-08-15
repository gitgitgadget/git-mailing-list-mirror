Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 407DE208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 14:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbdHOO2p (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 10:28:45 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38045 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751765AbdHOO2o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 10:28:44 -0400
Received: by mail-qt0-f195.google.com with SMTP id p3so859506qtg.5
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 07:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sCXTOtBy1Nw6Xy4LvCVwajIlqIJoXmvBHj4LEcgA3UI=;
        b=AcUKrROdHDXFstQa8utJXYMM5nmh8Lyfq01OtQ5aTDPlMtfRGV+aUnke7mMhsIlkyY
         kkNPkLm87tYEvt2Qoq1skMK5UBoJYBeLneRnwF6JMKZQ7r0hmuj6vGae1ynYslC4uNcn
         DkZYVQ+GxYz1n5teKwhUnzM+4fKWfSs0GJk6zZAshufTxyLDxAJMnFPGhq9zRYZA5kjN
         HAyu3KO5MdqzMv2bZfkhcoWG7Nwduhqjl/zXjXNLJxvU0sgjsouk11JS2eBh3FXqs8mt
         xXJpBB8+XCVQ7qQoed71oQoWXkq4oTw2cCGCECgzSbKsjx2O4HgyfE46R5Gf98c1VyTQ
         ukBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sCXTOtBy1Nw6Xy4LvCVwajIlqIJoXmvBHj4LEcgA3UI=;
        b=X5mtfJUcStNjbwDFhxYNbWnmuUrAaVJ///RK55+Ch5diccbwUHrQv4bCx5z4O33EH1
         Vu/kD+BXekp0r6gFeoR4TfN/GJjoFyvVLcpb+mWbpC1I0I8AtWx3r/b5etj7i+YYjxBd
         +nGT5cObmuTdFAV9KjY07CuVzoPpfAni6o00SOp7bpyLFGy4QtPqeeCvc+XJyz/1eIae
         u70c1cHWTRu2t5CA5Mzhz5H+UhFVv+Mx1+h26iS02AZuUeVeyc4DYY5HUHCzGtWg0Vuu
         0Bje9/zM+h5/QuPlFlY4coitZOJ0x54KR//VGmYWtOP0CcjF3Chx1o4b+x4AND7QO+Ht
         zJ7w==
X-Gm-Message-State: AHYfb5jJcqUqBVoMpqPwkS/4nlVQGIye3884paurEuxZjzQbJr8K/FGJ
        Ye1KO8IrcX7dnw==
X-Received: by 10.200.53.113 with SMTP id z46mr39864348qtb.184.1502807323727;
        Tue, 15 Aug 2017 07:28:43 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id s11sm7076447qtj.54.2017.08.15.07.28.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Aug 2017 07:28:42 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] clang-format: outline the git project's coding
 style
To:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, Johannes.Schindelin@gmx.de,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com, peff@peff.net,
        avarab@gmail.com
References: <20170808012554.186051-1-bmwill@google.com>
 <20170814213046.107576-1-bmwill@google.com>
 <20170814213046.107576-2-bmwill@google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <9c9a9b98-9308-95d6-a912-85a49bd3e21d@gmail.com>
Date:   Tue, 15 Aug 2017 10:28:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170814213046.107576-2-bmwill@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/14/2017 5:30 PM, Brandon Williams wrote:
> Add a '.clang-format' file which outlines the git project's coding
> style.  This can be used with clang-format to auto-format .c and .h
> files to conform with git's style.
> 
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>   .clang-format | 165 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 165 insertions(+)
>   create mode 100644 .clang-format
> 

I applied this and then ran:
     clang-format -i -style file *.c *.h builtin/*.c

The modified files generate lots of line ending warnings.  Apparently 
clang-format isn't respecting the git settings for line endings as it 
converted CRLF to LF in all the files it edited.

$ git add .
warning: LF will be replaced by CRLF in alloc.c.
The file will have its original line endings in your working directory.
warning: LF will be replaced by CRLF in base85.c.
The file will have its original line endings in your working directory.
warning: LF will be replaced by CRLF in bisect.h.
[...]

