Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52A351F462
	for <e@80x24.org>; Tue, 18 Jun 2019 17:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbfFRRPF (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 13:15:05 -0400
Received: from siwi.pair.com ([209.68.5.199]:10596 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728572AbfFRRPF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 13:15:05 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D4D733F4842;
        Tue, 18 Jun 2019 13:15:03 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:8936:d465:7226:58cb] (unknown [IPv6:2001:4898:a800:1012:3a6a:d465:7226:58cb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 92C033F4857;
        Tue, 18 Jun 2019 13:15:03 -0400 (EDT)
Subject: Re: GIT issue while cloning (fatal: pack is corrupted (SHA1
 mismatch)) !!!
To:     "Vanak, Ibrahim" <ibrahim.vanak@hpe.com>, Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <TU4PR8401MB121664A8A588D799803F1E84E11E0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
 <20190528093728.GA15106@sigill.intra.peff.net>
 <TU4PR8401MB1216A7B920D40B5063123A94E11E0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
 <20190528213004.GF24650@sigill.intra.peff.net>
 <TU4PR8401MB12166DBE2156683ADF28E9A4E11F0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
 <TU4PR8401MB1216339F1E7A378C45DF9B36E11F0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
 <20190530115742.GC31607@sigill.intra.peff.net>
 <TU4PR8401MB12163C00148C39F0083C732DE1ED0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
 <TU4PR8401MB1216962E3F135E850E81E407E1EA0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <6e78d3b7-07f2-f635-1dac-c4d98961b8eb@jeffhostetler.com>
Date:   Tue, 18 Jun 2019 13:15:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <TU4PR8401MB1216962E3F135E850E81E407E1EA0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/18/2019 10:31 AM, Vanak, Ibrahim wrote:
> Hello ALL again,
> 
> Has anyone tested the performance of GIT on HP-UX platform? Can someone please look into the issue we are seeing.
> 
> Thanks,
> Ibrahim


You might try setting some of the GIT_TRACE* environment variables
listed in [1] on both your HP-UX and Linux machines and see if you
can isolate any performance differences between them.


[1] https://git-scm.com/book/en/v2/Git-Internals-Environment-Variables
