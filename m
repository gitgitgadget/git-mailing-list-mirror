Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF3B5211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 15:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbeLEPnF (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 10:43:05 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:45307 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbeLEPnF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 10:43:05 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 43930R5W0Sz1qyC5;
        Wed,  5 Dec 2018 16:43:03 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 43930R4Jn3z1qsJg;
        Wed,  5 Dec 2018 16:43:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id d7guflDWDn0H; Wed,  5 Dec 2018 16:43:02 +0100 (CET)
X-Auth-Info: G0ThH9LIikF/VBpxcuIwb36VqzyozHgPquHbGmMZrsaGg3jEcHfZxEhJatWkZvrL
Received: from igel.home (ppp-188-174-150-181.dynamic.mnet-online.de [188.174.150.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed,  5 Dec 2018 16:43:02 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 58F0A2C11F1; Wed,  5 Dec 2018 16:43:02 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Elijah Newren <newren@gmail.com>
Cc:     kostix@bswap.ru, hi-angel@yandex.ru,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Any way to make git-log to enumerate commits?
References: <5e5c6d1c-6b3e-c94a-17be-a2af518c1607@yandex.ru>
        <20181205145419.vbbaghzzrnceez45@tigra>
        <CABPp-BHhYgBndaOjTC9-YQ5gNJXqaw21Hf=FZzyA7AKDQvN+0A@mail.gmail.com>
X-Yow:  Now I'm having INSIPID THOUGHTS about the beautiful, round
 wives of HOLLYWOOD MOVIE MOGULS encased in PLEXIGLASS CARS
 and being approached by SMALL BOYS selling FRUIT..
Date:   Wed, 05 Dec 2018 16:43:02 +0100
In-Reply-To: <CABPp-BHhYgBndaOjTC9-YQ5gNJXqaw21Hf=FZzyA7AKDQvN+0A@mail.gmail.com>
        (Elijah Newren's message of "Wed, 5 Dec 2018 07:31:45 -0800")
Message-ID: <87sgzcyo6x.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Dez 05 2018, Elijah Newren <newren@gmail.com> wrote:

> Or, just use name-rev so it works with non-linear histories too:
>
> git log | git name-rev --refs=$(git symbolic-ref HEAD) --stdin | less

That wouldn't work for a detached HEAD, though, and you need to use
--no-abbrev.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
