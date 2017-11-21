Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E811B2036D
	for <e@80x24.org>; Tue, 21 Nov 2017 12:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbdKUMgG (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 07:36:06 -0500
Received: from siwi.pair.com ([209.68.5.199]:58601 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751804AbdKUMgG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 07:36:06 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 6E33D844DB;
        Tue, 21 Nov 2017 07:36:05 -0500 (EST)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 3FDEE844D4;
        Tue, 21 Nov 2017 07:36:05 -0500 (EST)
Subject: Re: [PATCH] list-objects-filter-options: fix up some sparse warnings
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <b1037774-6ae6-630b-f330-e95b1c3d681d@ramsayjones.plus.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <654367f1-bc59-d546-a37d-dcb8f13ca65e@jeffhostetler.com>
Date:   Tue, 21 Nov 2017 07:36:04 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <b1037774-6ae6-630b-f330-e95b1c3d681d@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/20/2017 6:39 PM, Ramsay Jones wrote:
> 
> In particular, sparse complains that the armor_{en,de}code_arg()
> functions are 'not declared - should they be static?'. Since the
> armor_decode_arg() symbol does not require more than file visibility,
> we can simply mark the declaration with static. The armor_encode_arg()
> function has no callers, so we simply remove the (unused) definition.
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
> 
> Hi Jeff,
> 
> If you need to re-roll your 'jh/object-filtering' branch, could you
> please squash this (or something like it) into the relevant patch
> (commit bf0aedcbe1, "list-objects: filter objects in traverse_commit_list",
> 16-11-2017).
> 

thanks for the note.
i'm going to remove these functions completely in my next version.
it was decided that we don't need to do encoding/decoding at this level.

Thanks,
Jeff

