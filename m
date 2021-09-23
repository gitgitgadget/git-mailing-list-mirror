Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E84C433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 05:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB45061131
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 05:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhIWF3T (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 01:29:19 -0400
Received: from [50.213.99.139] ([50.213.99.139]:60031 "EHLO eddie.starwolf.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S229504AbhIWF3S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 01:29:18 -0400
X-Greylist: delayed 385 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Sep 2021 01:29:18 EDT
Received: by eddie.starwolf.com (Postfix, from userid 302)
        id 2F655CE; Wed, 22 Sep 2021 22:21:22 -0700 (PDT)
To:     git@vger.kernel.org
Subject: ANSI sequences produced on non-ANSI terminal
Message-Id: <20210923052122.2F655CE@eddie.starwolf.com>
Date:   Wed, 22 Sep 2021 22:21:22 -0700 (PDT)
From:   The Grey Wolf <greywolf@starwolf.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
	Logged on to a hard terminal and ran 'git status .' and
	'git pull'.

What did you expect to happen? (Expected behavior)
	I expected that colour sequences would not be output, or at least
	not hardcoded to ANSI standard.  In the case of 'pull', I expected
	that the stats would be just printed using <string>\r.

What happened instead? (Actual behavior)
	I got escape sequences that made the output unreadable.

What's different between what you expected and what actually happened?
	One produces mangled ouptut and the other doesn't.

Anything else you want to add:
	I searched google and the documentation as best I was able for
	this, but I am unable to find anywhere that will let me disable
	(or enable) colour for a particular term type.  Sometimes I'm on
	an xterm, for which this is GREAT.  Sometimes I'm on a Wyse WY60,
	for which this is sub-optimal.  My workaround is to disable colour
	completely, which is reluctantly acceptable, but it would be nice
	to say "If I'm on an xterm/aterm/urxvt/ansi terminal, enable
	colour or cursor-positioning, otherwise shut it off."  If this
	seems too much of a one-off to handle, fine, but most things that
	talk fancy to screens are kind enough to allow an opt-out based on
	terminal type. :)

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.

[System Info]
git version:
git version 2.32.0
cpu: amd64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: NetBSD 9.99.88 NetBSD 9.99.88 (EDDIE) #16: Tue Aug 31 19:14:47 PDT 2021  greywolf@eddie.starwolf.com:/sys/arch/amd64/compile/EDDIE amd64
compiler info: gnuc: 10.3
libc info: no libc information available (actually there's a LOT of it,
	but I'm not sure you really want it -- please let me know if you do).
$SHELL (typically, interactive shell): /bin/bash
$TERM: wy60

[Enabled Hooks]
	I don't know enough about git yet to use these.

