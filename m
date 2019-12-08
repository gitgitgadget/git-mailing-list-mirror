Return-Path: <SRS0=+MKA=Z6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB51C2D0BE
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 12:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA3D206F4
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 12:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfLHMJP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Dec 2019 07:09:15 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:40833 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfLHMJP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Dec 2019 07:09:15 -0500
Received: from [92.30.123.115] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1idvNB-00047v-CQ
        for git@vger.kernel.org; Sun, 08 Dec 2019 12:09:14 +0000
To:     Git List <git@vger.kernel.org>
From:   Philip Oakley <philipoakley@iee.email>
Subject: How to determine age of HEAD commit
Message-ID: <956e2efe-3426-f61e-7686-5416b51931b9@iee.email>
Date:   Sun, 8 Dec 2019 12:09:14 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Visual Studio git solution uses the vcpkg manager for dependencies, 
via a cloned git repo.

To avoid repeated probing for updates when compiling, I considered 
holding of on 'git pull' for the repo for say 24 hours (daily update). 
However I'm not aware of a git command that returns the numeric value of 
the agedness of a given local commit (typically HEAD).

Is there a command that does return the numeric agedness of a commit 
(e.g. now - commit_date, in seconds)?
-- 
Philip

