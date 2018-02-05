Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E402E1F404
	for <e@80x24.org>; Mon,  5 Feb 2018 22:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbeBEWDR (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 17:03:17 -0500
Received: from mail-yw0-f179.google.com ([209.85.161.179]:41932 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752181AbeBEWDO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 17:03:14 -0500
Received: by mail-yw0-f179.google.com with SMTP id b129so19513913ywa.8
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 14:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=r04cLFFOm1NJSwSlM5gqIk7inck5f7P2JL8pD8PrBbo=;
        b=s1zt8NEy8zCHlRcFUyTgKkNxU492KLMn9eFxtmVDy8B/8cc1zQnLXqNpYNHVy0x50+
         8JX8FaqAys5LEM4QmpSUa8+ePsY0pjw7KLwbKpSqNqk7Tq8eL3RKuKLNhdTwmsubrEd4
         f/DF2U4CRpPAA+ZvZqWCpsKPt5nqj9GhriHhMdGGLWGLM4+OpCt1PiPEQFtZPC8RaxvO
         lDXfKQlmqiUSx0iqlXDHN0+dfag8Hnl+LGNaW//2yf58pQ9c/pfMCDQ5WdTpawHLWpzU
         sqOP/v+wQzDBxP3OyH1d+CtwjKS06IFTK5cojdeyA8kDxqPjKL1PmMCqQ/qQxOW071my
         MVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=r04cLFFOm1NJSwSlM5gqIk7inck5f7P2JL8pD8PrBbo=;
        b=Apc4uwEnYxyra9gpV5L7kUPoxsBowIFrfxW9HAPwiMhgQ9g3Zjp468cno4C6bZYl5i
         0CTF0/rSids3TvpHJUsAIpTM1E34R38VlHGpLMQMt2kO/kB0hZZ7gg3qCl1owIOpv3uj
         Vh8oCoS+5HnvaRifsq/OwHbw/F7Vr6foy+j7MGuF7JFaP4UXxKbdpKtrDrNxG1eJZl7a
         zGqFkt+S4Xzy1pToqWXie9JrsbXE6LPZVFO0qkSCbx10+xZ5kk5bim987ws3bah+yABb
         yIWXhJQKHEuvZaxQZGPku1w2EdcbvTaZBDt1S67X6RVlW14+uOpI1f8JrkJ8YQCTlY0+
         g/AQ==
X-Gm-Message-State: APf1xPDZUkDbnxTy3hE8NZIrxm3B4yeD2zsoBTTO+2oGdroyhCB1uFn8
        zvUpX92qF7NcaXCa6nnXQFFh23V8W4+MTv881X7UCg==
X-Google-Smtp-Source: AH8x227TVkv17BtR3/54rAkrfSj8jHjQqkFhe01kxz3lLxNQ7v12VczRTfQLQnF2Sz6VH3YDmcCjiv/nNRmhIbIhlmI=
X-Received: by 10.129.108.149 with SMTP id h143mr157507ywc.373.1517868193733;
 Mon, 05 Feb 2018 14:03:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Mon, 5 Feb 2018 14:03:12 -0800 (PST)
In-Reply-To: <87wozry7z4.fsf@javad.com>
References: <87wozry7z4.fsf@javad.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 5 Feb 2018 14:03:12 -0800
Message-ID: <CAGZ79kZ5ZiETM7L6DRr1pSXMGBPPyOazsM8Gi0E9jrMYfwrfdA@mail.gmail.com>
Subject: Re: cherry-pick '-m' curiosity
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 5, 2018 at 3:46 AM, Sergey Organov <sorganov@gmail.com> wrote:
> Hello,
>
> $ git help cherry-pick
>
> -m parent-number, --mainline parent-number
>            Usually you cannot cherry-pick a merge because you do not
>            know which side of the merge should be considered the
>            mainline.
>
> Isn't it always the case that "mainline" is the first parent, as that's
> how "git merge" happens to work?
>
> Is, say, "-m 2" ever useful?

Say you want to backport everything except that topic using cherry-picks.
Then -m2 would be useful?
