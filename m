Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE08CC433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 23:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238141AbhLNXOa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 18:14:30 -0500
Received: from shell1.rawbw.com ([198.144.192.42]:15471 "EHLO shell1.rawbw.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231684AbhLNXO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 18:14:29 -0500
X-Greylist: delayed 797 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Dec 2021 18:14:28 EST
Received: from [192.168.5.3] (c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76])
        (authenticated bits=0)
        by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 1BEN1BYl001689
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 15:01:11 -0800 (PST)
        (envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76] claimed to be [192.168.5.3]
Message-ID: <e584d004-334c-f9ed-39cb-77cba02cae1a@rawbw.com>
Date:   Tue, 14 Dec 2021 15:01:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     Git Mailing List <git@vger.kernel.org>
From:   Yuri <yuri@rawbw.com>
Subject: What's the difference between 'git rebase -i HEAD~1' and 'git reset
 --soft HEAD^'
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

They both seem to perform the same function: undo the last commit and 
put all changes back as uncommitted.


But is there any difference between them?


Thanks,

Yuri


