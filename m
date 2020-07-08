Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F5FC433E1
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 18:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 660E2207C4
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 18:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgGHS6A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 14:58:00 -0400
Received: from static.214.254.202.116.clients.your-server.de ([116.202.254.214]:38070
        "EHLO ciao.gmane.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgGHS6A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 14:58:00 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Jul 2020 14:57:59 EDT
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcvg-git-3@m.gmane-mx.org>)
        id 1jtFBi-000731-Mk
        for git@vger.kernel.org; Wed, 08 Jul 2020 20:52:58 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Yuri D'Elia <wavexx@thregr.org>
Subject: [ANNOUNCE] git-assembler initial release
Date:   Wed, 08 Jul 2020 20:52:53 +0200
Message-ID: <87sge1rg8q.fsf@wavexx.thregr.org>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Cancel-Lock: sha1:uvnIASRMDXwAx91YCM9H/bqqgRc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone, I'm announcing the first "stable" release of git-assembler.

git-assembler can perform automatic merge and rebase operations
following a simple declarative script. Like "make", but for branches.

I've been using it to manage complex PRs when dealing with slow or
unresponsive upstreams and to perform testing along with with CI.

It takes inspiration from topgit, which I've also been using prior to
writing this, so if you're familiar with topgit you might also find
git-assembler useful.

Several examples along with formatted documentation are available at:

  https://www.thregr.org/~wavexx/software/git-assembler/

The source:

  https://gitlab.com/wavexx/git-assembler

Enjoy

