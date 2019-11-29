Return-Path: <SRS0=rBju=ZV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F8CC432C0
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 22:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07AB2464F
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 22:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfK2WUC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Nov 2019 17:20:02 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:43557 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbfK2WUB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Nov 2019 17:20:01 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 47Pppk25pdz5tlF;
        Fri, 29 Nov 2019 23:19:58 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id E60C91AE7;
        Fri, 29 Nov 2019 23:19:56 +0100 (CET)
Subject: Re: [PATCH 3/4] mingw: spawned processes need to inherit only
 standard handles
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.670.git.git.1574433665.gitgitgadget@gmail.com>
 <feb197792814701bf36cb15b73e1e73aae2baa4d.1574433665.git.gitgitgadget@gmail.com>
 <00ef72f5-b1fa-f449-0e00-23713bed0187@kdbg.org>
 <nycvar.QRO.7.76.6.1911291036320.31080@tvgsbejvaqbjf.bet>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <dbe065de-dac4-2dbf-0853-b7ea654136de@kdbg.org>
Date:   Fri, 29 Nov 2019 23:19:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1911291036320.31080@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.11.19 um 14:52 schrieb Johannes Schindelin:
> On Thu, 28 Nov 2019, Johannes Sixt wrote:
> Out of curiosity: did you apply the patch on `master`, or on anything
> different?

I tested this on top of e1874e422f3a ("Merge branch 'sg/test-bool-env'
into next", 2019-11-27), which is the commit before 4736894af6a1 ("Merge
branch 'js/mingw-inherit-only-std-handles' into next", 2019-11-27). I
merged your branch up to 9a780a384de2 ("mingw: spawned processes need to
inherit only standard handles", 2019-11-22) (plus one of my own patches
with Makefile adjustments).

> I wonder how you get that ERANGE when I get an ENOENT (and so do all the
> CI/PR builds that did not catch this).

I'll dig into this now.

-- Hannes
