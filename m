Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EC02208E9
	for <e@80x24.org>; Sun, 29 Jul 2018 21:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbeG2XMm (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 19:12:42 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:59349 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730476AbeG2XMm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jul 2018 19:12:42 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 41dx2g4lTTz1qvBl;
        Sun, 29 Jul 2018 23:40:43 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 41dx2g3wRtz1qqkP;
        Sun, 29 Jul 2018 23:40:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id ksyj05PyaK2t; Sun, 29 Jul 2018 23:40:42 +0200 (CEST)
X-Auth-Info: v3wvRX0cZBReF06ZNB7zPl6nvqovhRknxvo+EyrugGmTcrYkVG2qOGE6S8ecT3BW
Received: from igel.home (ppp-188-174-147-237.dynamic.mnet-online.de [188.174.147.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 29 Jul 2018 23:40:42 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id E62B12C126A; Sun, 29 Jul 2018 23:40:41 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Michael <aixtools@felt.demon.nl>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: git broken for AIX somewhere between 2.13.2 and 2.13.3
References: <fb935882-25b1-db5f-d765-50dab297f733@felt.demon.nl>
        <20180729181006.GC945730@genre.crustytoothpaste.net>
        <466c7a59-0535-e72c-6c90-5288a53b59a0@felt.demon.nl>
        <87zhy9u7rz.fsf@evledraar.gmail.com>
X-Yow:  Are you guys lined up for the METHADONE PROGRAM or FOOD STAMPS??
Date:   Sun, 29 Jul 2018 23:40:41 +0200
In-Reply-To: <87zhy9u7rz.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sun, 29 Jul 2018 22:05:52 +0200")
Message-ID: <87in4x4t5y.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jul 29 2018, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:

> Also, to you and anyone else with access to AIX: I'd be happy to figure
> these issues out pro-actively if you give me a login to an AIX
> machine. I promise not to do anything except compile/debug/test git on
> it.

The GCC compile farm <http://gcc.gnu.org/wiki/CompileFarm> has a machine
running AIX, and is free to use for anyone working on free software.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
