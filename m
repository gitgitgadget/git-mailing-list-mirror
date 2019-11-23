Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A08C432C0
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 00:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F76D2072D
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 00:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfKWAI3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 19:08:29 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:33138 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfKWAI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 19:08:29 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 20E541F463;
        Sat, 23 Nov 2019 00:08:29 +0000 (UTC)
Date:   Sat, 23 Nov 2019 00:08:28 +0000
From:   Eric Wong <e@80x24.org>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] git svn: stop using `rebase --preserve-merges`
Message-ID: <20191123000828.GA15493@dcvr>
References: <pull.295.git.1574463569.gitgitgadget@gmail.com>
 <c123d93ae7361b53b9d1d76124aefcb09740f0eb.1574463569.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c123d93ae7361b53b9d1d76124aefcb09740f0eb.1574463569.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com> wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> We deprecated `--preserve-merges` in favor of `--rebase-merges`; Let's
> reflect that in `git svn`.
> 
> Note: Even when the user asks for `--preserve-merges`, we now silently
> pass `--rebase-merges` to `git rebase` instead. Technically, this is a
> change of behavior. But practically, `git svn` only ever asks for a
> non-interactive rebase, and `--preserve-merges` and `--rebase-merges`
> are on par with regard to that.

I've never used --preserve-merges or --rebase-merges even with
standalone git; but this seems fine as there's no actual
behavior change...

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Acked-by: Eric Wong <e@80x24.org>

Thanks.
