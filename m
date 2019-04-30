Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C7D51F453
	for <e@80x24.org>; Tue, 30 Apr 2019 22:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfD3WzX (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 18:55:23 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:6855 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfD3WzW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 18:55:22 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 44txgr1jx2z5tlD;
        Wed,  1 May 2019 00:55:20 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 9485949BA;
        Wed,  1 May 2019 00:55:19 +0200 (CEST)
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
 <b8e799e2-356d-2a03-faa4-2792ec1b171d@kdbg.org>
 <nycvar.QRO.7.76.6.1904301832500.45@tvgsbejvaqbjf.bet>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <890578de-6286-1726-37fc-d05bf4b359df@kdbg.org>
Date:   Wed, 1 May 2019 00:55:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1904301832500.45@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.05.19 um 00:33 schrieb Johannes Schindelin:
> On Tue, 30 Apr 2019, Johannes Sixt wrote:
>> Am 30.04.19 um 01:17 schrieb Johannes Schindelin:
>>> You're right, this is confusing, especially since Git for Windows 2.x does
>>> not have that bug.
>>
>> If there is no bug, why do we need the patch?
> 
> I thought you of all people (building with the ancient MSys/MINGW
> toolchains) would benefit from it :-)
> 
> But if even you don't want it, I'll gladly drop it from Git for Windows'
> patches and be done with it.

Ah, this is only for the ancient MinGW! I do indeed not mind if you drop
it as I have updated my toolchain to the one you provide long ago.

Thank you for being considerate!

-- Hannes
