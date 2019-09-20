Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96D891F463
	for <e@80x24.org>; Fri, 20 Sep 2019 20:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfITUju (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 16:39:50 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37266 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfITUju (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 16:39:50 -0400
Received: by mail-pl1-f194.google.com with SMTP id b10so3718359plr.4
        for <git@vger.kernel.org>; Fri, 20 Sep 2019 13:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XdzzkFrxpNUQJBdCGcvlb6JZpP6ZuSHsLM94Q8wKqEc=;
        b=Klne7QYNiTW53PRDy3WyBuCZqweg52Tq2TTtN8cFRV5w9ER6lZu0sWVCa3ZgyUMj7F
         L4FvLcrEB73uqwJBrX8bL9msvEhmKctM2dGoo3YSXAFaIMr64Gy/K2fR0HZfLatC7cDh
         OAnfE89lkz5M66Su1nwOv6bi3tHCj5Zv+Cui6A/XpdIfUQqCczpuEtJMfURjaYKttV30
         66jsWIrIWb6k5yy94V69s9Tj4HIwSL9OCrire3lylyIP+hQqMVhGoK1pt6/CWmaZ1fx/
         NSVuf4hadwuVmUmGKbEqQd+xH7bzy6ta9QSgxUTn75rUh5+5bKAtwaaCPMXfhe1ogSkn
         znwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XdzzkFrxpNUQJBdCGcvlb6JZpP6ZuSHsLM94Q8wKqEc=;
        b=CGxU8aBnYJK8FHiDwwzNkex+0xcVMGPwuZ8DkrmYsBXrgk8ou9zKBgKOGJL6TNDt6Z
         jh1RqWzJl2JzF+dVxSa1G0QQBa9q7e2Bal+Gu3AySRXuv96Qhv8aJvqW9+PrHMV580Dy
         IQRs3v+QgTplKFnQUrNA1rz2u59aQB9OQUOhW/dnZ/jIvIWseI7VYoQJJLZ30qrBLhux
         hRUSzJwm4i1goXXKtvuokOPGKUAEdTYPz+GPrxfOXUCPRIK/p6WhJ3qwFbkf9DfBvupk
         hr2ChUbHz7K5qUG2wNoyp8c6VzU3bE5/F5fs/KtpRtmBD3MSXKaY3qp/WizR/dR+HSzO
         ok4A==
X-Gm-Message-State: APjAAAXfFPF1FhE286N2QCSs40B5vSEqhuxWG3loZ38y196dHN7/81Eu
        NtveNo9vDbowgtLmPmIp7cQ=
X-Google-Smtp-Source: APXvYqx0BDd3lAp79LburrO6cZposcAjvmG66fEHwrJgT7QBjlaoOMHD5ku+hlBndOBr5xaMepYGHA==
X-Received: by 2002:a17:902:a715:: with SMTP id w21mr18028787plq.274.1569011989941;
        Fri, 20 Sep 2019 13:39:49 -0700 (PDT)
Received: from GVFSs-MBP.guest.corp.microsoft.com ([2001:4898:80e8:b:3de5:4d83:552b:26ce])
        by smtp.gmail.com with ESMTPSA id n21sm3023920pjo.21.2019.09.20.13.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 13:39:49 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] multi-pack-index: add --no-progress
To:     Philip Oakley <philipoakley@iee.email>,
        William Baker via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     stolee@gmail.com, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>
References: <pull.337.git.gitgitgadget@gmail.com>
 <pull.337.v2.git.gitgitgadget@gmail.com>
 <1c94eaf5-fd62-cca3-2aeb-37512e8e41e6@iee.email>
From:   William Baker <williamtbakeremail@gmail.com>
Message-ID: <247026fb-0429-bc0e-3ef3-9f2553dfebd7@gmail.com>
Date:   Fri, 20 Sep 2019 13:39:48 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <1c94eaf5-fd62-cca3-2aeb-37512e8e41e6@iee.email>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/20/19 1:23 PM, Philip Oakley wrote:

> These subject lines are a bit long. Has there been some white space damage during preparation, such that the end of line, and following blank line, for a short subject line been compromised?
> 
> Normally the 'git log --oneline' should fit within the line, so ~50 chars.
> 
> Philip
> 

Thanks for the tip regarding 'git log --oneline'!  I missed that
I need a second end of line before the body of the commit
message and I will be sure to include them in future commits.

-William
