Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46F811F462
	for <e@80x24.org>; Fri, 24 May 2019 17:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731771AbfEXRLD (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 13:11:03 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:53881 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfEXRLD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 13:11:03 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 459XvT0lpvz1rj63;
        Fri, 24 May 2019 19:11:01 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 459XvT0RKlz1sRyX;
        Fri, 24 May 2019 19:11:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Yovx161_uHyo; Fri, 24 May 2019 19:11:00 +0200 (CEST)
X-Auth-Info: HjBobFINY7XO/9iicv9m1fj8ra83wUKQYUrbN03L5eLpLZEMFTJXpRDI2iytKTTR
Received: from igel.home (ppp-46-244-184-31.dynamic.mnet-online.de [46.244.184.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 24 May 2019 19:11:00 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id CA1D92C11BA; Fri, 24 May 2019 19:10:59 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: Need help merging unrelated histories
References: <CAHd499AidrL4jCG_WytPJF9yHfJJJvWJ5fpjKN6sGBY5Weu8Hg@mail.gmail.com>
X-Yow:  ANN JILLIAN'S HAIR makes LONI ANDERSON'S HAIR look like
 RICARDO MONTALBAN'S HAIR!
Date:   Fri, 24 May 2019 19:10:59 +0200
In-Reply-To: <CAHd499AidrL4jCG_WytPJF9yHfJJJvWJ5fpjKN6sGBY5Weu8Hg@mail.gmail.com>
        (Robert Dailey's message of "Fri, 24 May 2019 09:04:57 -0500")
Message-ID: <87ftp3lqvw.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mai 24 2019, Robert Dailey <rcdailey.lists@gmail.com> wrote:

> Can anyone provide some advice on how to properly restructure this
> repository to create some ancestry, as if all along a `master` existed
> and all release branches were based on this in a linear fashion?

How about using git replace --graft, then git filter-branch to make it
permanent?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
