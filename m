Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF21B20229
	for <e@80x24.org>; Fri, 21 Oct 2016 05:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753388AbcJUF1o (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 01:27:44 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:27251 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750857AbcJUF1n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 01:27:43 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3t0Z246NzPz5tlM;
        Fri, 21 Oct 2016 07:27:40 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 7A27C534C;
        Fri, 21 Oct 2016 07:27:40 +0200 (CEST)
Subject: Re: Drastic jump in the time required for the test suite
To:     Jeff King <peff@peff.net>
References: <alpine.DEB.2.20.1610191049040.3847@virtualbox>
 <xmqqbmygmehv.fsf@gitster.mtv.corp.google.com>
 <20161019205638.m3ytxozzmeh47ml2@sigill.intra.peff.net>
 <alpine.DEB.2.20.1610201218060.3264@virtualbox>
 <CAGZ79kZpj5xXHmnA+JfLKdGmgzp7Mut1OsKMOeowpw8m1+aKGA@mail.gmail.com>
 <20161020213803.7d7bymby7pouzij3@sigill.intra.peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <4d97fcc7-d15b-e7d8-c787-483c67d4a66b@kdbg.org>
Date:   Fri, 21 Oct 2016 07:27:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161020213803.7d7bymby7pouzij3@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.10.2016 um 23:38 schrieb Jeff King:
> 	test_cmp () {
> 		# optimize for common "they are the same" case
> 		# without any subshells or subprograms

We do this already on Windows; it's the function mingw_test_cmp in our 
test suite:
https://github.com/git/git/blob/master/t/test-lib-functions.sh#L884-L945

-- Hannes

