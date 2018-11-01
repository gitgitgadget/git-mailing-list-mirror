Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA5411F453
	for <e@80x24.org>; Thu,  1 Nov 2018 16:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbeKBBKl (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 21:10:41 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:40723 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbeKBBKl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 21:10:41 -0400
Received: by mail-qt1-f180.google.com with SMTP id k12so15798618qtf.7
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 09:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=cuxPO81gV6yaWcCj/2z9XPSg3+QwqhM16O3qFsMdjOA=;
        b=TvwRs7h679CkbTTctK5CNJwe6Uq63L+1jvlAJ13rBOKxIF57N1H/hFyZg2RRRIFCZW
         bMkHTh6m2XWprpDwkhEm33iArf2Fz/XvA6+TZKibMhm7MO5rK9BlgedZ6g0C1IO9k9wC
         PJtNqteo3n77gnmvPLHcmTkHLdKxQvkg+1EZ5FYPUkj1zLbRd+ECHQEwEs+cfN+QvobV
         B2/vAcY4dE0grgn8exvfpd7y8oLUV/2MPVAxkZBXtjlV3LkJkN2B15MvHn95Gf6Z6iC3
         +ZxQj8jSk8nAw9OvP/UYyWncFqW7NXltGKOkUhUM02jwL/dRrSV4JMTooJSV/MD9I6Mf
         Y0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cuxPO81gV6yaWcCj/2z9XPSg3+QwqhM16O3qFsMdjOA=;
        b=djVW6hbZIsvO8hm+VQ/chUBjaVh3+0Ij/mvwM1yzIOLWmGrwXc0iG8jrPoBOMOHTew
         GIcHTfSIrL9QY8Z0DEzqraeBGMr6h7vymKlm95Asa4mdtINZHXl3MEQ3xuq9pFx2Eh8S
         uNYPx7R85csSrZ8coNPYzaa4VB90N1xj3ESqwecJ3q0lVvC8AYw281L5bQ9qDuIMEsYo
         dLr/qsLDZW1Wnw7neZOE9NLtEr1Sf9uP3WpwHz/CIv2Em1zKqJHhHMF7z5qdu37R3zdp
         UhuIUxNqc+WWL6H+1cSYoVKXwB4fITaksD2VH5C30QjI8DL+xBSjfcs2KYd22EfRFwZ3
         YzHQ==
X-Gm-Message-State: AGRZ1gJuV/CC+AO+1HJshdybKkZGUtCKv6EMaMc+2GOC/5quhC4hdE//
        qGJhHvSW7L44TF0ho9ZD8hZPJbwZ
X-Google-Smtp-Source: AJdET5c+53yZtfohPpEgRK1PXKCIDUslVcLpNboIIgaXvS3U3Z0Tm2WKpgdxhrpGdAJs5OaNVeIv/w==
X-Received: by 2002:aed:3823:: with SMTP id j32-v6mr7279968qte.248.1541088425144;
        Thu, 01 Nov 2018 09:07:05 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:eddc:3ff3:d342:de1b? ([2001:4898:8010:0:d712:3ff3:d342:de1b])
        by smtp.gmail.com with ESMTPSA id b5-v6sm18994463qkf.4.2018.11.01.09.07.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 09:07:04 -0700 (PDT)
Subject: master updated? (was Re: What's cooking in git.git (Nov 2018, #01;
 Thu, 1))
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqd0rpt8wy.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <00d01524-a37f-4958-cb3d-7facaec82906@gmail.com>
Date:   Thu, 1 Nov 2018 12:07:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <xmqqd0rpt8wy.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/1/2018 5:59 AM, Junio C Hamano wrote:
> --------------------------------------------------
> [Graduated to "master"]

I see that several topics graduated, but it appears the master branch 
was not updated at https://github.com/gister/git. Was this intentional?

I noticed because the test-coverage build [1] using the previous master 
as master@{1} reported no uncovered code into master (because no new 
commits exist on master).

Thanks,
-Stolee

[1] https://git.visualstudio.com/git/_build/results?buildId=237&view=log
