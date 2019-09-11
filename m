Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AF5E1F463
	for <e@80x24.org>; Wed, 11 Sep 2019 11:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfIKLtJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 07:49:09 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39787 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfIKLtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 07:49:09 -0400
Received: by mail-yw1-f65.google.com with SMTP id n11so7697169ywn.6
        for <git@vger.kernel.org>; Wed, 11 Sep 2019 04:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o2I+kDQZGZy6Jip8bD7jTh6mhXA7AFOUry34auYll3A=;
        b=AmlpuNDXe6z6ePr3BbbUYxWIAl73c8j79Fs664Xw9axTwKDPiG4ovHxR2Lu2n03XXH
         RKWUbdzsNI4pQgezqpGkMqLOX3mQaizCrUaYDAMH391Pgc43IYqnWPwyT3AS0iX/T0yU
         drd0BriPJGcQcj2oYw97rtlvckUb1jl3akHCJPqM3rdDJjdls/qqg/g8DHHhyfzaUA4x
         XAXvJihk0HsSYnBQzyCZzVD5Oqc2O6JYPVt6QYX1Sk6ckjNd6PBMH5tZqEfSb/IZA9Fw
         rJKcD7ZUClH/QQDJcyvRUteC4ueQ5EQ+Gc8D+YpwHhNT54J2bPFwiKdga4xDksqA4veI
         vLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o2I+kDQZGZy6Jip8bD7jTh6mhXA7AFOUry34auYll3A=;
        b=VU3WG1C8ndja90qTuZdU0gyaDScnc+nc9igKmH+cyLYJIT+Y0WbHAI8vOJ10JemfPb
         1fWJyELQfk41mHzDDj4AshwP5OTHeL/PTN++N+rueBO23KqbkWcJMI+5BvPsfj72GUwi
         yyV1apMOzP+K1rhuwakud6Y3fZiyPHwL5g1xVoUZcXzF45ZbOa4l54ziRPneWz85CNH6
         Lu/uJE9RLRESBBNURdBbO5QbAPw3cSjOs0F3KbaHesnA/X4Goto60C+fI+69K8+Qyn/3
         u6i12W+OMyLb4jRxU12AbbijiKnIDL8LUcV03CgUTcjfQD66e3WsTP+KhjDmFJPXWj8E
         1dig==
X-Gm-Message-State: APjAAAWcqQbEH6tQfXMc2AzfItntrcYuNiP6Inc/gmj6xOWIG/mxuBrj
        oqTLC/hYkPDZmAyHMy0Pwxw=
X-Google-Smtp-Source: APXvYqx+YACBxzuURVwNB5XiRc1TZiC7r4LsiM+xIXF3pH1ffze7Eo4FRIzPCAhZhb90zVv9D5xjRA==
X-Received: by 2002:a81:7811:: with SMTP id t17mr24519452ywc.273.1568202548382;
        Wed, 11 Sep 2019 04:49:08 -0700 (PDT)
Received: from [192.168.1.9] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id a69sm1043575ywe.21.2019.09.11.04.49.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2019 04:49:07 -0700 (PDT)
Subject: Re: [PATCH 0/1] doc: small formatting fix
To:     Cameron Steffen via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <pull.330.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2f301b94-f8da-3a36-8d3b-08593ceb1a5a@gmail.com>
Date:   Wed, 11 Sep 2019 07:49:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <pull.330.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/9/2019 7:21 PM, Cameron Steffen via GitGitGadget wrote:
> Edit: I need permission to submit please

Hi Cameron.

When using GitGitGadget, your PR description becomes your cover letter on the mailing list. This is a great place for you to describe how you discovered this problem and if you have looked elsewhere for similar issues to fix up.

Thanks,
-Stolee
> 
> Cameron Steffen (1):
>   doc: small formatting fix
> 
>  Documentation/pretty-formats.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> base-commit: 75b2f01a0f642b39b0f29b6218515df9b5eb798e
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-330%2Fcamsteffen%2Fpatch-1-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-330/camsteffen/patch-1-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/330
> 
