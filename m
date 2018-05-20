Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD8EE200B9
	for <e@80x24.org>; Sun, 20 May 2018 19:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751144AbeETTd0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 15:33:26 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42602 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751045AbeETTdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 15:33:25 -0400
Received: by mail-wr0-f193.google.com with SMTP id t16-v6so10764015wrm.9
        for <git@vger.kernel.org>; Sun, 20 May 2018 12:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pw4oF+qgt0QGj65z5IC2n9EbnFdTER57uMnDDHxLEHQ=;
        b=jt0/Q8jd6lfxlrQRcaHSePyiA4/KucITcdgRf3KTiZ4VanoTrK82JVP9Pqw9bUbJ3X
         RuZ1D3jzMTbbY8QeQQPl15qdMjbbhPt7o3YNJGE12I/UpElFqBwMZ5icQ9dJQzGT1S+K
         h+o/0JxX34eLWRS08AiuIEfe+6TtEEp7JH6eMe2ekRQkOLRaOowVNZlOyxRXdd/LQveJ
         fVuOuOU3oio6M4iZs0gO6ejB6T5/nj1eHnatD4eP2INcxdhjrtPo7Xo05X/KtCvyGvjc
         St3IXd3DBmuc1R8ZrS5wkEqNViN1pgQP8fflWtirEYKKJsuvmE4lcWuxV+0gElX9cho1
         8Y+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pw4oF+qgt0QGj65z5IC2n9EbnFdTER57uMnDDHxLEHQ=;
        b=rpvSwP/z4MmIWgrNhC6vvWdXd9S0CqJEVlBTKoTWESsLCpzb+L/jHAaSSdm9Z3qc7W
         sq/x3TM/yHnrwp4IiRGCxq4V1j9RfwtFxL2GFCDqUgoNcgjrTAp0yKuVekQpDsNy78Z6
         OY3+SaYzE5hMz0ZWnzzSiz0lIb0KP1W4byLkwfPxZAeKUsIzNIFsGbBP2gxddKhtxe4v
         YWhP2Y+ub24Ew8KSA1GtL5dl+8lF4MCfsGugU6l8kmJqMhz3olbu53hvWuG/NW5jOdTE
         PePTHT5Z2dzdFMMLCR/l6r9uAn/t9A4Uy7WlbxzV4qJuaLLVNkeiMNdKb08SDdkDHsh9
         e5tw==
X-Gm-Message-State: ALKqPwevYN+9zv3yN64M4RVZYqw2OWRrKB36IjuUCR/SvXp4IUkRoJ0M
        IsWnUUbTeLPRjqz594AQnXx2hioS
X-Google-Smtp-Source: AB8JxZrLL9zdiuiDThGdCjGJfgXCJRLHWSpfPJw+Ijc775LvGtRcI1bQBFjz+LGevUGKpBEJ0puWdw==
X-Received: by 2002:adf:85dd:: with SMTP id 29-v6mr13480834wru.120.1526844804499;
        Sun, 20 May 2018 12:33:24 -0700 (PDT)
Received: from [192.168.0.103] ([92.55.154.57])
        by smtp.gmail.com with ESMTPSA id d12-v6sm6184003wre.39.2018.05.20.12.33.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 May 2018 12:33:23 -0700 (PDT)
Subject: Re: [GSoC] A blog about 'git stash' project
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <67e6d306-0885-9340-13c8-3e3d4333dc20@gmail.com>
 <ef15b063-c0e3-a5e9-7418-35d2d6b954f3@gmail.com>
 <e8a81d38-57d7-2974-b5c7-3489e8ceb1fc@gmail.com>
 <68b913de-8f4a-9203-1d63-32104a35628b@gmail.com>
 <be353b0e-1cba-3765-b920-f7307f9b7d40@gmail.com>
 <nycvar.QRO.7.76.6.1805171106370.77@tvgsbejvaqbjf.bet>
 <1729567e-3b95-ab37-d845-1980795542b0@gmail.com>
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Message-ID: <e0029f5e-87eb-7531-c32d-9a58469faaa5@gmail.com>
Date:   Sun, 20 May 2018 22:33:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1729567e-3b95-ab37-d845-1980795542b0@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

On 17.05.2018 13:29, Kaartic Sivaraam wrote:
> On Thursday 17 May 2018 02:39 PM, Johannes Schindelin wrote:
>> I have great empathy for the desire to see these bugs fixed. The
>> conversion must come first, though, and in the interest of making it
>> easier on me and other reviewers, I must insist on keeping the conversion
>> free of any changes, much in the way as we try to avoid evil merges (i.e.
>> merge commits that introduce changes that were not present in any of their
>> parents).
>>
> 
> Of course, the conversion should be separate from the bug fixes :-)
> 
> When I mentioned "while porting it to C", I actually meant the "thought
> process of creating a foundation for `git-stash` in C". I thought
> hinting at some of the existing and unsolved `git-stash` bugs would
> allow the person who would be doing the port of `git-stash` to C to
> consider how to avoid this while implementing the basic foundation. I
> should have been more explicit about this in my previous mails.
> 

Thank you! I will keep in mind to fix those bugs. I actually wrote a 
short paragraph about one of them (the one regarding -p option) on the 
blog (the first post).

Best,
Paul
