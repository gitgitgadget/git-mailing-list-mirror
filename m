Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AA051F4F8
	for <e@80x24.org>; Thu, 29 Sep 2016 05:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753004AbcI2F6z (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 01:58:55 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:48907 "EHLO bsmtp4.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751226AbcI2F6y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 01:58:54 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp4.bon.at (Postfix) with ESMTPSA id 3sl3mC0jJzz5tlB;
        Thu, 29 Sep 2016 07:58:50 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 0FF4B5318;
        Thu, 29 Sep 2016 07:58:50 +0200 (CEST)
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12
 hexdigits
To:     Junio C Hamano <gitster@pobox.com>
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
 <20160928233047.14313-1-gitster@pobox.com>
 <20160928233047.14313-5-gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, torvalds@linux-foundation.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <ae9dbf3b-4190-8145-a59f-0d578067032a@kdbg.org>
Date:   Thu, 29 Sep 2016 07:58:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20160928233047.14313-5-gitster@pobox.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.09.2016 um 01:30 schrieb Junio C Hamano:
> As Peff said, responding in a thread started by Linus's suggestion
> to raise the default abbreviation to 12 hexdigits:

This is waayy too large for a new default. The vast majority of 
repositories is smallish. For those, the long sequences of hex digits 
are an uglification that is almost unbearable.

I know that kernel developers are important, but their importance has 
long been outnumbered by the anonymous and silent masses of users.

Personally, I use 8 digits just because it is a "rounder" number than 7, 
but in all of my repositories 7 would still work just as well.

-- Hannes

