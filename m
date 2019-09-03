Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 175741F461
	for <e@80x24.org>; Tue,  3 Sep 2019 16:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbfICQp3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 12:45:29 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:14023 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730183AbfICQp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 12:45:29 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1i5Bvq-00017p-CJ; Tue, 03 Sep 2019 17:45:27 +0100
Subject: Re: Git does not recognise directory named '${sys:DATA_ROOT_DIR}'
To:     =?UTF-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>, Taylor Blau <me@ttaylorr.com>
Cc:     git <git@vger.kernel.org>
References: <CAHMHMxW4-6AZEDaJU8KOy2kRSLXjdC_RTH528=nnhVLXh=ADUA@mail.gmail.com>
 <20190903133422.GA51158@syl.lan>
 <CAHMHMxVy7Ud+pOHbfWXX4jzPoPng8TvR2zNgm_B56Srt64BrWw@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <13fcde6c-e373-718f-85ea-400824052494@iee.email>
Date:   Tue, 3 Sep 2019 17:45:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHMHMxVy7Ud+pOHbfWXX4jzPoPng8TvR2zNgm_B56Srt64BrWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/09/2019 15:11, Σταύρος Ντέντος wrote:
> The original folder did had a folder structure 3 levels deep.
> Unfortunately, I don't remember if the leaves were files (or
> directories themselves). However, since I "replicated" it, I went
> ahead and cleaned up my main repo (sigh).
>
> Thank you for reminding me of the empty-tree case :-)
Makes me wonder if git status could maybe warn about empty trees as 
'untracked'?

Philip
