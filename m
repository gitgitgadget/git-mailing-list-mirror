Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE2671F770
	for <e@80x24.org>; Wed,  2 Jan 2019 11:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbfABLSK (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Jan 2019 06:18:10 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:33532 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfABLSK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jan 2019 06:18:10 -0500
Received: by mail-io1-f67.google.com with SMTP id t24so24278259ioi.0
        for <git@vger.kernel.org>; Wed, 02 Jan 2019 03:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bOj53faJTtRWQxOlEdz43curBkEXum8pQSwGoGq+SNg=;
        b=KaH1RkRvGvmkmSdXD9kc40eZIAxLsV1+WGTaY8L2WJ/0Y2N/E3nTb3CuEQaMDpF4zs
         ZkZ7ct01Imw0JBuZV+gFEHgI784zymtFhA2IpFe7L8xhQVyUhfUKXzgaC8YV7258KHHa
         b8N1dsZiruCwg0AEY0YAnDjfymEez5Ndc9vEpybiuZXgabPHFOsRXSTXwPjzSDuU0eLS
         t8s4DkZNvssqVBzPAG1q1afsGX6D+MxSDWyX7+gLAFVXPmM5foJT+v0OuTcxl4tsc+Mg
         h5dV5I1Fx36pK6EHKH3UotN1bP2gZFmQ7zuhXzwGSeRaHD9ixw6gH5A7D2C0aPtsnTbO
         okCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bOj53faJTtRWQxOlEdz43curBkEXum8pQSwGoGq+SNg=;
        b=oKiRanPVQKv8Q89fpdAdj4MQ1FOXKSGGxAIIikrQClVqhdJyHb5XvEYMd6TVh2qqhT
         m1FA8RXG+tn0gLoYrZ0pf9VjS3WVCmTWn42/Lc9eDzCrpL5kElKQKuaseHL1JZJ/enFw
         3sd9ZjkGbYbpUHPtV/bo5Np7moCNx/GYBmOh9CK2vRHCoHGmAkNz5VlaABKlRd/U8xvH
         vmwgBroJ8tXfakZCyXK3o+IlXNW9uwVvYs87x2d9nj01z+jbQ2Zu9Z77mIGEkVLnaSdx
         tpvNmflnYUaRv0RunnmdyZuwKhAHS+tqSNeTyQna1PQzAxTsnQ/uEJAA6F/uR3k91M6r
         F7rw==
X-Gm-Message-State: AJcUukfosrnnbIaw7s1KqNnhaKdzgblx8Jx5VSGyHClM+QAI9mZyeNS/
        pXzCHUxM7iMk1jeucmVWupXiavZMCeyRYrajmLM=
X-Google-Smtp-Source: ALg8bN44AS1oHhm+HR4E5MaTsDNAYi44miZsQ1F4hWz3Cgq5/2bMeIFqmk0eer4vkR5a35o+oDownqHvOc16lqcDCYE=
X-Received: by 2002:a6b:c544:: with SMTP id v65mr30668976iof.118.1546427889775;
 Wed, 02 Jan 2019 03:18:09 -0800 (PST)
MIME-Version: 1.0
References: <CACsJy8D_gTKWXogPDNW7NQk_a0ChBu28HfGu388hFn3-by_cRw@mail.gmail.com>
 <20190101200818.81273-1-aburthinds@gmail.com>
In-Reply-To: <20190101200818.81273-1-aburthinds@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 2 Jan 2019 18:17:44 +0700
Message-ID: <CACsJy8B4FCkrV0srm8pvcU41DMWoZwDHgW8Wu0j3nZT5JLhEBA@mail.gmail.com>
Subject: Re: [PATCH v2] doc: remove unneeded TODO for release_commit_memory
To:     Albert Burt <aburthinds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 2, 2019 at 3:09 AM Albert Burt <aburthinds@gmail.com> wrote:
>
> Remove TODO that was left in from:
> commit 110240588d (Merge branch 'sb/object-store-alloc' - 2018-06-25)
>
> Todo can be removed as:
> 9d2c97016f (commit.h: delete 'util' field in struct commit - 2018-05-19)
> deletes commit->util.
>
> Signed-off-by: Albert Burt <aburthinds@gmail.com>
> ---
>
> Thanks for looking at this for me Duy. I updated some of the changes you
> suggested.
>
> Let me know if there's anything else that I would need to clean up, or do better.
> :)

Nope. The patch looks good to me.

>
>  commit.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/commit.c b/commit.c
> index 2d94e0b199..2ff6dca0bc 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -357,8 +357,6 @@ void release_commit_memory(struct commit *c)
>         c->index = 0;
>         free_commit_buffer(c);
>         free_commit_list(c->parents);
> -       /* TODO: what about commit->util? */
> -
>         c->object.parsed = 0;
>  }
>
> --
> 2.17.2 (Apple Git-113)
>


-- 
Duy
