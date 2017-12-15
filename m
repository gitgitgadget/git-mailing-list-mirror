Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 326F41F407
	for <e@80x24.org>; Fri, 15 Dec 2017 15:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932183AbdLOP3k (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 10:29:40 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:42140 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932072AbdLOP3j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 10:29:39 -0500
Received: by mail-pg0-f51.google.com with SMTP id e14so5998157pgr.9
        for <git@vger.kernel.org>; Fri, 15 Dec 2017 07:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S/Yj1jgVc/03zM/WUgzZ9huSCJ+LE1av47fv+7BoOfw=;
        b=TQbdrG5hrbkG6Q6KkBlkCpqaVeGU2r4ggEj8goUq24+PU2bflM5rcAaYN/A38lm3TT
         RmvVWR7se4mUWPwi89VOkn6L9ypEcW/togn9gkjPnvfpOmPVSLmyVQhSoFgj2rK8R5qO
         nsrbbqg8Fz9dqtihOCxV0spQx1Wz6VyKLQFdqd9PWu7swvSk+m7JR50Bli9labaz6tvc
         2L+1/TtLpjjiPPU8rw9mDlIju9M3I00pShc0c9VibtT9Z0T6bHlOnv227t/+PkrH1CyW
         5Nx7jSfMTBZbA9l44r0a4e4VFGW6xJ/xrienNlrsfzgytwZxVO5DUSPNkJ4QQp5oQX9H
         KRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S/Yj1jgVc/03zM/WUgzZ9huSCJ+LE1av47fv+7BoOfw=;
        b=uND7K6moxLgZxvyVmy5dJ+eLQGdZDm9VIkinJlhmkuyBPE5CYW8LHY3GrzbW+Bnmvy
         fGHatJ6rHbm/UlXK+geJbVOEDOCL74/QVZtDD3wf+MkfJb+hm8dLRDZAv2xq1+nGaLK4
         EfH235bGCP0x9UAJuuRZWzhnIKudhm8R4bWyCg0KPNxYfxpt0u0jRWyJ1XUfV9NpHK97
         V7Kkl9VhS+lQws7PqARrvqzflz8wigUnV6sghg76/v+3p2G/7TJ2W7rkAiXWePslEEDk
         1sU9CMj+mOaugAYUp0WUGgATHKrQLDYGxVIfkF5bZ5USxeLRh151SFAwhQ1qZilvnCKj
         EUcw==
X-Gm-Message-State: AKGB3mKBZpAQWWCDgFzmJ54gymuP4OczGUbQfm/zTf1dFf7lSqBUai1R
        JJxj3YGxlFl9ujece4PqVbAIDrDN
X-Google-Smtp-Source: ACJfBovw2ETJzSiAx2Q+6Jhu/P1aetHEbNmlZQpp5DF0MIdfTyaCR0cBl+Kg/CQqq8q/N1qBIaS5Rg==
X-Received: by 10.99.185.28 with SMTP id z28mr12739732pge.212.1513351778382;
        Fri, 15 Dec 2017 07:29:38 -0800 (PST)
Received: from [10.4.2.238] ([14.102.72.147])
        by smtp.gmail.com with ESMTPSA id z63sm14408351pfd.71.2017.12.15.07.29.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Dec 2017 07:29:37 -0800 (PST)
Subject: Re: What's cooking in git.git (Dec 2017, #03; Wed, 13)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqzi6mutcc.fsf@gitster.mtv.corp.google.com>
 <1513255038.6351.2.camel@gmail.com>
 <xmqqk1xpusyh.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <fc2d03d1-ad76-21ae-2880-8a74644b8b80@gmail.com>
Date:   Fri, 15 Dec 2017 20:59:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <xmqqk1xpusyh.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday 14 December 2017 10:50 PM, Junio C Hamano wrote:
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
> 
>> It seems my series that fixes an error message in 'git-rebase'[1]
>> (apart from a little cleanups) is missing. I guess I addressed the
>> issue that was raised in 3/3 as a v3 for that patch[2]. Are any more
>> changes needed?
>>
>> [1]: <20171127172104.5796-1-kaartic.sivaraam@gmail.com>
>> [2]: <20171201060935.19749-1-kaartic.sivaraam@gmail.com>
> 
> I think you only sent 3/3 in newer rounds, which made it not to
> apply to my tree.  

That's surprising, let me check.


> If you meant to drop changes in 1/3 and 2/3,
> perhaps because they were needless churn, then 3/3 needs to be
> updated not to depend on the changes these two made.
> 

2/3 is for sure not needless. But 1/3 might be. Though I think it 
improves the communicativity of the variable name. In case you think 
it's completely useless, then I can drop it as we won't lose much anyway ??


---
Kaartic
