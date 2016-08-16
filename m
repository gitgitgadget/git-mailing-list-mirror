Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 590DD1F859
	for <e@80x24.org>; Tue, 16 Aug 2016 21:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460AbcHPVKk (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 17:10:40 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:45398 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752329AbcHPVKi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 17:10:38 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3sDQ4X0cbpz5tlB;
	Tue, 16 Aug 2016 23:10:36 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 69C285198;
	Tue, 16 Aug 2016 23:10:35 +0200 (CEST)
Subject: Re: [PATCH] t/Makefile: make sure that file names are truly
 platform-independent
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <814aefbcf0f9380098e3f7a183399e11e24180dd.1471270061.git.johannes.schindelin@gmx.de>
 <xmqqk2fihv90.fsf@gitster.mtv.corp.google.com>
 <xmqqoa4tg2yi.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608161026110.4924@virtualbox>
 <alpine.DEB.2.20.1608161035320.4924@virtualbox>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
From:	Johannes Sixt <j6t@kdbg.org>
Message-ID: <6a3964b6-9488-b6e6-ab32-15dd9a965454@kdbg.org>
Date:	Tue, 16 Aug 2016 23:10:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1608161035320.4924@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 16.08.2016 um 10:42 schrieb Johannes Schindelin:
> That only leaves the conclusion that some of our pathspec
> code tries to be helpful and takes a backslash for a directory separator.

Very true. The code that does this is in prefix_filename():

https://github.com/git/git/blob/master/abspath.c#L170

-- Hannes

