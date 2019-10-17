Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CD5F1F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 18:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406810AbfJQSso (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 14:48:44 -0400
Received: from 195-159-176-226.customer.powertech.no ([195.159.176.226]:57152
        "EHLO blaine.gmane.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392717AbfJQSso (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 14:48:44 -0400
Received: from list by blaine.gmane.org with local (Exim 4.89)
        (envelope-from <gcvg-git-3@m.gmane.org>)
        id 1iLApA-0001L8-R9
        for git@vger.kernel.org; Thu, 17 Oct 2019 20:48:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Yuri D'Elia <wavexx@thregr.org>
Subject: Set default strategy options for merge/rebase
Date:   Thu, 17 Oct 2019 20:48:30 +0200
Message-ID: <87eezbi4xt.fsf@wavexx.thregr.org>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
Cancel-Lock: sha1:KR1WlL6P2/m8vzu7VOkFfO/zuD4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is it (or would it be) possible to set the default strategy and strategy
options as provided by merge/rebase ``-s`` and ``-X`` in gitconfig?

I found myself comparing several conflicts using recursive's -Xpatience,
and in some cases the difference is quite staggering, changing from a
jumbled mess to a compact and readable diff.

I'd love to be able to set it as a default to play around more (without
aliasing, that is).

It's also unclear to me from the documentation of git merge whether
-Xdiff-algorithm=? is an exception to the default diff algorithm
(diff.algorithm) or if that's completely independent setting meaning
that merge always ignores diff.algorithm to begin with.

And also, is -Xpatience just a shortcut to -Xdiff-algorithm=patience?

Thanks!

