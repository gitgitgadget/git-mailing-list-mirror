Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31B7C1F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 18:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbfJBSs7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 14:48:59 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:56889 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfJBSs7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 14:48:59 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 46k4t05gqnz5tlC;
        Wed,  2 Oct 2019 20:48:56 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 60719106;
        Wed,  2 Oct 2019 20:48:56 +0200 (CEST)
Subject: Re: git-gui: disable the "loose objects popup" dialog?
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Git List <git@vger.kernel.org>
References: <CAGr--=K15nUcnsJWOP87uMMjeQmTgAeO_6hnr12k2zuNQjNyBw@mail.gmail.com>
 <91e5b3b0-08f9-66a8-ebdf-90effd34c888@kdbg.org>
 <20190926191545.ro7w6lbtlpbyxpk7@yadavpratyush.com>
 <9d77189d-a357-ab0a-6cb5-e87ecdeffb91@kdbg.org>
 <20191001180005.iemqmlbn7ncv3dav@yadavpratyush.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <493aa11d-21db-e759-6be3-2c6b8f287a0b@kdbg.org>
Date:   Wed, 2 Oct 2019 20:48:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191001180005.iemqmlbn7ncv3dav@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.10.19 um 20:00 schrieb Pratyush Yadav:
> So here's what I propose: why don't we try to do something similar? What 
> about running `git-gc --auto` in the background when the user makes a 
> commit (which I assume is the most common operation in git-gui). This 
> would be disabled when the user sets gc.auto to 0.

Sounds good.

-- Hannes
