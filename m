Return-Path: <SRS0=OyOp=6K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C109AC55191
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 10:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A80C620728
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 10:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgDZKA5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Apr 2020 06:00:57 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:40940 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgDZKA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Apr 2020 06:00:56 -0400
Received: from [92.30.123.115] (helo=[192.168.1.39])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jSe5m-000BG5-Cb; Sun, 26 Apr 2020 11:00:55 +0100
Subject: Re: [PATCH] config: use GIT_CONFIG in git config sequence
To:     Matt Rogers <mattr94@gmail.com>,
        =?UTF-8?Q?Mateusz_Nowoty=c5=84ski?= <maxmati4@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, bwilliams.eng@gmail.com
References: <20200425235716.1822560-1-maxmati4@gmail.com>
 <CAOjrSZs33-CqV5m4wKROYJT8au1hup7bGZWiEaXMV7cU4p-J=Q@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <ff9a63d4-80e4-8090-c85c-03fd3ab43c55@iee.email>
Date:   Sun, 26 Apr 2020 11:00:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAOjrSZs33-CqV5m4wKROYJT8au1hup7bGZWiEaXMV7cU4p-J=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matt,

On 26/04/2020 02:12, Matt Rogers wrote:
> This would need an appropriate addition to show-scope functionality in order
> to be considered complete too, as I believe the current code would give it a
> scope of "unknown" which is obviously incorrect since we know the scope.
>
Given the extra config environment settings, could/should the
--show-scope (or complementary option) also show/clarify these
environment variable settings?
--
Philip
