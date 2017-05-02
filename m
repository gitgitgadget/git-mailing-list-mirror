Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E19511F790
	for <e@80x24.org>; Tue,  2 May 2017 15:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750796AbdEBPfh (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 11:35:37 -0400
Received: from siwi.pair.com ([209.68.5.199]:39319 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750710AbdEBPfg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 11:35:36 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 96F2B844C5;
        Tue,  2 May 2017 11:35:34 -0400 (EDT)
Subject: Re: [PATCH 0/5] Start of a journey: drop
 NO_THE_INDEX_COMPATIBILITY_MACROS
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
References: <20170501190719.10669-1-sbeller@google.com>
Cc:     gitster@pobox.com
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <253450f8-4ece-e31b-c139-5d8a3863fb9a@jeffhostetler.com>
Date:   Tue, 2 May 2017 11:35:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170501190719.10669-1-sbeller@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/1/2017 3:07 PM, Stefan Beller wrote:
> This applies to origin/master.
>
> For better readability and understandability for newcomers it is a good idea
> to not offer 2 APIs doing the same thing with on being the #define of the other.
>
> In the long run we may want to drop the macros guarded by
> NO_THE_INDEX_COMPATIBILITY_MACROS. This converts a couple of them.
>
> My main reason for this patch is to try out coccinelle as well as a
> discussion I had off list about maintainability of software.
>
> I just made these patches and wonder if now is a good time to pull through and
> convert the rest as well?
>

You may also want to look at unpack-trees.c : mark_new_skip_worktree().
It has a local variable named "the_index" in the argument list.
You may want to rename this to avoid confusion.

Jeff

