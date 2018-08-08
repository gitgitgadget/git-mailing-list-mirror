Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D3701F405
	for <e@80x24.org>; Wed,  8 Aug 2018 21:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbeHHXws (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 19:52:48 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53929 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbeHHXws (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 19:52:48 -0400
Received: by mail-wm0-f65.google.com with SMTP id s9-v6so4204381wmh.3
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 14:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qk8H9fUtNp3v/FuXGhfuaVK+ctI6ief4QUZSxheQchA=;
        b=Z9HUdAsC6LUiLXy5AsiqIdJ2Zqgv23VTMzou5wfq9WsdcrzXvztOkAYEUKZjDzLbMp
         DhkhAIBVicE5QhzbWx2+rjDAP5+c4zAfxxbAHLG1/YV2FMDp6WCkux9mhDoV9hTj/2e6
         4aVa9bYTwIKkXOJVH4/4XOzzkYnDQLdTgAre+DQSRnstfN+IUKARhKC55xXaUE4+i3Ax
         rza7xWq9IOQkkEM1TRtY2U+dzt4qZnQzeNifx0AwDmlowjbO82AwKqfiPFbWta6QIsnI
         DaBC/SIXQlNN/fzLPncX7yxLc/2W+4IWy7V37T9oeUyliYvu5x1I3iOgDnIxG2iN5GNg
         iYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qk8H9fUtNp3v/FuXGhfuaVK+ctI6ief4QUZSxheQchA=;
        b=QiQN83Px2UO1FVlCaeLFZzUDmKDTXabGyOW65T9SRuJeB268PTNfF/IB6oic5LEtOo
         fP05p2mMyTiJ9WMPRtZBuOB1EnI5VeXbWf8kbuhMSjmCtqX7HxJS4CuNhL0ki4R7oYWT
         0V48Dipq9hMk3OaNb6gc+hNHW7MXjxR8KPPsz5zA9InOf9B7zxSFKHtd7kBIaGHRtBuN
         KBmrWsyNPGE2Bms+mkWfygIMP4tEQL4wnEoMeEiZWMSL+UHbA6kev187ybUcoM05Oyi4
         T2CxBShENb69GgmPCVLe3ctgtnziL7bXfnDqgre2nu0M0A29Ow74jTt/QW21Wl69eJSO
         pdXQ==
X-Gm-Message-State: AOUpUlFKTv4dx4tqJQY4EbaKBDFFfCuhKfL06l4VN+DIbgk0E7+g8bZ5
        BZrZ92qgL8ULV9/CmckEPZmUlKAr
X-Google-Smtp-Source: AA+uWPyGuYShdRAp1mxEW96EhWdBNWgxgrjbABVt2pqrVOIU0pGSU0XyOJBqnOMFE6LA7VX8efcvJw==
X-Received: by 2002:a1c:385:: with SMTP id 127-v6mr2988905wmd.92.1533763876115;
        Wed, 08 Aug 2018 14:31:16 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l4-v6sm4224490wrv.23.2018.08.08.14.31.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Aug 2018 14:31:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-update-index.txt: reword possibly confusing example
References: <20180808202807.15350-1-newren@gmail.com>
Date:   Wed, 08 Aug 2018 14:31:13 -0700
In-Reply-To: <20180808202807.15350-1-newren@gmail.com> (Elijah Newren's
        message of "Wed, 8 Aug 2018 13:28:07 -0700")
Message-ID: <xmqqzhxweeam.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> The following phrase could be interpreted multiple ways:
>   "To pretend you have a file with mode and sha1 at path"
>
> In particular, I can think of two:
>   1. Pretend we have some new file, which happens to have a given mode
>      and sha1
>   2. Pretend one of the files we are already tracking has a different
>      mode and sha1 than what it really does
>
> I think people could easily assume either case while reading, but the
> example command provided doesn't actually handle the first case, which
> caused some minor frustration to at least one user.  Modify the example
> command so that it correctly handles both cases, and re-order the
> wording in a way that makes it more likely folks will assume the first
> interpretation.

I do not think the rephrasing loses those who want to update an
existing path, and is a good one.

> -To pretend you have a file with mode and sha1 at path, say:
> +To pretend you have a file at path with mode and sha1, say:
>  
>  ----------------
> -$ git update-index --cacheinfo <mode>,<sha1>,<path>
> +$ git update-index --add --cacheinfo <mode>,<sha1>,<path>
>  ----------------
