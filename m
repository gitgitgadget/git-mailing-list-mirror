Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60AEC61DA4
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 19:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjCMTEn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 15:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjCMTEm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 15:04:42 -0400
X-Greylist: delayed 986 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Mar 2023 12:04:42 PDT
Received: from shell1.rawbw.com (shell1.rawbw.com [198.144.192.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A2B21F916
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 12:04:41 -0700 (PDT)
Received: from [192.168.5.3] (c-73-162-96-20.hsd1.ca.comcast.net [73.162.96.20])
        (authenticated bits=0)
        by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 32DIkwXL038610
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 11:46:59 -0700 (PDT)
        (envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-73-162-96-20.hsd1.ca.comcast.net [73.162.96.20] claimed to be [192.168.5.3]
Message-ID: <35a28f6c-5fe3-3007-63b2-bcfcdd10795a@tsoft.com>
Date:   Mon, 13 Mar 2023 11:46:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Git Mailing List <git@vger.kernel.org>
From:   Yuri <yuri@rawbw.com>
Subject: 'git commit --amend --no-edit --date {date}' sets wrong date when the
 summer daylight saving time is on
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello git experts,


After the 'git commit --amend --no-edit --date "Mon 13 Mar 2023 
6:00:00PST"' command 'git log' shows that the last commit was made at 
07:00:00, not at 06:00:00.


This started happening only now after the switch to the summer daylight 
saving time was made a day ago.


In both cases, when the time is set or read, the time correction should 
be applied equally.



Yuri


