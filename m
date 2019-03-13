Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA3EA20248
	for <e@80x24.org>; Wed, 13 Mar 2019 18:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfCMSMb (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 14:12:31 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:50364 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfCMSMa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 14:12:30 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 44KKgc2SwDz1rGj6;
        Wed, 13 Mar 2019 19:12:28 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 44KKgc17XLz1qr5S;
        Wed, 13 Mar 2019 19:12:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 684U9accU4Z9; Wed, 13 Mar 2019 19:12:25 +0100 (CET)
X-Auth-Info: MPR3m3gUWm1EGMM3YEVkrZsAlj8uN5plA91/Py/EqPvImi6vZ/uxX73MOc6IMq6Z
Received: from igel.home (ppp-46-244-180-192.dynamic.mnet-online.de [46.244.180.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 13 Mar 2019 19:12:25 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 2E66B2C1420; Wed, 13 Mar 2019 19:12:25 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.org>,
        Elijah Newren <newren@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        vincent.guittot@linaro.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: Deprecating git diff ..; dealing with other ranges
References: <20190311093751.GA31092@archbookpro.localdomain>
        <xmqqmum0h88n.fsf@gitster-ct.c.googlers.com>
        <87va0orop4.fsf@igel.home>
        <CACsJy8DaTE3fbLZCbwW6XY4Z_2OjczOZROYiWsMPQrni_ybhZg@mail.gmail.com>
X-Yow:  Hmmm..  A hash-singer and a cross-eyed guy were SLEEPING on a deserted
 island, when...
Date:   Wed, 13 Mar 2019 19:12:25 +0100
In-Reply-To: <CACsJy8DaTE3fbLZCbwW6XY4Z_2OjczOZROYiWsMPQrni_ybhZg@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 13 Mar 2019 08:20:34 +0700")
Message-ID: <87wol28wza.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mär 13 2019, Duy Nguyen <pclouds@gmail.com> wrote:

> A..B from fetch is the same as branch@{1}..branch. If we have some
> shortcut similar to ^! but for reflog, that would be perfect (the
> branch part does not require much typing with tab completion).

Tab completion is much slower than c&p, especially if the completion is
ambigous.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
