Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57156C433EF
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 18:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B3B760232
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 18:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhJWSd7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Oct 2021 14:33:59 -0400
Received: from smtprelay07.ispgateway.de ([134.119.228.97]:19431 "EHLO
        smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhJWSd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Oct 2021 14:33:57 -0400
X-Greylist: delayed 11179 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Oct 2021 14:33:56 EDT
Received: from [79.233.235.171] (helo=[192.168.2.202])
        by smtprelay07.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1meItG-0003jU-IH
        for git@vger.kernel.org; Sat, 23 Oct 2021 17:24:58 +0200
From:   Martin <git@mfriebe.de>
Subject: Contradicting man page for git branch copy
To:     Git List <git@vger.kernel.org>
Message-ID: <7a600f7e-e3a7-edac-056c-9639ff01e471@mfriebe.de>
Date:   Sat, 23 Oct 2021 17:25:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The man page says

1) Under "Description"
https://git-scm.com/docs/git-branch#_description
> The |-c| and |-C| options have the exact same semantics as |-m| and 
> |-M|, except instead of the branch being renamed, it will be copied to 
> a new name, along with its config and reflog.

But on the option itself
https://git-scm.com/docs/git-branch#Documentation/git-branch.txt--c
>
> -c
> --copy
>
>     Copy a branch and the corresponding reflog.
>

The latter does not mention the config.

So does it copy the config or not ?



