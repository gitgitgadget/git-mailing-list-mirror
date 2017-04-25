Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DFA7207BD
	for <e@80x24.org>; Tue, 25 Apr 2017 09:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428943AbdDYJx7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 05:53:59 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:57663 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1428706AbdDYJx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 05:53:57 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3wBz7R37lvz1r55Q;
        Tue, 25 Apr 2017 11:53:55 +0200 (CEST)
Received: from localhost (dynscan01.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 3wBz7R1m8rz3jgYs;
        Tue, 25 Apr 2017 11:53:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan01.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id tzrVmcgUStBn; Tue, 25 Apr 2017 11:53:54 +0200 (CEST)
X-Auth-Info: +yZuaZDWa1pFkdBe5/RKpnkYntaRwTm11kaQjRKvSLmqabp/Ag7BMNhy8rtqouvB
Received: from igel.home (ppp-88-217-11-229.dynamic.mnet-online.de [88.217.11.229])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 25 Apr 2017 11:53:54 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 9F5B42C3AC5; Tue, 25 Apr 2017 11:53:49 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net
Subject: Re: [PATCH v2] rebase -i: add config to abbreviate command-names
References: <20170424032347.10878-1-liambeguin@gmail.com>
        <20170425044320.17840-1-liambeguin@gmail.com>
X-Yow:  I hope the ``Eurythmics'' practice birth control...
Date:   Tue, 25 Apr 2017 11:53:49 +0200
In-Reply-To: <20170425044320.17840-1-liambeguin@gmail.com> (Liam Beguin's
        message of "Tue, 25 Apr 2017 00:43:20 -0400")
Message-ID: <87zif4q0cy.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Apr 25 2017, Liam Beguin <liambeguin@gmail.com> wrote:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 475e874d5155..8b1877f2df91 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2614,6 +2614,25 @@ rebase.instructionFormat::
>  	the instruction list during an interactive rebase.  The format will automatically
>  	have the long commit hash prepended to the format.
>  
> +rebase.abbrevCmd::
> +	If set to true, `git rebase -i` will abbreviate the command-names in the
> +	instruction list. This means that instead of looking like this,
> +
> +-------------------------------------------
> +	pick deadbee The oneline of this commit
> +	pick fa1afe1 The oneline of the next commit
> +	...
> +-------------------------------------------
> +
> +	the list would use the short version of the command resulting in
> +	something like this.
> +
> +-------------------------------------------
> +	p deadbee The oneline of this commit
> +	p fa1afe1 The oneline of the next commit
> +	...
> +-------------------------------------------

That doesn't explain the point of the option.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
