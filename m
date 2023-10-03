Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE98BE75434
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 08:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239584AbjJCINP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 04:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239330AbjJCINM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 04:13:12 -0400
X-Greylist: delayed 1840 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Oct 2023 01:12:21 PDT
Received: from shell1.rawbw.com (shell1.rawbw.com [198.144.192.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D3F0659D
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 01:12:21 -0700 (PDT)
Received: from [192.168.5.3] (c-73-70-62-113.hsd1.ca.comcast.net [73.70.62.113])
        (authenticated bits=0)
        by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 3937ffaA072261
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
        for <git@vger.kernel.org>; Tue, 3 Oct 2023 00:41:41 -0700 (PDT)
        (envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-73-70-62-113.hsd1.ca.comcast.net [73.70.62.113] claimed to be [192.168.5.3]
Message-ID: <2f9081b4-e34f-38b3-a557-021c54e4384c@tsoft.com>
Date:   Tue, 3 Oct 2023 00:41:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To:     Git Mailing List <git@vger.kernel.org>
From:   Yuri <yuri@rawbw.com>
Subject: Is git-p4 maintained?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are problems with the 'git p4 submit' command.


The 'git p4 submit' command first asks many questions like:

Unfortunately applying the change failed!
//xx/xx/xx/xx/xx/xx/xx#92 - was edit, reverted
What do you want to do?
[s]kip this commit but apply the rest, or [q]uit?


The files that it complains about aren't even involved in the commit 
that is being pushed.

After all the questions are answered with "s" - git-p4 often fails to 
push commits.


Deleted files and added files cause problems during 'git p4 submit' and 
when such files are in the commit - 'git p4 submit' prints some error 
messages and fails to push commits.

git-p4 says that it can't apply some patches and fails when it is 
pushing commits that delete or add files.


The workaround is to place the deleted file back and remove the added 
files before the 'git p4 submit' operation.


Is git-p4 maintained?
Is there any chance for these problems to be fixed?


Thanks,

Yuri


