Return-Path: <SRS0=RoqO=ZW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531F9C432C0
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 22:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D42820833
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 22:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfK3WQd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Nov 2019 17:16:33 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:12974 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbfK3WQc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Nov 2019 17:16:32 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 47QQhD6qPNz5tl9;
        Sat, 30 Nov 2019 23:16:28 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 5AC411BFA;
        Sat, 30 Nov 2019 23:16:28 +0100 (CET)
Subject: Re: [PATCH 1/1] mingw: do set `errno` correctly when trying to
 restrict handle inheritance
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.480.git.1575063876.gitgitgadget@gmail.com>
 <685360f735e35e837bc9ef684cbde33564c81666.1575063876.git.gitgitgadget@gmail.com>
 <52f2fe39-6a71-a327-8aea-ba757b7eec18@kdbg.org>
 <nycvar.QRO.7.76.6.1911302303510.31080@tvgsbejvaqbjf.bet>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <4c8dc4c9-6d37-6879-d535-2ed4f17f2b81@kdbg.org>
Date:   Sat, 30 Nov 2019 23:16:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1911302303510.31080@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.11.19 um 23:06 schrieb Johannes Schindelin:
> Are you building with `NO_GETTEXT` perchance? I ask because gettext
> overrides `vsnprintf()` with their own version, which is obviously quite
> different from the version MSVCRT provides... and the former version is
> what I use, and what all those CI/PR builds use.

Indeed, I build with NO_GETTEXT.

-- Hannes
