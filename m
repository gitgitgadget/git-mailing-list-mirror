Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404FAC636D6
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 00:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbjBUAA2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 19:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjBUAA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 19:00:26 -0500
X-Greylist: delayed 374 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Feb 2023 16:00:26 PST
Received: from sneak2.sneakemail.com (sneak2.sneakemail.com [64.46.159.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D40F18AAC
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 16:00:26 -0800 (PST)
Received: (sneakemail censored 24417-1676937251-531825 #2); 20 Feb 2023
 23:54:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=liamekaens.com;
        s=mail; t=1676937251;
        bh=REk/4FgC58dCD60EzO4FiJrXteESfyZPgGrExiPyrRI=;
        h=Date:From:To:Subject:From;
        b=zQOJ1X1T+xViHOCqF+RjayX/JmDEUbflc49zWlpzF/VpULQRoY0HGuh/Ld5CD9a2V
         MdzDBfhk/9UiJQzaxa8gTQFxVQ1hvtDNNFlbwh48vL257MlXWf06MjvEwJOUb6YFmY
         n57ztdJdgEQYb3uOYLrKyJgj8aeNwJR1JXhv0B+1SJCjMW60bxZa4BNPNav+VMhjEY
         O7mXLafIMiZ61GcgIVceKBjH6EZE6jqcmyHezJl1xtIW08I4HxIM1LQU6EJnwpljdI
         jeahGx15lDTkWGH8uPNTsSrHeWa7o1OK6GRw20ozfIgJMSCGZ+DTgf+hmiMiQNofvI
         Zr5iyiOOxqvfg==
Received: (sneakemail censored 24417-1676937251-531825 #1); 20 Feb 2023
 23:54:11 -0000
Date:   Mon, 20 Feb 2023 23:54:11 +0000
From:   "squeaky" <334eevw4vj@liamekaens.com>
To:     git@vger.kernel.org
Message-ID: <24417-1676937251-531825@sneakemail.com>
Subject: git rev-list --no-walk RANGE not working as documented
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: Perl5 Mail::Internet v
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

git rev-list HERE..THERE --no-walk

What did you expect to happen? (Expected behavior)

Show the commits between HERE and THERE. 

What happened instead? (Actual behavior)

Only THERE is shown.

What's different between what you expected and what actually happened?

The documentation for --no-walk says, "This has no effect if a range is specified."
Since HERE..THERE is a range, --no-walk should have no effect. This isn't working as documented.

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.39.2.501.gd9d677b2d8
cpu: x86_64
built from commit: d9d677b2d8cc5f70499db04e633ba7a400f64cbf
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.1.6-200.fc37.x86_64 #1 SMP PREEMPT_DYNAMIC Sat Jan 14 16:55:06 UTC 2023 x86_64
compiler info: gnuc: 12.2
libc info: glibc: 2.36
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
[root@xps git] 

