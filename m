Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CADF81F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 05:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390603AbfJQFdI (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 01:33:08 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:35581 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731603AbfJQFdI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 01:33:08 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 46tyVp2mYMz5tlJ;
        Thu, 17 Oct 2019 07:33:06 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 7DE9D20A1;
        Thu, 17 Oct 2019 07:33:05 +0200 (CEST)
Subject: Re: [PATCH 1/2] git-gui: implement proc select_path_in_widget
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git List <git@vger.kernel.org>
References: <CAGr--=KXpt7GzqPpm1BCrsc1jhfaXeCT-XrWKNvq2pLtgAbSwQ@mail.gmail.com>
 <20191007171145.1259-1-birger.sp@gmail.com>
 <20191013202110.z3gyx7eikackvmzb@yadavpratyush.com>
 <CAGr--=K8beYCwRgjFdokyCkjguXTJu8wMoxMAMG_H7CVgmEA=g@mail.gmail.com>
 <20191016192819.5fxbwdediomj7gaz@yadavpratyush.com>
 <CAGr--=Ltx2JPexfVSWRrAdT0zHs0RWaZdS7OZD-TWJv2y7K-PA@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <86d8ea9c-f27e-8ab8-c7f6-b3fd1eb3895d@kdbg.org>
Date:   Thu, 17 Oct 2019 07:33:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAGr--=Ltx2JPexfVSWRrAdT0zHs0RWaZdS7OZD-TWJv2y7K-PA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.10.19 um 07:08 schrieb Birger Skogeng Pedersen:
> Hi Pratyush,
> 
> On Wed, Oct 16, 2019 at 9:28 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
>> I mentioned this earlier, and I'll mention this again: I'm not sure
>> whether this feature would be a good thing for the larger population. So
>> this _might_ not end up being accepted depending on how people react to
>> the proposal. I thought I'd let you know to avoid any nasty surprises
>> later.
> 
> Could you please elaborate on why you think the feature might be
> undesired? Why would users not want a staged file to be selected
> automatically?

FWIW, I would prefer to experiment with the feature for a few weeks
before it (or a configuration that enables it by default) is baked in.

-- Hannes
