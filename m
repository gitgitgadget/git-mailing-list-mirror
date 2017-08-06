Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B25D82047F
	for <e@80x24.org>; Sun,  6 Aug 2017 08:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751262AbdHFIeg (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Aug 2017 04:34:36 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:40201 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751179AbdHFIef (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Aug 2017 04:34:35 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 3xQDVK6ckkz5tlB;
        Sun,  6 Aug 2017 10:34:33 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 2AF28248;
        Sun,  6 Aug 2017 10:34:33 +0200 (CEST)
Subject: Re: [git-for-windows] [ANNOUNCE] Git for Windows 2.14.0
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20170805230001.3232-1-johannes.schindelin@gmx.de>
Cc:     git-for-windows@googlegroups.com, git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <c532df98-b020-810a-c378-04c7dd5b0fa7@kdbg.org>
Date:   Sun, 6 Aug 2017 10:34:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170805230001.3232-1-johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.08.2017 um 01:00 schrieb Johannes Schindelin:
> Dear Git users,
> 
> It is my pleasure to announce that Git for Windows 2.14.0 is available from:
> 
> 	https://git-for-windows.github.io/
> 
> Changes since Git for Windows v2.13.3 (July 13th 2017)

Thank you so much! One question, though:

> New Features
>...
>    * Comes with [BusyBox v1.28.0pre.15857.9480dca7c](https://github.com/
>      git-for-windows/busybox-w32/commit/9480dca7c].

What is the implication of this addition? I guess it is not just for the 
fun of it. Does it mean that all POSIX command line tools invoked by Git 
including a POSIX shell are now routed through busybox instead of the 
MSYS2 variant?

-- Hannes
