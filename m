Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 939982047F
	for <e@80x24.org>; Mon,  7 Aug 2017 17:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbdHGRcA (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 13:32:00 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:31764 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751426AbdHGRb7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 13:31:59 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 3xR4Mx6Tqzz5tlH;
        Mon,  7 Aug 2017 19:31:57 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 553291A25;
        Mon,  7 Aug 2017 19:31:57 +0200 (CEST)
Subject: Re: [git-for-windows] [ANNOUNCE] Git for Windows 2.14.0
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git-for-windows@googlegroups.com, git@vger.kernel.org
References: <20170805230001.3232-1-johannes.schindelin@gmx.de>
 <c532df98-b020-810a-c378-04c7dd5b0fa7@kdbg.org>
 <alpine.DEB.2.21.1.1708071147430.4271@virtualbox>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <f92fcfeb-75b9-6ee2-0bc0-a42d1dc01ebd@kdbg.org>
Date:   Mon, 7 Aug 2017 19:31:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1708071147430.4271@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.08.2017 um 12:02 schrieb Johannes Schindelin:
> On Sun, 6 Aug 2017, Johannes Sixt wrote:
>> Am 06.08.2017 um 01:00 schrieb Johannes Schindelin:
>>>     * Comes with [BusyBox v1.28.0pre.15857.9480dca7c](https://github.com/
>>>       git-for-windows/busybox-w32/commit/9480dca7c].
>>
>> What is the implication of this addition? I guess it is not just for the
>> fun of it. Does it mean that all POSIX command line tools invoked by Git
>> including a POSIX shell are now routed through busybox instead of the
>> MSYS2 variant?
> 
> As I wrote a little later:
> 
> * Git for Windows releases now also include an experimental [BusyBox-based
>    MinGit](https://github.com/git-for-windows/git/wiki/MinGit#experimental-busybox-based-mingit).

Thanks for the clue. It's an interesting concept. I would be interested 
in replacing my old MSYS environment by BusyBox. At best, it would be 
just a matter of replacing sh.exe.

-- Hannes
