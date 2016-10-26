Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 594AE2022A
	for <e@80x24.org>; Wed, 26 Oct 2016 20:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933022AbcJZUZo (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 16:25:44 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:11210 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932320AbcJZUZn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 16:25:43 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3t41jx26k5z5tlG;
        Wed, 26 Oct 2016 22:25:41 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id A4466100;
        Wed, 26 Oct 2016 22:25:38 +0200 (CEST)
Subject: Re: [PATCH 27/36] attr: convert to new threadsafe API
To:     Stefan Beller <sbeller@google.com>
References: <20161022233225.8883-1-sbeller@google.com>
 <20161022233225.8883-28-sbeller@google.com>
 <alpine.DEB.2.20.1610261049470.3264@virtualbox>
 <20161026093558.drsdwn2hm7bbcktt@ruderich.org>
 <20161026121525.twgiavpgfbr2ahvn@sigill.intra.peff.net>
 <CAGZ79kYgk9rQDju0MT2uniaxhAWpzJ9f1T9czgNnxfq+Wz6m+A@mail.gmail.com>
Cc:     Jeff King <peff@peff.net>, Simon Ruderich <simon@ruderich.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Duy Nguyen <pclouds@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <e1f760f5-27a7-8266-5d6c-d61fab7e194d@kdbg.org>
Date:   Wed, 26 Oct 2016 22:25:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYgk9rQDju0MT2uniaxhAWpzJ9f1T9czgNnxfq+Wz6m+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.10.2016 um 21:51 schrieb Stefan Beller:
> it is
> very convenient to not have to explicitly initialize mutexes?

Not to initialize a mutex is still wrong for pthreads.

-- Hannes

