Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E56421FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 21:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753228AbdBMVHZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 16:07:25 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:47698 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752618AbdBMVHX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 16:07:23 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 3vMdR93Lvqz5tlm;
        Mon, 13 Feb 2017 22:07:16 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 15E7C2AAA;
        Mon, 13 Feb 2017 22:07:16 +0100 (CET)
Subject: Re: [PATCH] mingw: use OpenSSL's SHA-1 routines
To:     Junio C Hamano <gitster@pobox.com>
References: <6a29f8c60d315a24292c1fa9f5e84df4dfdbf813.1486679254.git.johannes.schindelin@gmx.de>
 <20170210050237.gajicliueuvk6s5d@sigill.intra.peff.net>
 <alpine.DEB.2.20.1702101647340.3496@virtualbox>
 <20170210160458.pcp7mupdz24m6cms@sigill.intra.peff.net>
 <9913e513-553e-eba6-e81a-9c21030dd767@kdbg.org>
 <xmqq60kdev2r.fsf@gitster.mtv.corp.google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <b530c820-9956-4396-d853-c7d70ccaf11d@kdbg.org>
Date:   Mon, 13 Feb 2017 22:07:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <xmqq60kdev2r.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.02.2017 um 20:42 schrieb Junio C Hamano:
> I have been operating under the assumption that everybody on Windows
> who builds Git works off of Dscho's Git for Windows tree, and
> patches that are specific to Windows from Dscho's are sent to me via
> the list only after they have been in Git for Windows and proven to
> help Windows users in the wild.
>
> The consequence of these two assumptions is that I would feel safe
> to treat Windows specific changes that do not touch generic part of
> the codebase from Dscho just like updates from any other subsystem
> maintainers (any git-svn thing from Eric, any gitk thing from Paul,
> any p4 thing Luke and Lars are both happy with, etc.).
>
> You seem to be saying that the first of the two assumptions does not
> hold.  Should I change my expectations while queuing Windows specific
> patches from Dscho?

Your first assumption is incorrect as far as I am concerned. I build 
from your tree plus some topics. During -rc period, I build off of 
master; after a release, I build off of next. I merge some of the topics 
that you carry in pu when I find them interesting or when I suspect them 
to regress on Windows. Then I carry around a few additional patches that 
the public has never seen, and these days I also merge Dscho's rebase-i 
topic.

-- Hannes

