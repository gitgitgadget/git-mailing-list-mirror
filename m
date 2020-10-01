Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51599C4727E
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 16:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FEF020897
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 16:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732242AbgJAQmI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Oct 2020 12:42:08 -0400
Received: from siwi.pair.com ([209.68.5.199]:28534 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732048AbgJAQmI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Oct 2020 12:42:08 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 08B5C3F4131;
        Thu,  1 Oct 2020 12:42:08 -0400 (EDT)
Received: from Web02.contoso.com.tw (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id CC82B3F40CB;
        Thu,  1 Oct 2020 12:42:07 -0400 (EDT)
Subject: Re: [RFC PATCH 00/21] [RFC] Parallel checkout
To:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org
Cc:     stolee@gmail.com, jeffhost@microsoft.com
References: <cover.1597093021.git.matheus.bernardino@usp.br>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <956e4570-a42d-d9c6-f904-de9d793852d5@jeffhostetler.com>
Date:   Thu, 1 Oct 2020 12:42:07 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1597093021.git.matheus.bernardino@usp.br>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/10/20 5:33 PM, Matheus Tavares wrote:
> This series adds parallel workers to the checkout machinery. The cache
> entries are distributed among helper processes which are responsible for
> reading, filtering and writing the blobs to the working tree. This
> should benefit all commands that call unpack_trees() or check_updates(),
> such as: checkout, clone, sparse-checkout, checkout-index, etc.

This series looks very good!
Thanks for your attention to detail.

Jeff

