Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E1371FF32
	for <e@80x24.org>; Tue, 17 Oct 2017 17:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933298AbdJQRaJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 13:30:09 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:31812 "EHLO bsmtp8.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753302AbdJQRaI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 13:30:08 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp8.bon.at (Postfix) with ESMTPSA id 3yGhz23LWZz5tlK;
        Tue, 17 Oct 2017 19:30:06 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id CEDB3252;
        Tue, 17 Oct 2017 19:30:05 +0200 (CEST)
Subject: Re: [PATCH/RFC] git-post: the opposite of git-cherry-pick
To:     Rafael Ascensao <rafa.almas@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>
References: <c6b52120-98bf-d685-6dc0-3c83e9e80d30@kdbg.org>
 <CAGZ79kbr=zBc5GEL7hYyCnBcbdE8ZRp65QwxKMUVsQ+qXvRAAw@mail.gmail.com>
 <3d362037-3eb6-83db-a17f-47a984135580@kdbg.org>
 <87wp3zs4la.fsf@evledraar.booking.com>
 <33f7d379-126d-e27e-7dbf-616f5dfbc98a@kdbg.org>
 <CACUQV593kzMrtc4ENgD=6bBQcn0DXGRcyB7teCvGWk_QNtS98Q@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <d3ccfb02-004a-bbc3-af33-967db280c940@kdbg.org>
Date:   Tue, 17 Oct 2017 19:30:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CACUQV593kzMrtc4ENgD=6bBQcn0DXGRcyB7teCvGWk_QNtS98Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.10.2017 um 01:01 schrieb Rafael Ascensao:
>> This is worth discussing, though not my preference. The picture to "pick
>> cherries" has become quite common, and now that we use it for the name of
>> the command, "cherry-pick", the direction of flow is quite obvious and
>> strongly implied: from somewhere else to me (and not to somebody else).
> 
> What if we borrow '--onto' from rebase and make it cherry-pick --onto
> <destination>?

I actually like this. Although I would miss the convenience that the 
source defaults to HEAD. Unless we make a special case for --onto, that 
is, of course.

-- Hannes
