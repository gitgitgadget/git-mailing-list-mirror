Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFDFA1FBB0
	for <e@80x24.org>; Sun, 23 Oct 2016 12:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756355AbcJWMaB (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 08:30:01 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:33206 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755562AbcJWMaA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 08:30:00 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3t1zJQ14wkz3hjck;
        Sun, 23 Oct 2016 14:29:58 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
        by mail.m-online.net (Postfix) with ESMTP id 3t1zJQ0Vn3zvkKT;
        Sun, 23 Oct 2016 14:29:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
        with ESMTP id xNBvj7jSx-z0; Sun, 23 Oct 2016 14:29:56 +0200 (CEST)
X-Auth-Info: zk6JTZSOyWmNk1OAMdZU4rIsmv308FwOEC4n/Kl3PvX6g3i+33K7/eosK6IgrUZD
Received: from igel.home (ppp-88-217-17-110.dynamic.mnet-online.de [88.217.17.110])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 23 Oct 2016 14:29:56 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id EBA2F2C52C7; Sun, 23 Oct 2016 14:29:55 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Roman Neuhauser <neuhauser@sigpipe.cz>
Cc:     git@vger.kernel.org
Subject: Re: git clone --bare --origin incompatible?
References: <20161023110338.GA1486@isis.sigpipe.cz>
X-Yow:  I haven't been married in over six years, but we had sexual counseling
 every day from Oral Roberts!!
Date:   Sun, 23 Oct 2016 14:29:55 +0200
In-Reply-To: <20161023110338.GA1486@isis.sigpipe.cz> (Roman Neuhauser's
        message of "Sun, 23 Oct 2016 13:03:38 +0200")
Message-ID: <87y41f8czg.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Okt 23 2016, Roman Neuhauser <neuhauser@sigpipe.cz> wrote:

> what is the reason clone --bare prohibits --origin?
>
>   % git clone --bare -o fubar anything anywhere
>   fatal: --bare and --origin fubar options are incompatible.

Since a bare clone maps remote branches directly to local branches,
without any remote-tracking branches, --origin doesn't make sense.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
