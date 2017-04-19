Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA8441FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 13:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934302AbdDSNLe (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 09:11:34 -0400
Received: from mout.web.de ([217.72.192.78]:50746 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934280AbdDSNLa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 09:11:30 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LhNs4-1cEYCQ3jns-00mbgJ; Wed, 19
 Apr 2017 15:11:07 +0200
Subject: Re: [PATCH] various: disallow --no-no-OPT for --no-opt options
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
References: <20170418170914.9701-1-avarab@gmail.com>
 <de79d366-3609-8efe-b23a-7e793036b3ef@web.de>
 <CACBZZX6XWXjvDKeR+a1Ymb4csXgOKLiF==VkKLp5S9TRVQhgoA@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b4eef4c1-cd5a-aa71-fc79-8af89dbe365d@web.de>
Date:   Wed, 19 Apr 2017 15:11:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <CACBZZX6XWXjvDKeR+a1Ymb4csXgOKLiF==VkKLp5S9TRVQhgoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:ODDrBm4Pc9L2AIBd2lyhoLAN1B7iGwanWNhv0aGD/jCdZjaF0DD
 82MbPs0qJnLHbAcvp/tEgJf4ISTjcHgw/zJ9VqjyVvpQjJtVeYKWfYs6274z7jqpL7SNdUI
 PArBr90oIEH7IxHEm9W1Vcvtxu/TxOiLRNrQBeX3J06AYndLKhzNkXQc3LR2O6agNtF6+wZ
 h6nUnv10jKm8hdMwrOHHw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1uYxytlI1bk=:QSed1J8kzEabcBaN6IKyHA
 nSkWORWxnS/ZW29oqasS+J3mMhKrfDAZ9cOm0qb5tgA2dAxcHOVppecC4xqp5DQjnDyVk7wc5
 Xl/tcfpcW8TyeJeYmvqTW3EX4N2JDzRUpgQvaU9pXmbw0K/BcIF9CF+dU1XJLpstbLtyKWj/c
 gfbBClLRrzmLzafp8WPftcrTn5OOe8OgU8kVfEOmoKgB1toDiHKktvuqGjLSYVuLBKxuCdvS7
 LsakyBwQL5FQGtKglsxW5W+/qR7AfvU9h1IyeXs8PrFfgdfLtOzrwQF4+O3sydLUPwjZ90jjy
 Rk7g8Tg2X00zFBKz6jG6NdksgtKnwx7jG6GcKVu8M8BG/XZjYP0N2g8ky5lKtTp0PcV/YHvuS
 QD6OUl9PTLBITXbMvlVGGkHu7YOYieEeGMPYweEAaBDV/2bhdcIpD3H5ald2RNCzkqMtDrHdZ
 4mW35MmKueRLxhL2A6gc0MvI3pxYlVZ5+VxAkakt97qwpE6nm0uvJQn6WcVF6H3rir2CRi3Kk
 BiVbWuh83KpvPO58MjcvDBAzKRmL7Bggt6vXgKQ+PlTl0wK3K2beJzJ20FwZv6xANb9QVjm1w
 B6Ns/SYylb9zhoWEhh66JXuQ5ghf17rSh4Na7KsawEK7yn1ZDztbEKFkyWfZj97mA3pK7cD+K
 cqB0MHJ3maUhQg0NZAWIpfn+GyTlOqL63ZQyKiMJYxbaEndCFo8XFHGjcny1NPFmNmRgkkJ0F
 BwQiZf2z8eZikmU+W4f5T15QHPhs2HlDUkO5Co5eseTExk7UrZHCFY6eEe+27QsAwlUfK9W6q
 i80qacX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.04.2017 um 09:00 schrieb Ævar Arnfjörð Bjarmason:
> On Wed, Apr 19, 2017 at 12:29 AM, René Scharfe <l.s.r@web.de> wrote:
>> Setting PARSE_OPT_NONEG takes away the ability to toggle the affected
>> option.  E.g. git clone would reject --checkout.  Currently users can
>> specify --no- options as defaults in aliases and override them on the
>> command line if needed, with the patch that won't be possible anymore.
>>
>> PARSE_OPT_NONEG should only be used for options where a negation doesn't
>> make sense, e.g. for the --stage option of checkout-index.
> 
> That's a bad bug, I don't know whether to be surprised or not that we
> had no tests for this :)
> 
> I thought I was just disabling --no-no-checkout for --no-checkout, not
> --checkout, but didn't notice the subtleties of the special case
> handling for --no-* in parse-options.c, thanks.

I'm confused.  What's the bug here?

--no-no-checkout is undocumented; Jacob's patch addresses it. 
--no-checkout is the documented form.  Negation allows --checkout to be 
used as well, with the opposite meaning to --no-checkout.  Turning off 
negation with PARSE_OPT_NONEG forbids --checkout to be used.

Perhaps the issue is that a single line of documentation is not enough 
("PARSE_OPT_NONEG: says that this option cannot be negated")?

René
