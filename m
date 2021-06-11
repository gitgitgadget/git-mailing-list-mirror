Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B4CC48BD1
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 17:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30FC6613CF
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 17:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhFKRlg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 13:41:36 -0400
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:41375 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhFKRlg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 13:41:36 -0400
X-Greylist: delayed 3575 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Jun 2021 13:41:35 EDT
Received: from [91.113.179.170] (helo=[192.168.92.29])
        by smtprelay04.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <marc.strapetz@syntevo.com>)
        id 1lrkAb-0008H6-Rw
        for git@vger.kernel.org; Fri, 11 Jun 2021 18:38:09 +0200
From:   Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Server-side-proposed partial clone configuration (default clone
 --filter option)
To:     git@vger.kernel.org
Message-ID: <f6b3e10e-06b0-fa98-4e34-8a0eeaf45849@syntevo.com>
Date:   Fri, 11 Jun 2021 18:40:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 From a (GUI) client perspective, it would be quite helpful to propose 
good (partial) clone defaults to the user: whether to do a full clone, 
or skip large blobs, ... this can result in much smaller clones by 
*default* and thus a better user experience.

Such a proposal should most likely be a property of the repository 
itself, for example stored in a specific ref which can efficiently be 
fetched using Git, in preparation of the main clone.

Are there any best practices on how to implement that? Or even better, 
is there any specification on where this meta information should be 
stored, how it should look like, ...? If not, is anyone interested in 
this topic? I feel that this is something which not every 
platform/client should reinvent.

-Marc
