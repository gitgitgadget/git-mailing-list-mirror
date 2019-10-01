Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C6401F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 05:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbfJAF2e (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 01:28:34 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:25644 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727720AbfJAF2e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 01:28:34 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 46j78w04BXz5tlK;
        Tue,  1 Oct 2019 07:28:31 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 2129E1C8A;
        Tue,  1 Oct 2019 07:28:31 +0200 (CEST)
Subject: Re: [PATCH 1/1] git-gui (Windows): use git-bash.exe if it is
 available
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Thomas Klaeger via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Klaeger <thklaeger@gmail.com>
References: <pull.360.git.gitgitgadget@gmail.com>
 <414cf2c89876fe122ee18f8d6533f083c2f65654.1569519977.git.gitgitgadget@gmail.com>
 <20190926215737.aq4z2vhfrl6j634r@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1909301225300.46@tvgsbejvaqbjf.bet>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <1486440c-b6aa-51d9-c706-b7e531f4d6d0@kdbg.org>
Date:   Tue, 1 Oct 2019 07:28:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1909301225300.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.09.19 um 12:27 schrieb Johannes Schindelin:
> On Fri, 27 Sep 2019, Pratyush Yadav wrote:
>>> +	if {$cmdLine != $normalized && [file exists $cmdLine]} {
>>
>> Why the $cmdLine != $normalized? When would they be equal? The string
>> substitution should always change $cmdLine.
> 
> Except when Git GUI is installed in an unexpected location. This check
> is purely defensive programming.

Thanks for being considerate. This case would occur in my setting.

-- Hannes
