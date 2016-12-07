Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF27C1FC96
	for <e@80x24.org>; Wed,  7 Dec 2016 00:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753123AbcLGARh (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 19:17:37 -0500
Received: from mx1.2b3w.ch ([92.42.186.250]:42526 "EHLO mx1.2b3w.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752035AbcLGARf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 19:17:35 -0500
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
        by mx1.2b3w.ch (Postfix) with ESMTP id EEBB6C3450;
        Wed,  7 Dec 2016 01:17:31 +0100 (CET)
Received: from mcmini.bolli (215-243-153-5.dyn.cable.fcom.ch [5.153.243.215])
        by mx1.2b3w.ch (Postfix) with ESMTPSA id BD182C3444;
        Wed,  7 Dec 2016 01:17:31 +0100 (CET)
Subject: Re: [PATCH v4 1/3] update-unicode.sh: automatically download newer
 definition files
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
References: <835c0328-e812-1cb7-c49e-714ff0e9ffb3@drbeat.li>
 <1480798849-13907-1-git-send-email-dev+git@drbeat.li>
 <20161204075800.GA2415@tb-raspi>
 <xmqqmvga3yod.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   Beat Bolli <dev+git@drbeat.li>
Message-ID: <c35518dc-5278-bd89-569c-398e70aa8dc8@drbeat.li>
Date:   Wed, 7 Dec 2016 01:17:31 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <xmqqmvga3yod.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05.12.16 21:31, Junio C Hamano wrote:
> Torsten Bögershausen <tboegi@web.de> writes:
> 
>> On Sat, Dec 03, 2016 at 10:00:47PM +0100, Beat Bolli wrote:
>>> Checking just for the unicode data files' existence is not sufficient;
>>> we should also download them if a newer version exists on the Unicode
>>> consortium's servers. Option -N of wget does this nicely for us.
>>>
>>> Reviewed-by: Torsten Boegershausen <tboegi@web.de>
>>
>> Minor remark (Not sure if this motivates v5, may be Junio can fix it locally?)
>> s/oe/ö/
>>
>> Beside this: Thanks again (and I learned about the -N option of wget)
> 
> Will fix up while queuing (only 1/3 needs it, 2/3 has it right).
> 
> Also, I'll do s/update-unicode.sh/update_unicode.sh/ on the title
> and the message to match the reality.  At some point we might want
> to fix the reality to match people's expectations, though.

Thanks, Junio. This was a bit sloppy of me.

I really appreciate your regard for the small things!

Cheers, Beat
