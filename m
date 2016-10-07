Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A56F4207EC
	for <e@80x24.org>; Fri,  7 Oct 2016 05:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756161AbcJGFwE (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 01:52:04 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:28711 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751608AbcJGFwB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 01:52:01 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3sqzDZ0yCPz5tlF;
        Fri,  7 Oct 2016 07:51:58 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 289365301;
        Fri,  7 Oct 2016 07:51:57 +0200 (CEST)
Subject: Re: [PATCH 2/4] mergetool: move main program flow into a main()
 function
To:     David Aguilar <davvid@gmail.com>
References: <1475797679-32712-1-git-send-email-davvid@gmail.com>
 <1475797679-32712-2-git-send-email-davvid@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Luis Gutierrez <luisgutz@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <49cabceb-fdff-3ccb-b25d-ade9b08bdda2@kdbg.org>
Date:   Fri, 7 Oct 2016 07:51:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1475797679-32712-2-git-send-email-davvid@gmail.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.10.2016 um 01:47 schrieb David Aguilar:
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---

An answer to "why?" is missing here. I guess it is just so that 
everything happens in functions, and that there is only the invocation 
of main at the top-level of the script. I am unsure whether this is 
sufficient justification; you are adding a level of indentation after all.

-- Hannes

