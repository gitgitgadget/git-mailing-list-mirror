Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D0A41F597
	for <e@80x24.org>; Tue, 17 Jul 2018 21:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbeGQWaa (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 18:30:30 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39027 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729741AbeGQWaa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 18:30:30 -0400
Received: by mail-wm0-f66.google.com with SMTP id h20-v6so785992wmb.4
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 14:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vTXANV7kolSwIoUwt34v419US+peI+JUdEeg/Zd8R4U=;
        b=fcSTv7+Ee4bcUOXozyImu7Yyo3fQS71Sb2LHLq+yto97pPDZL4YIT+WARznRQdSHA1
         gp2huFy0D7FyROzqWOyIrnfZaCqWRUiofSvTbC+XKLz8QpASPdwN3EblJEdaaQjdiH8J
         p+Yh8HYRYLNEg8M3DhXdI4czo2BO3z8eRLmD1cYUs9bITlhNvkg2nGTZF3+fRrFHiYF2
         p9mXHc4r3aeTDK+NllZRN4weH69cVQN5PLFrAa2uY8bwdQ3kNLF5DLbMm0vVbnfg+4px
         FTyHFmOIaVtZQFAgq/1c1H6fqUpPTyIiZtXQUhwytpoep0mLtqraXlkewRprehy1Dk7G
         6gkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vTXANV7kolSwIoUwt34v419US+peI+JUdEeg/Zd8R4U=;
        b=P30DaIEnA89rji/afZYy1L2VaFrz2ORf5IL4QoAdam/mKtTRy0PpT8fTzRwyLtLxtO
         zTTjwS5yK/DrqKOYMDW2qZusrThZoNrEGvZ9ZuNE5b63O7FT2qX1zU2LCoxQnGDSJkma
         Tenonbk6Jze/SlTPOu/Lx1S+wflIn+o9msdhLaBZx5qEu95PXMt70L2Vb5NZ6KwSek9E
         v8L46jbJvkIumHi1SdWmbzkQzG0JyQeqD1aj3XYe6urckAcniDspiDz32XH3HMvYy7JY
         f9iLbL3y/7XczgPtN1sPut2jqzNX3lCk1mAFpIt+w5ZfUHIevc5PEmV5Sb71zdAgQZ/b
         Skjw==
X-Gm-Message-State: AOUpUlHjZmeX2IWTBX9n6MR+HA1iEZ6rrBjIz+qQ5wO7tUFc4PhucCRU
        JH5LEVsBZmtkd4PnNSgYzI1lewsp
X-Google-Smtp-Source: AAOMgpctwVEmFl3Pnn0ZhF9BuroEORhIOCpuIjSccke337HpPMvSfZwi+3FuVnNBQLa5W4S5cqjMFw==
X-Received: by 2002:a1c:ed07:: with SMTP id l7-v6mr2488623wmh.139.1531864550263;
        Tue, 17 Jul 2018 14:55:50 -0700 (PDT)
Received: from [192.168.0.137] (5-13-157-218.residential.rdsnet.ro. [5.13.157.218])
        by smtp.gmail.com with ESMTPSA id f12-v6sm1294693wrg.88.2018.07.17.14.55.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:55:49 -0700 (PDT)
Subject: Re: [GSoC] GSoC with git, week 11
To:     Alban Gruin <alban.gruin@gmail.com>, Git List <git@vger.kernel.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <866fb524-6fef-ca6c-da79-b63405b5e578@gmail.com>
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Message-ID: <b33c711f-ec95-76cc-73e8-9a421e4d1a7f@gmail.com>
Date:   Wed, 18 Jul 2018 00:55:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <866fb524-6fef-ca6c-da79-b63405b5e578@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On 17.07.2018 21:41, Alban Gruin wrote:
> Hi,
> 
> I published a new blog post about last week:
> 
>      https://blog.pa1ch.fr/posts/2018/07/17/en/gsoc2018-week11.html
> 
> Cheers,
> Alban
> 

Great entry!

Here I am too, with two updates on the blog:

* The weekly blog.

https://ungps.github.io/2018/07/15/week-11/

* Some of my thoughts on GSoC.

https://ungps.github.io/2018/07/16/About-GSoC/

Best,
Paul
