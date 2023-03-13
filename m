Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A614C61DA4
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 21:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjCMV5W (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 17:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjCMV5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 17:57:16 -0400
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911F68F50B
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 14:57:04 -0700 (PDT)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 9FB6F1F428;
        Mon, 13 Mar 2023 21:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1678744624;
        bh=B1gw04JzKp0yZcReTyUDxIsy4cPkkgnh0E4acoaqW8I=;
        h=Date:From:To:Subject:From;
        b=L0lSJ8qtSM+vXDAuJi1cp0IgOh9/nmUNvuPzFdplWvjDFoGYiQNjneTF5okZ9ImCo
         18hIXa3vSdghntnc54Zli3Lp53qFWBGKNJYjYu/aod5fowibOEJBvn+NAMmIdWf5sd
         2URgEA5MWOFGgRlU8en/PFTXuXRqxPrNQWYq7Z0M=
Date:   Mon, 13 Mar 2023 21:57:04 +0000
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Subject: public-inbox.org/git to be downgraded
Message-ID: <20230313215704.M573757@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Due to increasing costs and inflation, I'll be switching to a
cheaper VPS and likely proxying via ssh tunnel like I do with
<https://80x24.org/lore/>[1]

Reaching me may become less reliable, too, since my MTA is
on the same VPS that's being downgraded.


[1] https://80x24.org/lore/ dogfoods for lore.kernel.org and has
    the git.git coderepo wired up for blob construction if you
    follow diff hunk header links @ https://80x24.org/lore/git/

    There's more stuff coming to dogfood with coderepo
    integration, too; but no guarantees it'll stay up since my
    SSD has a lot of wear on it, already.
