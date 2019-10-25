Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 481121F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 15:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502745AbfJYPKi (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 11:10:38 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:55161 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502015AbfJYPKi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 11:10:38 -0400
Received: from [92.30.121.54] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iO1Ea-0003I7-CJ; Fri, 25 Oct 2019 16:10:37 +0100
Subject: Re: .git/binary
To:     =?UTF-8?B?0LHQtdC3INC40LzQtdC90Lg=?= <mykaralw@yandex.ru>,
        git@vger.kernel.org
References: <22757761571993594@vla1-d97dbca235a9.qloud-c.yandex.net>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <b9e29a2f-494b-eebc-a3ee-2a2ed4967d7e@iee.email>
Date:   Fri, 25 Oct 2019 16:10:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <22757761571993594@vla1-d97dbca235a9.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi zvezdochiot,
On 25/10/2019 09:53, без имени wrote:
> Is it possible to add a `.git/binary` configuration file like` .gitignore` to the `git` system with a list of files stored in a single (current) state.
>
Have you looked at the `git help attributes`?
In particular the example

*.jpg		-text

Where the '-text' says no end of lines for conversion (i.e. binary!)


Or were you thinking of some other meaning for "files stored in a single (current) state"?

-- 
Philip

