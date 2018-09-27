Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C45A1F454
	for <e@80x24.org>; Thu, 27 Sep 2018 16:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbeI0WhJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 18:37:09 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:46637 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbeI0WhI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 18:37:08 -0400
Received: by mail-qt1-f175.google.com with SMTP id h22-v6so3314766qtr.13
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 09:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=m5gN91kqjuuwWFl0YYQDUpf5DimMjadsiXUl6VDkhMo=;
        b=YwhhY7gSlmJh8IoW6El2ekFUW3nORVzB0sIM5wAJsAie+zTVg1J9njIE/yufFESpry
         mRhJhJUcQdy1I5HCgDCdXs0FsCBKPDhxE9cefx4rZh0G3+CNT6rIitYtClkcznrOM3Qf
         EnHa+XD5Yw5zLLx1Mr7tJA/C8AHFND/IOUpwMzN3LyVfAQXngigMSILlYpQau/0Y0kx/
         BEfYjQRXx2Whg7dSFJbmJStpOaJxOwvbcbotTBwa73R33jdWy/0CdchONP63PyZvlih5
         STSeq0ckaW7fJJ0DBPyo96KTQwR5e12VVgShrCUeFBSGuG0aldMlc8ahkJpZerFkiqVW
         8i/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=m5gN91kqjuuwWFl0YYQDUpf5DimMjadsiXUl6VDkhMo=;
        b=WI8Ei+6ctZmalCvB6vakKLUHZa3bYv7nUbGoCGmMQGig2OGk/hNkvWC4L4NaKifxna
         nResWiJAagdMHW/tDPFANHx6rnI75+4ApBSWIbXb7Rec4hdUzzIXc6VngPMfX897doKB
         VY1SYEtm3WTfTFE0zyYYySOSuDQQV4yHRe6/hsNHoSVIEkDOdvv/Wxy6tlW/1R6DJQjL
         q6wIqyX0aELIwTcUIWAstS0C5Fuup32J/Cu05taorYEqWcLy2R77CIOPNNHW533KfqKq
         PRqXWrsWDDmTXfKTPwLL42AAY19D9QzGI6x23vzv+8bxsyNZzB41zqjHe1aUae7MOGt4
         oUlw==
X-Gm-Message-State: ABuFfoihiEOsSsZozX0kH77dAkpXfui/1elsydfn2CKuu8H/SXaZk9dh
        LHy17/O4w+3zyDoW9YiMGPqvq4G8
X-Google-Smtp-Source: ACcGV619dSPJVuwlqL04zNtxh5VQnIth3YNzwlmy6S0rb08Y7ig5U+RazQe6v7CWouT4ni2HyU/Q/Q==
X-Received: by 2002:a0c:869c:: with SMTP id 28-v6mr8705648qvf.92.1538065087836;
        Thu, 27 Sep 2018 09:18:07 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:1455:e436:6b50:1b07? ([2001:4898:8010:0:fd8a:e436:6b50:1b07])
        by smtp.gmail.com with ESMTPSA id c2-v6sm1674456qkj.79.2018.09.27.09.18.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 09:18:07 -0700 (PDT)
Subject: Re: Git for Windows for Unix?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git-packagers@googlegroups.com, Git List <git@vger.kernel.org>
References: <87va6rhqup.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d3d82080-f3e7-50cd-df81-1fed3198eb88@gmail.com>
Date:   Thu, 27 Sep 2018 12:18:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <87va6rhqup.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/27/2018 12:01 PM, Ævar Arnfjörð Bjarmason wrote:
> I had an IRC conversation with Johannes saying I didn't know Git For
> Windows builds perfectly well for Linux, this just isn't advertised in
> the ANNOUNCE E-Mails, so I hadn't tried.

We run CI to ensure it builds and tests on Mac OSX, too. This is 
important to the VFS for Git group, as we work on making that work for 
Mac clients. We have our fork of Git for Windows at 
https://github.com/microsoft/git.

> GFW is a "friendly fork", but a permanent one it seems. The diff between
> it and 2.19.0 proper is ~10k lines, and e.g. this last release had
> experimental stash/rebase in C that 2.19.0 didn't.

Hopefully we can learn from having this experimental feature in the wild 
and improve the patches on-list by fixing issues.

We do have a desire to move as much as possible upstream. It's difficult 
to find time to pay down that "fork debt".

Thanks,

-Stolee

