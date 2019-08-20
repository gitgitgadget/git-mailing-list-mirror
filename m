Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70BFF1F461
	for <e@80x24.org>; Tue, 20 Aug 2019 21:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730962AbfHTVTw (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 17:19:52 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:18501 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730957AbfHTVTw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 17:19:52 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 46CkFy3JwSz5tl9;
        Tue, 20 Aug 2019 23:19:50 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 04DCC2146;
        Tue, 20 Aug 2019 23:19:50 +0200 (CEST)
Subject: Re: [PATCH 2/3] git-gui: Add the ability to revert selected lines
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20190819214110.26461-1-me@yadavpratyush.com>
 <20190819214110.26461-3-me@yadavpratyush.com>
 <73e63382-4f79-cfd0-47f4-812f9cd4f88b@kdbg.org>
 <20190820192944.gzfwnm52fvb5refq@localhost.localdomain>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <93095b5a-6e15-ce4a-eb9b-22f9528312e1@kdbg.org>
Date:   Tue, 20 Aug 2019 23:19:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820192944.gzfwnm52fvb5refq@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.08.19 um 21:29 schrieb Pratyush Yadav:
> On 20/08/19 09:21PM, Johannes Sixt wrote:
>> Please don't do this. This confirmation dialog is unacceptable in my
>> workflow. I use reversals of hunks and lines frequently, almost like a
>> secondary code editor. My safety net is the undo function of the IDE,
>> which works across reloads that are triggered by these external edits.
>> These confirmations get in the way.
>  
> But not everyone uses an IDE. I use vim and it does not have any such 
> undo feature that works across reloads. Not one I'm aware of anyway. It 
> is absolutely necessary IMO to ask the user for confirmation before 
> deleting their work, unless we have a built in safety net.

But you have a safety net built-in: Commit the work, then do the
reversals in amend-mode. Now you can recover old state to your heart's
content. That's recommended anyway if stuff is potentially precious.

> So how about adding a config option that allows you to disable the 
> confirmation dialog? Sounds like a reasonable compromise to me.

That's always an option. Needless to say that I'd prefer it off by
default; I don't need three safety nets.

-- Hannes
