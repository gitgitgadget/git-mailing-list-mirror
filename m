Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DB821F517
	for <e@80x24.org>; Sat,  9 Jun 2018 22:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753464AbeFIWo3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 18:44:29 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:3048 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753441AbeFIWo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 18:44:28 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 413DqG3817z5tlF;
        Sun, 10 Jun 2018 00:44:26 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id E2FB5D9;
        Sun, 10 Jun 2018 00:44:25 +0200 (CEST)
Subject: Re: [RFC PATCH v1] telemetry design overview (part 1)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Jeff King <peff@peff.net>, git@jeffhostetler.com,
        git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180607145313.25015-1-git@jeffhostetler.com>
 <c3ed8128-1184-8199-06e5-a4e96b2bc7c5@kdbg.org>
 <20180608090758.GA15112@sigill.intra.peff.net>
 <688240ef-34a1-ee9a-215a-b4f9628e7c72@virtuell-zuhause.de>
 <9ab3eec1-40c1-8543-e122-ed4ccfd367b4@kdbg.org>
 <87fu1w53af.fsf@evledraar.gmail.com>
 <900a34bb-4d8b-4a22-a0f5-1d2f6df84945@kdbg.org>
 <nycvar.QRO.7.76.6.1806092241180.77@tvgsbejvaqbjf.bet>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <410f0fee-010c-c178-224c-e47ae0b0dda6@kdbg.org>
Date:   Sun, 10 Jun 2018 00:44:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1806092241180.77@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.06.2018 um 22:43 schrieb Johannes Schindelin:
> On Sat, 9 Jun 2018, Johannes Sixt wrote:
>> When you want usage data, ask your users for feedback. Look over their
>> shoulders. But do not ask the software itself to gather usage data. It will be
>> abused.
>>
>> Do not offer open source software that has a "call-home" method built-in.
>>
>> If you want to peek into the workplaces of YOUR users, then monkey-patch
>> survaillance into YOUR version of Git. But please do not burden the rest of
>> us.
> 
> We already offer hooks. You can do anything with those hooks. Even, if you
> do not pay close attention, to transfer all your bitcoin to a specific
> account.
> 
> I agree with Peff: this is something you as a user need to be aware of,
> and need to make sure you configure your Git just like you want. As long
> as this is a purely opt-in feature, it is useful and helpful.

The problem with this feature is not so much that it enables someone to 
do bad things, but that it is specifically targeted at recording *how 
users use Git*.

> We do need it in-house, for the many thousands of Git users we try to
> support with a relatively small team of Git developers.

Then please build your private version and sell it to your thousands of 
Git users. "in-house" == Microsoft? Small team of Git developers? So, 
instead of shelling out the bucks for this extra burden, they put the 
burden on the Community?

-- Hannes
