Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB28C211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 19:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbeLDTjK (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 14:39:10 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:39153 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbeLDTjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 14:39:09 -0500
Received: by mail-wm1-f49.google.com with SMTP id f81so8115855wmd.4;
        Tue, 04 Dec 2018 11:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=iQwytpxIBcHHKVFu2QLF4iY+Mv1AFxWbqR3YYwAHeXw=;
        b=UQTiXPyHek7sm0ubUN3JzYhwpasskZeBGhPpdrJZzi0gsPoyMA02DBEy1MH/TvdVjY
         ATV1hc0L7wm5zP0wZfVXB2CFUHu1sOuGXfF3NiPzDZmlmZieeuQuVHDYldWAoH6kqONk
         VYZOw4+nkncUomoW7Sv35a/mXfz7bWsmzMLHwAVfOIejloakEmMz+Q4zILgq41MzZhfy
         KVg5tFSdGe2BXGjQmr7xH4fmCoMNqnb5ZM1UC27NNVGzBxdNZf37SiVJahNxAJHCgqHg
         oq/KSFLdh/KHcVcnyErHYlGTQaeq/LkyvONEMKG9A0Uz5DN4FCLQ8FrlEFfxJAShd+Ei
         StiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=iQwytpxIBcHHKVFu2QLF4iY+Mv1AFxWbqR3YYwAHeXw=;
        b=A5VP+xNIrlc/RdCuuXdnPH4ec/sbT77Czl97AO2cT01UwKhN3fzGO78f3Z530GzWhp
         5tdUDp3bFYhvsQhqVVPliWhE8IJS2mzxb15aJakGC5fl8tnG+aLtd3YN1w1KUlPmGvij
         XJkOO6xMsJweYEDR1ASPFhngeHGmek7e89tbePVfN0s4mFCCT6YiE08vhCzW8mwvdSEq
         9ZInh+k+PjSb0z4HPQz6a8LG4M5USPsZ1kwulOV7KU0UJoDZjWgHF4XKd8Y1BDxfq3g6
         RVweGIQWXVxABXkmoK6jP8/T2Qyd2DIBOYyPygwyVhKGkZ7YnE3hON/QDmFLdVdBIX9w
         jV+g==
X-Gm-Message-State: AA+aEWa9elI16n4EuBuGzQTDjvk9lD66ZGm2GjYNv2uozjoDS02KJo7f
        P7ml2L7vVRWoC2Wd99NWl/CCcHTh
X-Google-Smtp-Source: AFSGD/V5BGFIklEw+LjuOX84Jkv7sse5eU1+QSRpbbZkSZfbyuucytNKz0aa3lGmQ+Qa/iHr8VsCdg==
X-Received: by 2002:a1c:f112:: with SMTP id p18mr12676162wmh.83.1543952348138;
        Tue, 04 Dec 2018 11:39:08 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id 5sm13089590wmr.37.2018.12.04.11.39.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 11:39:07 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] Git v2.20.0-rc2
References: <xmqq36rhjnts.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqq36rhjnts.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 04 Dec 2018 20:39:05 +0100
Message-ID: <87in09ytd2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Dec 01 2018, Junio C Hamano wrote:

>  * "git ls-remote $there foo" was broken by recent update for the
>    protocol v2 and stopped showing refs that match 'foo' that are not
>    refs/{heads,tags}/foo, which has been fixed.
>    (merge 6a139cdd74 jk/proto-v2-ref-prefix-fix later to maint).

I started bisecting this thinking it was a regression, but found that
the reason the instructions in the protocol v2 announcement[1] don't
work anymore is because of it was due to 631f0f8c4b ("ls-remote: do not
send ref prefixes for patterns", 2018-10-31).

Perhaps we should note this more prominently, and since Brandon isn't at
Google anymore can some of you working there edit this post? It's the
first Google result for "git protocol v2", so it's going to be quite
confusing for people if after 2.20 the instructions in it no longer
work.

1. https://opensource.googleblog.com/2018/05/introducing-git-protocol-version-2.html
