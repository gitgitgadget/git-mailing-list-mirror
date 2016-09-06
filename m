Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFCED1F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 14:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756357AbcIFOFx (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 10:05:53 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33362 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754815AbcIFOFw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 10:05:52 -0400
Received: by mail-wm0-f67.google.com with SMTP id w207so18700058wmw.0
        for <git@vger.kernel.org>; Tue, 06 Sep 2016 07:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=o9/Lpx5GWH7d8Tn/Xp0DegToFkIw3pZ6KWcc6oRk/GQ=;
        b=VLzhzSMh/4Bo7cT2yYTIHtD3jm8ZbqrggEkMVP/TgUC3x/w5F4j9DV/aOJJoNI6nhL
         v2zKc8mu22Umq1kBqoj4Vg1541xaTsgbFxKzcNTa7nt13AoNBBcJzWKY/Y51XK2/RceZ
         Wb7JuzLVvRiGh0qplGTmI6PBq82Qsf96hiStHG94PUYE0KF1bZ1i8KN4NQxKpM6FX1mj
         lvFf8R97sY+OoAWi5GZw+CgZkvmkzX5z7hXgq9bDJUgWn8iriUI/Ucuk99u7ZE53civp
         fTPe+5JmVOYNrncevnFEKvK5oGADnA2WkxacVl6F7Qb5Y2ar0epvSJQaFQvts8R5TCHG
         yECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=o9/Lpx5GWH7d8Tn/Xp0DegToFkIw3pZ6KWcc6oRk/GQ=;
        b=IHODhsoZy3hvbCFIoGcVeVR26XLYb454So4y8jYe5ejj76RKIF6dn3Hy/PBNAE6kj1
         VT+XYQIedz07dUk7opdnIwKctYQGlIAb040GAHYjvIpacnOY6/4SeOuPmLrHiAU9r73k
         CE9hO5ew3GRzfuUFvyJVlEVNIYwfsYGYvqjN2tq3W1Rqv4iytGVzPi3h7B2UAPGSsW97
         XPvFoWtgBywRvdohgvlS2iOLCZjOGSN2CfkLUPzGdfcaFKnuc0b4OYBvz8aHpTtVtlsv
         ySjWGcL8vETST3/M/EI7e3/NGFDqO4w/dSQRRtmziAYH3uHCBiQnXVyvOKvHBUGQRDbz
         sb6Q==
X-Gm-Message-State: AE9vXwOPbyK2ytAMVLQ50TEH/fCGREtcdXj1TAlPCDkGJIbzd8lUJzTS+/SAGol6t/SE2g==
X-Received: by 10.194.150.40 with SMTP id uf8mr3868877wjb.119.1473170751044;
        Tue, 06 Sep 2016 07:05:51 -0700 (PDT)
Received: from [192.168.1.26] (epw136.neoplus.adsl.tpnet.pl. [83.20.64.136])
        by smtp.googlemail.com with ESMTPSA id g141sm5167516wmd.1.2016.09.06.07.05.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Sep 2016 07:05:50 -0700 (PDT)
Subject: Re: [PATCHv4] diff.c: emit moved lines with a different color
To:     Stefan Beller <stefanbeller@gmail.com>, git@vger.kernel.org
References: <20160906070151.15163-1-stefanbeller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <15618224-a9f3-bbe7-3556-8fd8aab2a2a4@gmail.com>
Date:   Tue, 6 Sep 2016 16:05:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160906070151.15163-1-stefanbeller@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 06.09.2016 o 09:01, Stefan Beller pisze:

> ---
> 
>  * moved new data structures into struct diff_options
>  * color.moved=bool as well as --[no-]color-moved to {dis,en}able the new feature
>  * color.diff.movedfrom and color.diff.movedto to control the colors
>  * added a test
[...]

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 0bcb679..5daf77a 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -974,14 +974,22 @@ This does not affect linkgit:git-format-patch[1] or the
>  'git-diff-{asterisk}' plumbing commands.  Can be overridden on the
>  command line with the `--color[=<when>]` option.
>  
> +color.moved::
> +	A boolean value, whether a diff should color moved lines
> +	differently. The moved lines are searched for in the diff only.
> +	Duplicated lines from somewhere in the project that are not
> +	part of the diff are not colored as moved.
> +	Defaults to true.

[...]
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 705a873..13b6a2a 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -234,6 +234,13 @@ ifdef::git-diff[]
>  endif::git-diff[]
>  	It is the same as `--color=never`.
>  
> +--[no-]color-moved::
> +	Show moved blocks in a different color.
> +ifdef::git-diff[]
> +	It can be changed by the `diff.ui` and `color.diff`
> +	configuration settings.
> +endif::git-diff[]

If not for `color.moved`, I would have thought that instead of adding
new command line option `--color-moved` (and the fact that it is on
by default), we could simply reuse duplication of code movement
detection as a signal of stronger detection, namely "-M -M" (and also
"-C -C" to handle copy detection) that git-blame uses...

-- 
Jakub Narębski

