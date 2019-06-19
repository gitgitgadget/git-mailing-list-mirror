Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 070B71F462
	for <e@80x24.org>; Wed, 19 Jun 2019 17:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfFSRY0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 13:24:26 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:54302 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfFSRY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 13:24:26 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45TWyw3TxPz5tlD;
        Wed, 19 Jun 2019 19:24:24 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id DB515208D;
        Wed, 19 Jun 2019 19:24:23 +0200 (CEST)
Subject: Re: [PATCH 02/17] t0001 (mingw): do not expect a specific order of
 stdout/stderr
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.149.git.gitgitgadget@gmail.com>
 <d551cdeafbf2953ba340aa16554fbd5ac6194a6e.1560860634.git.gitgitgadget@gmail.com>
 <CAPig+cQaoRBnH0JrUwXTo1hSwjrZ1vJHewjCAkKPeCrRwo=P2w@mail.gmail.com>
 <40cfbb30-c632-54da-62d9-9b31bc878806@kdbg.org>
 <CAPig+cTTAgYia6DUOrg7AuLmGSbqn5u=iy3wx-=--NJuyULwaQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.1906191325130.44@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1906191329040.44@tvgsbejvaqbjf.bet>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <0841b134-0719-8bda-41ec-abd124157df6@kdbg.org>
Date:   Wed, 19 Jun 2019 19:24:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1906191329040.44@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.06.19 um 13:30 schrieb Johannes Schindelin:
> Interesting side note: I just realized that t6050-replace.sh does indeed
> contain
> 
> 	test_i18ngrep "Needed a single revision" err
> 
> so I wonder why that works.

Why should it not work? If GIT_TEST_GETTEXT_POISON is on, it pretends
success; otherwise, it does a regular grep.

-- Hannes
