Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 177701F424
	for <e@80x24.org>; Thu, 21 Dec 2017 20:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752944AbdLUUVT (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 15:21:19 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37628 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbdLUUVS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Dec 2017 15:21:18 -0500
Received: by mail-wm0-f46.google.com with SMTP id f140so18044794wmd.2
        for <git@vger.kernel.org>; Thu, 21 Dec 2017 12:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PherT8urW7GzysZxT7cbqsLiglmVgvQdCFKRZeqegSM=;
        b=dqMQUIvi5eHGc4+N6NcpRX0S4zbUlKg25NtXLklwGe2lvQC8T1zYvatrF2Fi4PcMUH
         lW7mnpbl7snvqiMPUC43AYYiBKAIGv14KguACgk9rlgMjQpwfFedXeajpuMps/ko2ze0
         rsMUkXBuOXyJybjSPuL0Vk/0iLYbSNfiRXrzc6ps5cjKwgNMc/wSjx0dO6eiq06+lqiF
         235t/QrKEZ4kaBSeq68Rr43Yr5hZLcO2MIUOJ27OQ8FnukCTBaVdfoU4+5k6Z4kvylXz
         WLIvtEqeIHBqWMmbu+JqMnhAd28dkDKEaG1nJcON7zm8+tH3HDIuBmCm/rJn467+H1zo
         5VPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PherT8urW7GzysZxT7cbqsLiglmVgvQdCFKRZeqegSM=;
        b=VkTxryFjiO4x2/Ccuvpkvr8IlohRIADd1v/BjZZU3TF8oPIkt3cgFb7Ke6p69fEzn2
         /9PfeVK4JLEC/5ag/7lykFQRzz0XaRbMT4DOyqf+xwhjmX7k6tCJvmJjJJdQSKqxJPxp
         ck8deMzpVdr/a3bcR7sAurGwHpvESuzMv8TUsuBUyRiIag0HunI8ThAkZU0j8A2eulgu
         VP200sBwRKGiM4a0LoMbK0+YBJpVaIuUG5Bp3kftgBKFKSPQre/GX/t1u5LiQMaeOaOr
         QM/B1mMcAtu18gpXThe+prxW3ikxJqLdtYVMPBz5x7nG03f58193ky6kZTWioa4SN+JX
         +lKw==
X-Gm-Message-State: AKGB3mKr/FA5C1Z1g/Hh5kstY4iA/4QWoq4vh7B+9MhDSuTQyVugOuFS
        tFOjpUgKBODyYPUsAnC0SLiJPRCT
X-Google-Smtp-Source: ACJfBotdu8eyockfc93Zl6hrJFTt2w+5891Bsn6g/dSWpQZ1DeFG4dmYxJV00qb5I3LjFSlIoJdBfA==
X-Received: by 10.80.153.142 with SMTP id m14mr11825569edb.265.1513887677839;
        Thu, 21 Dec 2017 12:21:17 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id h56sm17223584ede.45.2017.12.21.12.21.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Dec 2017 12:21:16 -0800 (PST)
Subject: Re: [PATCH v2 1/5] core.aheadbehind: add new config setting
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171221190909.62995-1-git@jeffhostetler.com>
 <20171221190909.62995-2-git@jeffhostetler.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <01040d48-a24e-1146-dcea-29137b1104c9@gmail.com>
Date:   Thu, 21 Dec 2017 21:21:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171221190909.62995-2-git@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On 21/12/2017 20:09, Jeff Hostetler wrote:
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 9593bfa..c78d6be 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -895,6 +895,14 @@ core.abbrev::
>  	abbreviated object names to stay unique for some time.
>  	The minimum length is 4.
>  
> +core.aheadbehind::
            ^^^
A small nitpick - you may want to use "core.aheadBehind" throughout 
the series (note capital "B"), making it more readable and aligning 
with the rest of `git config` variable names (using "bumpyCaps" as 
per coding guidelines[1], and as seen at the end of this very patch, 
too, "add.ignoreErrors").

> +	If true, tells commands like status and branch to print ahead and
> +	behind counts for the branch relative to its upstream branch.
> +	This computation may be very expensive when there is a great
> +	distance between the two branches.  If false, these commands
> +	only print that the two branches refer to different commits.
> +	Defaults to true.
> +
>  add.ignoreErrors::
>  add.ignore-errors (deprecated)::
>  	Tells 'git add' to continue adding files when some files cannot be

Regards, Buga

[1] https://github.com/git/git/blob/master/Documentation/CodingGuidelines

  Externally Visible Names
  
  ...
  
  The section and variable names that consist of multiple words are
  formed by concatenating the words without punctuations (e.g. `-`),
  and are broken using bumpyCaps in documentation as a hint to the
  reader.
