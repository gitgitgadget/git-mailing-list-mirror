Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638FFC07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E62D61165
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbhGTRSQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 13:18:16 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:52577 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbhGTRQO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 13:16:14 -0400
Received: (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 96259100006;
        Tue, 20 Jul 2021 17:56:39 +0000 (UTC)
Date:   Tue, 20 Jul 2021 23:26:37 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Bertrand Provost <provost.bertrand@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [bug][git-gui] Git gui is not executing prepare-commit-msg hooks
 when run from a worktree
Message-ID: <20210720175637.nrlnkmbzbglvmebe@yadavpratyush.com>
References: <CAPKfN0NJ65Qmx+tCPi2L_QhPfFcrhAHMSb2JSYSe26mtkcwf+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPKfN0NJ65Qmx+tCPi2L_QhPfFcrhAHMSb2JSYSe26mtkcwf+Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/07/21 10:32AM, Bertrand Provost wrote:
> Hello,
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> - Create a worktree of a git in a new directory
> - Add prepare-commit-msg hook
> - Open `git gui` UI from the worktree directory
> 
> What did you expect to happen? (Expected behavior)
> It should fill the commit field with the hooks
> 
> What happened instead? (Actual behavior)
> Nothing
> 
> The hook works fine in the original directory (with the full .git)
> 
> [System Info]
> git version:
> git version 2.31.1
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 5.4.0-77-generic #86-Ubuntu SMP Thu Jun 17 02:35:03 UTC 2021 x86_64
> compiler info: gnuc: 9.3
> libc info: glibc: 2.31
> $SHELL (typically, interactive shell): /bin/bash
> 
> [Enabled Hooks]
> prepare-commit-msg

Thanks for reporting. I will take a look when I can find the time.

> 
> -- 
> Bertrand Provost

-- 
Regards,
Pratyush Yadav
