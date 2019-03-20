Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56CB920248
	for <e@80x24.org>; Wed, 20 Mar 2019 04:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfCTE4x (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 00:56:53 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:33701 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfCTE4x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 00:56:53 -0400
Received: by mail-wr1-f45.google.com with SMTP id q1so1222624wrp.0
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 21:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=j40cLpQX+h7lU7a9AgVrcSHBI+TrkLH9hryzPgi1/YM=;
        b=hH63no4/sXxon28Nd8wBEM7vGJ9qn9bTkUgoJGl1URV6rU/olLBKpFuC02SqsuGalU
         Sh3hQgzXo35YxG2m+EQ3DfBxO5J3xxbJ/aPkw6s0TtLGWZH7QkuLJl5Ke+pzBVNELOd7
         bWFmoNzfPKkfMqgiy5T3Y7nd53LWoLTM63Y+5n54B2lg/yPAmw0lfiBTVnqbYS5M09z+
         piEvQ8QamI5IyPfsX4sEBo6k2GyDhoe2K24kEQ3ELg0DVV8ZGwNy0bcuaoJsAwgd7hEg
         STp4yG+HcIt/CmWRDNSl+YwtMvpEVVoGfR2c2N4gCk+kw//xy7ScsMq/JM0p7s4IrxEY
         2Pdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=j40cLpQX+h7lU7a9AgVrcSHBI+TrkLH9hryzPgi1/YM=;
        b=WCpohijQZ+KY+xTRg+RJTEcS00SV3VCaJ468/SLTpZ2lR+u52rsaAG5NP9x0Yma0vN
         O+TVdojxfCHY9OC4gUUGINjM8JrP7I1zYwI2p8Cml+wf171dK/9Mx3sbH+gOpZLg1hIY
         OqF5ia2zvMRQzsxQLmV65AupoI51MgiXZUL/kpwG/+5fb+3z7+ChZb0iUjwlf8UfvX/K
         0wptPzjgt/4gCffqFZEaKLkPROINsNnx5fcR8OXvB1JVJkvvckIRlMbQc4spdI6t9Uvc
         uuCIiSsCm/F6pw6klRneEpd7scQdSJI4Bgf1ES0l+k+9S5Q4VzlKJypynuD57vhdcKeh
         OsTA==
X-Gm-Message-State: APjAAAX7fVpcn2TRaOhk8fl0FakpLu8PSHjf8J60oLoRCsBynmtpRs6q
        T6Eh4lHHypO3kf3NPrd0mvWiDev89xE=
X-Google-Smtp-Source: APXvYqwcsUFVXNnkPyvS8K/1R97M3D6QsMzypHqsNp3k/n73pKk2as8qA92aWIw6deOgXoP4LfbpWg==
X-Received: by 2002:a5d:624a:: with SMTP id m10mr20100282wrv.18.1553057811513;
        Tue, 19 Mar 2019 21:56:51 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id y66sm825963wmd.37.2019.03.19.21.56.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 21:56:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nickolai Belakovski <nbelakovski@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2019, #04; Wed, 20)
References: <xmqqa7hqw844.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 20 Mar 2019 13:56:50 +0900
In-Reply-To: <xmqqa7hqw844.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 20 Mar 2019 12:13:47 +0900")
Message-ID: <xmqqva0euorx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * nb/branch-show-other-worktrees-head (2019-03-18) 3 commits
>  - branch: add worktree info on verbose output
>  - branch: update output to include worktree info
>  - ref-filter: add worktreepath atom
>
>  "git branch --list" learned to show branches that are checked out
>  in other worktrees connected to the same repository prefixed with
>  '+', similar to the way the currently checked out branch is shown
>  with '*' in front.
>
>  The top one probably deserves retitling.
>  The second one is of dubious value, but if we are keeping it,
>  it should also be retitled.

Sorry, but my commentary in the last paragraph is stale.  These
patches have been updated with more sensible titles (as we can see
from the recent date for the topic).  I've moved this topic out of
Stalled section back to Cooking section.


