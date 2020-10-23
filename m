Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898AAC4363A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 14:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2031521527
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 14:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465184AbgJWOYI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 10:24:08 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:10970 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2901005AbgJWOYI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 10:24:08 -0400
Received: from host-89-243-187-160.as13285.net ([89.243.187.160] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1kVxzB-0000XX-9H; Fri, 23 Oct 2020 15:24:06 +0100
Subject: Re: Antw: [EXT] Re: Help understanding unexpected diff output
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>, gitster@pobox.com
Cc:     git@vger.kernel.org
References: <5F0C38BB020000A100039FF0@gwsmtp.uni-regensburg.de>
 <5F0C38BB020000A100039FF0@gwsmtp.uni-regensburg.de>
 <xmqqsgdvo3ec.fsf@gitster.c.googlers.com>
 <5F0D7252020000A10003A03E@gwsmtp.uni-regensburg.de>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <1be0d453-692a-faf7-c72d-225ee7aa12d6@iee.email>
Date:   Fri, 23 Oct 2020 15:24:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <5F0D7252020000A10003A03E@gwsmtp.uni-regensburg.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ulrich,
(only just catching up with intriguing queries)

On 14/07/2020 09:52, Ulrich Windl wrote:
> some lines that are not
> changed were reorderd

It may be me, but I think your comment above is at the core of the
unexpected diff output.

If text is moved, then normally it will (obviously?) require something
within the diff report to say where it was removed from, and then where
it was inserted. It seems like your expectation in your use-case was
that the moved line changes wouldn't be shown.

I don't believe there is an `--ignore-moved-lines` option, but if
there's a good rationale / use-case for it, then maybe it's something to
look at coding.

--
Philip
