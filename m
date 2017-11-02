Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A00120450
	for <e@80x24.org>; Thu,  2 Nov 2017 07:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754513AbdKBHXz (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 03:23:55 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:45358 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752237AbdKBHXz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 03:23:55 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3ySGm81Sv3z1r195;
        Thu,  2 Nov 2017 08:23:52 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 3ySGm80z7Yz1qqkM;
        Thu,  2 Nov 2017 08:23:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id q62n6_RKmadI; Thu,  2 Nov 2017 08:23:51 +0100 (CET)
X-Auth-Info: mJJxNSXQvhBBM9+2e8xfmERFZdIUnadvOz7YvNwcOrBLrA9RPowJ7EsQ4xWUPt80
Received: from localhost (ppp-188-174-149-98.dynamic.mnet-online.de [188.174.149.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu,  2 Nov 2017 08:23:51 +0100 (CET)
Received: by localhost (Postfix, from userid 1000)
        id 1BA3F2C1133; Thu,  2 Nov 2017 08:23:49 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>, Kevin Daudt <me@ikke.info>
Subject: Re: [PATCHv2 6/7] builtin/describe.c: describe a blob
References: <20171031003351.22341-1-sbeller@google.com>
        <20171031211852.13001-1-sbeller@google.com>
        <20171031211852.13001-7-sbeller@google.com>
        <xmqqbmkmvdrq.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1711011329300.6482@virtualbox>
        <CAGZ79kZPNiNnSJd6CNYb7XkTVsT2ONLQLhwAQxt6_SPFTSwMcw@mail.gmail.com>
        <EF573E5E-EA72-4DEE-822C-B44265FD581B@gmail.com>
        <alpine.DEB.2.21.1.1711012310250.6482@virtualbox>
        <CAGZ79kbOEM_W65Rym4yiDNHpFGTNWMYdh=aVPjThNWjEHPQong@mail.gmail.com>
        <alpine.DEB.2.21.1.1711012340290.6482@virtualbox>
X-Yow:  I have a TINY BOWL in my HEAD
Date:   Thu, 02 Nov 2017 08:23:49 +0100
In-Reply-To: <alpine.DEB.2.21.1.1711012340290.6482@virtualbox> (Johannes
        Schindelin's message of "Wed, 1 Nov 2017 23:41:45 +0100 (CET)")
Message-ID: <871slhm9dm.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Nov 01 2017, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> Sure, but it is still a tricky thing. Imagine
>
> - A1 - B1 - A2 - B2 - B3
>
> where all the B* commits have the blob. Do you really want to report B1
> rather than B2 as the commit introducing the blob? (I would prefer B2...)

What if B3 renames or copies the blob?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
