Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6E7C433E2
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 12:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13C0120748
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 12:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgGJMdp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 08:33:45 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:43837 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbgGJMdo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 08:33:44 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4B3CBt5VTsz1s8dl;
        Fri, 10 Jul 2020 14:33:42 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4B3CBt58qbz1r57M;
        Fri, 10 Jul 2020 14:33:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id hM7SO7nUYSrz; Fri, 10 Jul 2020 14:33:42 +0200 (CEST)
X-Auth-Info: 5ax9MwG/OS00OMtMVeHn2mbkzwqQlmYr/X1pvXrLmnRChTxW8yidUzqaR1Q9snho
Received: from igel.home (ppp-46-244-174-178.dynamic.mnet-online.de [46.244.174.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 10 Jul 2020 14:33:41 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 6DF542C0B4A; Fri, 10 Jul 2020 14:33:41 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Tom Browder <tom.browder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: "git rm" could be safer and have a better help msg
References: <CAFMGiz97fcw_nvaa=Xo-roTtB1o25qO06=PHGSrBzv4k_zGqaw@mail.gmail.com>
X-Yow:  I will invent "TIDY BOWL"...
Date:   Fri, 10 Jul 2020 14:33:41 +0200
In-Reply-To: <CAFMGiz97fcw_nvaa=Xo-roTtB1o25qO06=PHGSrBzv4k_zGqaw@mail.gmail.com>
        (Tom Browder's message of "Fri, 10 Jul 2020 07:25:29 -0500")
Message-ID: <878sfr1rdm.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jul 10 2020, Tom Browder wrote:

> I often need to remove a file from Git but leave it as is, changed or not.
> The only safe way to do that as far as I know is:
>
>     $ git rm -f --cached myfile   # many thanks to @jast on IRC #git

Why do you need -f?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
