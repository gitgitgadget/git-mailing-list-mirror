Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFB4C1F78F
	for <e@80x24.org>; Sun, 30 Apr 2017 10:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164839AbdD3KVq (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 06:21:46 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:54510 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163688AbdD3KVp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 06:21:45 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3wG3WC3YBmz1qrN1;
        Sun, 30 Apr 2017 12:21:43 +0200 (CEST)
Received: from localhost (dynscan01.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 3wG3WC34WPz3jgXn;
        Sun, 30 Apr 2017 12:21:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan01.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id tFwnnUmmYfaa; Sun, 30 Apr 2017 12:21:42 +0200 (CEST)
X-Auth-Info: i1bCz5pMWPXDQXQBbRt7l5oM1cu3HSm90HQlCm7XyfuWk8UnYTUPPFGWe6kk3PHJ
Received: from igel.home (ppp-88-217-22-0.dynamic.mnet-online.de [88.217.22.0])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 30 Apr 2017 12:21:42 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 1D8822C00E1; Sun, 30 Apr 2017 12:21:42 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Tomi Belan <tomi.belan@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug: wrong documentation for git-fast-import's option command
References: <CACUV5oeKoVdncK3RjtusiqrACj1xLiS--z8vC+Rsvy5TF09Lsw@mail.gmail.com>
X-Yow:  NATHAN...  your PARENTS were in a CARCRASH!!
 They're VOIDED - They COLLAPSED
 They had no CHAINSAWS...  They had no MONEY MACHINES...
 They did PILLS in SKIMPY GRASS SKIRTS...
 Nathan, I EMULATED them...  but they were OFF-KEY...
Date:   Sun, 30 Apr 2017 12:21:42 +0200
In-Reply-To: <CACUV5oeKoVdncK3RjtusiqrACj1xLiS--z8vC+Rsvy5TF09Lsw@mail.gmail.com>
        (Tomi Belan's message of "Sun, 30 Apr 2017 02:07:47 +0200")
Message-ID: <874lx68abt.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Apr 30 2017, Tomi Belan <tomi.belan@gmail.com> wrote:

> The man page of git-fast-import says the syntax is "'option' SP
> <option> LF". But this is wrong, and commands like that will be
> silently ignored.

Unless <option> starts with 'git', as you have seen.  Other importers
may recognize other options, eg 'option hg ...'.

> The correct syntax is e.g. "option git stats" or "option git
> big-file-threshold=123". The docs should say "'option' SP 'git' SP
> <option> LF" or maybe even "'option' SP 'git' SP <option> ('='
> <argument>)? LF" (similarly to the docs for feature), and explain this
> is meant to allow other consumers of the fast import format.
>
> Looks like this bug existed since the option command was added in
> 9c8398f in 2009. Am I the first one who tried to use it? ;-)
>
> Cheers,
>
> Tomi
>

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
