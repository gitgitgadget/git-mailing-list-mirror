Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 759331F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 20:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbfJYU70 (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 16:59:26 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:25027 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbfJYU70 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 16:59:26 -0400
Received: from [92.30.121.54] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iO6g8-0005qt-5Z; Fri, 25 Oct 2019 21:59:25 +0100
Subject: Re: .git/binary
To:     =?UTF-8?B?0LHQtdC3INC40LzQtdC90Lg=?= <mykaralw@yandex.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <22757761571993594@vla1-d97dbca235a9.qloud-c.yandex.net>
 <b9e29a2f-494b-eebc-a3ee-2a2ed4967d7e@iee.email>
 <24796381572021130@iva7-56e9317134d0.qloud-c.yandex.net>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <5f558e34-bdb2-6656-d2ca-42a2d7cb8874@iee.email>
Date:   Fri, 25 Oct 2019 21:59:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <24796381572021130@iva7-56e9317134d0.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/10/2019 17:32, без имени wrote:
>> Or were you thinking of some other meaning for "files stored in a single (current) state"?
> It means that new versions of files located in `.git / binary` will completely replace old versions in history, and therefore will be in a single (current) state in history. What used to be another version of this file should be ignored (very useful for PNG, JPEG, PDF).
>
"completely replace old versions in history" : but why?
- Is it a space (size on disc, or memory) problem/limitation
- A confidentiality problem?
- A 'must use latest procedure' (always checkout latest instructions) 
problem?
- A synchronisation problem (no adequate diff) needing single line of 
development? (there was a discussion at Git Merge in February about this 
for modified Audio-Visual (AV) files in Games development

“Git for games: current problems and solutions” presentation by John
Austin at Git Merge 2019:
   https://www.youtube.com/watch?v=K3zOhU3NdWA&list=PL0lo9MOBetEFqBue4vNcTEnkBjgIQU1Q3&index=8&t=0s

- Something else?


The main advantage of Git is that it distributes control from some central 'manager' to the individual and does that by taking snapshots and exchanging verification stamps, so the idea of deleting history feels somehow 'wrong', hence the need to understand

-- 
Philip

