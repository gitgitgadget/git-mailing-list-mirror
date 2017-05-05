Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 178B8207B3
	for <e@80x24.org>; Fri,  5 May 2017 23:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751519AbdEEX7B (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 19:59:01 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35811 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751242AbdEEX7A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 19:59:00 -0400
Received: by mail-pf0-f196.google.com with SMTP id u26so2355418pfd.2
        for <git@vger.kernel.org>; Fri, 05 May 2017 16:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jF/OgVKfFkGlojeeSeJZzYf1US+KtaKhrHG7J7fnmzk=;
        b=aLNelmSfFHguhKOICBZrA4UvRAZ1ux/TEOB2+Em++yZ3xmzBKvGw0M3I8HKF0MSM3f
         WT5S4N7dLmQIvvLokGxmWZoV4dslbOlLvHDkijwKX34vlJIOMFJnuF3mbZvuC6qZz41j
         cNl2YfCfvfsQwuREWX9bkVvXl1Pc1pwuRpg2OMCHpuSqRoYU4pAWex63VWpTkmOzKqHj
         nuEcme054l9N6hScfWHJvuuh49ZiR/o6LEGi8Ta4kqlyg7B65vNCXrQm+XiS6InMpN6g
         WWCAGAvUOAIGy68sw2dYtwGFNAWdhNu4wvWbH3avNkGYStfqa5XNnstD2VY/VLUeNv9P
         2J4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jF/OgVKfFkGlojeeSeJZzYf1US+KtaKhrHG7J7fnmzk=;
        b=bw0L9K+Tkd0Z34fx3xy7MG6q0/Jq8AMDgHw60pIV3myExJyJHfdMiRqKW/him7BQXV
         EPxBsorGRdJB5frKoUK+oYCadNx3gLj1Wy+aCcMG3dJ2eOPkkqynf7yYBExMzpYRjOJ2
         HYc3D0ukVNDG6RxEh9a4F3fDrepbet+Go8igSs/QdaghGgQufTK2ib2dMMEp9iRRuIj6
         AciYi2gzsB+XKdJzBziOeYJ3l0W9X86oERGp/X8Q+J4Fxkkh6MFzPuxJGM0S8MO5ESCL
         mCa4rzad/EKQxKKK8h24AvguD1P9T+3TUbyKipwObnPdrheHsx/4pmh5PUx8GChDJIkw
         s8TA==
X-Gm-Message-State: AN3rC/6/lffytz9Wd5McVT+SrpuMcTlPYeG/yBT8R5YyUaL+9ZMD+Q+o
        FuXcf8t/QjNtTu11KMc=
X-Received: by 10.98.74.135 with SMTP id c7mr19449781pfj.140.1494028740030;
        Fri, 05 May 2017 16:59:00 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:5d98:2d3c:6099:849])
        by smtp.gmail.com with ESMTPSA id 7sm7421954pff.36.2017.05.05.16.58.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 05 May 2017 16:58:59 -0700 (PDT)
Date:   Fri, 5 May 2017 16:58:57 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH 1/3] docs: correct receive.advertisePushOptions default
Message-ID: <20170505235857.GJ28740@aiede.svl.corp.google.com>
References: <cover.1494027001.git.jonathantanmy@google.com>
 <28c40105e53a4d4d828092bc1697fff8992419d6.1494027001.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28c40105e53a4d4d828092bc1697fff8992419d6.1494027001.git.jonathantanmy@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:

> In commit c714e45 ("receive-pack: implement advertising and receiving
> push options", 2016-07-14), receive-pack was taught to (among other
> things) advertise that it understood push options, depending on
> configuration. It was documented that it advertised such ability by
> default; however, it actually does not. (In that commit, notice that
> advertise_push_options defaults to 0, unlike advertise_atomic_push which
> defaults to 1.)
>
> Update the documentation to state that it does not advertise the ability
> by default.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  Documentation/config.txt | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 475e874d5..f49a2f3cb 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2620,9 +2620,8 @@ receive.advertiseAtomic::
>  	capability, set this variable to false.
>  
>  receive.advertisePushOptions::
> -	By default, git-receive-pack will advertise the push options
> -	capability to its clients. If you don't want to advertise this
> -	capability, set this variable to false.
> +	When set to true, git-receive-pack will advertise the push options
> +	capability to its clients.

Good catch.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Possible improvements:

- Should this also say "The default is false"?

- git-receive-pack(1) doesn't say anything about push options, so
  without more context it's hard for a new git admin taking over
  from someone who had set this up to understand what's going on.
  Should this have a pointer to the pre-receive + post-receive
  sections of githooks(5)?

- Speaking of which, should git-receive-pack(1) say something
  about push options (for example to also have a pointer to
  githooks(5))?

- git-push(1) has the same problem: when describing the -o option, it
  doesn't give a pointer to where to find more detail (though it's a
  little more helpful then this one since it includes the word "hook").

Thanks,
Jonathan
