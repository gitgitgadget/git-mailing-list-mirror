Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC64B1F464
	for <e@80x24.org>; Fri, 20 Sep 2019 17:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406194AbfITREx (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 13:04:53 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:44406 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389495AbfITREx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 13:04:53 -0400
Received: by mail-pg1-f202.google.com with SMTP id r25so4761007pgu.11
        for <git@vger.kernel.org>; Fri, 20 Sep 2019 10:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zMGJlnd7mzU/dtsA3o5yrkWGvN8sPy6EyIDpbuMsZfQ=;
        b=WgZ0xSHpfPJEra+Mzm6eZ2bsmE9xRmMtIvRvwOU4akPqIUProaooXegNFN1wSlCnQ4
         k1o/8aeNwSuf9B4ppPIOEdp/Pqym8aa7tdUptwODnrMgPYGvYzbH63AvlfttU5N18YXj
         xmjKv1C7GeWLTPcOd5mJnMHesMxorZr4SLpYfX84DCfMuyMaq5rbCeYZo/SldJDcX170
         fk36Wp0PQoO7gY3DNdMyz/XTggPOgae/sfKS22b2xQbLLnXl0OwxDFZNbvv8YA+LszH1
         DBlbck+J0TmyMgG1bWuyKfOlS550iqTbciuYAzHRLeV17tW6pNGnxCwAmjJHdsbJ5VkL
         F83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zMGJlnd7mzU/dtsA3o5yrkWGvN8sPy6EyIDpbuMsZfQ=;
        b=ghO/L2hkFaA7cCZ4uFgAMwFG3rF75XKfGGjmYXR7GavDZLXhWbhA7QNRsVIA7yyVnI
         LXb1uxDctCxB/Y3b/YrWzGNs3LL1fpsKZZHU9iydnECr18lSbx4Hz37VPep0E8QZXuIz
         2uZe7CYgfFMdowjnUehNFBBdNWIVvxN+7OaKWGWKNoFjofdmgLD81SubBgKYc7PTo0pS
         Nijyuo42T88pEbbRYD9kpA28Uq5W0hk7mnUghHBY9DTiP2kUtx9LhLl+8OwXg+JPJJRy
         UcgJqqFFHRA5D2fd6zhEJYQUJVykSTK5BM1hvp/y0HelUjOqZWivIjgkaLREJs/nsP6T
         BVCA==
X-Gm-Message-State: APjAAAVkqg3A4lc0T5IWn8zWR2ILpvoCqa1vkSDNPD0AIkFFiyWMQLoF
        z1pNkaiix/6o6nU+8GUw1aJoH98Ao5bw8caGDUvK
X-Google-Smtp-Source: APXvYqz1K/YbIbyz5aW0dvkpY269wGLkOBuppmQjnnC+eLcumCSTp9NxWhvnUKd+vJRTnRN+Qhm6a95VyOb3zhDd58XV
X-Received: by 2002:a63:531d:: with SMTP id h29mr7097614pgb.52.1568999091531;
 Fri, 20 Sep 2019 10:04:51 -0700 (PDT)
Date:   Fri, 20 Sep 2019 10:04:48 -0700
In-Reply-To: <20190913205148.GA8799@sigill.intra.peff.net>
Message-Id: <20190920170448.226942-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190913205148.GA8799@sigill.intra.peff.net>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: Re: Git in Outreachy December 2019?
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Prospective mentors need to sign up on that site, and should propose a
> project they'd be willing to mentor.

[snip]

> I'm happy to discuss possible projects if anybody has an idea but isn't
> sure how to develop it into a proposal.

I'm new to Outreachy and programs like this, so does anyone have an
opinion on my draft proposal below? It does not have any immediate
user-facing benefit, but it does have a definite end point.

Also let me know if an Outreachy proposal should have more detail, etc.

    Refactor "git index-pack" logic into library code

    Currently, whenever any Git code needs a pack to be indexed, it
    needs to spawn a new "git index-pack" process, passing command-line
    arguments and communicating with it using file descriptors (standard
    input and output), much like an end-user would if invoking "git
    index-pack" directly. Refactor the pack indexing logic into library
    code callable from other Git code, make "git index-pack" a thin
    wrapper around that library code, and (to demonstrate that the
    refactoring works) change fetch-pack.c to use the library code
    instead of spawning the "git index-pack" process.

    This allows the pack indexing code to communicate with its callers
    with the full power of C (structs, callbacks, etc.) instead of being
    restricted to command-line arguments and file descriptors. It also
    simplifies debugging in that there will no longer be 2
    inter-communicating processes to deal with, only 1.
