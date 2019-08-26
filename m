Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 051E51F461
	for <e@80x24.org>; Mon, 26 Aug 2019 17:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732909AbfHZRJI (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 13:09:08 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:49978 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729338AbfHZRJH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 13:09:07 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 46HJPs3jfNz1rcPg;
        Mon, 26 Aug 2019 19:09:05 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 46HJPs3Ny7z1qqkc;
        Mon, 26 Aug 2019 19:09:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id HzEtFqCv1J5K; Mon, 26 Aug 2019 19:09:04 +0200 (CEST)
X-Auth-Info: w/79tRfRC1BQJLReS9ZGbILHvhWW/+24SUwL484Qe1B6S8YKMSXH5JuxDU02sOpZ
Received: from igel.home (ppp-46-244-173-1.dynamic.mnet-online.de [46.244.173.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 26 Aug 2019 19:09:04 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 181BC2C0102; Mon, 26 Aug 2019 19:09:04 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Dhaval Patel <drdhaval2785@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git diff autocomplete
References: <CADSGPzV+dfNR=epmz2whKkrpiH=JMUR4gVjpZ+x+kzKrX0kD-A@mail.gmail.com>
        <20190818024757.765fx3tdfekseim5@LykOS.localdomain>
        <CADSGPzU6+AdMtrEnc98SHASmcmxGsj52Y99Dd5zvkOeRqWS-jQ@mail.gmail.com>
        <CADSGPzVgweL4tCEqg3LvfXbp=HZyQ7BngKpVrFp0_0SFJZVezQ@mail.gmail.com>
X-Yow:  Ask me the DIFFERENCE between PHIL SILVERS and ALEXANDER HAIG!!
Date:   Mon, 26 Aug 2019 19:09:04 +0200
In-Reply-To: <CADSGPzVgweL4tCEqg3LvfXbp=HZyQ7BngKpVrFp0_0SFJZVezQ@mail.gmail.com>
        (Dhaval Patel's message of "Mon, 26 Aug 2019 21:18:12 +0530")
Message-ID: <87mufvzwen.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Aug 26 2019, Dhaval Patel <drdhaval2785@gmail.com> wrote:

> If it is only about files and revisions both being handled by git
> diff, would it not ne possible to do something like this?
>
> For files
>
> git diff -f a[PRESS TAB]
>
> For revisions
>
> git diff -r a[PRESS TAB]
>
> Some sort of flag which says we are handling files or revisions.

That already exists, it is spelt `--'.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
