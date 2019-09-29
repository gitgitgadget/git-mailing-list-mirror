Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFC1F1F463
	for <e@80x24.org>; Sun, 29 Sep 2019 18:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbfI2SEC (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Sep 2019 14:04:02 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:46810 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728994AbfI2SEB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Sep 2019 14:04:01 -0400
Received: by mail-wr1-f46.google.com with SMTP id o18so8449519wrv.13
        for <git@vger.kernel.org>; Sun, 29 Sep 2019 11:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=FutNBH2nXYFowIYY3QhW3HQNxc8dN4X0rU5BHwBcewE=;
        b=igj6bzQp5dT/fhtgARdRMG1FEWGoQRbr14IO6Kc10Sz5McokXZunOOS+ZquYh5Igfg
         C/e0bgUCz3wpjjl7QUeqOiw1/SNs5MHLgJKs9esF9/NaspF7cFoSQE9icyiQ351mOpHD
         PLklwh/Be+Kra7VjpyYM7j6DKbT989N6k9qmJrr2euhxrhSd44W2sUoR5N0kX8uowKME
         /qbfXdneVJs8DueF2FfqNw6sbDVSM9AlzXyTxRzQoXfdFL5uPcqrVyCVAPZfgdGcfdFm
         EoYKbQPcaR/yHsCaow9Mvq67NG2w0hlGpUVP+00+MhTBDrxe+hs5PVzzR9tIVL5y/AxU
         SEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FutNBH2nXYFowIYY3QhW3HQNxc8dN4X0rU5BHwBcewE=;
        b=ilJY/+JTeqWfE4OZjshG+NG309hAchL/iO3nG9yI6cfFM8uEGZUJgWbMkwr3LT9FZc
         QDOADhrMLW0ZRc/vsaXxZS3B7S4u2Gk0hE0rSKUAMf4H6kU5UJI4PSFk+ZT2iZfbO5sB
         2PdvuNUZOlj3gMNJTV5SMrPbIIrZofhyLWo1MVTALVstzoh0B0vSKSvcU/cRb+M+NXGR
         FRS+iHPv9h2stuyC5/ebHPNoiZpzE6RaSHiNdjoDHMRri1S56bn5tuX1v0HFHU0syL11
         QsJvh73xkjgISUzV/4kbeg8T6xgUxUszz2YaqbXLntQGrFmwItsYAOwaeY1MEM1eaGYR
         fyoQ==
X-Gm-Message-State: APjAAAUXo7WQWJeCzJvjSoCvxzMD8PNp6gfhKogIIePnkBYX7mdWnZxD
        eEyMNnJgojiyBicnaf9ILfE5EMnH8bs=
X-Google-Smtp-Source: APXvYqz9VwITL1xGmHDAP1c25zS8Wana+6pRrblExlgwhAYMgah+7f1SIXyJ/WMpW1quFj2BNcwUrw==
X-Received: by 2002:adf:cf0e:: with SMTP id o14mr10283845wrj.277.1569780239333;
        Sun, 29 Sep 2019 11:03:59 -0700 (PDT)
Received: from [192.168.1.66] ([188.253.226.51])
        by smtp.gmail.com with ESMTPSA id g13sm14794233wrm.42.2019.09.29.11.03.58
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Sep 2019 11:03:58 -0700 (PDT)
Subject: Re: ProGit2 translation in Azerbaijani
From:   Alicenab <alibutlow@gmail.com>
To:     git@vger.kernel.org
References: <a819214f-c7bc-bb99-cbf6-3f70b9f2e2e0@gmail.com>
Message-ID: <3d720871-f79d-f5d1-3aab-433104172bc5@gmail.com>
Date:   Sun, 29 Sep 2019 22:03:57 +0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a819214f-c7bc-bb99-cbf6-3f70b9f2e2e0@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi guys, any updates?

On 22.09.19 02:36, Alicenab wrote:
> Hi there!
> I have a translated ProGit2 book to Azerbaijan language.
> As code of country name name for our country(az) have already taken, I 
> have created "aze" version of it.
> I hope it will be no problem for you.
> Partial translations available in https://github.com/progit2-aze/
> I'll be waiting for your response.
> 
> Sincerely,
> Ali
