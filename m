Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00FEF1F424
	for <e@80x24.org>; Mon, 18 Dec 2017 21:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937781AbdLRVzQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 16:55:16 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:29566 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935229AbdLRVzP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 16:55:15 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3z0vwJ6dg8z5tlY;
        Mon, 18 Dec 2017 22:55:12 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id BC2B941DD;
        Mon, 18 Dec 2017 22:55:11 +0100 (CET)
Subject: Re: [PATCH v1] convert: add support for 'encoding' attribute
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, patrick@luehne.de,
        Lars Schneider <larsxschneider@gmail.com>
References: <20171211155023.1405-1-lars.schneider@autodesk.com>
 <a07a0b5c-453a-f644-d5e5-7d185a943088@kdbg.org>
 <20171218101334.GA20685@tor.lan>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <c86c6f68-e78c-a36c-80e1-5d63e8f9d4d9@kdbg.org>
Date:   Mon, 18 Dec 2017 22:55:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171218101334.GA20685@tor.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.12.2017 um 11:13 schrieb Torsten Bögershausen:
> Just to confirm my missing knowledge here:
> Does this mean, that git-gui and gitk can decode/reencode
> the content of a file/blob, when the .gitattributes say so ?

No. I think they parse the output of git-diff et.al., split it per file, 
and then consult .gitattributes to interpret the byte sequence according 
to the encoding.

-- Hannes
