Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 358541F461
	for <e@80x24.org>; Thu, 27 Jun 2019 10:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfF0KtS (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 06:49:18 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36953 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfF0KtR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 06:49:17 -0400
Received: by mail-wm1-f67.google.com with SMTP id f17so5177725wme.2
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 03:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jsPOH8SbJqKMHyr/TXvJVNjh3pQVzuobMgSAYCNC7Kw=;
        b=uYuZ31zcRcc8lv0tCUgP6ZaOUdfid4tgw0/W/BXQajFpy7nc46VVfevtlQMslk+m/q
         z6c1YSAzYweuhe3zHZIIO6Lyua51ofoqUJREnt6V0JdZ39H96I1XoBr1DlzK7GU1SIWY
         vHFBc3u3eT44NWs4azpY50d1RyG8bq2REh6RaDz1szfDtts2VLRAKt9v0vckdw5rHLde
         KTnnWOy4N4hzmHOD3lzThzv87VyUPUrQml7Bf/+IAdf+uXV9HmbYdxQNyX0IGTPRWbRj
         rrgUu4Lu4f1boNTJBKfHB9mL/GJPBwNjy96tjbMgi2LozOblDwIdHpnndUS0WUZ29qcI
         c+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jsPOH8SbJqKMHyr/TXvJVNjh3pQVzuobMgSAYCNC7Kw=;
        b=QObL+h+4v7eHjgg3lCPzqgajGfa+GQ8hrFcfsgvQZvbXmRWqX2FyTKUfePrvsa5fAz
         eLTBoK1JHWF596Gy1++K7tVTk5kdyBZKrWHOB4wE3SPLbh9JVs5o/8H5Dxo/G0PodOXS
         MIyuENwBzMz8yn5uZlzzZ1lRGKzNh/MYdDCywTm1X6h21EnVcqtzmPAesUJL+m4rQTvO
         rJLcGLO+NK1typukhl+LNkfNc9zjs2PvwRukt6/6VbXysUANaBgggLDSzWfwNM/J+biX
         JHzDrPqtur0yYssclS6UeVqz0CbnvkfTE8zwE7ODYk/KOyst9tUJz00GyLsK+xMJMk0n
         E7Ag==
X-Gm-Message-State: APjAAAV19ijx07pSoUWqbUqjTgs2dM52L815Hu0eozTiyp3EbM//+0/R
        PprJ6lvuBesWG5UGHFdxnAM=
X-Google-Smtp-Source: APXvYqxKa8Wv3Xr8BJ5RwGKkp9CYAdB+rqBk+FlympuqXJ+OsHcUOnc8wfXvhos52cwPZmT1IiNd1w==
X-Received: by 2002:a05:600c:2388:: with SMTP id m8mr2648882wma.23.1561632555129;
        Thu, 27 Jun 2019 03:49:15 -0700 (PDT)
Received: from szeder.dev (x4d0c4603.dyn.telefonica.de. [77.12.70.3])
        by smtp.gmail.com with ESMTPSA id h6sm2455155wre.82.2019.06.27.03.49.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 03:49:14 -0700 (PDT)
Date:   Thu, 27 Jun 2019 12:49:09 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        git@vger.kernel.org, jeffhost@microsoft.com
Subject: Re: [PATCH] trace2: correct typo in technical documentation
Message-ID: <20190627104909.GA21574@szeder.dev>
References: <20190626200303.9834-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190626200303.9834-1-carenas@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 26, 2019 at 01:03:03PM -0700, Carlo Marcelo Arenas Belón wrote:
> an apparent typo for the environment variable was included with 81567caf87
> ("trace2: update docs to describe system/global config settings",
> 2019-04-15), and was missed when renamed variables by e4b75d6a1d
> ("trace2: rename environment variables to GIT_TRACE2*", 2019-05-19)
> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  Documentation/technical/api-trace2.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
> index 23c3cc7a37..f7ffe7d599 100644
> --- a/Documentation/technical/api-trace2.txt
> +++ b/Documentation/technical/api-trace2.txt
> @@ -35,7 +35,7 @@ Format details are given in a later section.
>  === The Normal Format Target
>  
>  The normal format target is a tradition printf format and similar
> -to GIT_TRACE format.  This format is enabled with the `GIT_TR`
> +to GIT_TRACE format.  This format is enabled with the `GIT_TRACE2`

Carlo, thanks for catching this.

Junio, this patch should be applied on top of 'sg/trace2-rename' which
contains e4b75d6a1d.  In current 'pu' it's applied on top of
'jh/trace2-sid-fix', which doesn't contain that commit and therefore
the rest of the codebase doesn't know about GIT_TRACE2 yet. 

