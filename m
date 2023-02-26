Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00910C64ED6
	for <git@archiver.kernel.org>; Sun, 26 Feb 2023 08:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBZIPr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Feb 2023 03:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjBZIPq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2023 03:15:46 -0500
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACABDBDC
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 00:15:45 -0800 (PST)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 4323D1F47D;
        Sun, 26 Feb 2023 08:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1677399345;
        bh=3EguquxAXV3zPVdrEqDipGtVsm3v92l8hM1bWaPOy0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ur+F7jZY2z7zBKSwAt7ZwPQMXbJhFsK68DfaIWXNKh7/Zc3VdTd6Mb5KaDmh4KTJg
         I0ti803tgk2LJHrYCDiOuiI0QmzWQiTy+eB2FYg8ATzplLeW2IP77OJBp4ZtJqMAys
         CjqPCKb4ofElHkhfKlnVtsFBmxHrVai+b+PjeXb4=
Date:   Sun, 26 Feb 2023 08:15:45 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2023, #05; Fri, 24)
Message-ID: <20230226081545.M216523@dcvr>
References: <xmqq1qmeyfps.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1qmeyfps.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> [New Topics]

Any feedback for <20230212090426.M558990@dcvr>?
([PATCH v2] fetch: support hideRefs to speed up connectivity checks)

Thanks.
