Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA57C1FF32
	for <e@80x24.org>; Tue, 17 Oct 2017 20:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760171AbdJQUDs (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 16:03:48 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:42488 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758070AbdJQUDr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 16:03:47 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3yGmNK63v4z1qsW7;
        Tue, 17 Oct 2017 22:03:45 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 3yGmNK5jLgz1qqkS;
        Tue, 17 Oct 2017 22:03:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id ZSsQjA03_7si; Tue, 17 Oct 2017 22:03:45 +0200 (CEST)
X-Auth-Info: agmlbvsaPB36iooFhdxYPkuFjTtPScZv0N6Vi5UoZ41hvzxtWo7R80DEkhvmtHtH
Received: from igel.home (ppp-188-174-154-116.dynamic.mnet-online.de [188.174.154.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 17 Oct 2017 22:03:45 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 50C2F2C3CB4; Tue, 17 Oct 2017 22:03:44 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Minor man page weirdness?
References: <A4E5D8CC-19A7-442A-814C-FD5A46391982@gmail.com>
        <20171016225641.x76jwycb7mcpvrw3@sigill.intra.peff.net>
        <87d15lu48o.fsf@linux-m68k.org>
        <20171017163828.igmlsbdynpe6m37w@sigill.intra.peff.net>
        <878tg9u1o7.fsf@linux-m68k.org>
        <20171017172930.var7jsodxtgzoz5t@sigill.intra.peff.net>
        <874lqxu0fw.fsf@linux-m68k.org>
        <20171017191108.6tcmpbuasbgrb4sk@sigill.intra.peff.net>
X-Yow:  NOW, I'm supposed to SCRAMBLE two, and HOLD th' MAYO!!
Date:   Tue, 17 Oct 2017 22:03:44 +0200
In-Reply-To: <20171017191108.6tcmpbuasbgrb4sk@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 17 Oct 2017 15:11:08 -0400")
Message-ID: <87r2u1sfrz.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Okt 17 2017, Jeff King <peff@peff.net> wrote:

> One other thing to try:
>
>   rm git-branch.1
>   make NO_MAN_BOLD_LITERAL=1 git-branch.1

That doesn't help:

   Reset <branchname> to <startpoint> if <branchname> exists already\&. Without
   \-f\fIgit branch\fR
   refuses to change an existing branch\&. In combination with

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
