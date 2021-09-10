Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E97C433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64AC8611C5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbhIJP2G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 11:28:06 -0400
Received: from silly.haxx.se ([159.253.31.95]:39692 "EHLO silly.haxx.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234308AbhIJP2G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 11:28:06 -0400
X-Greylist: delayed 384 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Sep 2021 11:28:05 EDT
Received: by silly.haxx.se (Postfix, from userid 1001)
        id DB6E95F6D5; Fri, 10 Sep 2021 17:20:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by silly.haxx.se (Postfix) with ESMTP id DAA1F7DA35;
        Fri, 10 Sep 2021 17:20:24 +0200 (CEST)
Date:   Fri, 10 Sep 2021 17:20:24 +0200 (CEST)
From:   Daniel Stenberg <daniel@haxx.se>
X-X-Sender: dast@silly
To:     Jeff King <peff@peff.net>
cc:     =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 5/8] http: correct version check for
 CURL_HTTP_VERSION_2
In-Reply-To: <YTt1RLty0KDEAio1@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.2109101713110.2614@fvyyl>
References: <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com> <patch-v2-5.8-2567b888c3d-20210910T105523Z-avarab@gmail.com> <YTt1RLty0KDEAio1@coredump.intra.peff.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
X-fromdanielhimself: yes
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 10 Sep 2021, Jeff King wrote:

>> The newest symbol we depend on is CURL_HTTP_VERSION_2. It was added in 
>> 7.33.0, but the CURL_HTTP_VERSION_2 alias we used was added in 7.47.0. So 
>> we could support an even older version here, but let's just correct the 
>> checked version.
>
> Thanks for expanding on the history here. I agree it probably doesn't matter 
> much between the two versions, as they're both 6+ years old (and only about 
> 6 months apart). If somebody has a case where it really matters, they can 
> submit a patch.

Forgive me for digressing a bit here but wow, I *so* appreciate your digging 
into the details of the curl history and the symbols that were introduced when 
etc. I know of no other libcurl-using project with this eye and sense for 
historic details and as the lead maintainer of libcurl I learn a lot here. It 
also keeps me motivated to provide this documentation and work on keeping in 
accurate.

Keep it up! <3

-- 

  / daniel.haxx.se
