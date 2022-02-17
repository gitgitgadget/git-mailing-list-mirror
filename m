Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E807FC433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 21:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243832AbiBQVAa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 16:00:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbiBQVA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 16:00:29 -0500
X-Greylist: delayed 558 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Feb 2022 13:00:13 PST
Received: from shell1.rawbw.com (shell1.rawbw.com [198.144.192.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DAC4315DDE6
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 13:00:13 -0800 (PST)
Received: from [192.168.5.3] (c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76])
        (authenticated bits=0)
        by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 21HKosfv092673
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 12:50:54 -0800 (PST)
        (envelope-from yuri@tsoft.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76] claimed to be [192.168.5.3]
Message-ID: <efdd752b-5cff-c483-80eb-654b53fdde7c@tsoft.com>
Date:   Thu, 17 Feb 2022 12:50:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     Git Mailing List <git@vger.kernel.org>
From:   Yuri <yuri@tsoft.com>
Subject: When rebase.autoStash=true is used, 'git pull' merge process still
 complains when incoming changes are in a different place of the file than
 local changes
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a file "x" that has one local change and some incoming pulled 
changes.

Pulled changes are contextually very far away, so it should be possible 
to merge them without user interaction.

But git still complains:

$ git pull
Updating 91bfe02..522ccf2
error: Your local changes to the following files would be overwritten by 
merge:
     x


Yuri


