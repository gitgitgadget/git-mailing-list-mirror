Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63439C433FE
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 17:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243069AbiCGRfF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 12:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbiCGRfE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 12:35:04 -0500
Received: from shell1.rawbw.com (shell1.rawbw.com [198.144.192.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B01B4580C5
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 09:34:09 -0800 (PST)
Received: from [192.168.5.3] (c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76])
        (authenticated bits=0)
        by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 227HY8F4003120
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
        for <git@vger.kernel.org>; Mon, 7 Mar 2022 09:34:09 -0800 (PST)
        (envelope-from yuri@tsoft.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76] claimed to be [192.168.5.3]
Message-ID: <47d5f648-fc24-2f6e-69fa-64962bd2a33c@tsoft.com>
Date:   Mon, 7 Mar 2022 09:34:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     Git Mailing List <git@vger.kernel.org>
From:   Yuri <yuri@tsoft.com>
Subject: git loses latest changes on 'git pull' when autoStash=true
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

.git/config has these options:

[pull]
         rebase = true
[rebase]
         autoStash = true
[merge]
         autoStash = true


Periodically latest uncommitted changes are lost when some unrelated 
commits are pulled.

Not all uncommitted changes are lost, only some of them. I couldn't 
figure out the condition.


git-2.34.1

FreeBSD 13.



Yuri


