Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C23CC1F453
	for <e@80x24.org>; Tue, 30 Apr 2019 06:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbfD3GVt (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 02:21:49 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:10407 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfD3GVt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 02:21:49 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 44tWdQ0ySRz5tlC;
        Tue, 30 Apr 2019 08:21:46 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 1B3834212;
        Tue, 30 Apr 2019 08:21:45 +0200 (CEST)
Subject: Re: [PATCH 1/1] mingw: optionally disable side-band-64k for transport
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Braun via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Braun <thomas.braun@byte-physics.de>
References: <pull.137.git.gitgitgadget@gmail.com>
 <31aa7bfcab834b753cc9f52fc9cc187f65e2d964.1556575475.git.gitgitgadget@gmail.com>
 <CAPig+cT1EP+HC5h4e0NGCu=1i6cZXPxERRgnnAdZJn+XeqpbFw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1904291916510.45@tvgsbejvaqbjf.bet>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <b8e799e2-356d-2a03-faa4-2792ec1b171d@kdbg.org>
Date:   Tue, 30 Apr 2019 08:21:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1904291916510.45@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.04.19 um 01:17 schrieb Johannes Schindelin:
> On Mon, 29 Apr 2019, Eric Sunshine wrote:
>> On Mon, Apr 29, 2019 at 6:04 PM Thomas Braun via GitGitGadget
>>> diff --git a/Documentation/config/sendpack.txt b/Documentation/config/sendpack.txt
>>> @@ -0,0 +1,5 @@
>>> +sendpack.sideband::
>>> +       Allows to disable the side-band-64k capability for send-pack even
>>> +       when it is advertised by the server. Makes it possible to work
>>> +       around a limitation in the git for windows implementation together
>>> +       with the dump git protocol. Defaults to true.
>>
>> s/dump/dumb/
>>
>> For someone who hasn't read the commit message of this patch, "work
>> around a limitation in ... git for windows" doesn't mean much. Perhaps
>> this documentation could explain in more precise terms under what
>> circumstances this option should be used?
> 
> You're right, this is confusing, especially since Git for Windows 2.x does
> not have that bug.

If there is no bug, why do we need the patch?

-- Hannes
