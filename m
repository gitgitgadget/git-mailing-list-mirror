Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C729320209
	for <e@80x24.org>; Wed, 28 Jun 2017 03:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753437AbdF1DZ3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 23:25:29 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35235 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752905AbdF1DZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 23:25:27 -0400
Received: by mail-pg0-f66.google.com with SMTP id f127so6518203pgc.2
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 20:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=seg+VkpR7o17Y9F2wQzK08M8/d+7mlIj8++lTMtHSCo=;
        b=Nbet8VtxsPHmDRuyQZ+UDGYVvia/m0cb1TEkCu6eInOy+vURYw0L+/xJQ8idk4BS+l
         2SmYZS2K+o96vvZtgZ8Fqh6XhLpMPLeR2tMusMZDjcV4y/r7wd7ly8/tijKIZaEs/gl4
         hGp4XtQ1SpwEuj2FarYzTkknfvNHrNX35P53p4Eyb5xtBI37qA6SHbqxSb6X4t+dD0xE
         iqFzjjPvdkpxB/hdDT7FotyWfwfSJJosb2wwf7zhv2pvG65ZbksyP48CbOyxnxqeK4H4
         8BAIgIdFPLlQcqCbV/t6pInnl5CcDk8Rpsg1lBczD+pegKpH1jfVd6wgK7cLX0sLMNSr
         qBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=seg+VkpR7o17Y9F2wQzK08M8/d+7mlIj8++lTMtHSCo=;
        b=gBOroO6XIVhxf+KjPiu2q7fDLrqnXgbR3HPtWuK5Og+6yjaaavIU0w1DQGfE90GASt
         IrUAllGfCAF01WURfh1UTaP8yJu6Ad6nSxYd4esDvDspYb2pNndQIbC+AOwjk2BXShT2
         ytA8MIhEezNbI6rigaaFbdg/CV4Wn4S5gXgW9qBWqawHipVqQFgUgsGWrHJslpy0ONX5
         jq7lSkpokfgPhEsgO07tEBosPnnso4o/UsAYneIh6kfmehqj5UJ8zAM5FmV5JwsIwwCm
         PQCh6cMsPYKvLPp6OTYlF9B/YNCNu4Jxhmq+pX/BF360OZSF5DcStdezqHmBquxG9ysI
         W1eg==
X-Gm-Message-State: AKS2vOw9HuylmFkcuOu94W80j1V3q8YeF6gMfe004WSNos9H6io8l7b1
        dZKGCbAxqHCVO66BC2k=
X-Received: by 10.84.194.165 with SMTP id h34mr9104074pld.65.1498620326932;
        Tue, 27 Jun 2017 20:25:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3095:bb54:d256:9ca9])
        by smtp.gmail.com with ESMTPSA id 85sm1223116pfr.90.2017.06.27.20.25.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 20:25:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net
Subject: Re: [PATCH 4/6] Documentation/diff: reword color moved
References: <20170628005651.8110-1-sbeller@google.com>
        <20170628005651.8110-5-sbeller@google.com>
Date:   Tue, 27 Jun 2017 20:25:25 -0700
In-Reply-To: <20170628005651.8110-5-sbeller@google.com> (Stefan Beller's
        message of "Tue, 27 Jun 2017 17:56:49 -0700")
Message-ID: <xmqq1sq4ztcq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This is easier for the casual reader.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  Documentation/config.txt       | 6 ++++--
>  Documentation/diff-options.txt | 7 ++++---
>  2 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 29e0b9fa69..3d89be2d84 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1052,8 +1052,10 @@ This does not affect linkgit:git-format-patch[1] or the
>  command line with the `--color[=<when>]` option.
>  
>  diff.colorMoved::
> -	If set moved lines in a diff are colored differently,
> -	for details see '--color-moved' in linkgit:git-diff[1].
> +	If set to either a valid `<mode>` or a true value, moved lines
> +	in a diff are colored differently, for details of valid modes
> +	see '--color-moved' in linkgit:git-diff[1]. If simply set to
> +	true the default color mode will be used.

Ah, I was ahead of myself on a review on an earlier patch.  The
above is OK but it may want to say what happens when set to false.

>  
>  color.diff.<slot>::
>  	Use customized color for diff colorization.  `<slot>` specifies
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index d2c6a60af2..d4dc46ee2f 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -252,9 +252,10 @@ plain::
>  	Similarly 'color.diff.oldMoved' will be used for removed lines
>  	that are added somewhere else in the diff.
>  zebra::
> -	Blocks of moved code are detected. The detected blocks are
> -	painted using the 'color.diff.{old,new}Moved' alternating with
> -	'color.diff.{old,new}MovedAlternative'.
> +	Blocks of moved code are detected greedily. The detected blocks are
> +	painted using either the 'color.diff.{old,new}Moved' color or
> +	'color.diff.{old,new}MovedAlternative'. The change between
> +	the two colors indicates that a new block was detected.
>  dimmed_zebra::
>  	Similar to 'zebra', but additional dimming of uninteresting parts
>  	of moved code is performed. The bordering lines of two adjacent
