Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DDC820954
	for <e@80x24.org>; Fri,  1 Dec 2017 18:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752161AbdLASwg (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 13:52:36 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:58615 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbdLASwf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 13:52:35 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3ypNgL6nJVz1qsh3;
        Fri,  1 Dec 2017 19:52:30 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 3ypNgL64Tdz1qqkP;
        Fri,  1 Dec 2017 19:52:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id DyBSuoFi9DD1; Fri,  1 Dec 2017 19:52:30 +0100 (CET)
X-Auth-Info: vZHERk3IRYvbtIn0AFVJNhWcmqRYZr3+KAvCTkAqO+ihPzxdQiHXWqRDYX0391wT
Received: from localhost (ppp-188-174-153-216.dynamic.mnet-online.de [188.174.153.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri,  1 Dec 2017 19:52:30 +0100 (CET)
Received: by localhost (Postfix, from userid 1000)
        id 930D02C2670; Fri,  1 Dec 2017 19:52:29 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Dan Jacques <dnj@google.com>
Cc:     j6t@kdbg.org, Johannes.Schindelin@gmx.de, avarab@gmail.com,
        git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v4 1/4] Makefile: generate Perl header from template file
References: <97acc3d3-5c6a-2e65-a372-24def5b21d54@kdbg.org>
        <20171201181845.8454-1-dnj@google.com>
X-Yow:  Kids, the seven basic food groups are GUM, PUFF PASTRY, PIZZA,
 PESTICIDES, ANTIBIOTICS, NUTRA-SWEET and MILK DUDS!!
Date:   Fri, 01 Dec 2017 19:52:29 +0100
In-Reply-To: <20171201181845.8454-1-dnj@google.com> (Dan Jacques's message of
        "Fri, 1 Dec 2017 13:18:45 -0500")
Message-ID: <87efoe46xe.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Dez 01 2017, Dan Jacques <dnj@google.com> wrote:

> I am not a `sed` wizard, but perhaps the tool is ignoring the semicolon because
> it's in the middle of the "s" expression? The shell may similarly be ignoring it
> because it's nested in between single-quotes?

As far as POSIX is concerned, semicolons are not special, but can be
used to separate commands instead of newlines.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
