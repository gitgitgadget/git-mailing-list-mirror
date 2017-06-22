Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB81E20401
	for <e@80x24.org>; Thu, 22 Jun 2017 05:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751263AbdFVFkG (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 01:40:06 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:38079 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbdFVFkF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 01:40:05 -0400
Received: by mail-it0-f49.google.com with SMTP id b205so14665541itg.1
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 22:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8kFzxA5ybKdXv5pa6vZQts+GhqJhtoBFuhRvE9x9jow=;
        b=A+vr3MaM3APetIKAXFQbqvNcCaO9UzQkdW8/lR3vx0HgN54RccC009cDBQdZibq33e
         CsFtemaZmYNP74CSsoaI+4V4+ISWuOddjwJLeIHU+jXGSnsQVqoBlApQQvWeE5mBOU/K
         jxmmceFn5azb+XH6Ecivp6SmU7Nr7OxNbfK/iNjjE3wT26vIp73YXFmWLcW0k8MVXSTH
         RdjIhwsHupUfg6oypRz7YxOPpqWPmg6YX5/Nn7J/pkFGTuc3Zl92Jb6N1u0Pzebew6XK
         +Nv09CCUX6F5H7Pcxp90XG5nGPOsFv7ueX+K7pFvFBZAfcrBs44fHJiR0kyXs+P4myv9
         Hd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8kFzxA5ybKdXv5pa6vZQts+GhqJhtoBFuhRvE9x9jow=;
        b=hg2mHvJI5QkrFPd7JRxSXepiC+26tE7LAbjfxJkqfgbnl8FhXcbw+E89smLWn6FBvo
         tYke312AmOoPDzfWbaObR+sXgCPF20qLmtdsVnMZDUj8AmJyg3DNc7uzw6qbYRyMKv+w
         v+2VEfRoEV3CVmfdJkOSPEgahxnUX/PDFBrWqiWa8ivnGowPyPnNPAa0aODagurO9XN3
         SkIqoGj/NEEhnOMLOG4BWARxgkGfovjMIvIMQVFDPpoCDyW/bo3o2B4JBpyKtnsTsvBO
         l8CODJEijOS3r8/ZqRN9HCW0yq9rTJhlG0WYmS8TR/5W7X9Fgbb6XdSt36Vi9XiF+7DM
         i3XQ==
X-Gm-Message-State: AKS2vOwXNPKg7D5LqjFtrmzBRQFsTHo1poJtWgy4bmES8D0K6sOv0yVr
        ZbZmeW8hy7cKJzXoC/zakDYEEgUbDg==
X-Received: by 10.36.13.16 with SMTP id 16mr382607itx.22.1498110004499; Wed,
 21 Jun 2017 22:40:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.72.66 with HTTP; Wed, 21 Jun 2017 22:39:23 -0700 (PDT)
In-Reply-To: <1498072442.32360.20.camel@gmail.com>
References: <1498070489.32360.14.camel@gmail.com> <20170621185518.nhnqlkbt63hdoate@sigill.intra.peff.net>
 <1498072442.32360.20.camel@gmail.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Thu, 22 Jun 2017 01:39:23 -0400
Message-ID: <CAJZjrdXYqmQuxrCuayy2zcwPkR5Gq56caurR+jO107MFrGspBA@mail.gmail.com>
Subject: Re: Using '--help' for aliases
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You could also just make the alias a bash function that does git help
checkout when you pass the --help flag to the alias.
