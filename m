Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18576208DB
	for <e@80x24.org>; Mon, 28 Aug 2017 21:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751240AbdH1VJm (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Aug 2017 17:09:42 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33258 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbdH1VJl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2017 17:09:41 -0400
Received: by mail-pg0-f53.google.com with SMTP id t3so4863236pgt.0
        for <git@vger.kernel.org>; Mon, 28 Aug 2017 14:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TEsV1bqfGGnzxsLgxizTQpgWxmt9rcGMn/djX/TMDkI=;
        b=da6sKinpGdQSGo1qHJDopaVpiLlvZy+NN7Lzc6pQJ/LJJG6Ccw1vprvJjqR1k79pv0
         JTQQXxvthtje44Ggwr7oKB6YNAPkaic4flI2BXqQuCFMnzX0rC2Lw+7sxn3nIGYVgYAu
         lSyt6fGtJagki1cRKkayi/1xkRt2hF2zwg4tUITKPJVb2hRgLq7p+bn0JvauYQO0cg/6
         I9nEHHud1UpfNI+8M+irp2VMnx07d9INNx10Lq9qtqU0bkxtU1aT/wfAXo4oeZCq9ryY
         oUYTI+4rAJz7piOB1O0S4+hIs1ETb0W7CFVmp37XEHOE2tT1NAR5LC6n6KaK6KFNjt5L
         10EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TEsV1bqfGGnzxsLgxizTQpgWxmt9rcGMn/djX/TMDkI=;
        b=tvpBG/QhYTjMoZHCSLH7ColZ5xtaw7Dw22e137rIbAXSdt7JuQW/USONptS+zBRfQd
         xyGrfslTnKSQ6kxmjyR6dyvHrcU73O0cKyuZQqJzLH5gNGX90ntL3us+hcEhY9VGQlH4
         3Oxcf6kW7K6YZPB2noKroj81iiQz41N1nN4rrQj/E8dzkzDIiqu4ELnao2LQ7XthpPeL
         rBFQjuTaejubUjn5i1gb0D5u8jsA1r7Ynj8s1yvig8/n/YhzmT7UNDloxDXTX0spysmq
         uaiJVruZ034WZYdAp8I1R2ulObUyMo6avfeo+XEmSkhHNKfBxJMCc/gQec1Bx0exm5Zp
         s3Cw==
X-Gm-Message-State: AHYfb5hbXCX+cNGGwGn5LafZOfFfpZTA3ulHZFEHPxtzA4WF/SOKX0lJ
        ye5En2XiK/tKGgYu
X-Google-Smtp-Source: ADKCNb5Ef9zDhtiNv9R3q1NXm4gSuda1m5Qqtx7ZF7jN8pt+xDVkan4kIAE8D3ZlO5TksAXc7l6u/Q==
X-Received: by 10.84.194.228 with SMTP id h91mr2249828pld.419.1503954581162;
        Mon, 28 Aug 2017 14:09:41 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:6c61:8bea:e4ba:8ecf])
        by smtp.gmail.com with ESMTPSA id 128sm1889965pff.62.2017.08.28.14.09.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 28 Aug 2017 14:09:40 -0700 (PDT)
Date:   Mon, 28 Aug 2017 14:09:39 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, kewillf@microsoft.com
Subject: Re: [PATCH] Add t/helper/test-write-cache to .gitignore
Message-ID: <20170828210939.GA71562@google.com>
References: <20170828200618.27569-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170828200618.27569-1-jonathantanmy@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/28, Jonathan Tan wrote:
> This new binary was introduced in commit 3921a0b ("perf: add test for
> writing the index", 2017-08-21), but a .gitignore entry was not added
> for it. Add that entry.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>

Looks good to me

> ---
>  t/helper/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/t/helper/.gitignore b/t/helper/.gitignore
> index 721650256..7c9d28a83 100644
> --- a/t/helper/.gitignore
> +++ b/t/helper/.gitignore
> @@ -35,3 +35,4 @@
>  /test-svn-fe
>  /test-urlmatch-normalization
>  /test-wildmatch
> +/test-write-cache
> -- 
> 2.14.1.581.gf28d330327-goog
> 

-- 
Brandon Williams
