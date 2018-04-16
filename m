Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF89F1F404
	for <e@80x24.org>; Mon, 16 Apr 2018 16:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753488AbeDPQPF (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 12:15:05 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:44700 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752777AbeDPQPC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 12:15:02 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 40Ptkr2Cblz1rMSd;
        Mon, 16 Apr 2018 18:14:59 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 40Ptkq6b2gz1qqkx;
        Mon, 16 Apr 2018 18:14:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id pLPK691wGgbB; Mon, 16 Apr 2018 18:14:59 +0200 (CEST)
X-Auth-Info: oBJjFJ49kmRL9e0fO2sFYIiWfRRoO27CR9cSNKdkOAT3NZZlLQSf3OujvjUEoWJW
Received: from localhost (ppp-188-174-148-193.dynamic.mnet-online.de [188.174.148.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 16 Apr 2018 18:14:59 +0200 (CEST)
Received: by localhost (Postfix, from userid 1000)
        id 397412C069F; Mon, 16 Apr 2018 18:14:58 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: man page for "git remote set-url" seems confusing/contradictory
References: <alpine.LFD.2.21.1804160538100.3564@localhost.localdomain>
X-Yow:  RELATIVES!!
Date:   Mon, 16 Apr 2018 18:14:58 +0200
In-Reply-To: <alpine.LFD.2.21.1804160538100.3564@localhost.localdomain>
        (Robert P. J. Day's message of "Mon, 16 Apr 2018 05:43:59 -0700
        (PDT)")
Message-ID: <87y3hn5drx.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Apr 16 2018, "Robert P. J. Day" <rpjday@crashcourse.ca> wrote:

> i don't understand how you can clearly set the fetch and push URLs of
> a remote independently, while the man page nonetheless insists that
> "even though they can be set differently, must still refer to the same
> place". how can they be set differently yet still must refer to the
> same place?

They could be using different transport methods.  For example, for
fetching the unauthenticated git: method could be used, but for pushing
an authenticated method like ssh: is usually needed.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
