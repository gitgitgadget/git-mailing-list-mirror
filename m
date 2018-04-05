Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C846D1F404
	for <e@80x24.org>; Thu,  5 Apr 2018 17:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751519AbeDERHZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 13:07:25 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44614 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750786AbeDERHV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 13:07:21 -0400
Received: by mail-pl0-f65.google.com with SMTP id b6-v6so18043098pla.11
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 10:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oFuSlc+flAjhasTzdd6C32L6pE5y4g8dE4hlrn2XF0Q=;
        b=XNrCxTAAJIvo3uLY3enmo0Pmj2wtlQ3yo1bf8YrMkKd+sHP6w+C8WeSDvlo8NAI/2I
         O6nq08q/10VvP1fVCePb0mBizxu6J6xQicI4p2x4HbUATDg9upCwuiu2Dix9SvefHC2a
         R26GL8Uwqi3Cq4+U8loPjdrDsG8iwiw/5gXdPcuXYHERpbBhsHIIylOYOqn5vegPCl4D
         6Ic5n7uIkfga6IteYwddZvYitHUYIrkowtFNxeWClxAsEIogxlrW8kqqYWf1HaawGPEL
         T5HKlmJDong5Nn1ThJc45L2/XSosN6dAkQLcDyEK4IV3rabj26erou9NGN2sT1HWRUNc
         PUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oFuSlc+flAjhasTzdd6C32L6pE5y4g8dE4hlrn2XF0Q=;
        b=chGBApqw/yiuFMgvVSse/9nCcOkP5iw321LCViEhQ58qHd+G/33arsan3FTi0x3Lvq
         ZTga0bP4c5VKIYdLEl5n+3cMEfqZp8XQ5BkthHuWtkrDQ5NYijOVnN/eBRcQCNglUBn3
         umEdmB/3J/WPhKdTUh40mtiLG3ff29Vyd6OjE88w7QLzEekvZ5ng3VYMqPbJTrmKHvzv
         wS/wwCdQIABkVfGS808ZZEqse1G+DyUweTn34DxSEmfugdaKvwuowUYcnQUAyox1PH95
         6XEwxMqV/FtiaOkO8pHtfkZmk/8AEkEyiFAKqF4EZSdXtkCUhM/OArupvlutENtfPNms
         qyyA==
X-Gm-Message-State: AElRT7Gx+lv00TZzlnhlRfiwgxadnLLUVihz4u+UNbDBnk1v1Yqg1abK
        oCf49i28+6orkrzYyTlV7wI=
X-Google-Smtp-Source: AIpwx48/Io18vvNpX9K3/JbK7gJ2z6THf8/5qHDiEYWyo4Ks7n1HS7hdOwjwNW8BtG/8mDLURhxtWA==
X-Received: by 2002:a17:902:8e86:: with SMTP id bg6-v6mr23405537plb.91.1522948040951;
        Thu, 05 Apr 2018 10:07:20 -0700 (PDT)
Received: from gmail.com (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id c66sm11330289pfc.56.2018.04.05.10.07.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Apr 2018 10:07:20 -0700 (PDT)
Date:   Thu, 5 Apr 2018 10:07:17 -0700
From:   David Aguilar <davvid@gmail.com>
To:     Bill Ritcher <Bill_Ritcher@guiffy.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetools: add support for guiffy
Message-ID: <20180405170717.GA32265@gmail.com>
References: <20180405135501.12836-1-Bill_Ritcher@guiffy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180405135501.12836-1-Bill_Ritcher@guiffy.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 05, 2018 at 08:55:01AM -0500, Bill Ritcher wrote:
> Add guiffy as difftool and mergetool
> 
> guiffy is available on Windows, Linux, and MacOS
> 
> Signed-off-by: Bill Ritcher <Bill_Ritcher@guiffy.com>
> ---
>  mergetools/guiffy | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 mergetools/guiffy
> 
> diff --git a/mergetools/guiffy b/mergetools/guiffy
> new file mode 100644
> index 000000000..8b23a13c4
> --- /dev/null
> +++ b/mergetools/guiffy
> @@ -0,0 +1,18 @@
> +diff_cmd () {
> +	"$merge_tool_path" "$LOCAL" "$REMOTE"
> +}
> +
> +merge_cmd () {
> +	if $base_present
> +	then
> +		"$merge_tool_path" -s "$LOCAL" \
> +		"$REMOTE" "$BASE" "$MERGED"
> +	else
> +		"$merge_tool_path" -m "$LOCAL" \
> +		"$REMOTE" "$MERGED"
> +	fi
> +}
> +
> +exit_code_trustable () {
> +	true
> +}
> -- 
> 2.15.1.windows.2

I tested this on Linux and it works great.  Thanks Bill.

Acked-by: David Aguilar <davvid@gmail.com>

cheers,
-- 
David
