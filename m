Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F43DC48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 11:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 614266145E
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 11:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhFOL5Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 07:57:16 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:49838 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhFOL5P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 07:57:15 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4G46FT0hG4z1qtPr;
        Tue, 15 Jun 2021 13:55:08 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4G46FS6Fb3z1qrk3;
        Tue, 15 Jun 2021 13:55:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 74D3NW0gaK6E; Tue, 15 Jun 2021 13:55:08 +0200 (CEST)
X-Auth-Info: ZeHCIxJbFSXm95ETgLhV7NqB2XpftybteFAp9MbDwXoS8BluPj3Y2Eh08aw13bRF
Received: from igel.home (ppp-46-244-165-152.dynamic.mnet-online.de [46.244.165.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 15 Jun 2021 13:55:08 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id B3A222C3652; Tue, 15 Jun 2021 13:55:07 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     it-developer@abelardolg.com
Cc:     git@vger.kernel.org
Subject: Re: A suggestion: more readable human commands
References: <fa2e886dd03a26c945d9deffe6f96d48@abelardolg.com>
X-Yow:  All of life is a blur of Republicans and meat!
Date:   Tue, 15 Jun 2021 13:55:07 +0200
In-Reply-To: <fa2e886dd03a26c945d9deffe6f96d48@abelardolg.com>
        (it-developer@abelardolg.com's message of "Tue, 15 Jun 2021 12:51:36
        +0200")
Message-ID: <87o8c7wdes.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jun 15 2021, it-developer@abelardolg.com wrote:

> To merge a single file from one branch to another:
>
> git checkout <branch_name> <path_to_file> --patch
>
> would be like more readable human like this:
>
> git merge <path_file> to <dst_branch>

This is ambigous if a branch or tag named <path_file> or to exists, and
the usual disambiguation using -- will not work.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
