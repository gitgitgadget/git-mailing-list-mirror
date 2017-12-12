Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 198221F407
	for <e@80x24.org>; Tue, 12 Dec 2017 07:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752152AbdLLHJG (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 02:09:06 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:33984 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751507AbdLLHJF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 02:09:05 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3ywrXb6v3pz5tlL;
        Tue, 12 Dec 2017 08:09:03 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 390FE2A79;
        Tue, 12 Dec 2017 08:09:03 +0100 (CET)
Subject: Re: [PATCH v1] convert: add support for 'encoding' attribute
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org,
        gitster@pobox.com, tboegi@web.de, peff@peff.net, patrick@luehne.de
References: <20171211155023.1405-1-lars.schneider@autodesk.com>
 <a07a0b5c-453a-f644-d5e5-7d185a943088@kdbg.org>
 <0BA27EC9-3836-407A-9A8A-52D06B8052AE@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <01dfe614-e707-30f3-6347-bb9bd2e5541c@kdbg.org>
Date:   Tue, 12 Dec 2017 08:09:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <0BA27EC9-3836-407A-9A8A-52D06B8052AE@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.12.2017 um 00:42 schrieb Lars Schneider:
> BTW: I am curios, can you share what encoding you use?
> My main use case is UTF-16 and I was surprised that I haven't
> found a single public repo on github.com with "encoding=utf-16"

Shift-JIS and CP1252. These are used for Windows resource files (*.rc).

-- Hannes
