Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DEFC48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 13:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7081561260
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 13:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbhFRNNX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 09:13:23 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:56364 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231167AbhFRNNX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 09:13:23 -0400
Received: from host-78-147-180-220.as13285.net ([78.147.180.220] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1luEHA-0003uB-Fj; Fri, 18 Jun 2021 14:11:13 +0100
Subject: Re: [PATCH v2 0/3] Make CMake work out of the box
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
References: <pull.970.git.1622828605.gitgitgadget@gmail.com>
 <pull.970.v2.git.1622980974.gitgitgadget@gmail.com>
 <xmqqpmwywl2z.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2106101144050.57@tvgsbejvaqbjf.bet>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <eca54e2b-d79a-5d74-2bcb-71b1ebbedb15@iee.email>
Date:   Fri, 18 Jun 2021 14:11:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2106101144050.57@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/06/2021 10:45, Johannes Schindelin wrote:
> As long as the CI builds pass, I am in favor of integrating the patch
> series.
>
>> I did wonder if we want this to be applicable to the maintenance
>> track for 2.31, though.  There is a textual conflict with the
>> addition of SIMPLE_IPC that happened during 2.32 cycle, which is
>> easily resolvable.
> If it isn't much work, sure. But I would think that developers who want to
> build using Visual Studio really should stay on newer branches.

Ack. Philip
