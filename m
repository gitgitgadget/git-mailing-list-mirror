Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 028841F4BD
	for <e@80x24.org>; Sun,  6 Oct 2019 22:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfJFWk0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Oct 2019 18:40:26 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:43489 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbfJFWkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Oct 2019 18:40:25 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iHFCQ-0001mn-5J; Sun, 06 Oct 2019 23:40:23 +0100
Subject: Re: [PATCH] Feature: custom guitool commands can now have custom
 keyboard shortcuts
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Pratyush Yadav <me@yadavpratyush.com>
Cc:     Harish Karumuthil <harish2704@gmail.com>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>
References: <01020153c22ab06b-e195b148-37cc-4f89-92f3-f4bed1915eb9-000000@eu-west-1.amazonses.com>
 <20160331164137.GA11150@gmail.com>
 <CACV9s2MFiikZWq=s8kYQ+qwidQ=oO-SHyKWAs4MUkNcgDhJzeg@mail.gmail.com>
 <CACV9s2MQCP04QASgt0xhi3cSNPSKjwXTufxmZQXAUNvnWD9DSw@mail.gmail.com>
 <20191003214422.d4nocrxadxt47smg@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1910041046000.46@tvgsbejvaqbjf.bet>
 <20191004120107.kpskplwhflnsamwu@yadavpratyush.com>
 <149a83fd40b71896b134b16c2b499ff472c6234e.camel@gmail.com>
 <20191005210127.uinrgazj5ezyqftj@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1910061054470.46@tvgsbejvaqbjf.bet>
 <20191006183948.5n23sdy2l4uwl6kb@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1910062208460.46@tvgsbejvaqbjf.bet>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <f0c10e8e-75e3-bebd-4912-d2b5ecd3fa5c@iee.email>
Date:   Sun, 6 Oct 2019 23:40:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1910062208460.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On 06/10/2019 21:27, Johannes Schindelin wrote:
> Let me provide you with some data, then. Granted, it's not necessarily
> all Git GUI, but it includes Git GUI patches, too: Git for Windows'
> contributions.
>
> As should be well-known, I try to follow Postel's Law when it comes to
> Git for Windows' patches: be lenient in the input, strict in the output.
> As such, I don't force contributors to use GitHub PRs (although that is
> certainly encouraged by virtue of Git for Windows' source code being
> hosted on GitHub), or send patches, or send pull requests to their own
> public repositories or bundles sent to the mailing list. I accept them
> all. At least that is the idea.
>
> I cannot tell you how many contributions came in via GitHub PRs. I can
> tell precisely you how many contributions were made_not_  using GitHub
> PRs. One one hand. Actually, on zero hands.
>
> So clearly, at least Git for Windows' contributors (including some who
> provided Git GUI patches) are much more comfortable with the PR workflow
> than with the mailing list-based workflow.
Just to say that most of the numbers are governed by the strength and 
experience with the particular infrastructures.

Tonight I had wanted to send in patches for G-f-W because of branch 
placement confusion. Eventually I had to throw in an extra rebase to a 
fresh branch, just so I could create a PR, all because of the zero 
experience you mentioned with using a G-f-W 2-patch series.

The Git list is strongly patch based and it's infrastructure works 
adequately, even if it is 'antiquated' by millennial standards.

The G-f-W interaction is almost totally via Github, and a few 
notification emails and occasional google-groups interactions. It's 
still imperfect, just like the Git list emails, but with it's own, 
different issues for trying to build its community.

Most community bondings actually build through their common adversity, 
rather than the apparent ease of joining/leaving.

The main bit I wanted to say (I think), was that having a maintainer who 
accepts input is probably the most important aspect, no matter the 
particular route used for the input. So thanks to both of you (Dscho, 
Pratyush) for *facilitating* the contribution flow.
-- 
Philip
