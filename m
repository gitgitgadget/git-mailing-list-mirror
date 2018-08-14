Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EFF31F404
	for <e@80x24.org>; Tue, 14 Aug 2018 23:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732505AbeHOBuc (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 21:50:32 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:35811 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729705AbeHOBub (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 21:50:31 -0400
Received: by mail-yw1-f65.google.com with SMTP id s68-v6so17518899ywg.2
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 16:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MGtK4imdcRLoIzCeH5RY+Y6HTpimxbhYgrF7NjbGH04=;
        b=GhAfhac5IGXX09Gf+HNnKfPbxgFHo9DV9CGpO7oK7fVCazfoKSSLxfoSG+d53ubwFO
         RsXKQD+pPxNx6br9DEUDNleHCnEjpm+C1iFY0bpOJLKFrwKuxMrz+i/ySNQWsn4pL946
         1TNEup1ARBgV+RdYHEyFw5Bnf/T9jKnalvwWf9385Upq03bgmYvY9rctkH4Upiqe2Fy0
         JFB6zncIingZgjgnan7h90xg0PgARXW8uvQFJjySqU/gy2T2gouttRQGRZ9llIeYD0ar
         qf77CFjqCIvlNZ6vIxqXQAptWlbH6LxGcTj+1GC4E+eL0gytFXF+UNThS811x20OVI5/
         VqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MGtK4imdcRLoIzCeH5RY+Y6HTpimxbhYgrF7NjbGH04=;
        b=TDl8To3OYWAT1kBcanoy5egBl8RhrOMnXMNOiipV7O9rzqIeqJqVsrTMA+vSTEaHah
         LEdy82SJy22y9KT6rw+QOhQk+tFeZErrV9mpDvV2Kh53HvFE5cBcs3/OVSQouUrJMfqn
         Et1Z9Fsc0e2GqmvzihEzkGhUiRg5mIk4DIip2OImBKuiY6+xLvo4c7ar5Zyby85hOjJo
         uGaXOFYlCChzIno74q+1piTfRzb/rxocngXw0xU+GfvF/4oM3IbMOqtgaJ8rlfxwgzWZ
         /e+aF/KxeblAhJBjM3X3zqCWm7OKE+RO3OpUxviJZbGzqSosUgv7opSz8Qz705pB6cfR
         bPrA==
X-Gm-Message-State: AOUpUlFed1jCvExdLko9RqN+rTruKJPFpMuGHR2PI1hLwa7B4RjkT43s
        FAjxa06Ehup2QuZkL1303DJtqx0JVj3vLODM57gjhQ==
X-Google-Smtp-Source: AA+uWPzE4DDaW+rqOyZHz1G04nvou31Ud3Y/gAicEtSxV0j4mtkgu+g9UMn0gjxs1a9Ae9yMcdkHTbkWp/zAG7IUMVw=
X-Received: by 2002:a25:3624:: with SMTP id d36-v6mr13544976yba.292.1534287666822;
 Tue, 14 Aug 2018 16:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180814222846.GG142615@aiede.svl.corp.google.com>
In-Reply-To: <20180814222846.GG142615@aiede.svl.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 14 Aug 2018 16:00:55 -0700
Message-ID: <CAGZ79kYbmTXXwWO6Sy5ytOLS6=p=9gMzgbjdrSbJPkkQqsyJTA@mail.gmail.com>
Subject: Re: [PATCH] partial-clone: render design doc using asciidoc
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 3:28 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Rendered documentation can be easier to read than raw text because
> headings and emphasized phrases stand out.  Add the missing markup and
> Makefile rule required to render this design document using asciidoc.
>
> Tested by running
>
>   make -C Documentation technical/partial-clone.html
>
> and viewing the output in a browser.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Today I noticed that this document wasn't available at
> https://www.kernel.org/pub/software/scm/git/docs/technical/partial-clone.html,
> so I wrote this patch.
>
> Thoughts of all kinds welcome, as always.

yay! Thanks for writing it!

...

> repack in GC has been updated to not touch promisor
> packfiles at all, and to only repack other objects.

We'd need to adapt this documentation in Jonathans series?



> -[0] https://bugs.chromium.org/p/git/issues/detail?id=2
> -    Chromium work item for: Partial Clone
> +[0] https://crbug.com/git/2
> +    Bug#2: Partial Clone

This is more than a formatting fix (I did not quite check the rest,
but this stood out), but some change to the actual content?
