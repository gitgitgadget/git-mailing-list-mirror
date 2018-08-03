Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 554B91F597
	for <e@80x24.org>; Fri,  3 Aug 2018 03:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbeHCEzJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 00:55:09 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:50614 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725736AbeHCEzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 00:55:09 -0400
Received: by mail-wm0-f46.google.com with SMTP id s12-v6so4677678wmc.0
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 20:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CJGs7dE5s4eOc7Ii6O8+NjhzXktR3PcgVzmYWlbdQis=;
        b=r4yAMRspNKpKimbhtt3VSAg9tzDWg7lHeYhlms1cWDQ48iw+KaNPKmMNrokJ951bG7
         1gnZK2G62IMqDFHs5TV4UGdxGC5ZHIQsC9hZBAAJR+oX8fGq0DGd+DmxdsEDI9w4z9ln
         0A4B5CY8KkBy/sTerltx8ektjdT4acM15NmXqbBo/EWQ15bqM7M+G+3NJS7KKnflf6oC
         0BhjaKZ1Zd7fu9SOMWZ2olYRRI0j9Dl6H+whg4UuYM4mUxO8OD4KtT+5zpa3bSartBz0
         mvsI5am/rSV/1S9+tqHCydCTSOdgMEIVx4SZr8CFF4/iO61yVk+kdNtEwWKX8/abUYoS
         w42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CJGs7dE5s4eOc7Ii6O8+NjhzXktR3PcgVzmYWlbdQis=;
        b=WItDSM8dlNCpaTx7d+3NdTwt2q6OgBjAlGXdGduI/9f2YBiqBHZi3ZzVH8dXbxTdbS
         pd6Jvu6EYwA/Xvz3Xzt+wo9Wll/pqQLL0VnrY48vDzIcUeVXy7S80HBwpOkfpQjcBIDT
         h2Ln/MXoH2f04UZtFdYnXJsWX71K/xMQJpWn16eVx5wUpQv/ubzztRnRU2Q0mvrUND/F
         PG6AGRSuJusSzqC45crafkFtDDyyAlhSjDzIR18X7sWV2336Cky44R9j5IIIqYEsTNgP
         babqsrj6eIvHEKf4MNXrLu5VkWP2E4ngDLG0BBISbgExkRwRDQcoYUr7/hpNCiQ/a6ZE
         x9CQ==
X-Gm-Message-State: AOUpUlF1TiG5S8MFzCg5r/01KsGPvLKC6I8refHZOXzv3afwVNQm/0n5
        8FGNbCZgM+h/l+7hAV1ec4dsdSiaJ6TNF8Vn3RibmAj4
X-Google-Smtp-Source: AAOMgpfFEm6Tf7VmIkck+PR91ghVoWuvG0rxb5TkuICO5s4MCzRP4unLPF+ySIM9RfNPTINgMLafdc3Nnbe21UOgrsU=
X-Received: by 2002:a1c:5e48:: with SMTP id s69-v6mr3444875wmb.19.1533265261992;
 Thu, 02 Aug 2018 20:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq4lgcz81f.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4lgcz81f.fsf@gitster-ct.c.googlers.com>
From:   Pratik Karki <predatoramigo@gmail.com>
Date:   Fri, 3 Aug 2018 08:45:51 +0545
Message-ID: <CAOZc8M-AqmcbM=Z47SoPpQNaGwFWEbQ=BctXHaYBVeUf9V+j=Q@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2018, #01; Thu, 2)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, Aug 3, 2018 at 4:47 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> * pk/rebase-in-c (2018-07-30) 3 commits
>  - builtin/rebase: support running "git rebase <upstream>"
>  - rebase: refactor common shell functions into their own file
>  - rebase: start implementing it as a builtin
>
>  Rewrite of the "rebase" machinery in C.
>
>  Will merge to 'next'.

On a recent mail[1], I had suggested stalling this iteration in `pu`
and wait for another iteration to merge in `next`.

[1]: https://public-inbox.org/git/CAOZc8M_FJmMCEB1MkJrBRpLiFjy8OTEg_MxoNQTh5-brHxR-=A@mail.gmail.com/

Cheers,
Pratik
