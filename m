Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B00DF1F42D
	for <e@80x24.org>; Tue, 27 Mar 2018 10:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbeC0KD3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 06:03:29 -0400
Received: from siwi.pair.com ([209.68.5.199]:36224 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751068AbeC0KD1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 06:03:27 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 5F1183F4090;
        Tue, 27 Mar 2018 06:03:26 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 30B003F408A;
        Tue, 27 Mar 2018 06:03:26 -0400 (EDT)
Subject: Re: [RFC PATCH v5 0/8] rebase-interactive
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Wink Saville <wink@saville.com>, jeffhost@microsoft.com,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1521779249.git.wink@saville.com>
 <cover.1521839546.git.wink@saville.com>
 <CAKk8isqj3OusAE8OJtcys0a-Yj9fgQNn=DtLe-ZGYNzcKp=-3Q@mail.gmail.com>
 <xmqq7eq2h0wa.fsf@gitster-ct.c.googlers.com>
 <CAKk8isoJQrikitO7ezRajgphUXYR6207k4UkXP6r57WJEFBaDA@mail.gmail.com>
 <CAKk8ispSgNgZxS7KfuOyxfU53tzesvNyLRaNXFZa3K7SCbaRkQ@mail.gmail.com>
 <xmqqzi2ude4w.fsf@gitster-ct.c.googlers.com>
 <9ca76d31-828d-0b6f-5069-375792c1f55d@jeffhostetler.com>
 <xmqqh8p2d8jh.fsf@gitster-ct.c.googlers.com>
 <d56a60a8-e735-b147-a2e6-4e48461ad701@jeffhostetler.com>
 <xmqqy3ie9kdv.fsf@gitster-ct.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <f655f5d3-9a8a-ead7-04b2-eda3c14ed8f5@jeffhostetler.com>
Date:   Tue, 27 Mar 2018 06:03:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <xmqqy3ie9kdv.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/27/2018 1:07 AM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
[...]
> So I would think it is most sensible to have double, uintmax_t and
> intmax_t variants.  If you do not care about the extra value range
> that unsigned integral types afford, a single intmax_t variant would
> also be fine.

I'll reroll with just the double and intmax_t variants.
Thanks for the feedback and sorry for all the noise.

Jeff

