Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5EA6207BD
	for <e@80x24.org>; Tue, 25 Apr 2017 09:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428954AbdDYJ53 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 05:57:29 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:32984 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1428951AbdDYJ51 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 05:57:27 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3wBzCT4PGPz1qtXD;
        Tue, 25 Apr 2017 11:57:25 +0200 (CEST)
Received: from localhost (dynscan01.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 3wBzCT2kyHz3hhRr;
        Tue, 25 Apr 2017 11:57:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan01.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id QqTPUr7QKMb0; Tue, 25 Apr 2017 11:57:23 +0200 (CEST)
X-Auth-Info: v0bi8ShhvZTGCWCPXn6ajW3hrg2eSKnPiddrAfbxVhjYV9UiYkAH1kmHld4kX+kw
Received: from igel.home (ppp-88-217-11-229.dynamic.mnet-online.de [88.217.11.229])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 25 Apr 2017 11:57:23 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 52FAB2C3AC5; Tue, 25 Apr 2017 11:57:20 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     git@vger.kernel.org, Jhannes.Schindelin@gmx.de, peff@peff.net
Subject: Re: [PATCH v2] rebase -i: add config to abbreviate command-names
References: <20170424032347.10878-1-liambeguin@gmail.com>
        <20170425043742.15529-1-liambeguin@gmail.com>
X-Yow:  I have a very good DENTAL PLAN.  Thank you.
Date:   Tue, 25 Apr 2017 11:57:20 +0200
In-Reply-To: <20170425043742.15529-1-liambeguin@gmail.com> (Liam Beguin's
        message of "Tue, 25 Apr 2017 00:37:42 -0400")
Message-ID: <87vapsq073.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Apr 25 2017, Liam Beguin <liambeguin@gmail.com> wrote:

> Add the 'rebase.abbrevCmd' boolean config option to allow `git rebase -i`
> to abbreviate the command-names in the instruction list.
>
> This means that `git rebase -i` would print:
>     p deadbee The oneline of this commit
>     ...
>
> instead of:
>     pick deadbee The oneline of this commit
>     ...
>
> Using a single character command-name allows the lines to remain
> aligned, making the whole set more readable.

Perhaps there should rather be an option to tell rebase to align the
columns?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
