Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1F7C433B4
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 14:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36DC6611C1
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 14:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348360AbhDGOX3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 10:23:29 -0400
Received: from w4.tutanota.de ([81.3.6.165]:41776 "EHLO w4.tutanota.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233367AbhDGOX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 10:23:28 -0400
Received: from w3.tutanota.de (unknown [192.168.1.164])
        by w4.tutanota.de (Postfix) with ESMTP id 52F631060E03
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 14:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1617805396;
        s=s1; d=tutanota.com;
        h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
        bh=FyJSbyhQVlfWXyydijc/pVt3oZu4UwaVTzj8oUiAndQ=;
        b=MHEmbfjLvQt/UPrm8cgxJU7TkIXri7g+lCAihig4YTkgx1XfN5dRTH8NkOFMTgPY
        Lrk2iA4oAFJbfB67xD02NjtopLRFmPLQFKlRTQ9Oprpkv1mas6LnE89VmO+rEDL6ZR6
        hY76RuuhvwvjiD/j4fo2ra5h2s03r6Zj3JcclARwVl+PnbEVCOAXV5yNrWQmCSDbl0s
        wflyX+0/AR2LnL3FxZTgGkZNjRuv9xx5h8mg+qMeM+AHyo3Lyfh6sgB7atvVx4dYm0+
        1M6JCh8V5N8ONmB3qaJJHuNzeq1MvV63nFZFpenBFo/q8TgQsNPPq4jGj8xFXoORZXa
        67BURQanVA==
Date:   Wed, 7 Apr 2021 16:23:16 +0200 (CEST)
From:   jost.schulte@tutanota.com
To:     Git <git@vger.kernel.org>
Message-ID: <MXghkzC----2@tutanota.com>
Subject: Shell completion for branch names
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello guys,

I have a question regarding git-completion. I'm using zsh and have added the function .git-completion.bash. That gives me some auto-completion for branch names.

What I'm looking for: I have a branch named "feature/issue-123-add-feature" for example. I'd like to type "git switch 123[tab]". Is there some function out there that provides this?

Cheers
Jost

