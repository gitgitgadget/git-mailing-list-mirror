Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C7DB215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 19:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754772AbeD3TRp (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 15:17:45 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:48010 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753482AbeD3TRo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 15:17:44 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 40ZZ7B5VXXz5tl9;
        Mon, 30 Apr 2018 21:17:42 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 8A0411C94;
        Mon, 30 Apr 2018 21:17:41 +0200 (CEST)
Subject: js/no-pager-shorthand [was: What's cooking in git.git (Apr 2018, #04;
 Mon, 30)]
To:     Junio C Hamano <gitster@pobox.com>
References: <xmqq4ljtz87g.fsf@gitster-ct.c.googlers.com>
Cc:     git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <918c69be-89ce-c66d-92ee-4821e9412793@kdbg.org>
Date:   Mon, 30 Apr 2018 21:17:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqq4ljtz87g.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.04.2018 um 05:25 schrieb Junio C Hamano:
> * js/no-pager-shorthand (2018-04-25) 1 commit
>   - git: add -N as a short option for --no-pager
> 
>   "git --no-pager cmd" did not have short-and-sweet single letter
>   option. Now it does.
> 
>   Will merge to 'next'.

I consider your argument that -N is only an abbreviation for an 
unspecific "no" a valid one. So, I would like to be sure that we are not 
painting us into the wrong corner by squatting -N for --no-pager.

I find -P is not that bad after all.

-- Hannes
