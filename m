Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEC5C433F5
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 17:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345539AbiAYRbo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 12:31:44 -0500
Received: from shell1.rawbw.com ([198.144.192.42]:53447 "EHLO shell1.rawbw.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1588269AbiAYR3x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 12:29:53 -0500
X-Greylist: delayed 955 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jan 2022 12:29:53 EST
Received: from [192.168.5.3] (c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76])
        (authenticated bits=0)
        by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 20PHDYEe070105
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 09:13:53 -0800 (PST)
        (envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76] claimed to be [192.168.5.3]
Message-ID: <4493bcea-c7dd-da0a-e811-83044b3a1cac@tsoft.com>
Date:   Tue, 25 Jan 2022 09:13:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     Git Mailing List <git@vger.kernel.org>
From:   Yuri <yuri@rawbw.com>
Subject: 'git stash push' isn't atomic when Ctrl-C is pressed
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ctrl-C was pressed in the middle. git creates the stash record and 
didn't update the files.


Expected behavior: Ctrl-C should cleanly roll back the operation.



Yuri


