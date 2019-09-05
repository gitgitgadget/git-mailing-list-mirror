Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C0431F4B7
	for <e@80x24.org>; Thu,  5 Sep 2019 06:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731199AbfIEGWD (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 02:22:03 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:40237 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731084AbfIEGWD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 02:22:03 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 46P9Zc5wnjz5tl9;
        Thu,  5 Sep 2019 08:22:00 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 02D09102;
        Thu,  5 Sep 2019 08:21:59 +0200 (CEST)
Subject: Re: [PATCH 1/2] git-gui: warn if the commit message contains lines
 longer than the set limit
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>
References: <7da71d89f9fa987eca2e25974e4cec382c146e44.1567627609.git.bert.wesarg@googlemail.com>
 <CAPig+cSL0fpc5cVgO1soAksD2b5xadkDLG+JxiDCi5s95VRU_A@mail.gmail.com>
 <CAKPyHN3=hh7DCoyEKB9DOf=t=v=Y1bX1xVx9r6Lxy=WQb9JC-A@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <ef44ce71-2ed7-0f17-faf2-06b3c7d193b9@kdbg.org>
Date:   Thu, 5 Sep 2019 08:21:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKPyHN3=hh7DCoyEKB9DOf=t=v=Y1bX1xVx9r6Lxy=WQb9JC-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.09.19 um 22:43 schrieb Bert Wesarg:
> these people did not saw the entered text anyway. they would have
> needed to change the option (default to 75 characters) to see what
> they have typed. which could have been garbage to begin with.

Huh? When I type overly long line, all text scrolls out of view on the
left side. So I definitely _can_ see the long text.

> How about a horizontal scrollbar? This indicates pretty conveniently
> and in a standard visual way, that there is more text to the side ;-)

The scrollbar is an option, of course, but I dislike somewhat that it
takes away screen space if it is permanently visible.

-- Hannes
