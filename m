Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D1622035F
	for <e@80x24.org>; Fri, 28 Oct 2016 18:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964999AbcJ1SQb (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 14:16:31 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:42234 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941632AbcJ1SQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 14:16:27 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3t5Blr0PWsz5tlD;
        Fri, 28 Oct 2016 20:16:23 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id A3802147;
        Fri, 28 Oct 2016 20:16:19 +0200 (CEST)
Subject: Re: [PATCH] attr: convert to new threadsafe API
To:     Stefan Beller <sbeller@google.com>, gitster@pobox.com
References: <xmqqy41a8hxj.fsf@gitster.mtv.corp.google.com>
 <20161027221550.14930-1-sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Johannes.Schindelin@gmx.de, peff@peff.net, simon@ruderich.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <7ce9676b-c43a-337a-b19d-c93d30493dde@kdbg.org>
Date:   Fri, 28 Oct 2016 20:16:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161027221550.14930-1-sbeller@google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.10.2016 um 00:15 schrieb Stefan Beller:
> * use attr_start on Windows to dynamically initialize the Single Big Attr Mutex

I'm sorry, I didn't find time to test the patch on Windows. I won't be 
back at my Windows box before Wednesday.

-- Hannes

