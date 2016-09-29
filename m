Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C566207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 18:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754639AbcI2SiI (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 14:38:08 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:48690 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751795AbcI2SiH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 14:38:07 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3slNcC74YZz5tlD;
        Thu, 29 Sep 2016 20:38:03 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id CE8FC5330;
        Thu, 29 Sep 2016 20:38:02 +0200 (CEST)
Subject: Re: [PATCH v8 00/11] Git filter protocol
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
References: <20160920190247.82189-1-larsxschneider@gmail.com>
 <xmqq8tubitjs.fsf@gitster.mtv.corp.google.com>
 <C2C9761E-986F-473D-BFB7-CBEF900D9FA3@gmail.com>
 <f7a4f828-bb1d-0ffa-e369-3b4fa476d9e5@web.de>
 <xmqqk2duhcdm.fsf@gitster.mtv.corp.google.com>
 <1A8A9127-4DF9-44AD-9497-F8A630AB1193@gmail.com>
 <7f8ab626-ecdb-70a8-aa19-615c3c84148e@web.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        ramsay@ramsayjones.plus.com
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <049fad9b-d625-a80b-bd6b-9b80c9701f7a@kdbg.org>
Date:   Thu, 29 Sep 2016 20:38:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <7f8ab626-ecdb-70a8-aa19-615c3c84148e@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.09.2016 um 20:18 schrieb Torsten Bögershausen:
> I would agree that  Git should not wait for the filter.
> But does the test suite need to wait for the filter ?

We have fixed a test case on Windows recently where a process hung 
around too long (5babb5bd). So, yes, the test suite has to wait for the 
filter.

-- Hannes

