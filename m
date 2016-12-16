Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 791F71FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 18:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756696AbcLPSom (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 13:44:42 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:44624 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755398AbcLPSok (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 13:44:40 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3tgK3p16xLz5tlW;
        Fri, 16 Dec 2016 19:44:38 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id AE8532226;
        Fri, 16 Dec 2016 19:44:37 +0100 (CET)
Subject: Re: [PATCH 1/1] mingw: intercept isatty() to handle /dev/null as Git
 expects it
To:     Junio C Hamano <gitster@pobox.com>
References: <cover.1481454992.git.johannes.schindelin@gmx.de>
 <42ddc270ea04e01e899cc479063e5d602e4a4448.1481454992.git.johannes.schindelin@gmx.de>
 <129f000c-49c1-0e75-26b3-c96e9b442443@kdbg.org>
 <xmqqy3zfsq4q.fsf@gitster.mtv.corp.google.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <5977e71d-da58-7cb0-bc69-343bb3a1341d@kdbg.org>
Date:   Fri, 16 Dec 2016 19:44:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <xmqqy3zfsq4q.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.12.2016 um 19:08 schrieb Junio C Hamano:
> Sorry for not having waited for you to chime in before agreeing to
> fast-track this one, and now this is in 'master'.

No reason to be sorry, things happen... Dscho's request for 
fast-tracking was very reasonable, and the patch looked "obviously 
correct". I lacked time to test it promptly, and when I finally did, I 
ignored the symptoms because my workflow was a mess and I had to 
concentrate on other things. Only after 'git push' did not report the 
pack progress, was my suspicion raised...

>> Should we not use winansi_get_osfhandle() instead of _get_osfhandle()?

Unfortunately, I'm away from my Windows box over the weekend. It will 
have to wait until Monday before I can test this idea.

-- Hannes

