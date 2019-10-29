Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DAF71F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 20:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfJ2UoD (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 16:44:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45217 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbfJ2UoB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 16:44:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1so10426117pgj.12
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 13:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c2i11t+nqEBZ6jT6ZcFBtCGb7F9GH/Peu+WJKPdAWo4=;
        b=WZ1sBrhICSqST6bDaPCc8taxndiJwP5zjl8PF5Br23zZG4o/ruRsCBvS9molPsLz0w
         Nh732SJ7az4v/b+5ENL5NziJw5b7QXxLYjZkD13NUHQVKiLS8zLLSB8yJp72YE+vOEx4
         Yjf6d/mcewtcJe6uiknKa3srvAOv7FNz4b3Mp1b8CRPCSFDvK3/Mwp0MMHS2vcXk5Mgm
         iLCHka5NvFqtBcmCoDcY4Wx0NVG+Hawp5Vi3a7QO34gFFMZXphTDtfEush2i8oUm/s5M
         1JfUIGpUrgvem63l8DDwSCtR7Ov7OtibJWbZ6Vybb3RX2EB/+k4y8swNAZZ08YXSZkCV
         v8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=c2i11t+nqEBZ6jT6ZcFBtCGb7F9GH/Peu+WJKPdAWo4=;
        b=k80tOT11wonZNDD8U99olHItmwqUVEkdNTb5bv0xR5Y+SzA4mPwZ6CY2jEjbi4SruP
         FQK4lbj4hHrlhzRX+60qt4nyBaQCZdwVtm8lIWkFU9cf5K3+ZuxvlDa/G2vHHdX1GJuJ
         rgvg3uHLbhy86Uq7wixaIlpJ1orX8nWq+DUL0b/HqQNZOGW10R02OlXqEc/q5PCyXxh1
         6fHP0vqKvyti/PzhxBpHwmhv2M8oEYIqNUVnb3HxJpRfyuzHd0txOvE5dRilBcX0ny/n
         yTbBxdxffmpHscf01FpBITuqgzilsRU9vi+a2KvpW6GYbCudmp7YqWFbEWkMmED7hJZ9
         OTlg==
X-Gm-Message-State: APjAAAUpYghvsSUSCOprC/xgqp1uAXhIvLhwbsgW9NVdg0DEIwxMJdby
        mxk3Un0sZqJ+SsLQ3qatL5S3lg==
X-Google-Smtp-Source: APXvYqwB+Y3BiwrHjqZ3wx31DtFFWCZ8i+Q7/iLgDyIBwUfAcZsFT4f4Ij4JCZvH/ZzyKT4uqzIFyg==
X-Received: by 2002:a63:cf0b:: with SMTP id j11mr29337816pgg.240.1572381840263;
        Tue, 29 Oct 2019 13:44:00 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:ece8:7fe:c1f1:a20f])
        by smtp.gmail.com with ESMTPSA id t27sm15475615pfq.169.2019.10.29.13.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 13:43:59 -0700 (PDT)
Date:   Tue, 29 Oct 2019 13:43:55 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 3/9] bugreport: add version and system information
Message-ID: <20191029204355.GB12243@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20191025025129.250049-1-emilyshaffer@google.com>
 <20191025025129.250049-4-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025025129.250049-4-emilyshaffer@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.10.24 19:51, Emily Shaffer wrote:
[snip]
> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> index 2ef16440a0..7232d31be7 100644
> --- a/builtin/bugreport.c
> +++ b/builtin/bugreport.c
> @@ -1,4 +1,5 @@
>  #include "builtin.h"
> +#include "bugreport.h"
>  #include "stdio.h"
>  #include "strbuf.h"
>  #include "time.h"
> @@ -27,6 +28,13 @@ int get_bug_template(struct strbuf *template)
>  	return 0;
>  }
>  
> +void add_header(FILE *report, const char *title)

I get the same compilation error here, can you make add_header() static
as well?
