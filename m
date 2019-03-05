Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BDBD20248
	for <e@80x24.org>; Tue,  5 Mar 2019 12:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbfCEMoq (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 07:44:46 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35326 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbfCEMoq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 07:44:46 -0500
Received: by mail-wr1-f66.google.com with SMTP id t18so9317235wrx.2
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 04:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nee8QIvMQcWKWQgFxnmMVUAzNFxoLUE7hbD6LVUlmLw=;
        b=TJbZQnFTUbQ+P3mzW3E2qtT8me+/TO8OUAjOpZY8AO/5mx+h0/IiWxf8yyxOzAgK9f
         0w78ZtpupwnD/BE50NoM9UF86qdzLqMvNiCNyLmJjFf596oJWDoae6NpjHpaojFfDebI
         IR9lQyA2gUX7aw3LYZw0BZU8mKAtvzcKfkVI6Qo3z3TvNn/sX+VRsFzfxdTw8RgeOJVB
         rAc3Da/DCvSULPAeTSpTIyFdH0elyApfaKK6Yi2Xmq3r2CP45T/Q0ACT3o7u846oB+tr
         Wu1r1Il2E6iT5KDuKqlbPWaWiz9swGs7BMg+WJq/x75v5zi3zwwcGHD1qOpifgin0Hxp
         MltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nee8QIvMQcWKWQgFxnmMVUAzNFxoLUE7hbD6LVUlmLw=;
        b=LQl9r5+j+p1jScOFq7wG+urUwgrNGbNk8Hh8+BmHOgV62YTsKZO9Lrcl0ZBrS9+CwV
         JgnSjva3bPmIL1WfS8NBOW/YaJhNgiafPL+jgkZPnBlRsgY7CjbacvN4ud9GE7Rho1WG
         rRKcjJ6GRYhx5uwwDwhTY8kkGZeZvCmFkLA3ArdLNT8TKwFRJEKVxZmalJZcIhJ4LYoF
         8wtXNebHXDanaf/TTSKf4hSZaRRSS2p4S896k6+E587OuVNkTd91dE8hq6jcc7sXk/5w
         hHGqc5la1uVXE4Rk+mK9Z0wNAw5XErW66diLwFr7xG5qs5yw21sCsYubgZjW3g7tfZ1s
         CPFg==
X-Gm-Message-State: APjAAAViWpoL9zdkXXQ0SvVwpYOl3QOxVxuJIzIKPx8B61L4Cksn8jo4
        Z0oP/uT2MqVlNoLZhn4+GjA=
X-Google-Smtp-Source: APXvYqzJXhoy29mRmg8HTSdxxeWP+U74AJmrjIbPAS5y8KXvSr1XcDNDM1fcStY2eg9wMotYkpNRyg==
X-Received: by 2002:adf:ec10:: with SMTP id x16mr16417848wrn.171.1551789884393;
        Tue, 05 Mar 2019 04:44:44 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x74sm10545925wmf.22.2019.03.05.04.44.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 04:44:43 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [GSoC][PATCH v3 2/3] t3600: modernize style
References: <20190303122842.30380-1-rohit.ashiwal265@gmail.com>
        <20190304120801.28763-1-rohit.ashiwal265@gmail.com>
        <20190304120801.28763-3-rohit.ashiwal265@gmail.com>
        <CAPig+cQ=Uoa3G0mvJ6MGfEM=W6bpghS-+Ub32UtmdoC0OAZD7w@mail.gmail.com>
Date:   Tue, 05 Mar 2019 21:44:43 +0900
In-Reply-To: <CAPig+cQ=Uoa3G0mvJ6MGfEM=W6bpghS-+Ub32UtmdoC0OAZD7w@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 4 Mar 2019 19:36:48 -0500")
Message-ID: <xmqqimwxv6bo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> This test is unusual in that it first cd's into a subdirectory and
> then cd's back out with "cd ..". And, while the use of subshells is
> correct to ensure that all 'cd' commands are undone at the end of the
> test (whether successful or not), the entire construction is
> unnecessarily confusing. This is not the sort of issue which should be
> fixed in this style-fix patch, however, it is something which could be
> cleaned up with a follow-up patch. For instance, the test might be
> reworked like this:
>
>     git init repo &&
>     (
>         cd repo &&
>         echo something >somefile &&
>         git add somefile &&
>         git commit -m "add a file"
>     ) &&
>     git --git-dir=repo/.git --work-tree=repo rm somefile &&
>     test_must_fail git -C repo ls-files --error-unmatch somefile
>
> It's up to you whether you actually want to include such a follow-up
> patch in your series; it's certainly not a requirement.

I missed that.  As you said, it can be left for further clean-up.
