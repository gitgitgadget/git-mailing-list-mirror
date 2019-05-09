Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4657B1F45F
	for <e@80x24.org>; Thu,  9 May 2019 13:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfEINYw (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 09:24:52 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:37665 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfEINYv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 09:24:51 -0400
Received: by mail-wr1-f46.google.com with SMTP id a12so3073512wrn.4
        for <git@vger.kernel.org>; Thu, 09 May 2019 06:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1tCOl07ABAj2bvUZ8Y9CJcP+qhI6rtlx+wLRV8He0SA=;
        b=CyaChnIdmxsnXJdAKLk+7ygmB1HSTRV9e3EQGSKbNhYBbBjWSkzpBTbX4Jh4CZEAW3
         DB+/t0NMhU6wPYh+ZHyoYdSMStI1gc+G6trb6QZCzp7XEp8rFJJ8sKQy7Y93kTtJugAu
         a7aMV8qwhGnmmBdMG5KOrQoKCZKDBQh9zYrficZ8iIvss7Pfk0x6vVkmD87vJ5IdIYL4
         /uCvCrC6xD2M2WGtWEMZWEZwQOXgBXA37IrJXIlreufafzO4f765Y+uQGdgK+/3umeOf
         CvJ3KnQiCf6GvZbdIWe0iSb1gtnzFw85Lio/90Cjv70Dszyk9n71bNy1ydk4B0P3+uLn
         zERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1tCOl07ABAj2bvUZ8Y9CJcP+qhI6rtlx+wLRV8He0SA=;
        b=TBDWEDmtYRcDlflrro/8ysXCud6diHhwZ5voA+iUa15Tlcc8lWgmsgdDF9Q5OU9g0j
         NOPb+E1PKEOvbn/VEvrNeylPvE/kZ3qYMyTagLmWGuTPGJmDH9UsRYyoew9fV65lvX7H
         DyzubAKwiMAeCJBHj6Y2YHZxKgdUwrNOrO+aO75OlYTo14wGEaxso2c/rbA/dxhq8IiJ
         0xXSeiQf8zCfx6CbiWceIMqGwnGlUZgxxqSPBg6bLsUMTlpKi0dTLH5E/ZU35xndrD50
         gwQ8CRhRK+iIpfw6he46jtjJ/Zq32FrJaPnh9QyBoe3DcnzQgu/Far//3pPfqtdS9RKb
         YSwg==
X-Gm-Message-State: APjAAAXh/izyQvifN24tN4qR33Bt/DSiT3Nz3ZE20UPtBezw2gicLLqr
        vvJYCQ3SgUwrnRMiwYfDNNNv46FJ
X-Google-Smtp-Source: APXvYqzW7QOV41c0Fpk31O+IXSx1w9cI42Z2sDUWE82flqnQBXutd1gwdUFsPlk0H6CkBel6nPkgkg==
X-Received: by 2002:a5d:67cb:: with SMTP id n11mr3113394wrw.3.1557408290009;
        Thu, 09 May 2019 06:24:50 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id c131sm2497188wma.31.2019.05.09.06.24.48
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 06:24:49 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (May 2019, #01; Thu, 9)
To:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
References: <xmqqlfzgg8s3.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <6726f99a-ec27-b72f-39d7-03eecb555197@gmail.com>
Date:   Thu, 9 May 2019 14:24:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqqlfzgg8s3.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/05/2019 18:23, Junio C Hamano wrote:
> * pw/rebase-abort-clean-rewritten (2019-05-08) 1 commit
>   - rebase --abort: cleanup refs/rewritten
>   (this branch uses pw/rebase-i-internal.)
> 
>   "git rebase --abort" used to leave refs/rewritten/ when concluding
>   "git rebase -r", which has been corrected.
> 
>   Will merge to 'next'.

Can you hold off on this one please, I think we should clean up 
refs/rewritten/ on --quit as well (I'm not sure I've convinced dscho 
about that yet though [1])

Thanks

Phillip

[1] 
https://public-inbox.org/git/4d486504-7f64-95fb-b7eb-51d424f3e6cc@gmail.com/#t
