Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28F8820248
	for <e@80x24.org>; Wed, 27 Mar 2019 18:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389521AbfC0Szq (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 14:55:46 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:45198 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389650AbfC0Szp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 14:55:45 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 44Txz31PKSz1qvvr;
        Wed, 27 Mar 2019 19:55:43 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 44Txz30xdsz1qsx0;
        Wed, 27 Mar 2019 19:55:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 0FEfZ-pmM6nF; Wed, 27 Mar 2019 19:55:41 +0100 (CET)
X-Auth-Info: zXpmlfB240t8eHPHOXCtVMGwHrOyhAB1K2kPAwy9w0kGIZXdBQUUHW8dsG+IWLfY
Received: from igel.home (ppp-46-244-175-98.dynamic.mnet-online.de [46.244.175.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 27 Mar 2019 19:55:41 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 26A052C12D4; Wed, 27 Mar 2019 19:55:41 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Petr Bena <petr@bena.rocks>
Cc:     git@vger.kernel.org
Subject: Re: Unable to change remote url of origin
References: <7b30ebfd-4f85-0fa7-8e66-7e63d7cb52d9@bena.rocks>
X-Yow:  I want to kill everyone here with a cute colorful Hydrogen Bomb!!
Date:   Wed, 27 Mar 2019 19:55:41 +0100
In-Reply-To: <7b30ebfd-4f85-0fa7-8e66-7e63d7cb52d9@bena.rocks> (Petr Bena's
        message of "Wed, 27 Mar 2019 13:25:27 +0100")
Message-ID: <87ef6sb102.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mär 27 2019, Petr Bena <petr@bena.rocks> wrote:

> # Display remote URL
>
> petr.bena@MacBook:~/Documents/grumpy$ git remote -v
> origin    git@github.com:grumpy-irc/grumpy (fetch)
> origin    git@github.com:grumpy-irc/grumpy (push)
>
> #Now change it to HTTPS instead of SSH
>
> petr.bena@MacBook:~/Documents/grumpy$ git remote set-url origin
> https://github.com/grumpy-irc/grumpy
>
> # Verify if it has changed
>
> petr.bena@MacBook:~/Documents/grumpy$ git remote -v
> origin    git@github.com:grumpy-irc/grumpy (fetch)
> origin    git@github.com:grumpy-irc/grumpy (push)
>
>
> It's still SSH. What am I doing wrong?

Do you have a URL rewrite rule (url.*.insteadof)?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
