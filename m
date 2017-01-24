Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3040B1F437
	for <e@80x24.org>; Tue, 24 Jan 2017 19:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750756AbdAXTvY (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 14:51:24 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35294 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750708AbdAXTvX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 14:51:23 -0500
Received: by mail-lf0-f66.google.com with SMTP id v186so18579414lfa.2
        for <git@vger.kernel.org>; Tue, 24 Jan 2017 11:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=CdatJYaoS9VJaLy2g5dO1MzWC8VBFgHnkGia45VnhyU=;
        b=Ak13vPeEXN8KeeBa1qseXxzbfpiq7VGk2VNmj1apohFFizb5U69Ap8UAL5w5AQbjdS
         lYQKctJdRpFbU5b1E0gfbw1V72yj3Pa3OVSpuXRPGJN0SxYF6XsW5jizDnPJPjWZpI0n
         FI3x23ZPTtvtoLfJVkw8bgogIcsTAQH+cuDEttbSbcs3JBnHcrnkhBYOwqDEffHQS7I/
         Uz8b4OTwtNJcdQnBHIc+2PmcTAnUBkeIa2n5J2NY30vBFQTBwY+4HCrxdl8/FwSK/DYU
         iogyHWv9T6iU35kzf8Kl8pgXBE0Wa9L9nmCVNlmxgePBGWJS6Bl7qQ6NGfzrCd+n/Ela
         eyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=CdatJYaoS9VJaLy2g5dO1MzWC8VBFgHnkGia45VnhyU=;
        b=taF+tU0torOTuAw+sig3ZbUb3ab5n+SK39bBLTH2pvaYzNayxVo1gcIXMqd/Bxy1xy
         0UT6M1abKYhZ8sBrgi33MzQOk6kJ+l8OB4WRGnOCi0UpnKi+W6NlRg7Bq8jB5oJOm9Sd
         blPQaHlp5v+cY746BNiDyKhKwsxMwWnF5UzcmwszYyRXnCb1CAQ1KIjppbNgVZyysGdQ
         8tnG7cmj34OwZ0ZmVcmQYcWQm6iVobjXVWTiX0Ho/SKGOAreaiDqPrkuIpTSu5sAnyxf
         2fCK6nisEiIj3OwignXf4TLtkT2uQ/TL3Zt/hVRsYq2Bdbmoo2AvHoHb/NbG3Vvf+RYv
         pE0A==
X-Gm-Message-State: AIkVDXIgZ0lWUHmIgN8JPSX4qpbi66ehnx/PzH+cS2oKXZuQg0aLiypVNAkKeIf2VQUHBA==
X-Received: by 10.25.32.149 with SMTP id g143mr11696065lfg.7.1485287482165;
        Tue, 24 Jan 2017 11:51:22 -0800 (PST)
Received: from [192.168.1.26] (acuz88.neoplus.adsl.tpnet.pl. [83.11.105.88])
        by smtp.googlemail.com with ESMTPSA id 18sm7694593ljh.39.2017.01.24.11.51.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jan 2017 11:51:21 -0800 (PST)
Subject: Re: [PATCH 1/3] Documentation/stash: remove mention of git reset
 --hard
To:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org
References: <20170121200804.19009-1-t.gummerer@gmail.com>
 <20170121200804.19009-2-t.gummerer@gmail.com>
Cc:     Stephan Beyer <s-beyer@gmx.net>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <c5732a5b-b6a9-2980-3d99-179a93fe6418@gmail.com>
Date:   Tue, 24 Jan 2017 20:51:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170121200804.19009-2-t.gummerer@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 21.01.2017 o 21:08, Thomas Gummerer pisze:
> Don't mention git reset --hard in the documentation for git stash save.
> It's an implementation detail that doesn't matter to the end user and
> thus shouldn't be exposed to them.
> 
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  Documentation/git-stash.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> index 2e9cef06e6..0ad5335a3e 100644
> --- a/Documentation/git-stash.txt
> +++ b/Documentation/git-stash.txt
> @@ -47,8 +47,9 @@ OPTIONS
>  
>  save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
>  
> -	Save your local modifications to a new 'stash', and run `git reset
> -	--hard` to revert them.  The <message> part is optional and gives
> +	Save your local modifications to a new 'stash', and revert the
> +	the changes in the working tree to match the index.

I think the following might be better:

        ..., and set the working tree to match the index.

Or not, as it ignores problem of untracked files.

Anyway, removing internal implementation detail looks like a good idea.
OTOH the reader should be familiar with what `git reset --hard` does,
and if not, he knows where to find the information.

> +	The <message> part is optional and gives
>  	the description along with the stashed state.  For quickly making
>  	a snapshot, you can omit _both_ "save" and <message>, but giving
>  	only <message> does not trigger this action to prevent a misspelled
> 

-- 
Jakub Narębski
