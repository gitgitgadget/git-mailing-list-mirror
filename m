Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE336C433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 08:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237389AbiDRInB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 04:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237368AbiDRImv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 04:42:51 -0400
X-Greylist: delayed 1647 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Apr 2022 01:40:12 PDT
Received: from gateway22.websitewelcome.com (gateway22.websitewelcome.com [192.185.47.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27656430
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 01:40:12 -0700 (PDT)
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 527CB4C5C
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 02:47:11 -0500 (CDT)
Received: from gator3142.hostgator.com ([50.87.144.177])
        by cmsmtp with SMTP
        id gM6Jnwv2MRnrrgM6JngG3z; Mon, 18 Apr 2022 02:47:11 -0500
X-Authority-Reason: nr=8
Received: from 92-249-234-155.pool.digikabel.hu ([92.249.234.155]:33733 helo=[192.168.0.107])
        by gator3142.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <csosza@designsoftware.com>)
        id 1ngM6I-000uhX-Mf
        for git@vger.kernel.org; Mon, 18 Apr 2022 02:47:10 -0500
Message-ID: <4026b85f-8cae-bcca-af14-e886e80725d4@designsoftware.com>
Date:   Mon, 18 Apr 2022 09:47:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     git@vger.kernel.org
From:   Attila Csosz <csosza@designsoftware.com>
Subject: Git bug report - disk errors on Windows after push
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator3142.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - designsoftware.com
X-BWhitelist: no
X-Source-IP: 92.249.234.155
X-Source-L: No
X-Exim-ID: 1ngM6I-000uhX-Mf
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 92-249-234-155.pool.digikabel.hu ([192.168.0.107]) [92.249.234.155]:33733
X-Source-Auth: csosza@designsoftware.com
X-Email-Count: 1
X-Source-Cap: ZHNnNHQwcjtkc2c0dDByO2dhdG9yMzE0Mi5ob3N0Z2F0b3IuY29t
X-Local-Domain: yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
Pushing to a directory directly.

What did you expect to happen? (Expected behavior)
Good behavior

What happened instead? (Actual behavior)
Disk errors. After pushing to a directory (my origin field is C:\Work 
for example) the git repository will be corrupted.
Moreover causing disk errors not only in the target git bare repository. 
I've loosed some other files.
Cannot be reproduced exactly. However I have decided to report this 
problem.
I've experienced this problem for several years.

What's different between what you expected and what actually happened?
Described.

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.31.1.windows.1
cpu: x86_64
built from commit: c5f0be26a7e3846e3b6268d1c6c4800d838c6bbb
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 19044
compiler info: gnuc: 10.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe


[Enabled Hooks]


