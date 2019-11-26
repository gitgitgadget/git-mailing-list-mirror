Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015CEC432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 23:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD5892068E
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 23:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfKZXLw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 18:11:52 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:54423 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfKZXLw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 18:11:52 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 47N05y5NHvz1qql1;
        Wed, 27 Nov 2019 00:11:50 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 47N05y4L6hz1qql9;
        Wed, 27 Nov 2019 00:11:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id dihEyQki-Hlh; Wed, 27 Nov 2019 00:11:49 +0100 (CET)
X-Auth-Info: EjLyxoKqyHKxqBMyvAxMZqWScMNKL4m3uuRd0zgQRQWlJbD41CFpBqkP5viV8HDV
Received: from igel.home (ppp-46-244-161-164.dynamic.mnet-online.de [46.244.161.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 27 Nov 2019 00:11:49 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 452782C0F12; Wed, 27 Nov 2019 00:11:49 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH] t7812: add missing redirects
References: <20190724151415.3698-1-avarab@gmail.com>
        <20190726150818.6373-7-avarab@gmail.com> <87blsyl32c.fsf_-_@igel.home>
        <nycvar.QRO.7.76.6.1911262325390.31080@tvgsbejvaqbjf.bet>
X-Yow:  Today, THREE WINOS from DETROIT sold me a framed photo of
 TAB HUNTER before his MAKEOVER!
Date:   Wed, 27 Nov 2019 00:11:49 +0100
In-Reply-To: <nycvar.QRO.7.76.6.1911262325390.31080@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Tue, 26 Nov 2019 23:27:03 +0100
        (CET)")
Message-ID: <874kyqkzbe.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Nov 26 2019, Johannes Schindelin wrote:

> footer, and the commit reference is not in the recommended format either
> because it lacks the date),

Where is that documented?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
