Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D04CA20323
	for <e@80x24.org>; Sun, 19 Mar 2017 21:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbdCSVdj (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Mar 2017 17:33:39 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:57720 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751228AbdCSVdi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2017 17:33:38 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3vmXPq39Kzz5tlF;
        Sun, 19 Mar 2017 22:33:35 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 0337E4278;
        Sun, 19 Mar 2017 22:33:33 +0100 (CET)
Subject: Re: Is there a way to have a local version of a header file?
To:     Samuel Lijin <sxlijin@gmail.com>
References: <nycvar.QRO.7.75.62.1703180724490.3797@qynat-yncgbc>
 <CACBZZX5FMdjuxxNru+XfTQdSXEQ_b0OP2rngGZLf1sSHR_D8Ng@mail.gmail.com>
 <nycvar.QRO.7.75.62.1703180750460.3797@qynat-yncgbc>
 <CACBZZX7G=C84kz4n26VTnWWUTKRv1rVvms=8AvELtMSCviu1kQ@mail.gmail.com>
 <xmqqzigi31fl.fsf@gitster.mtv.corp.google.com>
 <nycvar.QRO.7.75.62.1703181539310.3797@qynat-yncgbc>
 <xmqqy3w2yybt.fsf@gitster.mtv.corp.google.com>
 <CAJZjrdVxT7G+Cn+1_vqPBCtMOALmR_542jvP7nXXuvs74ko5qg@mail.gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, David Lang <david@lang.hm>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <5d06ba31-bec1-0172-cb00-10b4d2c4e648@kdbg.org>
Date:   Sun, 19 Mar 2017 22:33:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAJZjrdVxT7G+Cn+1_vqPBCtMOALmR_542jvP7nXXuvs74ko5qg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.03.2017 um 00:22 schrieb Samuel Lijin:
> I'd just provide a .sample and tell people what to do with it in the
> README. The alternative is to provide config.h as is and tell people
> to use "git update-index --assume-unchanged" immediately after cloning
> to ignore changes to the file, but this is prone to people
> accidentally committing credentials.

Please do not suggest to use --assume-unchanged. It is not intended for 
this purpose, and if used in the way you suggest, it will sooner or 
later bite back.

--assume-unchanged is a promise to Git that you do not change the file. 
If you break the promise, you get what you deserve ;)

-- Hannes

