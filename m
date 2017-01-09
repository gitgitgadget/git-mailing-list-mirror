Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57AB71FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 19:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936874AbdAITy2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 14:54:28 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:51088 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754978AbdAITy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 14:54:26 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 3ty5TD49C6z5tlL;
        Mon,  9 Jan 2017 20:54:24 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 58F593AB;
        Mon,  9 Jan 2017 20:54:24 +0100 (CET)
Subject: Re: [PATCH] Makefile: POSIX windres
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20170107214110.3124-1-svnpenn@gmail.com>
 <xmqqtw99x70u.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1701090903500.3469@virtualbox>
Cc:     Steven Penny <svnpenn@gmail.com>, git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <69ad0a2b-2005-4845-7400-9951a0811c1c@kdbg.org>
Date:   Mon, 9 Jan 2017 20:54:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1701090903500.3469@virtualbox>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.01.2017 um 09:09 schrieb Johannes Schindelin:
> Hi Junio,
>
> On Sun, 8 Jan 2017, Junio C Hamano wrote:
>
>> Steven Penny <svnpenn@gmail.com> writes:
>>
>>> When environment variable POSIXLY_CORRECT is set, the "input -o
>>> output" syntax is not supported.
>>>
>>> http://cygwin.com/ml/cygwin/2017-01/msg00036.html
>>>
>>> Signed-off-by: Steven Penny <svnpenn@gmail.com>
>>> ---
>>
>> Who other than cygwin build uses this target?  Git for Windows?
>
> Yes, Git for Windows uses this target, as did msysGit (and I suspect
> Hannes' setup).

The patch works for me, too.

-- Hannes

