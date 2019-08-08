Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D68591F731
	for <e@80x24.org>; Thu,  8 Aug 2019 11:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbfHHLmz (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 07:42:55 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:37234 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfHHLmz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 07:42:55 -0400
Received: by mail-wr1-f52.google.com with SMTP id b3so2208092wro.4
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 04:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sOE83RZjW5YWlsbYpT3bqdCPHf06jSstMx3DV24c9wE=;
        b=rS8lV5Nb+kwtNkAGCIPLEscdZm8oCRa8onDj1mSE43z1hRdbSg0WBadMayl4UTyx16
         6bJil6zmwnhrJniFJWkDqrrVLNpRym+ou3P7DHr8IBZgNz692FQkN4HXD3IGB07NOhVP
         K+4a3Dnme7JhVy6L2adV5Gi2XgzYYBbs111Re0R6KK1SWx7UsZCs6fBa/U534D37EPHY
         Xa2mcJ5Xi/MGLf94Z3MMfg30j1J5xZ/vVzTn4dZ5SjyEfVN62n4KOK59ln61YNTyBAa2
         u2hF3kajH8O2hiRhg6Z7xj7yTpELzc6cUcu7ckiLI0O+7aapihlTJ8TLfrd0x90x2KOe
         Q09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sOE83RZjW5YWlsbYpT3bqdCPHf06jSstMx3DV24c9wE=;
        b=WS+14OjHlNW7aGZHqY4DiJBLY8PiAcf8NTX3GCPL4up/EV+tXynAGs3i5BwARJTNWm
         tgF6ZH+b0QGpUBWLLFkIm3m3rgVIlVlliXmjPlAyMU1NDIISmqM08nzFfmG/UnKbb8dz
         1a62+Bar6J6/yA7io/Ei3pOeYMu46UQxmf5+LLzVzb8g608SFZQkr/3ggKMvdeGxlsQi
         +1JqpBBrh0HR1Fl0xFiXXc1AUw67ImqUzDKp8P9OWT8FwTB75kzet/splg6kS49N99HH
         7DP2m00eskuGWwvAMkc86AW35Ief6hjw0enH3oLE3BMx1FmhZiOwU+BaTvO2NwgNwSDM
         JAog==
X-Gm-Message-State: APjAAAVZ+VwjSDVpBeCHwRlagVGGaW3pPigsd9EieJArwTW4xWWU7+wZ
        6wbxc8HJVhTF8l0q6j5uvR4=
X-Google-Smtp-Source: APXvYqzTYJ13DYkDoP1OgNYSGCNPXiq8msm1bUdGNuhQISJEn9NmMHe8wQzSFX/28+NG6WMB/O4ioQ==
X-Received: by 2002:adf:b1d0:: with SMTP id r16mr16968877wra.332.1565264573591;
        Thu, 08 Aug 2019 04:42:53 -0700 (PDT)
Received: from [192.168.1.18] (host-78-148-43-8.as13285.net. [78.148.43.8])
        by smtp.gmail.com with ESMTPSA id u2sm5613663wmc.3.2019.08.08.04.42.52
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 04:42:53 -0700 (PDT)
Subject: Re: [GSoC][PATCHl 6/6] rebase: add --author-date-is-committer-date
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Junio <gitster@pobox.com>, GIT Mailing List <git@vger.kernel.org>
Cc:     Thomas <t.gummerer@gmail.com>, Elijah <newren@gmail.com>,
        Dscho <Johannes.Schindelin@gmx.de>,
        Martin <martin.agren@gmail.com>
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20190806173638.17510-7-rohit.ashiwal265@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <0631044f-48ad-ad55-b256-cf500fc144cb@gmail.com>
Date:   Thu, 8 Aug 2019 12:42:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806173638.17510-7-rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-HK
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit

On 06/08/2019 18:36, Rohit Ashiwal wrote:
> The previous commit introduced --ignore-date flag to interactive
> rebase, but the name is actually very vague in context of rebase -i
> since there are two dates we can work with. Add an alias to convey
> the precise purpose.

That's an excellent idea

Best Wishes

Phillip

> 
> Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> ---
>   Documentation/git-rebase.txt | 1 +
>   builtin/rebase.c             | 2 ++
>   2 files changed, 3 insertions(+)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index a5cdf8518b..bb60426911 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -388,6 +388,7 @@ See also INCOMPATIBLE OPTIONS below.
>   	as the committer date. This implies --force-rebase.
>   
>   --ignore-date::
> +--author-date-is-committer-date::
>   	Lie about the author date by re-setting it to the value
>   	same as committer (current) date. This implies --force-rebase.
>   +
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 7f464fc9ba..a9a42f9ee4 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1433,6 +1433,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   		OPT_BOOL(0, "committer-date-is-author-date",
>   			 &options.committer_date_is_author_date,
>   			 N_("make committer date match author date")),
> +		OPT_BOOL(0, "author-date-is-committer-date", &options.ignore_date,
> +			 "ignore author date and use current date"),
>   		OPT_BOOL(0, "ignore-date", &options.ignore_date,
>   			 "ignore author date and use current date"),
>   		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
> 
