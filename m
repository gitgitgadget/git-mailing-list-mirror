Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 288A4202AE
	for <e@80x24.org>; Sun,  9 Jul 2017 12:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752255AbdGIMhx (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jul 2017 08:37:53 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:41013 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752146AbdGIMhv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2017 08:37:51 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3x57Cr4MrQz1qsCM;
        Sun,  9 Jul 2017 14:37:43 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 3x57Cq3Hpqz3jgY8;
        Sun,  9 Jul 2017 14:37:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id v3oseHbP-qoD; Sun,  9 Jul 2017 14:37:42 +0200 (CEST)
X-Auth-Info: TlYODJWjDxJ7TXcso5n263uttgD88EYnUFEnw67DeQHdzfCwoM0nwvzyWbd36/zD
Received: from igel.home (ppp-88-217-2-240.dynamic.mnet-online.de [88.217.2.240])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun,  9 Jul 2017 14:37:42 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id C4DCB2C38AB; Sun,  9 Jul 2017 14:37:41 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: use strcmp(3) for comparing strings in gitdiff_verify_name()
References: <d1bb978b-a7df-48a8-15c8-80730c77e11c@web.de>
        <87tw2ngp94.fsf@linux-m68k.org>
        <e46a7de9-3e0e-4eeb-c9a3-a8b5f22620b4@web.de>
        <87o9svgia8.fsf@linux-m68k.org>
        <df3bd047-6ddd-c120-54dd-4165d2257bb0@web.de>
X-Yow:  UH-OH!!  We're out of AUTOMOBILE PARTS and RUBBER GOODS!
Date:   Sun, 09 Jul 2017 14:37:41 +0200
In-Reply-To: <df3bd047-6ddd-c120-54dd-4165d2257bb0@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 9 Jul 2017 14:20:32 +0200")
Message-ID: <87lgnxpyzu.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jul 09 2017, René Scharfe <l.s.r@web.de> wrote:

> [2] http://pubs.opengroup.org/onlinepubs/009695399/functions/memchr.html

You are using an old revision.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
