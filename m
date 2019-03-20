Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D98220248
	for <e@80x24.org>; Wed, 20 Mar 2019 00:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfCTArj (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 20:47:39 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:37927 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfCTArj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 20:47:39 -0400
Received: by mail-wr1-f42.google.com with SMTP id g12so837277wrm.5
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 17:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lJysWRcfaua6SCqJY+PTMm0zThvEM2SkBfvTGuYKaUI=;
        b=DREZb9VcZisaCHAKZCHuLVwa0Cq6z7sggmlB5YZZfm/ZU5nwstU2hgxNFL+wiEyKTq
         R+hv2eqiZVrMI0UB7t13x5eYIx5ua4BxgVW3DISZyr4nulv/ky0e3IaWs3TrmMK4wgMl
         PfhmwRGGUzQs1TroZLPS6l7nR9JHAdRmHDI3hBdLRdDBSVW9yPbpf2uR8/oRMClaExL2
         oY03AUHvoVESSe260ujxMbIXUglcfWrbcElhf7mcGz4HLrtZXdNGZskPPzzMtW7p2Ljb
         yFz9Mpo7QlHa5tynalGmiidUBBHQ4azrPaXQJ3T6KqFeo55Okatb+ElU/txXQ8yMV2hX
         /hDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lJysWRcfaua6SCqJY+PTMm0zThvEM2SkBfvTGuYKaUI=;
        b=HxJ9Fxb011Mx/Uh/nYKJIKrsF/si68lcGMOF7dwiwCFpOsNUAIcm5x9BgpSyL2EoWG
         8xFo0rO00fnGcQvk6xgEr1XR0Eb2SuR3px62kxn0qO3wirsEV+6Z3k1xQeHHSGyBefkT
         XCh/JXf5LdA6Fm28wsIP/ZyU3TIIeL3s4El5TfPnRWCLs9hqzQxDd4ASNOONCTlvAwjj
         O+5bhiWUZjjh5IDr3gxHYi4By0ozkcxhVAd4XEb0pNOb0jwVAA4jkDT9tRz2ySwSpDRh
         ztCTNz05h+8a1qnlTFikJXdI53/mxENl7zkqxm82PfDbKHQpkLlCPfSX6dvFsvqI2d25
         VrBg==
X-Gm-Message-State: APjAAAXV+A9foDl9kYWbvy0UmURUJ8pzm+fMpGuToic5elsl2Qi2lhOJ
        m4DitXFtXZ3AOao2tKcxtScvirA1SSQ=
X-Google-Smtp-Source: APXvYqx81kyiXAIcPkWHTpdhppO1Dl6t06V6V23N2pmlbTe6QXTtytKanC4vUdVmpwhDn6w9yiW4tg==
X-Received: by 2002:a5d:63c4:: with SMTP id c4mr8848766wrw.307.1553042857481;
        Tue, 19 Mar 2019 17:47:37 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id g3sm442626wmk.32.2019.03.19.17.47.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 17:47:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     balaji marisetti <balajimarisetti@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git command history
References: <CAKcrOwe2ARK4J6YuiXUiVXic=q568VC8JtgWMNs6WEd4hhZs3A@mail.gmail.com>
Date:   Wed, 20 Mar 2019 09:47:35 +0900
In-Reply-To: <CAKcrOwe2ARK4J6YuiXUiVXic=q568VC8JtgWMNs6WEd4hhZs3A@mail.gmail.com>
        (balaji marisetti's message of "Tue, 19 Mar 2019 21:33:34 +0530")
Message-ID: <xmqq1s32xtg8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

balaji marisetti <balajimarisetti@gmail.com> writes:

> Can anyone please tell me if there is way to see the command history
> of a local git repo? If there isn't a way, why hasn't the
> command-history feature been implemented?

Another question may be why anybody would want to have such a per
repository command history, want Git to spend cycles and disk I/O to
store it, and want developers to spend braincycles to think about
it.

Depending on where you come from (i.e. if the interest in such a
history is coming from corporate management and/or big brother side
that wants to learn what its users are doing), I think JeffH's
trace2 effort that allows "telemetry" to be collected may be a
better match than a command history (e.g. "history | grep git").
Without knowing (not that I am all that interested in) what the
motivation of wanting such a thing, it is rather hard to guess,
though ;-).
