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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B9D21F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 20:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfJ2UHV (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 16:07:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34173 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfJ2UHV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 16:07:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id e4so6083456pgs.1
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 13:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vMGhnPQnJD/T6xol+VZlnP+2NFXsHO4Z+ie2pBxuu84=;
        b=hgUx61K95meSE+hmX8FfKxitOlpoRTstV/Ii0Lmb42nv2oXTaZXC5Aw63zqml5Ge8+
         SAQAzokY9tzs5rUCKmsWE7sV0H3paoz3sUNyQFd71CaC4UV9ZzCydITuIQ6CN3MJ2AfN
         lVhEIBkl57jcfcSM3v/D2DYe6GFZifHJw6ETJdsEmDxXVaq14mUvR9V2mX9zKPyqOeId
         uYC5Zt2HIHa/XC7HHY9uzBOpaGIQjBybtrQNu4RDyrDLqA73iY4QeCsW1b3sazwIPGxW
         01l3ZRHj2H49Zif2Gep4CKEz0INUrN2cM7g1pxsD6suhbyW/43oORFOqk7jXzZO93Kr1
         M4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vMGhnPQnJD/T6xol+VZlnP+2NFXsHO4Z+ie2pBxuu84=;
        b=OsVQF7TxT5rGih6gDGpJLnFX5xjPbnn/+eXpXcL5ajQOj6+nJnoHRnaxW3J/RaBwrx
         T/CrCtshtwA4ib2HO2TGpsYyhT+mmejzLSreAPAxTWziPj/WDQW3f2/ANXTdkeeiBtr6
         hNAV26RqdHUNBDSnuj7TPcOd/cNPvmqDzu1f4/yWvJKqPePXgT8XLB53mrdLGDnLGu+e
         SknGdYDdXChMSucsQps+Aj96ufTLAgDiRXzBxiL6yy0Y/a2ma5npJ5hf7G6mK+rG24lP
         FoCdfqVHD8BX8xll6HcsrCbD3IXGzDMH9BwtLRbt73sWz4XbijIC9uhWelu3saTYeRx5
         tCPQ==
X-Gm-Message-State: APjAAAXKEZMsb8fBOY+ZGoziS+KepIDaX+5naip8HDAZcLwLjrlu2HFw
        /Bs13/F5PcilsjCumU54/FQ=
X-Google-Smtp-Source: APXvYqyxrktsLbWDqy+pBWQMYRsah3i/j3liLUhbopAWEdwXyrgYn8Y8sukTr7GlJql194oWr6TXwA==
X-Received: by 2002:aa7:8e57:: with SMTP id d23mr29958621pfr.207.1572379639371;
        Tue, 29 Oct 2019 13:07:19 -0700 (PDT)
Received: from GVFSs-MBP.guest.corp.microsoft.com ([2001:4898:80e8:9:1f4:d899:effd:9f5d])
        by smtp.gmail.com with ESMTPSA id x139sm33337pgx.92.2019.10.29.13.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2019 13:07:18 -0700 (PDT)
Subject: Re: [PATCH 1/1] t7519-status-fsmonitor: improve comments
To:     William Baker via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     williamtbakeremail@gmail.com, Junio C Hamano <gitster@pobox.com>,
        William Baker <William.Baker@microsoft.com>, stolee@gmail.com,
        Johannes.Schindelin@gmx.de, jeffhost@microsoft.com
References: <pull.404.git.1571254547.gitgitgadget@gmail.com>
 <85ca71fadaa7390a32218d3a5553c83d60c06a7f.1571254547.git.gitgitgadget@gmail.com>
From:   William Baker <williamtbakeremail@gmail.com>
Message-ID: <3e95662d-3c65-8511-a01b-226b0e572b83@gmail.com>
Date:   Tue, 29 Oct 2019 13:07:17 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <85ca71fadaa7390a32218d3a5553c83d60c06a7f.1571254547.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/16/19 12:35 PM, William Baker via GitGitGadget wrote:
> From: William Baker <William.Baker@microsoft.com>
> 
> The comments for the staging/unstaging test did not accurately
> describe the scenario being tested.  It is not essential that
> the test files being staged/unstaged appear at the end of the
> index.  All that is required is that the test files are not
> flagged with CE_FSMONITOR_VALID and have a position in the
> index greater than the number of entries in the index after
> unstaging.
> 
> The comment for this test has been updated to be more
> accurate with respect to the scenario that's being tested.
> 
> Signed-off-by: William Baker <William.Baker@microsoft.com>
> ---
>  t/t7519-status-fsmonitor.sh | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
> index d8df990972..997d5fb349 100755
> --- a/t/t7519-status-fsmonitor.sh
> +++ b/t/t7519-status-fsmonitor.sh
> @@ -354,9 +354,11 @@ test_expect_success 'discard_index() also discards fsmonitor info' '
>  	test_cmp expect actual
>  '
>  
> -# Test staging/unstaging files that appear at the end of the index.  Test
> -# file names begin with 'z' so that they are sorted to the end of the index.
> -test_expect_success 'status succeeds after staging/unstaging ' '
> +# Test unstaging entries that:
> +#  - Are not flagged with CE_FSMONITOR_VALID
> +#  - Have a position in the index >= the number of entries present in the index
> +#    after unstaging.
> +test_expect_success 'status succeeds after staging/unstaging' '
>  	test_create_repo fsmonitor-stage-unstage &&
>  	(
>  		cd fsmonitor-stage-unstage &&
> 

Gentle ping on this patch.  It's just a small update to the comments
for an fsmonitor related test based on feedback I received in the
segfault fix patch series [1].

Thanks,
William

[1] https://public-inbox.org/git/3d3b290c-bc15-4bd5-e0c0-1377c9ec3ff9@gmail.com/
