Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 543631FC44
	for <e@80x24.org>; Tue, 14 Feb 2017 06:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751023AbdBNGOF (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 01:14:05 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:20363 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750818AbdBNGOE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 01:14:04 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 3vMsZ12Ltyz5tlh;
        Tue, 14 Feb 2017 07:14:01 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id D30531E70;
        Tue, 14 Feb 2017 07:14:00 +0100 (CET)
Subject: Re: [PATCH] mingw: use OpenSSL's SHA-1 routines
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <6a29f8c60d315a24292c1fa9f5e84df4dfdbf813.1486679254.git.johannes.schindelin@gmx.de>
 <20170210050237.gajicliueuvk6s5d@sigill.intra.peff.net>
 <alpine.DEB.2.20.1702101647340.3496@virtualbox>
 <20170210160458.pcp7mupdz24m6cms@sigill.intra.peff.net>
 <9913e513-553e-eba6-e81a-9c21030dd767@kdbg.org>
 <xmqq60kdev2r.fsf@gitster.mtv.corp.google.com>
 <b530c820-9956-4396-d853-c7d70ccaf11d@kdbg.org>
 <alpine.DEB.2.20.1702132337470.3496@virtualbox>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <6c2bbca7-7a8f-d3d8-04b6-31494a3e1b43@kdbg.org>
Date:   Tue, 14 Feb 2017 07:14:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1702132337470.3496@virtualbox>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.02.2017 um 23:38 schrieb Johannes Schindelin:
> In addition, you build from a custom MINGW/MSys1 setup, correct?

Correct. Specifically, I use the build tools from "msysgit" times, but 
build outside the premanufactured build environement; i.e., the 
"THIS_IS_MSYSGIT" section in config.mak.uname is not used.

-- Hannes

