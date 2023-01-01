Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40713C4167B
	for <git@archiver.kernel.org>; Sun,  1 Jan 2023 19:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjAATtl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Jan 2023 14:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjAATtk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jan 2023 14:49:40 -0500
X-Greylist: delayed 91 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 01 Jan 2023 11:49:38 PST
Received: from shell1.rawbw.com (shell1.rawbw.com [198.144.192.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1D5C1C2
        for <git@vger.kernel.org>; Sun,  1 Jan 2023 11:49:38 -0800 (PST)
Received: from [192.168.5.3] (c-73-162-96-20.hsd1.ca.comcast.net [73.162.96.20])
        (authenticated bits=0)
        by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 301Jm7Pd088276
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
        for <git@vger.kernel.org>; Sun, 1 Jan 2023 11:48:07 -0800 (PST)
        (envelope-from yuri@tsoft.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-73-162-96-20.hsd1.ca.comcast.net [73.162.96.20] claimed to be [192.168.5.3]
Message-ID: <46647d82-56f1-350a-a697-543d8f86ae1d@tsoft.com>
Date:   Sun, 1 Jan 2023 11:48:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To:     Git Mailing List <git@vger.kernel.org>
From:   Yuri <yuri@tsoft.com>
Subject: 'git tag' returns tags not in the order they were created
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git tag' returns these tags on 
https://github.com/out-of-cheese-error/the-way:

v0.10.0
v0.10.1
v0.11.0
v0.11.1
v0.12.0
v0.12.1
v0.13.0
v0.14.0
v0.14.1
v0.14.2
v0.14.3
v0.14.4
v0.15.0
v0.16.0
v0.16.1
v0.17.0
v0.17.1
v0.18.0
v0.2.1-osx
v0.2.1_osx
v0.2.2
v0.2.3
v0.2.4
v0.2.5
v0.3.0
v0.3.1
v0.3.2
v0.4.0
v0.5.0
v0.6.0
v0.6.1
v0.7.0
v0.8.0
v0.9.0

The latest tag is 0.18.0.


'git tag' should return tags in the order they were created.

Maybe they should be sorted by date?



git-2.38.1


Yuri

