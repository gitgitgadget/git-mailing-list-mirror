Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 754261F859
	for <e@80x24.org>; Sat, 27 Aug 2016 07:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbcH0HWP (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Aug 2016 03:22:15 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:9090 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750825AbcH0HWO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2016 03:22:14 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 3sLq8t5fjTz5tlC;
        Sat, 27 Aug 2016 09:21:34 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id F3AC15237;
        Sat, 27 Aug 2016 09:21:33 +0200 (CEST)
Subject: Re: [PATCH 1/2] gitk: align the commit summary format to the
 documentation
To:     Junio C Hamano <gitster@pobox.com>
References: <1472230741-5161-1-git-send-email-dev+git@drbeat.li>
 <xmqqoa4fgzhv.fsf@gitster.mtv.corp.google.com>
Cc:     Beat Bolli <dev+git@drbeat.li>, Heiko Voigt <hvoigt@hvoigt.net>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <a9731f60-5c30-0bc6-f73a-f7ffb7bd4231@kdbg.org>
Date:   Sat, 27 Aug 2016 09:21:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2
MIME-Version: 1.0
In-Reply-To: <xmqqoa4fgzhv.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.08.2016 um 20:24 schrieb Junio C Hamano:
> Beat Bolli <dev+git@drbeat.li> writes:
>> In 175d38c ("SubmittingPatches: document how to reference previous commits",
>> 2016-07-28) the format for referring to older commits was specified.
>
> is easier to read when pasted into a sentence than what the recent
> update 175d38ca ("SubmittingPatches: document how to reference
> previous commits", 2016-07-28) suggests to do, i.e.

While it may be easier to read due to the extra mark-up, the resulting 
text where such a quotation appears does not flow well, IMO. A commit 
message text that references another commit reads more fluently without 
the quotes around the summary line because the quoted text is not so 
much a quotation that must be marked, but a parenthetical statement.

I absolutely welcome the proposed change to gitk, because I always edit 
out the double-quotes.

-- Hannes

