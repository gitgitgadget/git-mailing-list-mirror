Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADCFC433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 14:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF7AD6113A
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 14:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348376AbhDGOXa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 10:23:30 -0400
Received: from w4.tutanota.de ([81.3.6.165]:41778 "EHLO w4.tutanota.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348250AbhDGOX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 10:23:29 -0400
Received: from w3.tutanota.de (unknown [192.168.1.164])
        by w4.tutanota.de (Postfix) with ESMTP id 942FE1060E09
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 14:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1617805396;
        s=s1; d=tutanota.com;
        h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
        bh=FyJSbyhQVlfWXyydijc/pVt3oZu4UwaVTzj8oUiAndQ=;
        b=J5ouUhvHyoQj1dbT9z3BBfc8JTM+anl0YAWvlkH5o9f1K3jI7Byw8tqgrs3pOFYo
        6YudXAKKgF/KSLuyJPq2WfIyM1n2PVbR7arJF7CTt68GVRCvIUymutToJklz6kKV1Mo
        dInxR9cvuv3kZ89qxpWgTiIqYECCclQ3Kp0Jzfmgk/tozCTPS8sz0p+iTUHwWXndZ1b
        zfb3zxeaV1v9zGRiMx+2LTIKeBJrGSinNxxwF9ykCMCCrBzSmt1lkBPJ6zQsUX697jd
        WGoPDHtb651BzjZsNvqV80ICaUefOEelnST7mJnOBf2L+tRD5HoJ3ReYmu8q+OD+028
        0cYi1Se+/g==
Date:   Wed, 7 Apr 2021 16:23:16 +0200 (CEST)
From:   jost.schulte@tutanota.com
To:     Git <git@vger.kernel.org>
Message-ID: <MXghkzG----2@tutanota.com>
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

