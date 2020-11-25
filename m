Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDABC5519F
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 12:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14FB6206F7
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 12:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbgKYMb1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 07:31:27 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:13724 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbgKYMb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 07:31:26 -0500
Received: from host-89-243-187-160.as13285.net ([89.243.187.160] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1khtxE-0001Qy-DX; Wed, 25 Nov 2020 12:31:24 +0000
Subject: Re: [PATCH v8 08/10] pull: add pull.mode
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
References: <20201125032938.786393-1-felipe.contreras@gmail.com>
 <20201125032938.786393-9-felipe.contreras@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <a3be85cd-a01a-4ed9-bf98-09785e79fb85@iee.email>
Date:   Wed, 25 Nov 2020 12:31:22 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201125032938.786393-9-felipe.contreras@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Accidental repetition of phrasing from branch.<name>.pullmode ?

On 25/11/2020 03:29, Felipe Contreras wrote:
> +pull.mode::
> +	When "git pull" is run, this determines if it would either merge or
> +	rebase the fetched branch. The possible values are 'merge',
> +	and 'rebase'. See "branch.<name>.pullmode" for doing
> +	this in a non branch-specific manner.
> +
s/non//

Same problem in 09/10 I think.
I didn't check the code... Spotted while browsing.
--
Philip
