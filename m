Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0446B1F404
	for <e@80x24.org>; Wed,  4 Apr 2018 17:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751280AbeDDRbn (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 13:31:43 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:33084 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751236AbeDDRbn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 13:31:43 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 40GY0r6vcMz5tlC;
        Wed,  4 Apr 2018 19:31:40 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 90FFC100;
        Wed,  4 Apr 2018 19:31:40 +0200 (CEST)
Subject: Re: js/runtime-prefix-windows, was Re: What's cooking in git.git (Mar
 2018, #06; Fri, 30)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqvadd1epf.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1804031511510.5026@qfpub.tvgsbejvaqbjf.bet>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <65a25131-9278-62c8-4d13-b8531209825d@kdbg.org>
Date:   Wed, 4 Apr 2018 19:31:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1804031511510.5026@qfpub.tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.04.2018 um 15:12 schrieb Johannes Schindelin:
> On Fri, 30 Mar 2018, Junio C Hamano wrote:
> 
>> * js/runtime-prefix-windows (2018-03-27) 2 commits
>>   - mingw/msvc: use the new-style RUNTIME_PREFIX helper
>>   - exec_cmd: provide a new-style RUNTIME_PREFIX helper for Windows
>>   (this branch uses dj/runtime-prefix.)
>>
>>   The Windows port was the first that allowed Git to be installed
>>   anywhere by having its components refer to each other with relative
>>   pathnames.  The recent dj/runtime-prefix topic extends the idea to
>>   other platforms, and its approach has been adopted back in the
>>   Windows port.
>>
>>   Is this, together with the dj/runtime-prefix topic, ready for
>>   'next'?
> 
> As far as I am concerned: yes!

Works in my environment, too. No objections.

-- Hannes
