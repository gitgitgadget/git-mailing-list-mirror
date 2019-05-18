Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76D461F461
	for <e@80x24.org>; Sat, 18 May 2019 15:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbfERPQr (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 May 2019 11:16:47 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:57800 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbfERPQr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 May 2019 11:16:47 -0400
Received: from [192.168.1.22] ([92.1.197.142])
        by smtp.talktalk.net with SMTP
        id S14mhnzzVnuQZS14mhBwRt; Sat, 18 May 2019 16:16:44 +0100
X-Originating-IP: [92.1.197.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=echDgIMH c=1 sm=1 tr=0 a=gH7h/AuSNjzKVpz8AWYPeg==:117
 a=gH7h/AuSNjzKVpz8AWYPeg==:17 a=IkcTkHD0fZMA:10 a=cTi5-KVUc979oJ3KCkMA:9
 a=QEXdDO2ut3YA:10 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
To:     Git Mailing List <git@vger.kernel.org>
From:   Philip Oakley <philipoakley@iee.org>
Subject: Command to list <pattern> Branches on a specific Remote (i.e. select
 from rtb's)
Message-ID: <dcdff07d-77c7-8cb8-fa06-82acda5fe9ec@iee.org>
Date:   Sat, 18 May 2019 16:16:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfK+0vfSflIkZIMVchHJk3B5J6ZBG3K1/vuc6jrnPYC99X3/Ikl8yQXqXb2xD6VzA+yehuItiaH3cJ6Gte+w2umo4uszxcumnyfom39CL6WfLT2Up/xrv
 mpGvRT/kCZoTz3wCF+MpsGAdWHrZh/FYFtBP16uTDhU3qKoxRAIpYtKy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
I'm unsure if there is a command for this.

Currently I have 1600+ remote tracking branches (rtb) for my Git repo as 
it covers both git.git and git-for-windows and some other contributors.

Finding a specific rtb for a particular remote looks like there ought to 
be a simple command ready to do the job, but I haven't found anything.

Is there a command or simple simple invocation of branch, show-ref, 
for-each-ref, etc that can be give a branch pattern and remote name to 
quickly filter down the list of potential branches to just one or two 
24-line screens?

-- 
Philip

