Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9558B1FAF4
	for <e@80x24.org>; Tue,  7 Feb 2017 09:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751995AbdBGJAJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 04:00:09 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:19206 "EHLO bsmtp5.bon.at"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751094AbdBGJAI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 04:00:08 -0500
Received: from bsmtp4.bon.at (unknown [192.168.181.108])
        by bsmtp5.bon.at (Postfix) with ESMTPS id 3vHdZt6GpMz5vHd
        for <git@vger.kernel.org>; Tue,  7 Feb 2017 10:00:06 +0100 (CET)
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp4.bon.at (Postfix) with ESMTPSA id 3vHdZr3lWdz5tlq;
        Tue,  7 Feb 2017 10:00:04 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 398062824;
        Tue,  7 Feb 2017 10:00:03 +0100 (CET)
Subject: Re: [PATCH v2 0/7] completion bash: add more options and commands
To:     Junio C Hamano <gitster@pobox.com>
References: <20170203110159.377-1-cornelius.weig@tngtech.com>
 <xmqqd1ev100b.fsf@gitster.mtv.corp.google.com>
Cc:     cornelius.weig@tngtech.com, git@vger.kernel.org,
        szeder.dev@gmail.com
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <5c8d6f15-e37f-f92f-5eb3-2e6224b2a92f@kdbg.org>
Date:   Tue, 7 Feb 2017 10:00:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqd1ev100b.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.02.2017 um 22:29 schrieb Junio C Hamano:
> cornelius.weig@tngtech.com writes:
>
>> From: Cornelius Weig <cornelius.weig@tngtech.com>
>>
>> This is the re-roll of patch series <20170122225724.19360-1-cornelius.weig@tngtech.com>.
>>
>> This patch series adds all long-options that are mentioned in the synopsis of
>> the man-page for the respective git-command. There are only a few exceptions,
>> as discussed in the above thread. For example, no unsafe options should be
>> completed.
>> Furthermore, the patches add subommand option completion for git-submodule and
>> git-remote.
>
> Reviewers, do these look good now?

My concerns have been addressed. The patches look good from a cursory read.

-- Hannes

