Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24501C433DF
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 10:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF61C2067D
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 10:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbgGAKU7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:20:59 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:37295 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729683AbgGAKUT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 06:20:19 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 49xcfy31hFz1rwbQ;
        Wed,  1 Jul 2020 12:20:10 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 49xcfy2gf6z1qqkC;
        Wed,  1 Jul 2020 12:20:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Hnn4V0WTSDrl; Wed,  1 Jul 2020 12:20:09 +0200 (CEST)
X-Auth-Info: S9l1tOqHiY0y6yL0uTvdBetqnhaqMGIpk+QhaKLIve4NG7WwBh4nUALaF+7co8wp
Received: from igel.home (ppp-46-244-162-239.dynamic.mnet-online.de [46.244.162.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed,  1 Jul 2020 12:20:09 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 3F72E2C111E; Wed,  1 Jul 2020 12:20:09 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Why won't git checkout a branch?
References: <CAH8yC8m1=0n8zzoW--g_XLebJFqFSXpBpTr+1S58z7snLTt-0Q@mail.gmail.com>
        <87tuyrd0ng.fsf@igel.home>
        <CAH8yC8kxY5mV0p-98W0uDN7PLxmNR4LkNcz9vbKsq21aTd-qQg@mail.gmail.com>
X-Yow:  YOW!!
Date:   Wed, 01 Jul 2020 12:20:09 +0200
In-Reply-To: <CAH8yC8kxY5mV0p-98W0uDN7PLxmNR4LkNcz9vbKsq21aTd-qQg@mail.gmail.com>
        (Jeffrey Walton's message of "Wed, 1 Jul 2020 06:09:10 -0400")
Message-ID: <87lfk3czae.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jul 01 2020, Jeffrey Walton wrote:

> On Wed, Jul 1, 2020 at 5:50 AM Andreas Schwab <schwab@linux-m68k.org> wrote:
>>
>> On Jul 01 2020, Jeffrey Walton wrote:
>>
>> > $ git checkout m4
>>
>> Try a newer git version:
>>
>> $ git checkout m4
>> fatal: 'm4' could be both a local file and a tracking branch.
>> Please use -- (and optionally --no-guess) to disambiguate
>
> Ack, thanks.
>
> This does not look normal, either. I don't want to create a new
> branch. I want to work on the existing branch.

To disambiguate, use `git checkout m4 --' if you want the branch, and
`git checkout -- m4' if you want the local file.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
