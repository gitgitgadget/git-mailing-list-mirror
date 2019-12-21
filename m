Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2B8C2D0D3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 17:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E632070C
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 17:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfLURAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 12:00:48 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:59976 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbfLURAs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 12:00:48 -0500
Received: from [92.30.123.115] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iii7S-0006V4-4c; Sat, 21 Dec 2019 17:00:46 +0000
Subject: Re: Propose promoting 'contrib/rerere-train.sh' to command
To:     Tom Miller <jackerran@gmail.com>, git@vger.kernel.org
References: <BZAQIE4YND2I.Z7BFCW7BLH3K@penguin>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <7b60ce55-700e-0c67-76ac-a983991e49f2@iee.email>
Date:   Sat, 21 Dec 2019 17:00:48 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <BZAQIE4YND2I.Z7BFCW7BLH3K@penguin>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Tom,

On 21/12/2019 02:17, Tom Miller wrote:
> I would like to propose promoting 'contrib/rerere-train.sh' to one of the
> following:
>
>     1. A builtin c command 'builtin/rerere-train.c'
>     2. To the top level directory as a built in script 'git-rerere-train.sh'
>
> I have recently found myself writing scripts using 'contrib/rerere-train.sh'
> and I wish it was built into the command. This would make it easier to use
> rather than having to find it on different platforms. I think it could also
> benefit from some documentation.
>
> I am trying to gauge the interest in this change before spending some time on
> working on it. I would also appreciate feedback or alternative approaches to
> what I have suggested. Thank you for your time.
>
> Thanks,
> Tom Miller
This sounds like a useful capability (especially the documentation!).

I also had aspirations that there should also be a way of exchanging the
essence of the rerere data when conflicts (e.g. feature vs master branch
merges) are known locally and ought to be communicable with the patch sets.

see messages:
<37ccaad0-40b4-ca63-e057-791119d7fa69@talktalk.net>
<nycvar.QRO.7.76.6.1909261253400.15067@tvgsbejvaqbjf.bet>

Philip
