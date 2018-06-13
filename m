Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D96781F403
	for <e@80x24.org>; Wed, 13 Jun 2018 18:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935302AbeFMSWC (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 14:22:02 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44877 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935256AbeFMSWA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 14:22:00 -0400
Received: by mail-wr0-f196.google.com with SMTP id x4-v6so3730233wro.11
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 11:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Darrc5QenLbrxz5O1e5EuqZJFBDndEA7+tyU5zDVdQ0=;
        b=YKxgmR48Du63k1o8eLO5jGWzkkivZXlgrUUGWI+2Ol/JNUUuGSlBv+chNaLVOyq0XD
         TrkRGUqKuJZpwluPNpYRrSNj+88y59AgWHGRjBeNZoqrz3B10tYUtqjdDawxtxpZbYSc
         9BZRXIFvLo6ae8le63c9x1mHZAxjhuvhn3NwjVSjiAXxDKuUX7D2V4L+VH98TU5FBXBE
         XxY7/YwL1NuTQtyWG36CYyzt/tLOEsrZk53H/xkba+UnMGRxVckrk06MU9rLN0R6pk0a
         0mD9KILTFdljy6lCGWMrHnJXF4JIs8vcHL/AkB6idwe1DJAGs4oA9c1FBMQuIwvBhOXo
         R9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Darrc5QenLbrxz5O1e5EuqZJFBDndEA7+tyU5zDVdQ0=;
        b=pCDmOMABaKjvN4OSgAw97U9FQkP9tbvqJjGOCdN4DIk0BHvdlfmA+I1YRYzMlxymH9
         B590ZLhERGSiEsjxFQaYlpemkarPoTbTSMUcKUHpLgW2zBQBCVhJcQOXESaXA9drT+n0
         ZLARnwXVTupbWZasdSFP5OdGOlZjIpMeX4cGQ2uNP9f7A8whUGXgNc3fcl9ZzL7C2xuX
         buT4EpFcr2HemOyLWxC03yUIT5l1+rD7vpIxXEdA6JBPQzP+GjioKt7abQLwlmZs+Qcn
         UEFbqlXPExyToKmg8UVYBOgAYQuY5zSlBs4nNT4PB/J2qD8RHV+twoIUlrjy9XzDiKFY
         dBvg==
X-Gm-Message-State: APt69E3sFVr51m5uXrTeqFhhtbA0IGiej2pJmx4ykit7lOiE0Qji5DCI
        1fnYr/KHtmFTR9/BK/ITeTg=
X-Google-Smtp-Source: ADUXVKLYIXSRE3bgy5QqCDZc+RYFUiNF4Hze2kB5Z2+/O8aDdw4fzpsNX8f0Vo2m2woxR6sVKzW85Q==
X-Received: by 2002:adf:ca03:: with SMTP id o3-v6mr5036568wrh.148.1528914119238;
        Wed, 13 Jun 2018 11:21:59 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w15-v6sm5689242wro.52.2018.06.13.11.21.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 11:21:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Meng-Sung Wu <mengsungwu@fortunewhite.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: update the order of the syntax `git merge --continue`
References: <20180613035702.15957-1-mengsungwu@fortunewhite.org>
Date:   Wed, 13 Jun 2018 11:21:58 -0700
In-Reply-To: <20180613035702.15957-1-mengsungwu@fortunewhite.org> (Meng-Sung
        Wu's message of "Wed, 13 Jun 2018 11:57:02 +0800")
Message-ID: <xmqq36xq7dix.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Meng-Sung Wu <mengsungwu@fortunewhite.org> writes:

> The syntax "git merge <message> HEAD <commit>" has been removed. The
> order of the syntax should also be updated.
> ---
>  Documentation/git-merge.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

An obviously good change.  Could you please sign-off your patch?

cf. https://git.github.io/htmldocs/SubmittingPatches.html#sign-off



> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index d5dfd8430..6a5c00e2c 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -57,7 +57,7 @@ reconstruct the original (pre-merge) changes. Therefore:
>  discouraged: while possible, it may leave you in a state that is hard to
>  back out of in the case of a conflict.
>  
> -The fourth syntax ("`git merge --continue`") can only be run after the
> +The third syntax ("`git merge --continue`") can only be run after the
>  merge has resulted in conflicts.
>  
>  OPTIONS
