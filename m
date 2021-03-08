Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DABAC433DB
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 20:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C2C26527A
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 20:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhCHUOr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 15:14:47 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:43461 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbhCHUOh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 15:14:37 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4DvV1R2ScRz1qs0n;
        Mon,  8 Mar 2021 21:14:35 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4DvV1R213Gz1r1MQ;
        Mon,  8 Mar 2021 21:14:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id cDTdB3vQLxfZ; Mon,  8 Mar 2021 21:14:34 +0100 (CET)
X-Auth-Info: lUMbrykPI4rsFfhIgPa7mLq1EH1g8U6dNggkotosUHiRGhv3mihfWybn5ocKBa71
Received: from igel.home (ppp-46-244-182-153.dynamic.mnet-online.de [46.244.182.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon,  8 Mar 2021 21:14:34 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 092652C37BA; Mon,  8 Mar 2021 21:14:34 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Fabien Terrani <terranifabien@gmail.com>, git@vger.kernel.org
Subject: Re: remote.<name>.merge missing from the git-config man page?
References: <CAOuwed4HJLTgk48Fre5vGYjYanqD6hu8yZM73CpcAmF1ajiTnA@mail.gmail.com>
        <xmqqlfax7dya.fsf@gitster.c.googlers.com>
        <YEZwY0721KvQNkK+@nand.local>
X-Yow:  Yow!  Is my fallout shelter termite proof?
Date:   Mon, 08 Mar 2021 21:14:33 +0100
In-Reply-To: <YEZwY0721KvQNkK+@nand.local> (Taylor Blau's message of "Mon, 8
        Mar 2021 13:43:47 -0500")
Message-ID: <87pn092yja.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mär 08 2021, Taylor Blau wrote:

> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index ab103c82cf..a953c7c387 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -600,7 +600,7 @@ EXAMPLES
>
>  `git push origin`::
>  	Without additional configuration, pushes the current branch to
> -	the configured upstream (`remote.origin.merge` configuration
> +	the configured upstream (`branch.<name>.merge` configuration
>  	variable) if it has the same name as the current branch, and
>  	errors out without pushing otherwise.

That doesn't say what <name> is.  Is that supposed to be <branch>?
Also, what is "it" referring to in "if it has the same name"?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
