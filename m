Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7D6C33CA9
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 17:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0700E206DA
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 17:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgAMR3p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 12:29:45 -0500
Received: from p10link.net ([80.68.89.68]:56989 "EHLO P10Link.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgAMR3o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 12:29:44 -0500
X-Greylist: delayed 330 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Jan 2020 12:29:44 EST
Received: from [IPv6:2a02:c7f:ba49:1500::2] (unknown [IPv6:2a02:c7f:ba49:1500::2])
        by P10Link.net (Postfix) with ESMTPSA id B229140C001
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 17:24:13 +0000 (GMT)
To:     git@vger.kernel.org
From:   peter green <plugwash@p10link.net>
Subject: under what circumstances will git replacements be pushed/pulled
Message-ID: <7adb48ad-299d-bbec-c467-b29376583486@p10link.net>
Date:   Mon, 13 Jan 2020 17:24:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I need to make some local tweaks to history to make merges go more smoothly, traditionally the tool for doing this is grafts, however git is yelling at me that grafts are deprecated and will be removed in a future release and that I should use git-replace instead.

However there is something that is concerning me, https://git.wiki.kernel.org/index.php/GraftPoint says

 > As of Git 1.6.5, the more flexible git replace has been added, which
 > allows you to replace any object with any other object, and tracks
 > the associations via refs which can be pushed and pulled between repos.

However the git-replace man page makes no mention of push or pull.

under what circumstances will replacements be pushed or pulled, and what if any steps do I need to take to ensure that my replacements stay local.

