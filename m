Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3535F2070A
	for <e@80x24.org>; Tue,  5 Jul 2016 20:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599AbcGEU0A (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 16:26:00 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:47503 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753228AbcGEU0A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 16:26:00 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3rkb4P3k7Wz5tlG;
	Tue,  5 Jul 2016 22:25:57 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 7D5A352D9;
	Tue,  5 Jul 2016 22:25:56 +0200 (CEST)
Subject: Re: [PATCH 3/5] index-pack: correct "len" type in unpack_data()
To:	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
References: <1466807902.28869.8.camel@gmail.com>
 <20160705170558.10906-1-pclouds@gmail.com>
 <20160705170558.10906-4-pclouds@gmail.com>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	michelbach94@gmail.com
From:	Johannes Sixt <j6t@kdbg.org>
Message-ID: <577C17D4.6080708@kdbg.org>
Date:	Tue, 5 Jul 2016 22:25:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <20160705170558.10906-4-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 05.07.2016 um 19:05 schrieb Nguyễn Thái Ngọc Duy:
> +			die(Q_("premature end of pack file, %"PRIuMAX" byte missing",
> +			       "premature end of pack file, %"PRIuMAX" bytes missing",

I would be surprised if this form of translation worked...

> +			       (unsigned int)len),
> +			    (uintmax_t)len);

-- Hannes

