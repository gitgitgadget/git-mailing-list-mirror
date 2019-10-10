Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34C841F4C0
	for <e@80x24.org>; Thu, 10 Oct 2019 18:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfJJSoo (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 14:44:44 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:43202 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfJJSoo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 14:44:44 -0400
Received: by mail-pg1-f201.google.com with SMTP id 6so5036178pgi.10
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 11:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zgY8VA7SbC2gmoQvmovFAv2ujYXI92aS8gfyCzXnHew=;
        b=jYHoi8K3Z/jq5pkKDVDemZvUm2Ix0AcQc5FyF32GG9oE4f6Ws5LpLXZli0LTFA+3D3
         ySrcyTQtTUj8Q9BM7hFBnKD95H4PvRfmCb5d9CLKoZ/L9BaQSCHzKFfRNKVVX20aLObc
         8pH/fRGngOlyOOzNVEewaXA+AC1+8Cz3Yt+kQU6u/tQ2Z28dM+0rMaG7gtIgwmuK+dFC
         2lnY4tPq2LzGVNnKP+C0QfPfOZqHYLhw5TZVYjsZ9XfCIocGfW6QoTdKUylnrt/numY7
         imCIa0HQZyfZQPMcEsP/8GD83txydg7Ca59rlXgeCp/MmzFG9GoLAxFxZqS8RSdYzv6Q
         8vEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zgY8VA7SbC2gmoQvmovFAv2ujYXI92aS8gfyCzXnHew=;
        b=AJWt7cNHcc5bOG0MClaw+r/VcFvJnH6xjzI+NMOKtQQD8p8weoEOIhk/1jIv7Etftp
         CkKIZTok3gpUAk9XJxz5fotK8jLCQQNb0ZMeQGefT7q2U56jdTlf3wx2nExvWyvzwoVO
         fQwzM23OiDuOqacsH0c1e/ZdepGOYHUPDuEVcu+Go+h9pbDoVpEjHxbvDqGDYo7wL2bO
         zOW8yQ4061VaKEl1LtJEW67bl4O0YyTZvdwe7ZYWG1x9erMN+hTI0wuMDW+yVHBHFoJJ
         zWURZBis2zgVJ8Vk8IltUCyr1ZY8aZLCJGquxYAPZoJg4t0Tegc+k5+atcs5OITduw9S
         rXTA==
X-Gm-Message-State: APjAAAWe4XLuYJj1ixJK+h3/cqilNYN0XqZJ1o4poZYTl6gnNWzQUuZs
        l/3mqlZgcG0ChPHi8VBzLP/vft65Nhc+rFthBYKP
X-Google-Smtp-Source: APXvYqys0BrBC350e9/Wlfmyh/M21YK8SaXX6GXbYPS9qg/eoInBI8XUQOaBTv5VLPmVLR7y6a/yVY5GGTquX8fgenRy
X-Received: by 2002:a63:9557:: with SMTP id t23mr12995300pgn.268.1570733083316;
 Thu, 10 Oct 2019 11:44:43 -0700 (PDT)
Date:   Thu, 10 Oct 2019 11:44:39 -0700
In-Reply-To: <20191010115230.10623-1-wambui.karugax@gmail.com>
Message-Id: <20191010184439.94173-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20191010115230.10623-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: Re: [Outreachy] [PATCH] blame: Convert pickaxe_blame defined
 constants to enums
From:   Jonathan Tan <jonathantanmy@google.com>
To:     wambui.karugax@gmail.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Convert pickaxe_blame preprocessor constants in blame.h to an enum.
> Also replace previous instances of the constants with the new enum values.

First of all, thanks for your initiative in finding a microproject and
making a patch for it!

About your commit message title, I know that 50 characters is a soft
limit, but we should adhere to it if possible. Also, in Git, the letter
following the colon is usually in lowercase. So I would write it like:

  blame: make PICKAXE_BLAME_* an enum

(Feel free to use that or think of a different one.)

> -	if ((opt & PICKAXE_BLAME_COPY_HARDEST)
> -	    || ((opt & PICKAXE_BLAME_COPY_HARDER)
> +	if ((opt & BLAME_COPY_HARDEST)
> +	    || ((opt & BLAME_COPY_HARDER)

Any reason why the names are renamed to omit "PICKAXE_"? In particular,
these names are still global, so it is good to retain the extra context.

(This doesn't mean that you are wrong to remove them - I just gave my
opinion, and a reason for my opinion. If you had a reason to remove
them, you can mention that, and we can discuss this together. Or, if you
read my reason and agree with it, you can say that and put the
"PICKAXE_" back.)

> -#define PICKAXE_BLAME_MOVE		01
> -#define PICKAXE_BLAME_COPY		02
> -#define PICKAXE_BLAME_COPY_HARDER	04
> -#define PICKAXE_BLAME_COPY_HARDEST	010
> -
>  #define BLAME_DEFAULT_MOVE_SCORE	20
>  #define BLAME_DEFAULT_COPY_SCORE	40
>  
> +enum pickaxe_blame_action {
> +	BLAME_MOVE = 01,
> +	BLAME_COPY,
> +	BLAME_COPY_HARDER = 04,
> +	BLAME_COPY_HARDEST = 010,
> +};

In Git, we often look at historical commits, so it is good to keep
history as clean as possible. In particular, we shouldn't move things
around unless we have another reason to. Here, for example, you are
moving the constants from above BLAME_DEFAULT_* to below. You should
move them back. (Or if you have a reason for moving, mention that and we
can discuss it.)

Also, I have a slight preference for putting "= 02" on the BLAME_COPY
line but that is not necessary.

Apart from all that, one thing that I expected in this patch is the
changing of the type of local variables and parameters. For example, in
blame.c, I would have expected find_copy_in_parent() (for example) to
have its "opt" parameter changed from "int" to "enum
pickaxe_blame_option". One of the reasons why we want to use enums is
for type safety, and that can only be done if we use the enum type when
possible.
