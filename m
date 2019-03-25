Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7EF420248
	for <e@80x24.org>; Mon, 25 Mar 2019 07:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbfCYHOQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 03:14:16 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:52497 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729792AbfCYHOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 03:14:16 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 44SQVY72RPz5tlL;
        Mon, 25 Mar 2019 08:14:13 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 07EA049BF;
        Mon, 25 Mar 2019 08:14:12 +0100 (CET)
Subject: Re: How to disable docs when building Git from sources
To:     noloader@gmail.com
References: <CAH8yC8mDWpf0b3zykyvHRLLbYdmLB7hAk9LcsciB=dYhs4C=VA@mail.gmail.com>
Cc:     Git List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <27b99f79-7a6a-1205-b528-84fd81433e0e@kdbg.org>
Date:   Mon, 25 Mar 2019 08:14:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAH8yC8mDWpf0b3zykyvHRLLbYdmLB7hAk9LcsciB=dYhs4C=VA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.03.19 um 07:40 schrieb Jeffrey Walton:
> I'm working on a low-resource dev-board. It is missing a lot of
> utilities to save space. I'm building Git 2.20 from sources. Make is
> failing due to '/bin/sh: 1: msgfmt: not found'. I don't cross-compile
> because that's a bigger pain in the ass than waiting for the native
> build to finish.
> 
> I ran './configure --help' but I don't see a way to disable the docs.
> In the past I tired --disable-docs but it had no effect.
> 
> How do I disable the docs?

These are message translations, not documentation. To disable them, set

NO_GETTEXT=Yes

in your config.mak.

-- Hannes
