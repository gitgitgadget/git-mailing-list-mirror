Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B54F1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 22:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbeGRXVQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 19:21:16 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53070 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729309AbeGRXVP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 19:21:15 -0400
Received: by mail-wm0-f65.google.com with SMTP id o11-v6so4235141wmh.2
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 15:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4BymEfCycCKmqyL4/IgkH1lGH0VFd8x4P2bkNctopyU=;
        b=l5rDpfyhXakSPbsZ4gXc7UdGGMheHOutvimjXS1PU/V6lO0lOVkQbQo+4ovfvjo/xU
         dz7dxQPr0a+xjfQTp6gIVnwewTBhauRDLRoeZq+GKpUXwqRZxIPZ+iy8zWlQSgcBsCxU
         7B1OPliizXRw53fQ+AEIJXLMFnlnZYliKGv1mQM0MXppd6CSPQj3/Hs3caohFIwVJBn0
         YTz8SqmM3XtzSKRX3vTaeRvdCuZsL9NWH4IWPhUTPq14AVmz6Tw/NrDoOECfSngkUiEF
         EPZ3+oikYbcp6nlHI07REKrGrYEa2wQil2yZ/tSx1ilzbVUmiT6ng8Shk8lBWEIq5fCp
         J47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4BymEfCycCKmqyL4/IgkH1lGH0VFd8x4P2bkNctopyU=;
        b=E8ATKn4efVM59+YiPkc37WVi3NLCwRRW2WcoXSZVBtK4NAatPG0qXiQHMRG9W6VaTX
         IkPeBIPntr3eeEoSdSwcDgkrxVpGo2E+zNmPHdFpOvokaAB4NlM90FwKBFnlNS/9eM7t
         SMCHZ/3sM9PU1oUM1D8xfZnrcpu3ZiSMvOSWuUJhZpYk5CQmlAcIzBVxRqDRAEpGXISF
         PvR1g9TKQbM9yyUABRHhRSLmBMRK7JesjEECWN7xeVuv5IwMOLntY4Nho0NfhRqhPabN
         yz/WVZSrahlSoDrroRwXSmwj62JchjV1TkPvNML6ZSo55ijkdD49LmizyD2WLZZFyYra
         A07A==
X-Gm-Message-State: AOUpUlFbenUtxhE1E1utljMrudPLXPzbFi0nJhEFP+V/PT6Cf2F1gLEu
        UI5tAMHQrf6nrcpRU4RSx9c=
X-Google-Smtp-Source: AAOMgpd93O8DnSwQRYdZYlQvNg/v3Lgk+mV8m2XF6h9Y06ifGqxgaDKXhn8E1dnISAmmXOo0Me7q7w==
X-Received: by 2002:a1c:a103:: with SMTP id k3-v6mr2696591wme.161.1531953671815;
        Wed, 18 Jul 2018 15:41:11 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 79-v6sm5858776wmf.5.2018.07.18.15.41.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 15:41:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/3] check_replace_refs: fix outdated comment
References: <20180718204424.GA1483@sigill.intra.peff.net>
        <20180718204449.GA31816@sigill.intra.peff.net>
Date:   Wed, 18 Jul 2018 15:41:10 -0700
In-Reply-To: <20180718204449.GA31816@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 18 Jul 2018 16:44:49 -0400")
Message-ID: <xmqqlga8i2ux.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Commit afc711b8e1 (rename read_replace_refs to
> check_replace_refs, 2014-02-18) added a comment mentioning
> that check_replace_refs is set in two ways:
>
>   - from user intent via --no-replace-objects, etc
>
>   - after seeing there are no replace refs to respect
>
> Since c3c36d7de2 (replace-object: check_replace_refs is safe
> in multi repo environment, 2018-04-11) the second is no
> longer true. Let's drop that part of the comment.
>

I wonder if c3c36d7de2 should be corrected so that we would have
this bit per in-core repository instance?  When the superproject and
its three submodules all have an in-core repository instance each,
and only one of the submodules uses replace ref, the original
optimization disabled by that patch would be an obvious thing to
have per repository.

But that is a tangent.  What this patch does is correct without
any doubt.


> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  cache.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index d49092d94d..6365fd6c0f 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -804,9 +804,7 @@ void reset_shared_repository(void);
>   * Do replace refs need to be checked this run?  This variable is
>   * initialized to true unless --no-replace-object is used or
>   * $GIT_NO_REPLACE_OBJECTS is set, but is set to false by some
> - * commands that do not want replace references to be active.  As an
> - * optimization it is also set to false if replace references have
> - * been sought but there were none.
> + * commands that do not want replace references to be active.
>   */
>  extern int check_replace_refs;
>  extern char *git_replace_ref_base;
