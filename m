Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFACC6FA99
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 22:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjCJWD0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 17:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjCJWC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 17:02:58 -0500
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BFE360AC
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 13:59:57 -0800 (PST)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id BE6791F428;
        Fri, 10 Mar 2023 21:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1678485073;
        bh=zgmP/4zGJM1zh5hjeQSEXUPGqP/ntUW0Vvwh2ixuQLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dVHL8x74sT1PzbL+fIkLKrpY3a5Ieod+Z0k16BoIBpYqo7XGhHJG9s8nvsHVUiRC5
         jRfoYr8PSaJ1LldvP38Dyiabx7/ptAtzGSR7UlxZ6yYVOJz8iY5AtL4vg/LPUDqwBy
         IzlHoMlrwxvVnrnCDswIw3nGE6eYlSOEflePKcN8=
Date:   Fri, 10 Mar 2023 21:51:13 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] test: cleanups of aggregate-results.sh
Message-ID: <20230310215113.M656422@dcvr>
References: <20230309173032.959968-1-felipe.contreras@gmail.com>
 <xmqqa60k5ryc.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa60k5ryc.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> These two look sensible.  Any comments on them by reviewers on the
> initial round?

Looks fine to me.
