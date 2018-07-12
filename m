Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACA2D1F90A
	for <e@80x24.org>; Thu, 12 Jul 2018 14:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbeGLOTh (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 10:19:37 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:51209 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbeGLOTh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 10:19:37 -0400
Received: by mail-wm0-f46.google.com with SMTP id s12-v6so5833665wmc.1
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 07:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3oztROo4uCIuy0SnL3Npx6qxY8ZGnC1dlToa5xOudyo=;
        b=jQ5mPiyCO0tViYvRMT38+bv78tLCseswG1+j/mlFx9QXUMz4s0HH4kWa0aMysV7LP+
         1j722uHDwZmbtQUiExjEukFDSaw0XsnXqQDw43tBDIL5Q6TLFITWL75m+YxSLryDUBUh
         Cg/fZwHB/7nly00BcZURCLtPTHkatSw4L0Ptw96EIyWXpUUrKTrT5JG6FlqkYNSKrEng
         00US6xGzAGkNMku0gKuGCl3RdhPZK3f1MyPtMR1POWFq8wFaQi+yS07QRJRB8tYkjRNU
         YTM07ldrx1OTxk9TQGgdg56uW0AWfsjIPdcWnSldirn6LoB3bplxzOqHAzVZd00lV6nj
         zFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3oztROo4uCIuy0SnL3Npx6qxY8ZGnC1dlToa5xOudyo=;
        b=uV4EpMfFGutUA/eYxkgEjyb0j9oHtCH705DLMUqN1r0vZnej71dNvA9x1WVK6KXcaS
         xAG9r5qCJrlT2jUhBtayI/mHGuPJ0N6fKsP5IVQrdzSzxljANBU+hvbnguSYSCN57ciS
         by1eKWBGSdS0KAWJDQ8YNzKHBMScWe0I4v8HJ5phIlGI+rcA9UbO5/E2GWzPGWwWS3kE
         mfMm50oY00M0gHmiqcnAWvnaHxP3wrTdIoob/XmHlgBYIfrViM+DkcJ4kkGZUsAs9aV4
         AphuO1TI7K8toUlNnlJwFQi3KbSfDYo8iprjav7lejPjCaHEi+FO1lkNBzcHQQByyPxE
         TbNw==
X-Gm-Message-State: AOUpUlECNKZ0X8bQzmh7iE5oKnDdS7SfQpEZQF3HQYI1+W1yLlmdWvCy
        90Xz9g8ee7k9pHQtLyyp1ww=
X-Google-Smtp-Source: AAOMgpeW9uJvwf4BfUzEYm3mTV2SCmCM2FRlSI3vBeC5lY2cGhkMyepiFdqXfT2XqV3P6+CQwNCkDg==
X-Received: by 2002:a7b:c058:: with SMTP id u24-v6mr1498993wmc.136.1531404591515;
        Thu, 12 Jul 2018 07:09:51 -0700 (PDT)
Received: from [192.168.0.137] (5-13-238-53.residential.rdsnet.ro. [5.13.238.53])
        by smtp.gmail.com with ESMTPSA id a13-v6sm5451879wrf.93.2018.07.12.07.09.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 07:09:50 -0700 (PDT)
Subject: Re: [GSoC] GSoC with git, week 10
To:     Pratik Karki <predatoramigo@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <d6b9e84b-4d9e-ff1d-e726-56aa58a6b358@gmail.com>
 <CAOZc8M-CVgSqCByngV3DjQ0wNhDFOoWZuHVyRmoHiHZ9kuB-OQ@mail.gmail.com>
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Message-ID: <f2fcb7ef-8d24-b11d-42cc-33f0d3bc6367@gmail.com>
Date:   Thu, 12 Jul 2018 17:09:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAOZc8M-CVgSqCByngV3DjQ0wNhDFOoWZuHVyRmoHiHZ9kuB-OQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

> Sorry for late notification, my blog is up too.
> 
> https://prertik.github.io/post/week-10

Good job!

I also forgot to post it here, although the blog entry was available 
since days ago. I am sorry for that!

https://ungps.github.io/

P.S: Since the moment I wrote that text, there are no more bugs. Soon (I 
hope today), I will update this blog entry with a link to the Github repo.

Best,
Paul
