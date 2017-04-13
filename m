Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3D9120960
	for <e@80x24.org>; Thu, 13 Apr 2017 23:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752468AbdDMXKM (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 19:10:12 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34132 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751657AbdDMXKK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 19:10:10 -0400
Received: by mail-pf0-f176.google.com with SMTP id c198so34455358pfc.1
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 16:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NvrVSXJ3xR5w5vo+HdcC3G8Xg9iShsstiWwIrDuJ/zA=;
        b=BZaKjq2fPE2IL3YIf9ooZy6NpkD1nxpgVy/+EIoSkQdl93B2nO5uuGFuLk6jWBby4+
         cs5Lery7Qy9EZ2Pnr7ICcM74cagy+HUZmpiy0s4WMrNXm1zLCLK1QCtnTeeYohpq2Shp
         Hszmti25tkrXSCxlkcYMqOLxLUjLQnAQPZhcRVo4Ct1u994wXG4Ef2o4aPYwFQqIQW+o
         YrQI+pWHFRFfV5TneJvmJJJo0Gm2Gh0LufEbfylCbjzKkXVi7VTQLnrJ/hjcvigLLfsS
         I24WsFF5yUiSxy0vV/yqMHD0hFRjIL3d8OeJRRIQgPkO6wjU/RG2737/U0xiS6Jb04QM
         AsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NvrVSXJ3xR5w5vo+HdcC3G8Xg9iShsstiWwIrDuJ/zA=;
        b=MOrv7RwGTiCvbdoAeHnXqRo+nSk1PHSl0LWDNQWm6OFosZ06sPCWBGYFCm5OEMWFnH
         6jYkF7ka/qojEf8hZK11TSoPOI+QhGzvN1WpkyOz+MCZbUERnvznl15onz48i0ECklyq
         rS7fmF0QMwkAYHxWu8JNngxeHuMGSzA9W9Sy7rw33FHtOK+C2LUtJFQlrCEkh2Uxl5E9
         5g4qgsIGMl7puQHpFeiy+5h3creyugbjkZCr0/HTuCTKUo7RisQXfHZzbLNtABdzkEVK
         wo/WMUYkVeXGgw/S9ns9ShpH1Iu84frfMMnK16rlSWDFCTMHbM/ihtLHc8wQ1XIL+/b/
         KwRQ==
X-Gm-Message-State: AN3rC/4FIrMw8UIIWwpkw9qSn/NxIWFEE6ScJmFZU/shttXVg6zKVZNY
        FDWe4m2705/Lbip8
X-Received: by 10.98.41.199 with SMTP id p190mr4303325pfp.266.1492125009993;
        Thu, 13 Apr 2017 16:10:09 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:1426:66e2:260b:9db9])
        by smtp.gmail.com with ESMTPSA id p80sm133998pfk.50.2017.04.13.16.10.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Apr 2017 16:10:09 -0700 (PDT)
Date:   Thu, 13 Apr 2017 16:10:07 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH] submodule--helper: fix typo in is_active error message
Message-ID: <20170413231007.GC115420@google.com>
References: <20170413220854.14767-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170413220854.14767-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/13, Stefan Beller wrote:
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/submodule--helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index e42e671014..b1d4269e10 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1145,7 +1145,7 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
>  static int is_active(int argc, const char **argv, const char *prefix)
>  {
>  	if (argc != 2)
> -		die("submodule--helper is-active takes exactly 1 arguments");
> +		die("submodule--helper is-active takes exactly 1 argument");

Obvious fix.  Thanks!

>  
>  	gitmodules_config();
>  
> -- 
> 2.12.2.603.g7b28dc31ba
> 

-- 
Brandon Williams
