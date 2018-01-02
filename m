Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC3171F428
	for <e@80x24.org>; Tue,  2 Jan 2018 21:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750749AbeABVWe (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 16:22:34 -0500
Received: from siwi.pair.com ([209.68.5.199]:40344 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbeABVWe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 16:22:34 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id AF199844DF;
        Tue,  2 Jan 2018 16:22:33 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 724B4844DE;
        Tue,  2 Jan 2018 16:22:33 -0500 (EST)
Subject: Re: [PATCH v3 0/6] Renames in git-status "changed not staged" section
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Cc:     alexmv@dropbox.com, igor.d.djordjevic@gmail.com
References: <20171226091012.24315-1-pclouds@gmail.com>
 <20171227101839.26427-1-pclouds@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <ad27dd2c-a39b-03a0-a1ea-152d1205acef@jeffhostetler.com>
Date:   Tue, 2 Jan 2018 16:22:33 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20171227101839.26427-1-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/27/2017 5:18 AM, Nguyễn Thái Ngọc Duy wrote:
> v3 more or less goes back to v1 after my discussion with Igor about
> porcelain formats. So 7/7 is not needed anymore. 4/7 becomes 5/6. The
> meat is still in 6/6, now with some more updates in git-status.txt and
> to address the comment from Torsten.
> 
> Nguyễn Thái Ngọc Duy (6):
>    t2203: test status output with porcelain v2 format
>    Use DIFF_DETECT_RENAME for detect_rename assignments
>    wt-status.c: coding style fix
>    wt-status.c: catch unhandled diff status codes
>    wt-status.c: rename rename-related fields in wt_status_change_data
>    wt-status.c: handle worktree renames
> 
>   Documentation/git-status.txt | 23 ++++++------
>   builtin/commit.c             |  2 +-
>   diff.c                       |  2 +-
>   t/t2203-add-intent.sh        | 72 ++++++++++++++++++++++++++++++++++++++
>   wt-status.c                  | 83 ++++++++++++++++++++++++++++----------------
>   wt-status.h                  |  5 +--
>   6 files changed, 143 insertions(+), 44 deletions(-)
> 


Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>

