Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EDAC1F454
	for <e@80x24.org>; Sat,  2 Nov 2019 03:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfKBD3B (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Nov 2019 23:29:01 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37118 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfKBD3B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Nov 2019 23:29:01 -0400
Received: by mail-pg1-f195.google.com with SMTP id z24so3071904pgu.4
        for <git@vger.kernel.org>; Fri, 01 Nov 2019 20:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MYkD90rnhXuNgABNFmtkCFBSCVQnRg5RobyKCMGNu70=;
        b=WzDlzMLqQl7X6WK0A2ox1Qft+Ui/TEm6zgfNR0pLLkwNAjLlP7FZ+uJIB0eP+XmVPG
         xZQNO9sCrYkCYSpYbSviRF+EcgnT1Y2J3T4encUpdnxcaD/6b5A4AZ1O08tjgWg49evf
         ujFRgvpV8XrWDtMBEuNabJLEvhqzkZcnu9niPfoZ9+3pvjyjo3P25CEywXpHAsmTFk9a
         TE9AAldh06NG+/48iDbYssqgLW3ZvMVl/grrzw4/KjmgjPTWMCBbXQ5e0yxzPc79Jbt1
         qEx3FpH22XDuFeX2YxLKpAswKctjvoxcgLAt82J+Up/5wHuaWYi/rZrdfGzFduV8khRH
         3y7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MYkD90rnhXuNgABNFmtkCFBSCVQnRg5RobyKCMGNu70=;
        b=flr3CDKAdDQ0PLeeMcxyU5MawN0WZDIGJXbyFVuYcVGLY4nEqzg/S081ICa4s96iTD
         KRHeC114DCD7lMzTwYaDYVt9nTrNSe9pzvMYtiA4LtFIhEFrPZlgKLHxn94PdbNHqABn
         98Zt55fVxC4h5c1C81NDEAIljdplNMali+r8BJHSzvVu8Frrh6N1FyqFP3N7AbjkV7CB
         2FQw2qUQpRvtGbihgKBLL9MoHFCReeIxEyygRq3KDv5W9YL3wNbf58QdFR7MPHlI/HLv
         dRfFRyOJoDJGcGfEwtfLSYveUJxN0YvT5kWZrmbRd5ZwwAZeATO/jl5SqZbChb2JIaJ8
         UzWQ==
X-Gm-Message-State: APjAAAU1UvDvpXq1rcvx68EZpcuuWM9T8B6wKEcjdvK9pcSRvyy5KVKp
        Rf+hRXfxp3bEMQaMXc7cQCFQww==
X-Google-Smtp-Source: APXvYqzCaQiJKlPwcIwGohcqrI+PkPewrpIRZelQl07NOyqXU6/eUHGEUv0qFgoHuBOf223WAIYpHQ==
X-Received: by 2002:a17:90a:9a9:: with SMTP id 38mr20379590pjo.45.1572665340184;
        Fri, 01 Nov 2019 20:29:00 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:8cf7:b958:9b37:1730])
        by smtp.gmail.com with ESMTPSA id a8sm7773027pfc.20.2019.11.01.20.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 20:28:59 -0700 (PDT)
Date:   Fri, 1 Nov 2019 20:28:58 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/2] RelNotes/2.24.0: typofix
Message-ID: <20191102032858.GA93209@syl.local>
References: <pull.440.git.1572466878.gitgitgadget@gmail.com>
 <2e1ebe70820fd4cbc40df1f89779c77b9ceea881.1572466878.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2e1ebe70820fd4cbc40df1f89779c77b9ceea881.1572466878.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Wed, Oct 30, 2019 at 08:21:17PM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  Documentation/RelNotes/2.24.0.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/RelNotes/2.24.0.txt b/Documentation/RelNotes/2.24.0.txt
> index b7083cd6b2..26e018078d 100644
> --- a/Documentation/RelNotes/2.24.0.txt
> +++ b/Documentation/RelNotes/2.24.0.txt
> @@ -316,7 +316,7 @@ Fixes since v2.23
>     to access the worktree correctly, which has been corrected.
>     (merge dfd557c978 js/stash-apply-in-secondary-worktree later to maint).
>
> - * The merge-recursive machiery is one of the most complex parts of
> + * The merge-recursive machinery is one of the most complex parts of
>     the system that accumulated cruft over time.  This large series
>     cleans up the implementation quite a bit.
>     (merge b657047719 en/merge-recursive-cleanup later to maint).
> --
> gitgitgadget

Thanks, I hadn't noticed this when I read through the release notes
myself. This looks obviously good to me.

Thanks,
Taylor
